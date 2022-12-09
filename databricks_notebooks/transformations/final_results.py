# Databricks notebook source
# MAGIC %run "../includes/configuration"

# COMMAND ----------

# MAGIC %run "../includes/common_functions"

# COMMAND ----------

from pyspark.sql import Row
import pyspark.sql.functions as F
from pyspark.sql.functions import count, countDistinct, lit, col, round, split, mean, first, monotonically_increasing_id
from pyspark.sql.types import DoubleType, StringType

# COMMAND ----------

home_value_sale_price_df = spark.read.format("delta").load(f"{presentation_folder_path}/results") 

# COMMAND ----------

display(home_value_sale_price_df)

# COMMAND ----------

home_growth_df = spark.read.format("delta").load(f"{processed_folder_path}/home_growth") 

# COMMAND ----------

final_df = home_growth_df.alias('a')\
.join(home_value_sale_price_df.alias('b'), home_growth_df.region == home_value_sale_price_df.region)\
.select("a.id", "a.region", "a.size_rank", "b.date", "b.mean_home_value", "b.median_sale_price", "a.one_year_growth", "a.data_source")\
.withColumn("created_at", current_timestamp())

# COMMAND ----------

display(final_df)

# COMMAND ----------

# display(final_w_growth_df.select(countDistinct('date')))

# COMMAND ----------

# overwrite_partition(final_df, 're_presentation', 'final_results', 'date')

# COMMAND ----------

merge_condition = 'tgt.id = src.id AND tgt.date = src.date'
merge_delta_data(final_df, 're_presentation', 'final_results', presentation_folder_path, merge_condition, 'date')

# COMMAND ----------

# MAGIC %sql SHOW PARTITIONS re_presentation.final_results;

# COMMAND ----------

final_df.count()

# COMMAND ----------

display(final_df.select(countDistinct('date')))

# COMMAND ----------

# MAGIC %sql SELECT * FROM re_presentation.final_results
# MAGIC WHERE date = '2022-09-30';

# COMMAND ----------

