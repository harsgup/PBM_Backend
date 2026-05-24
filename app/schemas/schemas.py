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
        orm_mode = True


