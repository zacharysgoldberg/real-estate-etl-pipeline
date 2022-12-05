# Databricks notebook source
dbutils.widgets.text("p_data_source", "")
v_data_source = dbutils.widgets.get('p_data_source')

# COMMAND ----------

# MAGIC %run "../includes/configuration"

# COMMAND ----------

# MAGIC %run "../includes/common_functions"

# COMMAND ----------

from pyspark.sql.functions import current_timestamp, col
from pyspark.sql.types import StructType, StructField, IntegerType, StringType, FloatType, DateType

# COMMAND ----------

home_growth_df = spark.read\
    .option('header', True)\
    .option('inferSchema', True)\
    .csv(f'{raw_folder_path}/home_growth.csv')\
    .drop('RegionType')

# COMMAND ----------

home_growth_df.printSchema()

# COMMAND ----------

from pyspark.sql.functions import lit

# COMMAND ----------

home_growth_renamed_df = home_growth_df\
    .withColumnRenamed('RegionID', 'region_id')\
    .withColumnRenamed('SizeRank', 'size_rank')\
    .withColumnRenamed('RegionName', 'region')\
    .withColumnRenamed('StateName', 'state')\
    .withColumnRenamed('BaseDate', 'base_date')\
    .withColumn("data_source", lit(v_data_source))

# COMMAND ----------

home_growth_final_df = add_ingestion_date(home_growth_renamed_df)

# COMMAND ----------

# home_growth_final_df.write.mode("overwrite").parquet(f"{processed_folder_path}/home_growth")
home_growth_final_df.write.mode("overwrite").format("parquet").saveAsTable("re_processed.home_growth")

# COMMAND ----------

display(spark.read.parquet(f"{processed_folder_path}/home_growth"))

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT * FROM re_processed.home_growth;

# COMMAND ----------

dbutils.notebook.exit("Success")