# Databricks notebook source
dbutils.widgets.text("p_data_source", "")
v_data_source = dbutils.widgets.get('p_data_source')

# COMMAND ----------

# MAGIC %run "../includes/configuration"

# COMMAND ----------

# MAGIC %run "../includes/common_functions"

# COMMAND ----------

from pyspark.sql.functions import current_timestamp, col, lit


# COMMAND ----------

median_sale_price_df = spark.read\
    .option('header', True)\
    .option('inferSchema', True)\
    .csv(f'{raw_folder_path}/median_sale_price.csv')\
    .drop('RegionType')

# COMMAND ----------

median_sale_price_renamed_df = median_sale_price_df\
    .withColumnRenamed('RegionID', 'region_id')\
    .withColumnRenamed('SizeRank', 'size_rank')\
    .withColumnRenamed('RegionName', 'region')\
    .withColumnRenamed('StateName', 'state')\
    .withColumn("data_source", lit(v_data_source))

# COMMAND ----------

median_sale_price_renamed_df.printSchema()


# COMMAND ----------

median_sale_price_final_df = add_ingestion_date(median_sale_price_renamed_df)

# COMMAND ----------

# median_sale_price_final_df.write.mode("overwrite").parquet(f"{processed_folder_path}/median_sale_price")
median_sale_price_final_df.write.mode('overwrite').format('parquet').saveAsTable("re_processed.median_sale_price")

# COMMAND ----------

display(spark.read.parquet(f"{processed_folder_path}/median_sale_price"))

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT * FROM re_processed.median_sale_price;

# COMMAND ----------

dbutils.notebook.exit("Success")