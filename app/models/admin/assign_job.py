from sqlalchemy import JSON, Column, Date, DateTime, Float, ForeignKey, Integer, String, Boolean, UniqueConstraint, func
from app.database.db import Base


class ScreeningJob(Base):
    __tablename__ = "screening_jobs"

    id = Column(Integer, primary_key=True, index=True)
    application_no = Column(String(12), index=True)
    cycle = Column(String(50))        
    post_name = Column(String(60))
    verification1_status = Column(Boolean, default=False)
    verification1_assign_status = Column(Boolean, default=False)
    verifier1_id = Column(Integer, nullable=True)
    verifier1_remarks = Column(String(100), nullable=True)
    verifier1_screening_status = Column(String(60), nullable=True)
    verification2_status = Column(Boolean, default=False)
    verification2_assign_status = Column(Boolean, default=False)
    verifier2_id = Column(Integer, nullable=True)
    verifier2_remarks = Column(String(100), nullable=True)
    verifier2_screening_status = Column(String(60), nullable=True)
    approver_id = Column(Integer, nullable=True)
    approver_status = Column(Boolean, default=False)
    approver_assign_status = Column(Boolean, default=False)
    approver_remarks = Column(String(100), nullable=True)
    approver_screening_status = Column(String(60), nullable=True)
    
    __table_args__ = (
        UniqueConstraint('application_no', 'cycle', name='unique_app_cycle'),
    )


class Education(Base):
    __tablename__ = 'education'

    Sno = Column(Integer, primary_key=True, autoincrement=True)
    application_no = Column(String(15), nullable=True)
    qualification = Column(String(100), nullable=True)
    subject_ = Column(String(100), nullable=True)
    passing_status = Column(String(30), nullable=True)
    passing_date = Column(String(30), nullable=True,default='')
    boardName = Column(String(150), nullable=True)
    marking_scheme = Column(String(30), nullable=True,default='')
    obtained_marks_CGPA = Column(Float, nullable=True,default=0.0)
    total_marks_CGPA = Column(Float, nullable=True,default=0.0)
    class_division = Column(String(20),nullable=True)

class Experience(Base):
    __tablename__ = 'experiences'

    id = Column(Integer, primary_key=True, autoincrement=True)
    application_no = Column(String(15), nullable=True)
    name = Column(String(255), nullable=True)
    type = Column(String(50), nullable=True)
    employment_type = Column(String(50), nullable=True)
    designation = Column(String(255), nullable=True)
    from_date = Column(String(30), nullable=True)
    to_date = Column(String(30), nullable=True)
    duration = Column(String(30), nullable=True)
    experience = Column(String(255), nullable=True)
    totalDuration = Column(JSON) 

class Personal(Base):
    __tablename__ = 'personal'

    SN = Column(Integer, primary_key=True, autoincrement=True)
    application_no = Column(String(25), nullable=True)
    post = Column(String(25), nullable=True)
    dicipline = Column(String(25), nullable=True)
    user = Column(String(50), nullable=True)
    C_name = Column(String(50), nullable=True)
    F_name = Column(String(50), nullable=True)
    M_name = Column(String(50), nullable=True)
    gender = Column(String(10), nullable=True)
    category = Column(String(25), nullable=True)
    cert_no = Column(String(25),default = '-')
    issue_date = Column(String(25), default='-')
    issue_state = Column(String(25), default='-')
    marital_status = Column(String(25), nullable=True)
    nationality = Column(String(25), nullable=True)
    pwd = Column(String(25), nullable=True)
    type_disability = Column(String(25), default='-')
    percentage_disability = Column(String(10), default='-')
    certificate_disability = Column(String(25), default='-')
    date_of_issue = Column(String(25), default='-')
    identification = Column(String(25), nullable=True)
    exserve = Column(String(25), nullable=True)
    date_joining = Column(String(25), default='-')
    date_discharge = Column(String(25), default='-')
    minority = Column(String(25), nullable=True)
    minority_type = Column(String(25), nullable=True)
    DOB = Column(String(25), nullable=True) 
    age = Column(String(10), nullable=True)  
    age_relaxation = Column(String(10), nullable=True)
    relaxation_in = Column(String(10), nullable=True) 
    identity_type = Column(String(25), nullable=True)
    identity_no = Column(String(25), nullable=True)

class AdvertMaster(Base):
    __tablename__ = 'advert_master'
    id = Column(Integer, autoincrement=True,primary_key=True)
    advert_name = Column(String(50), nullable=True)
    opening_date = Column(String(30), nullable=True)
    closing_date = Column(String(30), nullable=True)
    file_path = Column(String(255), nullable=True)
    # posts = relationship("Posts", back_populates="advt", primaryjoin="Advert.id == Posts.advt_sn")


class Discipline(Base):
    __tablename__ = 'discipline'
    SN = Column(Integer, autoincrement=True,primary_key=True)
    discipline = Column(String(100), nullable=True)
    post_id = Column(Integer,ForeignKey('posts.post_id',ondelete='RESTRICT'))
    duration_req = Column(String(10), nullable=True)

class Payment(Base):
    __tablename__ = 'payment_status'
    SN = Column(Integer, primary_key=True, index=True)
    application_no = Column(String)
    status = Column(String(15),nullable=True)
    final_status = Column(String(15),default='PENDING')
    payment_id = Column(String(30),default="-")
    pay_date = Column(Date,nullable=True)
    date_time = Column(DateTime, default=func.now(), onupdate=func.now())
