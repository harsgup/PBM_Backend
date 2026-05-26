from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy import func
from sqlalchemy.orm import Session

from app.database.db import get_db
from app.models.admin.assign_job import Personal, ScreeningJob, Payment
from app.models.admin.users import User
from app.schemas.schemas import AddUserRequest, AssignJobRequest, AssignedJobResponse, BuildScreeningJobRequest, UserResponse,UpdateUserRoleRequest
from app.utility.jwt import verify_user,verify_admin
from app.utility.security import hash_password,verify_password

router = APIRouter(prefix="/admin", tags=["Admin"], 
                   dependencies=[Depends(verify_admin)]
                   )


@router.post("/users", response_model=UserResponse, status_code=201)
def create_user(data: AddUserRequest,db: Session = Depends(get_db)):
    if db.query(User).filter(User.pis == data.pis).first():
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST,detail="User with this PIS already exists")

    user_data = data.dict()
    user_data["password"] = hash_password(data.password)
    user = User(**user_data)

    db.add(user)
    db.commit()
    db.refresh(user)

    return user

@router.get("/users", response_model=list[UserResponse])
def get_all_users(db: Session = Depends(get_db)):
    return db.query(User).all()

@router.get("/users/by-role")
def get_users_by_role(role: str,db: Session = Depends(get_db)):
    users = (
        db.query(User.id, User.name)
        .filter(User.role == role)
        .order_by(User.name)
        .all()
    )

    return [
        {"label": u.name, "value": u.id}
        for u in users
    ]

@router.put("/users/{user_id}/role", response_model=UserResponse)
def update_user_role(user_id: int,data: UpdateUserRoleRequest,db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == user_id).first()

    if not user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,detail="User not found")

    user.role = data.role
    db.commit()
    db.refresh(user)

    return user

@router.delete("/users/{user_id}")
def delete_user(user_id: int,db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == user_id).first()

    if not user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,detail="User not found")

    db.delete(user)
    db.commit()

@router.get("/screening/cycles")
def get_cycles(db: Session = Depends(get_db)):
    rows = (db.query(ScreeningJob.cycle).distinct().order_by(ScreeningJob.cycle).all())

    return [r.cycle for r in rows]


@router.get("/screening/posts")
def get_posts(cycle: str,db: Session = Depends(get_db)):
    rows = (
        db.query(ScreeningJob.post_name)
        .filter(ScreeningJob.cycle == cycle)
        .distinct()
        .order_by(ScreeningJob.post_name)
        .all()
    )

    return [r.post_name for r in rows]


from sqlalchemy import or_, and_

@router.post("/screening/build-screening-jobs")
def build_screening_jobs(data: BuildScreeningJobRequest, db: Session = Depends(get_db)):
    
    records = (
        db.query(Personal.application_no,Personal.dicipline).join(Payment,Payment.application_no == Personal.application_no)
        .filter(or_(Payment.status == "exempted",and_(Payment.final_status == "completed"))).all()
    )
    print(records)
    inserted = 0

    for r in records:

        exists = db.query(ScreeningJob).filter(
            ScreeningJob.application_no == r.application_no,
            ScreeningJob.cycle == data.cycle
        ).first()

        if exists:
            continue

        job = ScreeningJob(
            application_no=r.application_no,
            post_name=r.dicipline,
            cycle=data.cycle,
            verification1_assign_status=False,
            verification2_assign_status=False,
            approver_assign_status=False
        )

        db.add(job)
        inserted += 1

    db.commit()

    return {
        "message": "Screening jobs created",
        "cycle": data.cycle,
        "inserted": inserted
    }


@router.post("/screening/assign-jobs")
def assign_jobs(data: AssignJobRequest,db: Session = Depends(get_db)):
    query = db.query(ScreeningJob).filter(
        ScreeningJob.cycle == data.cycle,
        ScreeningJob.post_name == data.post_name
    )

    if data.role == "verifier":
        if data.verifier_group == "V1":
            query = query.filter(
                ScreeningJob.verification1_assign_status == 0,
                ScreeningJob.verifier1_id.is_(None)
            )
        elif data.verifier_group == "V2":
            query = query.filter(
                ScreeningJob.verification2_assign_status == 0,
                ScreeningJob.verifier2_id.is_(None)
            )
        else:
            raise HTTPException(status_code=400, detail="Verifier Gruop required")

    elif data.role == "approver":
        query = query.filter(
            ScreeningJob.verification1_status == 1,
            ScreeningJob.verification2_status == 1,
            ScreeningJob.approver_id.is_(None)
        )

    if data.assign_type == "random":
        query = query.order_by(func.random())
    else:
        query = query.order_by(ScreeningJob.id.asc())

    jobs = query.limit(data.count).all()

    if not jobs:
        raise HTTPException(status_code=404, detail="No eligible jobs found")

    for job in jobs:
        if data.role == "verifier":
            if data.verifier_group == "V1":
                job.verifier1_id = data.user_id
                job.verification1_assign_status = 1
            else:
                job.verifier2_id = data.user_id
                job.verification2_assign_status = 1
        else:
            job.approver_id = data.user_id

    db.commit()

    return {
        "assigned": len(jobs),
        "role": data.role,
        "user_id": data.user_id
    }

@router.get("/screening/screening-jobs/summary")
def screening_job_summary(
    cycle: str | None = None,
    post_name: str | None = None,
    db: Session = Depends(get_db)
):
    base_query = db.query(ScreeningJob)

    if cycle:
        base_query = base_query.filter(ScreeningJob.cycle == cycle)

    if post_name:
        base_query = base_query.filter(ScreeningJob.post_name == post_name)

    total = base_query.count()

    available_verifier1 = base_query.filter(
        ScreeningJob.verifier1_id.is_(None)
    ).count()

    available_verifier2 = base_query.filter(
        ScreeningJob.verifier2_id.is_(None)
    ).count()

    available_approver = base_query.filter(
        ScreeningJob.verification1_status == 1,
        ScreeningJob.verification2_status == 1,
        ScreeningJob.approver_id.is_(None)
    ).count()

    return {
        "total": total,
        "available_verifier1": available_verifier1,
        "available_verifier2": available_verifier2,
        "available_approver": available_approver
    }


@router.get("/screening/assigned-jobs", response_model=list[AssignedJobResponse])
def get_assigned_jobs(db: Session = Depends(get_db)):
    jobs = db.query(ScreeningJob).order_by(ScreeningJob.id.desc()).all()

    result = []

    for j in jobs:
        if j.verification1_assign_status == 0 and j.verification2_assign_status == 0:
            status = "Not Assigned"
        elif j.verification1_assign_status == 1 and j.verification2_assign_status == 0:
            status = "Assigned to Verifier-1"
        elif j.verification1_assign_status == 0 and j.verification2_assign_status == 1:
            status = "Assigned to Verifier-2"
        elif j.verification1_assign_status == 1 and j.verification2_assign_status == 1:
            status = "Assigned to Verifier-1 & Verifier-2"
        elif j.verification2_status == 1 and j.verification1_status == 1:
            status = "Pending Approver Assignment"
        elif j.approver_id and j.approver_assign_status == 1:
            status = "Assigned to Approver"
        else:
            status = "Completed"

        result.append({
            "id": j.id,
            "cycle": j.cycle,
            "post_name": j.post_name,
            "application_no": j.application_no,
            "status": status
        })

    return result


@router.post("/screening/assigned-jobs/{job_id}/reset")
def reset_job(job_id: int,db: Session = Depends(get_db)):
    job = db.query(ScreeningJob).filter(ScreeningJob.id == job_id).first()

    if not job:
        raise HTTPException(status_code=404, detail="Job not found")

    job.verifier1_id = None
    job.verifier2_id = None
    job.approver_id = None

    job.verification1_status = 0
    job.verification2_status = 0
    job.verification2_assign_status = 0
    job.verification1_assign_status = 0
    job.approver_status = 0
    job.approver_assign_status = 0

    job.verifier1_remarks = None
    job.verifier2_remarks = None
    job.approver_remarks = None

    job.verifier1_screening_status = None
    job.verifier2_screening_status = None
    job.approver_screening_status = None

    db.commit()

    return {"message": "Job reset successfully"}


@router.get("/reports/summary", summary="Get candidate summary report for admin")
def get_summary_report(
    cycle: str,
    post_name: str,
    db: Session = Depends(get_db)
):
    results = (
        db.query(ScreeningJob, Personal)
        .join(
            Personal, 
            ScreeningJob.application_no.collate("utf8mb4_general_ci") == 
            Personal.application_no.collate("utf8mb4_general_ci")
        )
        .filter(
            ScreeningJob.cycle == cycle,
            ScreeningJob.post_name == post_name
        )
        .all()
    )
    
    total = len(results)
    if total == 0:
        return {
            "status": "empty",
            "message": f"No candidates found in cycle '{cycle}' for post '{post_name}'.",
            "data": []
        }
        
    completed = 0
    data_list = []
    for sj, p in results:
        is_completed = bool(sj.verification1_status) and bool(sj.verification2_status) and bool(sj.approver_status)
        if is_completed:
            completed += 1
        data_list.append({
            "application_no": sj.application_no,
            "candidate_name": p.C_name,
            "father_name": p.F_name,
            "verifier1_status": sj.verifier1_screening_status or "PENDING",
            "verifier1_remarks": sj.verifier1_remarks or "Action Not Taken",
            "verifier2_status": sj.verifier2_screening_status or "PENDING",
            "verifier2_remarks": sj.verifier2_remarks or "Action Not Taken",
            "approver_status": sj.approver_screening_status or "PENDING",
            "approver_remarks": sj.approver_remarks or "Action Not Taken",
            "is_completed": is_completed
        })
        
    if completed < total:
        return {
            "status": "incomplete",
            "message": f"Report cannot be generated. Only {completed} of {total} candidates have been fully processed by verifiers and the approver.",
            "data": [],
            "total": total,
            "completed": completed
        }
        
    return {
        "status": "ready",
        "data": data_list
    }

