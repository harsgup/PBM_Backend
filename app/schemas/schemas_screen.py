from typing import Literal
from pydantic import BaseModel

class CycleResponse(BaseModel):
    id: int
    name: str

class PostResponse(BaseModel):
    id: int
    name: str