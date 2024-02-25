# from sqlalchemy.ext.declarative import declarative_base
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Column, Integer, Date, String, Numeric, DateTime

# Base = declarative_base()

db = SQLAlchemy()


class Result(db.Model):
    __tablename__ = 'results'
    id = Column(Integer, primary_key=True, autoincrement=True)
    city = Column(String, nullable=False)
    state = Column(String, nullable=False)
    size_rank = Column(Integer, nullable=False)
    date = Column(Date, nullable=False)
    mean_home_value = Column(Numeric, nullable=True)
    mean_sale_price = Column(Numeric, nullable=True)
    one_year_growth = Column(Numeric, nullable=False)
    data_source = Column(String)
    created_at = Column(DateTime)
