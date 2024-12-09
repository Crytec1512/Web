from fastapi import FastAPI, Depends, Query
from sqlalchemy.orm import Session
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy import Column, Integer, String
from typing import List
from pydantic import BaseModel
from typing import Optional
from fastapi.middleware.cors import CORSMiddleware

DATABASE_URL = "postgresql://api_user:12345@localhost/web"

engine = create_engine(DATABASE_URL)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

class Student(Base):
    __tablename__ = 'students'

    surname = Column(String, primary_key=True, nullable=False)
    name = Column(String, primary_key=True, nullable=False)
    patronymic = Column(String)
    course = Column(Integer, nullable=False)
    group_name = Column(String, primary_key=True, nullable=False)
    faculty = Column(String, nullable=False)

Base.metadata.create_all(bind=engine)

app = FastAPI()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

class StudentSchema(BaseModel):
    surname: str
    name: str
    patronymic: Optional[str] = None
    course: int
    group_name: str
    faculty: str

    class Config:
        orm_mode = True

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost", "http://127.0.0.1"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/api/data", response_model=List[StudentSchema])
def get_all_students(
    db: Session = Depends(get_db),
    page: int = Query(1, ge=1),
    size: int = Query(10, le=100)
):
    # Рассчитываем пропуск записей для пагинации
    skip = (page - 1) * size

    # Получаем записи с сортировкой, чтобы они шли в одном и том же порядке
    print(f"skip={skip}, size={size}")  # Добавьте вывод в консоль для отладки
    students = db.query(Student).order_by(Student.surname).offset(skip).limit(size).all()
    print(f"Fetched {len(students)} students") 


    return students
