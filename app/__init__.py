from flask import Flask
from dotenv import load_dotenv
from .models import db
import urllib.parse
from .routers import market_data
import os
import pyodbc
import logging

load = load_dotenv()


def create_app():
    app = Flask(__name__, template_folder='src/templates')

    drivers = [item for item in pyodbc.drivers()]
    logging.warning(drivers)

    params = urllib.parse.quote_plus(
        "Driver={0};Server=tcp:{1},1433;Database={2};Uid={3};Pwd={4};Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;".format("{ODBC Driver 13 for SQL Server}",
                                                                                                                                          os.getenv("DB_HOST"), os.getenv("DB_NAME"), os.getenv("DB_USER"), os.getenv("DB_PASSWORD"))
    )

    app.config.from_mapping(
        SECRET_KEY='dev',
        SQLALCHEMY_DATABASE_URI=f'mssql+pyodbc:///?odbc_connect={params}',
        SQLALCHEMY_TRACK_MODIFICATIONS=False,
        SQLALCHEMY_ECHO=True
    )

    db.init_app(app)

    app.register_blueprint(market_data.bp)

    return app

    # engine = create_engine(os.getenv("DATABRICKS_URL"),
    #                        connect_args={"http_path": os.getenv("HTTP_PATH")},
    #                        )

    # SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

    # session = SessionLocal()
