from sqlalchemy import Column, Integer, String, ForeignKey, UniqueConstraint
from sqlalchemy.orm import relationship
from app.database.db import Base

class InterviewCommittee(Base):
    __tablename__ = "interview_committees"

    id = Column(Integer, primary_key=True, index=True)
    cycle = Column(String(50), nullable=False)
    post_name = Column(String(60), nullable=False)

    members = relationship(
        "InterviewCommitteeMember",
        back_populates="committee",
        cascade="all, delete-orphan",
        passive_deletes=True
    )

    __table_args__ = (
        UniqueConstraint('cycle', 'post_name', name='uq_interview_committee_cycle_post'),
    )

class InterviewCommitteeMember(Base):
    __tablename__ = "interview_committee_members"

    id = Column(Integer, primary_key=True, index=True)
    committee_id = Column(Integer, ForeignKey("interview_committees.id", ondelete="CASCADE"), nullable=False)
    member_type = Column(String(100), nullable=False)  # "Chairperson" or "Member" / custom member type
    name = Column(String(200), nullable=False)
    designation = Column(String(200), nullable=False)
    lab_estt = Column(String(200), nullable=False)

    committee = relationship("InterviewCommittee", back_populates="members")
