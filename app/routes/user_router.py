from fastapi import APIRouter, Depends, Query, HTTPException
from sqlalchemy import func
from sqlalchemy.orm import Session
from typing import Optional
from pydantic import BaseModel
from app.models.admin.assign_job import ScreeningJob, Personal, Education, Experience, ScreenedCandidate
from app.models.admin.committee import TechnicalCommittee
from app.models.admin.users import User
from app.database.db import get_db
from app.utility.jwt import verify_user

class SubmitReviewRequest(BaseModel):
    application_no: str
    status: str
    remarks: Optional[str] = None
    job_id: Optional[int] = None

router = APIRouter(
    prefix = "/candidates",
    tags = ['Candidate Details']
)

def get_logged_in_verifier_remarks(sj: ScreeningJob, user_id: int, user_role: Optional[str] = None):
    """
    Returns the remarks of the user
    """
    if not user_id:
        return {
            "remarks": None,
            "screening_status": None
        }
    if user_role == "approver":
        return {
            "remarks": sj.approver_remarks,
            "screening_status": sj.approver_screening_status
        }
    if sj.verifier1_id == user_id:
        return {
            "remarks": sj.verifier1_remarks,
            "screening_status": sj.verifier1_screening_status
        }
    if sj.verifier2_id == user_id:
        return {
            "remarks": sj.verifier2_remarks,
            "screening_status": sj.verifier2_screening_status
        }
    if sj.approver_id == user_id:
        return {
            "remarks": sj.approver_remarks,
            "screening_status": sj.approver_screening_status
        }
    return {
            "remarks": None,
            "screening_status": None
        }

    

@router.get("", summary="Get candidate details with optional filters")
def get_candidates(
    db: Session = Depends(get_db),
    cycle: str = Query(...),
    post_name: str = Query(...),
    user_id: int = Query(...)
):
    
#     query = (db.query(ScreeningJob, Personal).join(Personal, func.collate(ScreeningJob.application_no,"utf8mb4_general_ci") == func.collate(Personal.application_no,"utf8mb4_general_ci")).filter(
#         ScreeningJob.cycle == cycle,
#         ScreeningJob.post_name == post_name,(
#             (ScreeningJob.verifier1_id == user_id )|
#             (ScreeningJob.verifier2_id == user_id)
#         )
#     )
# )
    user = db.query(User).filter(User.id == user_id).first()
    user_role = user.role if user else None

    if user_role == "approver":
        query = (
            db.query(ScreeningJob, Personal)
            .join(
                Personal, 
                ScreeningJob.application_no.collate("utf8mb4_general_ci") == 
                Personal.application_no.collate("utf8mb4_general_ci")
            )
            .filter(
                ScreeningJob.cycle == cycle,
                ScreeningJob.post_name == post_name,
                ScreeningJob.verification1_status == True,
                ScreeningJob.verification2_status == True
            )
        )
    else:
        query = (
            db.query(ScreeningJob, Personal)
            .join(
                Personal, 
                ScreeningJob.application_no.collate("utf8mb4_general_ci") == 
                Personal.application_no.collate("utf8mb4_general_ci")
            )
            .filter(
                ScreeningJob.cycle == cycle,
                ScreeningJob.post_name == post_name,
                (
                    (ScreeningJob.verifier1_id == user_id) |
                    (ScreeningJob.verifier2_id == user_id) |
                    (ScreeningJob.approver_id == user_id)
                )
            )
        )
    results = query.all()
    response = []

    for sj, p in results:
        verifier_data = get_logged_in_verifier_remarks(sj, user_id, user_role)
        response.append({
            "id": sj.id,
            "application_no": sj.application_no,
            "candidate_name": p.C_name,
            "father_name": p.F_name,
            # verifier status
            "verifier_status": verifier_data["screening_status"],
            "verifier_remarks": verifier_data["remarks"],
            "verifier1_status": sj.verifier1_screening_status or "PENDING",
            "verifier1_remarks": sj.verifier1_remarks or "Action Not Taken",
            "verifier2_status": sj.verifier2_screening_status or "PENDING",
            "verifier2_remarks": sj.verifier2_remarks or "Action Not Taken"
        })
    return response

@router.get("/candidate_details", summary="Get candidate details by application number")
def get_candidate_details(
    db: Session = Depends(get_db),
    application_no: str = Query(...),
):
    sj = db.query(ScreeningJob).filter(ScreeningJob.application_no == application_no).first()
    p = db.query(Personal).filter(Personal.application_no == application_no).first()
    e = db.query(Education).filter(Education.application_no == application_no).first()
    experiences = db.query(Experience).filter(Experience.application_no == application_no).all()

    if not sj or not p:
        return {"error": "Candidate not found"}
    
    experiences_list = []
    for exp in experiences:
        experiences_list.append({
            "name": exp.name,
            "type": exp.type,
            "employment_type": exp.employment_type,
            "designation": exp.designation,
            "from_date": exp.from_date,
            "to_date": exp.to_date,
            "duration": exp.duration,
            "experience": exp.experience,
            "totalDuration": exp.totalDuration
        })

    return{ "personal_details": {
        "id": sj.id,
        "application_no": sj.application_no,
        "candidate_name": p.C_name,
        "father_name": p.F_name,
        "mother_name": p.M_name,
        "date_of_birth": p.DOB,
        "age": p.age,
        "gender": p.gender,
        "category": p.category,
        "category_certificate_no": p.cert_no,
        "category_certificate_issue_date": p.issue_date,
        "category_certificate_issue_state": p.issue_state,
        "disability": p.pwd,
        "type_of_disability": p.type_disability,
        "percentage_of_disability": p.percentage_disability,
        "disability_certificate_no": p.certificate_disability,
        "disability_certificate_issue_date": p.date_of_issue,
        "Ex_serviceman": p.exserve,
        "date_of_joining": p.date_joining,
        "date_of_discharge": p.date_discharge,
        "minority": p.minority,
        "minority_type": p.minority_type,
        "marital_status": p.marital_status,
        "identity_type": p.identity_type,
        "identity_no": p.identity_no,
    },
    "education_details": {
        "qualification": e.qualification,
        "subject": e.subject_,
        "passing_status": e.passing_status,
        "passing_date": e.passing_date,
        "board_name": e.boardName,
        "marking_scheme": e.marking_scheme,
        "obtained_marks_CGPA": e.obtained_marks_CGPA,
        "total_marks_CGPA": e.total_marks_CGPA,
        "class_division": e.class_division
    },
    "experience_details": experiences_list,
    }

@router.post("/submit_review", summary="Submit review for a candidate")
def submit_candidate_review(
    data: SubmitReviewRequest,
    db: Session = Depends(get_db),
    current_user: dict = Depends(verify_user)
):
    user_id = int(current_user.get("sub"))
    
    job = None
    if data.job_id:
        job = db.query(ScreeningJob).filter(ScreeningJob.id == data.job_id).first()
        
    if not job:
        # Fallback to finding the job where this user is assigned
        job = db.query(ScreeningJob).filter(
            ScreeningJob.application_no == data.application_no,
            (
                (ScreeningJob.verifier1_id == user_id) |
                (ScreeningJob.verifier2_id == user_id) |
                (ScreeningJob.approver_id == user_id)
            )
        ).first()

    if not job:
        # Final fallback to first matching application number
        job = db.query(ScreeningJob).filter(ScreeningJob.application_no == data.application_no).first()
        
    if not job:
        raise HTTPException(status_code=404, detail="Screening job not found")
        
    user_obj = db.query(User).filter(User.id == user_id).first()
    user_role = user_obj.role if user_obj else None

    remarks = data.remarks
    if not remarks or not remarks.strip():
        if data.status == "VERIFIED":
            remarks = "Verified by user"
        elif data.status == "REJECTED":
            remarks = "Rejected by user"
        elif data.status == "ON_HOLD":
            remarks = "Onhold by user"
    else:
        remarks = remarks.strip()

    is_assigned = False
    
    if job.verifier1_id == user_id:
        job.verifier1_screening_status = data.status
        job.verifier1_remarks = remarks
        job.verification1_status = True
        is_assigned = True
        
    if job.verifier2_id == user_id:
        job.verifier2_screening_status = data.status
        job.verifier2_remarks = remarks
        job.verification2_status = True
        is_assigned = True

    if user_role == "approver" and job.verification1_status and job.verification2_status:
        job.approver_screening_status = data.status
        job.approver_remarks = remarks
        job.approver_status = True
        job.approver_id = user_id
        is_assigned = True

        committee = db.query(TechnicalCommittee).filter(
            TechnicalCommittee.cycle == job.cycle,
            TechnicalCommittee.post == job.post_name
        ).first()
        if committee:
            if data.status == 'VERIFIED':
                existing = db.query(ScreenedCandidate).filter(
                    ScreenedCandidate.cycle == job.cycle,
                    ScreenedCandidate.post == job.post_name,
                    ScreenedCandidate.application_no == job.application_no
                ).first()
                if not existing:
                    sc = ScreenedCandidate(
                        cycle=job.cycle,
                        post=job.post_name,
                        application_no=job.application_no
                    )
                    db.add(sc)
            else:
                db.query(ScreenedCandidate).filter(
                    ScreenedCandidate.cycle == job.cycle,
                    ScreenedCandidate.post == job.post_name,
                    ScreenedCandidate.application_no == job.application_no
                ).delete()
        
    if not is_assigned:
        raise HTTPException(
            status_code=403, 
            detail="You are not assigned as a verifier for this candidate."
        )
        
    db.commit()
    return {"message": "Review submitted successfully"}


@router.get("/reports/administrative-screening", summary="Get administrative screening report for verifier/approver")
def get_administrative_screening_report(
    cycle: str,
    post_name: str,
    db: Session = Depends(get_db),
    current_user: dict = Depends(verify_user)
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

    user_id = int(current_user.get("sub"))
    user_obj = db.query(User).filter(User.id == user_id).first()
    if not user_obj:
        raise HTTPException(status_code=404, detail="User not found")

    role = user_obj.role
    if role not in ["verifier", "approver", "user"]:
        raise HTTPException(status_code=403, detail="Access denied")

    if role == "verifier":
        query = db.query(ScreeningJob, Personal).join(
            Personal,
            ScreeningJob.application_no.collate("utf8mb4_general_ci") ==
            Personal.application_no.collate("utf8mb4_general_ci")
        ).filter(
            ScreeningJob.cycle == cycle,
            ScreeningJob.post_name == post_name,
            (ScreeningJob.verifier1_id == user_id) | (ScreeningJob.verifier2_id == user_id)
        )
    elif role == "approver":
        query = db.query(ScreeningJob, Personal).join(
            Personal,
            ScreeningJob.application_no.collate("utf8mb4_general_ci") ==
            Personal.application_no.collate("utf8mb4_general_ci")
        ).filter(
            ScreeningJob.cycle == cycle,
            ScreeningJob.post_name == post_name,
            ScreeningJob.approver_id == user_id
        )
    else:
        query = db.query(ScreeningJob, Personal).join(
            Personal,
            ScreeningJob.application_no.collate("utf8mb4_general_ci") ==
            Personal.application_no.collate("utf8mb4_general_ci")
        ).filter(
            ScreeningJob.cycle == cycle,
            ScreeningJob.post_name == post_name,
            (ScreeningJob.verifier1_id == user_id) | (ScreeningJob.verifier2_id == user_id) | (ScreeningJob.approver_id == user_id)
        )

    results = query.all()
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

    completed = 0
    data_list = []

    for sj, p in results:
        job_status = "PENDING"
        job_remarks = "Action Not Taken"
        is_job_completed = False

        if sj.verifier1_id == user_id:
            job_status = sj.verifier1_screening_status or "PENDING"
            job_remarks = sj.verifier1_remarks or "Action Not Taken"
            is_job_completed = bool(sj.verification1_status)
        elif sj.verifier2_id == user_id:
            job_status = sj.verifier2_screening_status or "PENDING"
            job_remarks = sj.verifier2_remarks or "Action Not Taken"
            is_job_completed = bool(sj.verification2_status)
        elif sj.approver_id == user_id:
            job_status = sj.approver_screening_status or "PENDING"
            job_remarks = sj.approver_remarks or "Action Not Taken"
            is_job_completed = bool(sj.approver_status)

        if is_job_completed:
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

        data_list.append({
            "application_no": sj.application_no,
            "candidate_name": p.C_name,
            "father_name": p.F_name,
            "category_and_subcategory": cat_sub,
            "status": job_status,
            "remarks": job_remarks,
            "is_completed": is_job_completed
        })

    if completed < total:
        return {
            "status": "incomplete",
            "message": f"Report cannot be generated. Only {completed} of {total} of your allotted candidates have been fully processed by you.",
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
        "user_name": user_obj.name,
        "user_designation": user_obj.rank,
        "user_role": role,
        "data": data_list
    }
            