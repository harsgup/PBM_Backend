from sqlalchemy import Column, Integer, String
from app.database.db import Base

class User(Base):
    __tablename__ = "users_"

    id = Column(Integer, primary_key=True, index=True)
    pis = Column(String(25), unique=True, index=True, nullable=False)
    password = Column(String(256), nullable=False)