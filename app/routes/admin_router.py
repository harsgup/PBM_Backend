from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy import func
from sqlalchemy.orm import Session

from app.database.db import get_db
from app.models.admin.assign_job import Personal, ScreeningJob, Payment, ScreenedCandidate
from app.models.admin.committee import TechnicalCommittee
from app.models.admin.users import User
from app.schemas.schemas import AddUserRequest, AssignJobRequest, AssignedJobResponse, BuildScreeningJobRequest, UserResponse,UpdateUserRoleRequest, TechnicalCommitteeCreate, TechnicalCommitteeResponse
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

    db.query(ScreenedCandidate).filter(
        ScreenedCandidate.cycle == job.cycle,
        ScreenedCandidate.post == job.post_name,
        ScreenedCandidate.application_no == job.application_no
    ).delete()

    db.commit()

    return {"message": "Job reset successfully"}


@router.get("/reports/summary", summary="Get candidate summary report for admin")
def get_summary_report(
    cycle: str,
    post_name: str,
    db: Session = Depends(get_db)
):
    from sqlalchemy import text
    
    # Fetch post_code from posts table
    post_code = "N/A"
    try:
        post_row = db.execute(
            text("SELECT post_code FROM posts WHERE post_name = :post_name"), 
            {"post_name": post_name}
        ).first()
        if post_row:
            post_code = post_row[0]
    except Exception:
        pass

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
            "data": [],
            "post_code": post_code,
            "post_name": post_name,
            "cycle": cycle
        }
        
    users = db.query(User.id, User.name, User.rank).all()
    user_map = {u.id: {"name": u.name, "rank": u.rank} for u in users}

    completed = 0
    data_list = []
    for sj, p in results:
        is_completed = bool(sj.verification1_status) and bool(sj.verification2_status) and bool(sj.approver_status)
        if is_completed:
            completed += 1
            
        category = p.category or "GEN"
        pwd = p.pwd or "-"
        exserve = p.exserve or "-"
        sub_cat = []
        if pwd.strip().upper() == "YES":
            sub_cat.append("PwD")
        if exserve.strip().upper() == "YES":
            sub_cat.append("Ex-Serviceman")
        cat_sub = category
        if sub_cat:
            cat_sub += " (" + ", ".join(sub_cat) + ")"

        v1_info = user_map.get(sj.verifier1_id) if sj.verifier1_id else None
        v2_info = user_map.get(sj.verifier2_id) if sj.verifier2_id else None
        app_info = user_map.get(sj.approver_id) if sj.approver_id else None

        data_list.append({
            "application_no": sj.application_no,
            "candidate_name": p.C_name,
            "father_name": p.F_name,
            "category_and_subcategory": cat_sub,
            "verifier1_status": sj.verifier1_screening_status or "PENDING",
            "verifier1_remarks": sj.verifier1_remarks or "Action Not Taken",
            "verifier1_name": v1_info["name"] if v1_info else "N/A",
            "verifier1_designation": v1_info["rank"] if v1_info else "N/A",
            "verifier2_status": sj.verifier2_screening_status or "PENDING",
            "verifier2_remarks": sj.verifier2_remarks or "Action Not Taken",
            "verifier2_name": v2_info["name"] if v2_info else "N/A",
            "verifier2_designation": v2_info["rank"] if v2_info else "N/A",
            "approver_status": sj.approver_screening_status or "PENDING",
            "approver_remarks": sj.approver_remarks or "Action Not Taken",
            "approver_name": app_info["name"] if app_info else "N/A",
            "approver_designation": app_info["rank"] if app_info else "N/A",
            "is_completed": is_completed
        })
        
    if completed < total:
        return {
            "status": "incomplete",
            "message": f"Report cannot be generated. Only {completed} of {total} candidates have been fully processed by verifiers and the approver.",
            "data": [],
            "total": total,
            "completed": completed,
            "post_code": post_code,
            "post_name": post_name,
            "cycle": cycle
        }
        
    return {
        "status": "ready",
        "post_code": post_code,
        "post_name": post_name,
        "cycle": cycle,
        "data": data_list
    }


def sync_screened_candidates(db: Session, cycle: str, post: str):
    passed_jobs = db.query(ScreeningJob).filter(
        ScreeningJob.cycle == cycle,
        ScreeningJob.post_name == post,
        ScreeningJob.verification1_status == True,
        ScreeningJob.verification2_status == True,
        ScreeningJob.approver_status == True,
        ScreeningJob.approver_screening_status == 'VERIFIED'
    ).all()

    existing_records = db.query(ScreenedCandidate).filter(
        ScreenedCandidate.cycle == cycle,
        ScreenedCandidate.post == post
    ).all()
    existing_apps = {r.application_no for r in existing_records}

    for job in passed_jobs:
        if job.application_no not in existing_apps:
            sc = ScreenedCandidate(
                cycle=cycle,
                post=post,
                application_no=job.application_no
            )
            db.add(sc)

    passed_apps = {job.application_no for job in passed_jobs}
    for app_no in existing_apps:
        if app_no not in passed_apps:
            db.query(ScreenedCandidate).filter(
                ScreenedCandidate.cycle == cycle,
                ScreenedCandidate.post == post,
                ScreenedCandidate.application_no == app_no
            ).delete()

    db.commit()


@router.post("/technical-committee", response_model=TechnicalCommitteeResponse)
def create_technical_committee(
    data: TechnicalCommitteeCreate,
    db: Session = Depends(get_db)
):
    existing = db.query(TechnicalCommittee).filter(
        TechnicalCommittee.cycle == data.cycle,
        TechnicalCommittee.post == data.post
    ).first()
    if existing:
        raise HTTPException(
            status_code=400,
            detail="A Technical Committee for this recruitment cycle and post already exists."
        )

    committee = TechnicalCommittee(
        cycle=data.cycle,
        post=data.post,
        committee_name=data.committee_name,
        chairman=data.chairman,
        lab_rep=data.lab_rep,
        external_member=data.external_member,
        subject_expert=data.subject_expert
    )
    db.add(committee)
    db.commit()
    db.refresh(committee)

    sync_screened_candidates(db, data.cycle, data.post)

    return committee


@router.get("/technical-committee", response_model=list[TechnicalCommitteeResponse])
def get_technical_committees(db: Session = Depends(get_db)):
    return db.query(TechnicalCommittee).all()


@router.put("/technical-committee/{committee_id}", response_model=TechnicalCommitteeResponse)
def update_technical_committee(
    committee_id: int,
    data: TechnicalCommitteeCreate,
    db: Session = Depends(get_db)
):
    committee = db.query(TechnicalCommittee).filter(TechnicalCommittee.id == committee_id).first()
    if not committee:
        raise HTTPException(status_code=404, detail="Technical Committee not found")

    old_cycle = committee.cycle
    old_post = committee.post

    if old_cycle != data.cycle or old_post != data.post:
        existing = db.query(TechnicalCommittee).filter(
            TechnicalCommittee.cycle == data.cycle,
            TechnicalCommittee.post == data.post,
            TechnicalCommittee.id != committee_id
        ).first()
        if existing:
            raise HTTPException(
                status_code=400,
                detail="A Technical Committee for this recruitment cycle and post already exists."
            )

        db.query(ScreenedCandidate).filter(
            ScreenedCandidate.cycle == old_cycle,
            ScreenedCandidate.post == old_post
        ).delete()
        db.commit()

    committee.cycle = data.cycle
    committee.post = data.post
    committee.committee_name = data.committee_name
    committee.chairman = data.chairman
    committee.lab_rep = data.lab_rep
    committee.external_member = data.external_member
    committee.subject_expert = data.subject_expert
    committee.chairman = data.chairman

    db.commit()
    db.refresh(committee)

    sync_screened_candidates(db, data.cycle, data.post)

    return committee


@router.delete("/technical-committee/{committee_id}")
def delete_technical_committee(
    committee_id: int,
    db: Session = Depends(get_db)
):
    committee = db.query(TechnicalCommittee).filter(TechnicalCommittee.id == committee_id).first()
    if not committee:
        raise HTTPException(status_code=404, detail="Technical Committee not found")

    db.delete(committee)
    db.commit()

    return {"message": "Technical Committee deleted successfully"}

