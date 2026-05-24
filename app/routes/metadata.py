from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session 
from sqlalchemy import distinct
from app.database.db import get_db
from app.models.admin.assign_job import ScreeningJob
from app.schemas.schemas_screen import CycleResponse, PostResponse

router = APIRouter(
    prefix = "/metadata",
    tags = ['Metadata']
)

@router.get('/cycles', response_model=list[CycleResponse])
def cycle_names(db: Session = Depends(get_db)):
    cycles = (db.query(distinct(ScreeningJob.cycle))
              .filter(ScreeningJob.cycle.isnot(None))
              .order_by(ScreeningJob.cycle)
              .all()
              )
    
    return ([{'id': i+1, 'name': c[0]} for i,c in enumerate(cycles)])

@router.get('/post_names', response_model=list[PostResponse])
def post_names(db: Session = Depends(get_db)):
    posts = (db.query(distinct(ScreeningJob.post_name))
                      .filter(ScreeningJob.post_name.isnot(None))
                      .order_by(ScreeningJob.post_name)
                      .all()
                      )
    
    return ([{'id': i+1, 'name': p[0]} for i, p in enumerate(posts)])
