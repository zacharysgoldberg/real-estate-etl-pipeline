# Databricks notebook source
# %sql
# DROP TABLE re_processed.median_sale_price;

# COMMAND ----------

dbutils.widgets.text("p_data_source", "")
v_data_source = dbutils.widgets.get('p_data_source')

# COMMAND ----------

# MAGIC %run "../includes/configuration"

# COMMAND ----------

# MAGIC %run "../includes/common_functions"

# COMMAND ----------

from pyspark.sql.functions import current_timestamp, col, countDistinct, monotonically_increasing_id, round
from pyspark.sql import Row

# COMMAND ----------

median_sale_price_df = spark.read\
    .option('header', True)\
    .option('inferSchema', True)\
    .csv(f'{raw_folder_path}/median_sale_price.csv')\
    .drop('RegionType')

# COMMAND ----------

from pyspark.sql.functions import lit

# COMMAND ----------

median_sale_price_renamed_df = median_sale_price_df\
    .withColumnRenamed('RegionID', 'region_id')\
    .withColumnRenamed('SizeRank', 'size_rank')\
    .withColumnRenamed('RegionName', 'region')

# COMMAND ----------

display(median_sale_price_renamed_df)

# COMMAND ----------

median_sale_price_months_df = mean_months_table(median_sale_price_renamed_df, 'median_sale_price')

# COMMAND ----------

sale_price_final_df = add_ingestion_date(median_sale_price_months_df)

# COMMAND ----------

sale_price_final_df = sale_price_final_df.select(sale_price_final_df.id, sale_price_final_df.region, sale_price_final_df.size_rank, sale_price_final_df.date, sale_price_final_df.median_sale_price, sale_price_final_df.ingestion_date).withColumn("data_source", lit(v_data_source))

# COMMAND ----------

display(sale_price_final_df)

# COMMAND ----------

display(sale_price_final_df.select(countDistinct('region')))

# COMMAND ----------

# output_df = re_arrange_patition_column(sale_price_final_df, 'date')

# COMMAND ----------

overwrite_partition(sale_price_final_df, 're_processed', 'median_sale_price', 'date')

# COMMAND ----------

display(spark.read.parquet(f"{processed_folder_path}/median_sale_price"))

# COMMAND ----------

dbutils.notebook.exit("Success")

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT * FROM re_processed.median_sale_price;

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT date, COUNT(1) 
# MAGIC FROM re_processed.median_sale_price
# MAGIC GROUP BY date;

# COMMAND ----------

