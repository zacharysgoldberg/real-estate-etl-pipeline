from pyspark.sql import SparkSession
from pyspark.sql.functions import current_timestamp, col
from pyspark.sql.types import IntegerType, DateType, StructType, StructField, StringType

%run "../includes/includes/configuration"


spark = SparkSession.builder.getOrCreate()


home_values_df = spark.read\
    .option('header', True)\
    .option('inferSchema', True)\
    .csv('/mnt/c/Users/Goldb/OneDrive/Desktop/real-estate-etl/raw-data/home_value.csv')\
    .drop('RegionType')

# home_values_df = spark.read\
#     .option('header', True)\
#     .option('inferSchema', True)\
#     .csv('/mnt/realestatedl/raw/raw-data/home_value.csv')\
#     .drop('RegionType')

# home_values_selected_df = home_values_df\
#     .select(home_values_df.columns[-120:])


home_values_renamed_df = home_values_df\
    .withColumnRenamed('RegionID', 'region_id')\
    .withColumnRenamed('SizeRank', 'size_rank')\
    .withColumnRenamed('RegionName', 'region')\
    .withColumnRenamed('StateName', 'state')

home_values_final_df = home_values_renamed_df.withColumn(
    "ingestion_date", current_timestamp())


home_values_final_df.printSchema()


# home_values_renamed_df.write.mode("overwrite").parquet(
#     "/mnt/realestatedl/processed/home_value")


# display(spark.read.parquet("/mnt/realestatedl/processed/home_value"))
