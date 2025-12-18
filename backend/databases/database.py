from sqlmodel import SQLModel, create_engine

db_name = "todo.db"
db_route = f"sqlite:///{db_name}"

engine = create_engine(db_route, connect_args={"check_same_thread": False})

def create_db_and_tables():
    SQLModel.metadata.create_all(engine)