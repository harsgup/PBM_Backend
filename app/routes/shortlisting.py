from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import and_, case
from sqlalchemy.orm import Session
from app.database.db import get_db
from app.models.admin.assign_job import Education, Experience, Personal, ScreeningJob
from app.models.admin.committee import TechnicalCommittee
from app.models.admin.technical_screening import TechnicalScreening
from app.schemas.schemas import ScreeningJobSchema, TechnicalScreeningCreate,ScreeningRequest


router = APIRouter(prefix="/shortlisting", tags=["Shortlisting"])

@router.post("/shortlisting-jobs", response_model=list[ScreeningJobSchema])
def get_shortlisting_jobs(request_data: ScreeningRequest,db: Session = Depends(get_db)):
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
        status_expression 
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
        ScreeningJob.approver_status == 1,
        ScreeningJob.cycle == cycle,
        ScreeningJob.post_name == post_name
    ).all()