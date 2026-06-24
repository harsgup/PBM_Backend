from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.database.db import get_db
from app.models.admin.interview import InterviewCommittee, InterviewCommitteeMember
from app.schemas.schemas import InterviewCommitteeCreate, InterviewCommitteeResponse

router = APIRouter(prefix="/interview", tags=["Interview"])

@router.post("/committee", response_model=InterviewCommitteeResponse)
def save_interview_committee(payload: InterviewCommitteeCreate, db: Session = Depends(get_db)):
    # 1. Validation logic: Minimum 3 members (including chairperson)
    if len(payload.members) < 3:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Minimum 3 members (including Chairperson) are required."
        )

    # 2. Check if there is exactly one Chairperson
    chairperson_count = sum(1 for m in payload.members if m.member_type.lower() == "chairperson")
    if chairperson_count == 0:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="A Chairperson details must be provided."
        )
    elif chairperson_count > 1:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Only one Chairperson can be assigned to the committee."
        )

    # Find if a committee already exists for this cycle and post_name
    committee = db.query(InterviewCommittee).filter(
        InterviewCommittee.cycle == payload.cycle,
        InterviewCommittee.post_name == payload.post_name
    ).first()

    if committee:
        # Clear members relationship. cascade="all, delete-orphan" will delete old records
        committee.members.clear()
    else:
        # Create a new InterviewCommittee
        committee = InterviewCommittee(
            cycle=payload.cycle,
            post_name=payload.post_name
        )
        db.add(committee)
        db.flush()

    # Add the new members
    for m in payload.members:
        member = InterviewCommitteeMember(
            committee_id=committee.id,
            member_type=m.member_type,
            name=m.name,
            designation=m.designation,
            lab_estt=m.lab_estt
        )
        db.add(member)

    try:
        db.commit()
        db.refresh(committee)
    except Exception as e:
        db.rollback()
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to save Interview Committee: {str(e)}"
        )

    return committee

@router.get("/committee", response_model=InterviewCommitteeResponse)
def get_interview_committee(cycle: str, post_name: str, db: Session = Depends(get_db)):
    committee = db.query(InterviewCommittee).filter(
        InterviewCommittee.cycle == cycle,
        InterviewCommittee.post_name == post_name
    ).first()

    if not committee:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"No Interview Committee found for cycle '{cycle}' and post '{post_name}'."
        )

    return committee
