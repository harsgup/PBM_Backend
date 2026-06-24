from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import and_, case
from sqlalchemy.orm import Session
from app.database.db import get_db
from app.models.admin.assign_job import Education, Experience, Personal, ScreeningJob
from app.models.admin.committee import TechnicalCommittee
from app.models.admin.technical_screening import TechnicalScreening
from app.models.admin.shortlist_candidate_for_interview import ShortlistCandidateForInterview
from app.schemas.schemas import ScreeningJobSchema, TechnicalScreeningCreate, ScreeningRequest, ShortlistRequest

router = APIRouter(prefix="/shortlisting", tags=["Shortlisting"])

@router.post("/shortlisting-jobs", response_model=list[ScreeningJobSchema])
def get_shortlisting_jobs(request_data: ScreeningRequest, db: Session = Depends(get_db)):
    cycle = request_data.cycle
    post_name = request_data.post_name

    status_expression = case(
        (TechnicalScreening.application_no == None, "pending"),
        else_=TechnicalScreening.status
    ).label("status")

    shortlisted_expression = case(
        (ShortlistCandidateForInterview.application_no != None, True),
        else_=False
    ).label("shortlisted")

    return db.query(
        ScreeningJob.id,
        ScreeningJob.application_no,
        ScreeningJob.cycle,
        ScreeningJob.post_name,
        ScreeningJob.approver_remarks,
        TechnicalCommittee.committee_name,
        status_expression,
        Personal.C_name.label("candidate_name"),
        Personal.category.label("category"),
        Personal.pwd.label("pwd"),
        TechnicalScreening.final_marks.label("marks"),
        TechnicalScreening.remarks.label("remarks"),
        shortlisted_expression
    ).join(
        TechnicalCommittee,
        and_(
            ScreeningJob.cycle == TechnicalCommittee.cycle,
            ScreeningJob.post_name == TechnicalCommittee.post
        )
    ).join(
        Personal,
        ScreeningJob.application_no.collate("utf8mb4_general_ci") == 
        Personal.application_no.collate("utf8mb4_general_ci")
    ).outerjoin( 
        TechnicalScreening,
        ScreeningJob.application_no == TechnicalScreening.application_no
    ).outerjoin(
        ShortlistCandidateForInterview,
        ScreeningJob.application_no == ShortlistCandidateForInterview.application_no
    ).filter(
        ScreeningJob.approver_status == 1,
        ScreeningJob.cycle == cycle,
        ScreeningJob.post_name == post_name
    ).all()

@router.post("/shortlist")
def shortlist_candidates(data: ShortlistRequest, db: Session = Depends(get_db)):
    action = data.action
    application_nos = data.application_nos
    
    if action == "shortlist":
        for app_no in application_nos:
            existing = db.query(ShortlistCandidateForInterview).filter(
                ShortlistCandidateForInterview.application_no == app_no
            ).first()
            if existing:
                continue
                
            candidate_info = db.query(
                ScreeningJob.cycle,
                ScreeningJob.post_name,
                TechnicalCommittee.committee_name,
                TechnicalScreening.final_marks,
                TechnicalScreening.remarks,
                TechnicalScreening.status
            ).join(
                TechnicalCommittee,
                and_(
                    ScreeningJob.cycle == TechnicalCommittee.cycle,
                    ScreeningJob.post_name == TechnicalCommittee.post
                )
            ).outerjoin(
                TechnicalScreening,
                ScreeningJob.application_no == TechnicalScreening.application_no
            ).filter(
                ScreeningJob.application_no == app_no
            ).first()
            
            if not candidate_info:
                raise HTTPException(status_code=404, detail=f"Candidate job not found for {app_no}")
                
            shortlist_rec = ShortlistCandidateForInterview(
                application_no=app_no,
                cycle=candidate_info.cycle,
                post_name=candidate_info.post_name,
                technical_committee_name=candidate_info.committee_name,
                marks=candidate_info.final_marks,
                technical_screening_remarks=candidate_info.remarks,
                status=candidate_info.status or "pending"
            )
            db.add(shortlist_rec)
            
        db.commit()
        return {"message": "Candidates shortlisted successfully"}
        
    elif action == "revert":
        for app_no in application_nos:
            db.query(ShortlistCandidateForInterview).filter(
                ShortlistCandidateForInterview.application_no == app_no
            ).delete()
        db.commit()
        return {"message": "Shortlist reverted successfully"}
        
    else:
        raise HTTPException(status_code=400, detail="Invalid action")