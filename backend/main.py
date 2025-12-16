from fastapi import FastAPI, Depends, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from sqlmodel import Session, select
from databases.database import create_db_and_tables, engine
from models.task import Task
from contextlib import asynccontextmanager

def get_session():
    with Session(engine) as session:
        yield session

@asynccontextmanager
async def life_span(app: FastAPI):
    create_db_and_tables()
    yield


app = FastAPI(lifespan=life_span)

app.add_middleware(CORSMiddleware, allow_origins=["*"], allow_credentials=True, allow_headers=["*"], allow_methods=["*"])

@app.post("/tasks")
def create_task(task: Task, session: Session = Depends(get_session)):
    session.add(task)
    session.commit()
    session.refresh(task)
    
    return task

@app.get("/tasks")
def read_tasks(session: Session = Depends(get_session)):
    query = select(Task)
    
    tasks = session.exec(query).all()
    
    return tasks

@app.put("/tasks/{task_id}")
def update_task(task_id: int, task_new_data: Task, session: Session = Depends(get_session)):
    db_task = session.get(Task, task_id)
    
    if not db_task:
        raise HTTPException(status_code=404, detail="Task not found")
    
    db_task.title = task_new_data.title
    db_task.completed = task_new_data.completed
    
    session.add(db_task)
    session.commit()
    session.refresh(db_task)
    
    return db_task

@app.delete("/tasks/{task_id}")
def delete_task(task_id: int, session: Session = Depends(get_session)):
    db_task = session.get(Task, task_id)
    
    if not db_task:
        raise HTTPException(status_code=404, detail="Task not found")
    
    session.delete(db_task)
    session.commit()
    
    return {"ok": True}