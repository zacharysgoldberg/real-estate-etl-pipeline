# Databricks notebook source
dbutils.widgets.text("p_data_source", "")
v_data_source = dbutils.widgets.get('p_data_source')

# COMMAND ----------

# MAGIC %run "../includes/configuration"

# COMMAND ----------

# MAGIC %run "../includes/common_functions"

# COMMAND ----------

from pyspark.sql.functions import current_timestamp, col, monotonically_increasing_id, lit
from pyspark.sql import Row
from pyspark.sql.types import StructType, StructField, IntegerType, StringType, FloatType, DateType

# COMMAND ----------

home_growth_df = spark.read\
    .option('header', True)\
    .option('inferSchema', True)\
    .csv(f'{raw_folder_path}/home_growth.csv')\
    .drop('RegionType')

# COMMAND ----------

# home_growth_df.printSchema()

# COMMAND ----------

home_growth_renamed_df = home_growth_df\
    .withColumnRenamed('RegionID', 'region_id')\
    .withColumnRenamed('SizeRank', 'size_rank')\
    .withColumnRenamed('RegionName', 'region')\
    .withColumnRenamed('BaseDate', 'base_date')\
    .withColumn("data_source", lit(v_data_source))

# COMMAND ----------

# year_growth_col = home_growth_df.select(home_growth_df[-3])
# year_growth_col = year_growth_col.dtypes[0][0]
# home_growth_df = home_growth_df.withColumnRenamed(year_growth_col, f"oyg_{year_growth_col}")

# COMMAND ----------

def home_growth_table(input_df):
    df_copy = input_df.select(input_df.region, input_df.size_rank)
    date = input_df.columns[7]
    new_df = input_df.select(input_df.region, input_df.size_rank, input_df[date], (input_df[date]).alias("one_year_growth"))
    new_list = new_df.select(new_df["*"]).collect()

    rows = []
    for v in new_list:
        d = v.asDict()
        for key, item in d.items():
            if "-" in key:
                rows.append(Row(region=v[0], size_rank=v[1], date=key, growth=v[3]))

    R = Row("region", "size_rank", "date", "one_year_growth")
    new_month_df = spark.createDataFrame(
            [R(v[0], v[1], v[2], v[3]) for v in rows]).withColumn('id', monotonically_increasing_id())
    
    return new_month_df

# COMMAND ----------

home_growth_final_df = home_growth_table(home_growth_renamed_df)

# COMMAND ----------

home_growth_final_df = add_ingestion_date(home_growth_final_df)

# COMMAND ----------

home_growth_final_df = home_growth_final_df.select(home_growth_final_df.id, home_growth_final_df.region, home_growth_final_df.size_rank, home_growth_final_df.date, home_growth_final_df.one_year_growth).withColumn("data_source", lit(v_data_source))

# COMMAND ----------

display(home_growth_final_df)

# COMMAND ----------

# home_growth_final_df.write.mode("overwrite").format("parquet").saveAsTable("re_processed.home_growth")

# COMMAND ----------

overwrite_partition(home_growth_final_df, 're_processed', 'home_growth', 'date')

# COMMAND ----------

display(spark.read.parquet(f"{processed_folder_path}/home_growth"))

# COMMAND ----------

dbutils.notebook.exit("Success")

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT * FROM re_processed.home_growth;

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT date, COUNT(1) 
# MAGIC FROM re_processed.home_growth
# MAGIC GROUP BY date;

# COMMAND ----------

