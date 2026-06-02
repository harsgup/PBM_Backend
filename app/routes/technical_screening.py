from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import and_, case
from sqlalchemy.orm import Session
from app.database.db import get_db
from app.models.admin.assign_job import Education, Experience, Personal, ScreeningJob
from app.models.admin.committee import TechnicalCommittee
from app.models.admin.technical_screening import TechnicalScreening
from app.schemas.schemas import ScreeningJobSchema, TechnicalScreeningCreate,ScreeningRequest

router = APIRouter(prefix="/technical", tags=["Technical"])

@router.post("/technical-screening-job", response_model=list[ScreeningJobSchema])
def get_technical_screening_jobs(request_data: ScreeningRequest,db: Session = Depends(get_db)):
    cycle = request_data.cycle
    post_name = request_data.post_name

    status_expression = case((TechnicalScreening.application_no == None, "pending"),else_=TechnicalScreening.status).label("status")

    return db.query(
        ScreeningJob.id,
        ScreeningJob.application_no,
        ScreeningJob.cycle,
        ScreeningJob.post_name,
        ScreeningJob.approver_remarks,
        TechnicalCommittee.committee_name,
        status_expression,
        Personal.C_name.label("candidate_name"),
        TechnicalScreening.final_marks.label("marks"),
        TechnicalScreening.remarks.label("remarks")
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
    ).filter(
        ScreeningJob.approver_status == 1,
        ScreeningJob.cycle == cycle,
        ScreeningJob.post_name == post_name
    ).all()

@router.put("/test/{id}")
def update_committee(committee_id: int, db: Session = Depends(get_db)
):

    committee = db.query(ScreeningJob).filter(ScreeningJob.id == committee_id).first()

    if not committee:
        raise HTTPException(status_code=404, detail="Committee not found")

    committee.approver_status = 1
    committee.approver_remarks = 'GG'

    db.commit()

    return {"message": "Committee updated"}


@router.get("/committee-details/{name}")
def get_committee_details(name: str, db: Session = Depends(get_db)):
    committee = db.query(TechnicalCommittee).filter(TechnicalCommittee.committee_name == name).first()
    
    if not committee:
        raise HTTPException(status_code=404, detail="Committee not found")
        
    return committee


@router.get("/technical-evaluation/{application_no}")
def get_candidate_details(application_no: str, db: Session = Depends(get_db)):

    personal = db.query(Personal).filter(
        Personal.application_no == application_no
    ).first()

    education = db.query(Education).filter(
        Education.application_no == application_no
    ).all()

    experience = db.query(Experience).filter(
        Experience.application_no == application_no
    ).all()

    return {
        "personal": personal,
        "education": education,
        "experience": experience
    }

@router.get("/technical-screening/{application_no}")
def get_existing_evaluation(
    application_no: str,
    db: Session = Depends(get_db)
):

    record = db.query(TechnicalScreening).filter(
        TechnicalScreening.application_no == application_no
    ).first()

    return record


@router.post("/technical-screening")
def submit_technical_screening(data: TechnicalScreeningCreate,db: Session = Depends(get_db)):

    existing = db.query(TechnicalScreening).filter(TechnicalScreening.application_no == data.application_no).first()

    if existing:
        existing.committee_id = data.committee_id
        existing.final_marks = data.final_marks
        existing.remarks = data.remarks
        existing.status = "complete"

        db.commit()

        return {"message": "Evaluation updated successfully"}

    else:
        screening = TechnicalScreening(
            application_no=data.application_no,
            cycle = data.cycle,
            post_name = data.post_name,
            committee_id=data.committee_id,
            final_marks=data.final_marks,
            remarks=data.remarks,
            status="complete" 
        )

        db.add(screening)
        db.commit()

        return {"message": "Evaluation submitted successfully"}