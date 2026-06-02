from sqlalchemy import Column, Integer, String, UniqueConstraint
from app.database.db import Base

class TechnicalCommittee(Base):
    __tablename__ = "technical_committees"

    id = Column(Integer, primary_key=True, index=True)

    committee_name = Column(String(200), nullable=False,unique=True)
    lab_rep = Column(String(200), nullable=False)
    external_member = Column(String(200), nullable=False)
    subject_expert = Column(String(200), nullable=False)
    chairman = Column(String(200), nullable=False)
    cycle = Column(String(50), nullable=False)
    post = Column(String(200), nullable=False)

    __table_args__ = (
        UniqueConstraint('cycle', 'post', name='uq_technical_committee_cycle_post'),
    )