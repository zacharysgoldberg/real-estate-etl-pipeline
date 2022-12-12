import os
from dotenv import load_dotenv
from sqlalchemy import *
from sqlalchemy.engine import create_engine
from sqlalchemy.orm import sessionmaker


load = load_dotenv()

engine = create_engine(os.getenv("DATABRICKS_URL"),
                       connect_args={"http_path": os.getenv("HTTP_PATH")},
                       )

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

session = SessionLocal()
