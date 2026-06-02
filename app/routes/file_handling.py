import os
from fastapi import APIRouter, Depends, HTTPException, status

from app.schemas.schemas import DocumentRequest


router = APIRouter(prefix="/file", tags=["File Handling"])


@router.post("/document")
def get_document(data: DocumentRequest):
    base_path = f"uploads_files_backend/user_uploads/{data.doc_for}/{data.doc_type}/{data.application_no}"

    for ext in ["png", "jpg", "jpeg"]:
        file_name = f"{data.application_no}_{data.doc_name}.{ext}"
        file_path = os.path.join(base_path, file_name)

        if os.path.exists(file_path):
            return {
                "url": f"/files/user_uploads/{data.doc_for}/{data.doc_type}/{data.application_no}/{file_name}"
            }

    raise HTTPException(status_code=404, detail="Document not found")