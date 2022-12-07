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

final_df = get_new_entries('final_results_w_growth', 'final_results')

# COMMAND ----------

display(final_df)

# COMMAND ----------

home_growth_df = get_new_entries('final_resulst_w_growth', 'home_growth')

# COMMAND ----------

display(final_df)

# COMMAND ----------

final_w_growth_df = home_growth_df.alias('a')\
.join(final_df.alias('b'), home_growth_df.region == final_df.region)\
.select("a.id", "a.region", "a.size_rank", "b.date", "b.mean_home_value", "b.median_sale_price", "a.one_year_growth", "a.data_source")\
.withColumn("created_at", current_timestamp())

# COMMAND ----------

display(final_w_growth_df)

# COMMAND ----------

# display(final_w_growth_df.select(countDistinct('date')))

# COMMAND ----------

overwrite_partition(final_w_growth_df, 're_presentation', 'final_results_w_growth', 'date')

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT * FROM re_presentation.final_results_w_growth;

# COMMAND ----------

