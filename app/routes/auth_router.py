from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.database.db import get_db
from app.models.admin.users import User
from app.schemas.schemas import  TokenResponse
from app.utility.security import verify_password, hash_password
from app.utility.jwt import create_access_token
import bcrypt
from fastapi.security import OAuth2PasswordRequestForm

router = APIRouter(prefix="/auth", tags=["Auth"])

@router.post("/login", response_model=TokenResponse)
def login(form_data: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(get_db)):

    user = db.query(User).filter(User.pis == form_data.username).first()
    if not user:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,detail="Invalid PIS or password")
 
    if not verify_password(form_data.password,user.password):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,detail="Invalid  password")


    token = create_access_token({
    "sub": str(user.id),
    "role": user.role,
    "name": user.name
})

    return {
        "access_token": token,
        "token_type": "bearer"
    }

