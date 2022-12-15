# Databricks notebook source
# MAGIC %run "../includes/configuration"

# COMMAND ----------

jdbc_hostname = dbutils.secrets.get(scope="realestate-scope", key="realestate-app-jdbc-hostname")
jdbc_port = dbutils.secrets.get(scope="realestate-scope", key="realestate-app-jdbc-port")
jdbc_database = dbutils.secrets.get(scope="realestate-scope", key="realestate-app-jdbc-database")
jdbc_user = dbutils.secrets.get(scope="realestate-scope", key="realestate-app-jdbc-user")
jdbc_password = dbutils.secrets.get(scope="realestate-scope", key="realestate-app-jdbc-password")
properties = {
    "user": f"{jdbc_user}",
    "password": f"{jdbc_password}",
    "driver": "com.microsoft.sqlserver.jdbc.SQLServerDriver"
}
    
# "driver": "org.postgresql.Driver" 

# COMMAND ----------

url = f"jdbc:sqlserver://{jdbc_hostname}:{jdbc_port};database={jdbc_database};user={properties['user']}@realestate-etl-server;password={properties['password']};encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;"

# COMMAND ----------

df = spark.sql("SELECT * FROM re_presentation.final_results_for_viz")

# COMMAND ----------

from pyspark.sql import DataFrameWriter
import pandas as pd

# COMMAND ----------

final_df = DataFrameWriter(df)

# COMMAND ----------

final_df.jdbc(url=url, table="results", mode="overwrite", properties=properties)

# COMMAND ----------


