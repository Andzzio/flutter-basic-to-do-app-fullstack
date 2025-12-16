from sqlmodel import create_engine, SQLModel

sqlite_file = "todo.db"
sqlite_url = f"sqlite:///{sqlite_file}"

engine = create_engine(sqlite_url, connect_args={"check_same_thread": False})

def create_db_and_tables():
    SQLModel.metadata.create_all(engine)