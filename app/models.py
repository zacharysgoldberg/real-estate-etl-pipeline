from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import create_engine

db = SQLAlchemy()


# One to Many Tables


class HomeValue(db.model):
    __tablename__ = 'home_value'

# [Many to Many Table]
