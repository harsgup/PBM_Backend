from typing import Literal
from pydantic import BaseModel


class TokenResponse(BaseModel):
    access_token: str
    token_type: str = "bearer"


class AddUserRequest(BaseModel):
    pis: str
    name: str
    rank: str
    role: str
    password: str


class UserResponse(BaseModel):
    id: int
    pis: str
    name: str
    rank: str
    role: str


class UpdateUserRoleRequest(BaseModel):
    role: Literal["user", "verifier", "approver"]
    


class BuildScreeningJobRequest(BaseModel):
    cycle: str

class AssignJobRequest(BaseModel):
    cycle: str
    post_name: str
    role: Literal["verifier", "approver"]
    verifier_group: Literal["V1", "V2"] | None = None
    user_id: int
    count: int
    assign_type: Literal["random", "continuous"]

class AssignedJobResponse(BaseModel):
    id: int
    cycle: str
    post_name: str
    application_no: str
    status: str


    class Config:
        from_attributes = True

# ------------------------------------------------------------------
# Deepak's code for technical committee
# ------------------------------------------------------------------
class TechnicalCommitteeCreate(BaseModel):
    cycle: str
    post: str
    committee_name: str
    chairman: str
    lab_rep: str
    external_member: str
    subject_expert: str


class TechnicalCommitteeResponse(BaseModel):
    id: int
    cycle: str
    post: str
    committee_name: str
    chairman: str
    lab_rep: str
    external_member: str
    subject_expert: str

    class Config:
        orm_mode = True

class ScreeningJobSchema(BaseModel):
    id: int
    application_no: str
    cycle: str
    post_name: str
    approver_remarks: str | None
    committee_name:str
    status: str
    candidate_name: str | None = None
    marks: int | None = None
    remarks: str | None = None
    category: str | None = None
    pwd: str | None = None
    shortlisted: bool | None = None
    
class TechnicalScreeningCreate(BaseModel):
    application_no: str
    cycle:str
    post_name:str
    committee_id: int
    final_marks: int
    remarks: str | None = None


class DocumentRequest(BaseModel):
    application_no: str
    doc_type: str
    doc_name: str
    doc_for:str
    
class ScreeningRequest(BaseModel):
    cycle: str
    post_name: str
    
    class Config:
        orm_mode = True

class ShortlistRequest(BaseModel):
    application_nos: list[str]
    action: str


class InterviewMemberSchema(BaseModel):
    member_type: str
    name: str
    designation: str
    lab_estt: str

    class Config:
        from_attributes = True
        orm_mode = True


class InterviewCommitteeCreate(BaseModel):
    cycle: str
    post_name: str
    members: list[InterviewMemberSchema]


class InterviewCommitteeResponse(BaseModel):
    id: int
    cycle: str
    post_name: str
    members: list[InterviewMemberSchema]

    class Config:
        from_attributes = True
        orm_mode = True
