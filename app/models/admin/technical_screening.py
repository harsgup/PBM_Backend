from sqlalchemy import Column, Integer, String, ForeignKey
from app.database.db import Base


class TechnicalScreening(Base):
    __tablename__ = "technical_screening"

    id = Column(Integer, primary_key=True, index=True)
    cycle = Column(String(50),nullable=False)        
    post_name = Column(String(60),nullable=False)
    application_no = Column(String(20),nullable=False)
    committee_id = Column(Integer,ForeignKey("technical_committees.id"),nullable=False)
    final_marks = Column(Integer, nullable=False)
    remarks = Column(String(500))
    suitable = Column(String(50), nullable=True)   
    status = Column(String(50), default="pending") 