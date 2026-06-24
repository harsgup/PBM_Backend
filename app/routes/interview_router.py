from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.database.db import get_db
from app.models.admin.interview import InterviewCommittee, InterviewCommitteeMember
from app.models.admin.shortlist_candidate_for_interview import ShortlistCandidateForInterview
from app.models.admin.assign_job import Personal
from app.schemas.schemas import InterviewCommitteeCreate, InterviewCommitteeResponse, ShortlistedCandidateResponse

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

    # 3. Connect shortlisted candidates in the same cycle & post to this committee
    db.query(ShortlistCandidateForInterview).filter(
        ShortlistCandidateForInterview.cycle == payload.cycle,
        ShortlistCandidateForInterview.post_name == payload.post_name
    ).update({ShortlistCandidateForInterview.interview_committee_id: committee.id})

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

@router.get("/committees", response_model=list[InterviewCommitteeResponse])
def get_all_interview_committees(cycle: str | None = None, post_name: str | None = None, db: Session = Depends(get_db)):
    query = db.query(InterviewCommittee)
    if cycle:
        query = query.filter(InterviewCommittee.cycle == cycle)
    if post_name:
        query = query.filter(InterviewCommittee.post_name == post_name)
    return query.all()

@router.delete("/committee/{id}")
def delete_interview_committee(id: int, db: Session = Depends(get_db)):
    committee = db.query(InterviewCommittee).filter(InterviewCommittee.id == id).first()
    if not committee:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Interview Committee with ID {id} not found."
        )
    try:
        db.delete(committee)
        db.commit()
    except Exception as e:
        db.rollback()
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to delete Interview Committee: {str(e)}"
        )
    return {"message": "Interview Committee deleted successfully."}

@router.get("/shortlisted-candidates", response_model=list[ShortlistedCandidateResponse])
def get_shortlisted_candidates(cycle: str, post_name: str, db: Session = Depends(get_db)):
    results = db.query(
        ShortlistCandidateForInterview.application_no,
        Personal.C_name.label("candidate_name"),
        Personal.F_name.label("father_name"),
        Personal.category
    ).join(
        Personal,
        ShortlistCandidateForInterview.application_no == Personal.application_no
    ).filter(
        ShortlistCandidateForInterview.cycle == cycle,
        ShortlistCandidateForInterview.post_name == post_name
    ).all()
    
    return results
