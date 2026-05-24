from dotenv import load_dotenv
from fastapi import FastAPI
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
from app.routes.auth_router import router as auth_router
from app.routes.admin_router import router as admin_router
from app.routes.metadata import router as metadata_router
from app.routes.user_router import router as user_router
from app.database.db import init_db

app = FastAPI()

load_dotenv(dotenv_path="environment.env")

init_db()


origins = [
    "https://scaling-lamp-x5wqxrv4r6gqc6w9j-4200.app.github.dev",
    "https://super-spoon-g46746w9vxv3vx5q-4200.app.github.dev"  
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth_router)
app.include_router(admin_router)
app.include_router(metadata_router)
app.include_router(user_router)