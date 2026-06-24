from sqlalchemy import Column, Integer, String, ForeignKey
from app.database.db import Base

class ShortlistCandidateForInterview(Base):
    __tablename__ = "shortlist_candidate_for_interview"

    sno = Column(Integer, primary_key=True, autoincrement=True)
    application_no = Column(String(25), nullable=False)
    cycle = Column(String(50), nullable=False)
    post_name = Column(String(60), nullable=False)
    technical_committee_name = Column(String(100), nullable=False)
    marks = Column(Integer, nullable=True)
    technical_screening_remarks = Column(String(500), nullable=True)
    status = Column(String(50), default="pending")
    interview_committee_id = Column(Integer, ForeignKey("interview_committees.id", ondelete="SET NULL"), nullable=True)

