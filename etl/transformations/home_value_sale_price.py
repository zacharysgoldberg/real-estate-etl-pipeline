# Databricks notebook source
# MAGIC %run "../includes/configuration"

# COMMAND ----------

# MAGIC %run "../includes/common_functions"

# COMMAND ----------

from pyspark.sql.functions import current_timestamp, col, countDistinct, to_date, monotonically_increasing_id, round
from pyspark.sql import Row
import pyspark.sql.functions as F
from pyspark.sql.functions import lit

# COMMAND ----------

home_value_df = spark.read.format("delta").load(f"{processed_folder_path}/home_value") 

# COMMAND ----------

sale_price_df = spark.read.format("delta").load(f"{processed_folder_path}/sale_price") 

# COMMAND ----------

final_df = home_value_df.alias('a')\
.join(sale_price_df.alias('b'), home_value_df.id == sale_price_df.id)\
.select('a.id', "a.region", "a.size_rank", "a.date", "a.mean_home_value", "b.median_sale_price", "b.data_source")\
.withColumn("created_at", current_timestamp())

# COMMAND ----------

display(final_df)

# COMMAND ----------

# overwrite_partition(final_df, 're_presentation', 'results', 'date')

# COMMAND ----------

merge_condition = 'tgt.id = src.id AND tgt.date = src.date'
merge_delta_data(final_df, 're_presentation', 'results', presentation_folder_path, merge_condition, 'date')

# COMMAND ----------

# MAGIC %sql SHOW PARTITIONS re_presentation.results;

# COMMAND ----------

from delta.tables import DeltaTable

# COMMAND ----------

if DeltaTable.isDeltaTable(spark, f"{presentation_folder_path}/results"):
    print('True')
else:
    print('False')

# COMMAND ----------

# MAGIC %sql SELECT COUNT(date) FROM re_presentation.results;

# COMMAND ----------

