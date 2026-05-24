from fastapi import APIRouter, Depends, Query, HTTPException
from sqlalchemy import func
from sqlalchemy.orm import Session
from typing import Optional
from pydantic import BaseModel
from app.models.admin.assign_job import ScreeningJob, Personal, Education, Experience
from app.models.admin.users import User
from app.database.db import get_db
from app.utility.jwt import verify_user

class SubmitReviewRequest(BaseModel):
    application_no: str
    status: str
    remarks: Optional[str] = None

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
            "verifier_remarks": verifier_data["remarks"]
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
    
    job = db.query(ScreeningJob).filter(ScreeningJob.application_no == data.application_no).first()
    if not job:
        raise HTTPException(status_code=404, detail="Screening job not found")
        
    user_obj = db.query(User).filter(User.id == user_id).first()
    user_role = user_obj.role if user_obj else None

    is_assigned = False
    
    if job.verifier1_id == user_id:
        job.verifier1_screening_status = data.status
        job.verifier1_remarks = data.remarks
        job.verification1_status = True
        is_assigned = True
        
    if job.verifier2_id == user_id:
        job.verifier2_screening_status = data.status
        job.verifier2_remarks = data.remarks
        job.verification2_status = True
        is_assigned = True

    if user_role == "approver" and job.verification1_status and job.verification2_status:
        job.approver_screening_status = data.status
        job.approver_remarks = data.remarks
        job.approver_status = True
        job.approver_id = user_id
        is_assigned = True
        
    if not is_assigned:
        raise HTTPException(
            status_code=403, 
            detail="You are not assigned as a verifier for this candidate."
        )
        
    db.commit()
    return {"message": "Review submitted successfully"}
            