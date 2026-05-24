from sqlalchemy import Column, Integer, String
from app.database.db import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    pis = Column(String(10), unique=True, index=True, nullable=False)
    name = Column(String(30), nullable=False)
    rank = Column(String(30), nullable=False)
    role = Column(String(30), nullable=False, default="user")
    password = Column(String(255), nullable=False)