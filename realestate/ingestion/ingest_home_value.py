# Databricks notebook source
# dbutils.widgets.help()

# COMMAND ----------

dbutils.widgets.text("p_data_source", "")
v_data_source = dbutils.widgets.get('p_data_source')

# COMMAND ----------

# MAGIC %run "../includes/configuration"

# COMMAND ----------

# MAGIC %run "../includes/common_functions"

# COMMAND ----------

from pyspark.sql.functions import current_timestamp, col


# COMMAND ----------

home_value_df = spark.read\
    .option('header', True)\
    .option('inferSchema', True)\
    .csv(f'{raw_folder_path}/home_value.csv')\
    .drop('RegionType')

# COMMAND ----------

from pyspark.sql.functions import lit

# COMMAND ----------

home_value_renamed_df = home_value_df\
    .withColumnRenamed('RegionID', 'region_id')\
    .withColumnRenamed('SizeRank', 'size_rank')\
    .withColumnRenamed('RegionName', 'region')\
    .withColumnRenamed('StateName', 'state')\
    .withColumn("data_source", lit(v_data_source))

# COMMAND ----------

home_value_final_df = add_ingestion_date(home_value_renamed_df)


# COMMAND ----------

# home_value_final_df.write.mode("overwrite").parquet(f"{processed_folder_path}/home_value")
home_value_final_df.write.mode("overwrite").format("parquet").saveAsTable("re_processed.home_value")

# COMMAND ----------

display(spark.read.parquet(f"{processed_folder_path}/home_value"))

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT * FROM re_processed.home_value;

# COMMAND ----------

dbutils.notebook.exit("Success")

# COMMAND ----------

