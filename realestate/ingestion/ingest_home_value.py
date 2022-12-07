# Databricks notebook source
# %sql
# DROP TABLE re_processed.home_value;

# COMMAND ----------

# dbutils.widgets.help()

# COMMAND ----------

dbutils.widgets.text("p_data_source", "")
v_data_source = dbutils.widgets.get('p_data_source')

# COMMAND ----------

# MAGIC %run "../includes/configuration"

# COMMAND ----------

# MAGIC %run "../includes/common_functions"

# COMMAND ----------

from pyspark.sql.functions import current_timestamp, col, countDistinct, to_date, monotonically_increasing_id, round
from pyspark.sql import Row
import pyspark.sql.functions as F
from pyspark.sql.functions import lit

# COMMAND ----------

home_value_df = spark.read\
    .option('header', True)\
    .option('inferSchema', True)\
    .csv(f'{raw_folder_path}/home_value.csv')\
    .drop('RegionType')\
    .drop('StateName')

home_value_renamed = home_value_df\
    .withColumnRenamed('RegionID', 'region_id')\
    .withColumnRenamed('SizeRank', 'size_rank')\
    .withColumnRenamed('RegionName', 'region')

# COMMAND ----------

median_sale_price_df = spark.read\
    .option('header', True)\
    .option('inferSchema', True)\
    .csv(f'{raw_folder_path}/median_sale_price.csv')\
    .drop('RegionType')\
    .drop('StateName')

median_sale_price_renamed = median_sale_price_df\
    .withColumnRenamed('RegionID', 'region_id')\
    .withColumnRenamed('SizeRank', 'size_rank')\
    .withColumnRenamed('RegionName', 'region')

# COMMAND ----------

cols = col_exists(home_value_renamed, median_sale_price_renamed)
home_value_df = home_value_renamed.select(*cols)

# COMMAND ----------

df = find_difference(home_value_df, median_sale_price_renamed, 'region', cols)
df = df.select(sorted(df.columns, reverse=True))

# COMMAND ----------

display(df)

# COMMAND ----------

home_value_df, sale_price_df = split_dataframe(df)

# COMMAND ----------

display(home_value_df)

# COMMAND ----------

display(sale_price_df)

# COMMAND ----------

home_value_df = mean_months_table(home_value_df, 'mean_home_value')

# COMMAND ----------

display(home_value_df)

# COMMAND ----------

display(home_value_df.select(countDistinct('date')))

# COMMAND ----------

sale_price_df = mean_months_table(sale_price_df, 'median_sale_price')

# COMMAND ----------

display(sale_price_df)

# COMMAND ----------

final_df = home_value_df.alias('a')\
.join(sale_price_df.alias('b'), home_value_df.id == sale_price_df.id)\
.select('a.id', "a.region", "a.size_rank", "a.date", "a.mean_home_value", "b.median_sale_price")

# COMMAND ----------

final_df = add_ingestion_date(final_df)

# COMMAND ----------

finaL_df = final_df.select(final_df.id, final_df.region, final_df.size_rank, final_df.date, final_df.mean_home_value, final_df.median_sale_price, final_df.ingestion_date).withColumn("data_source", lit(v_data_source))

# COMMAND ----------

display(final_df)

# COMMAND ----------

# output_df = re_arrange_patition_column(home_value_final_df, 'region')

# COMMAND ----------

overwrite_partition(final_df, 're_processed', 'final_results', 'date')

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT * FROM re_processed.final_results;

# COMMAND ----------

# display(spark.read.parquet(f"{processed_folder_path}/final_results"))

# COMMAND ----------

dbutils.notebook.exit("Success")

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT date, COUNT(1) 
# MAGIC FROM re_processed.final_results
# MAGIC GROUP BY date;

# COMMAND ----------

