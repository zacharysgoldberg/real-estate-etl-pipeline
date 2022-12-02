# from pyspark.sql import SparkSession
from pyspark.sql.functions import current_timestamp, col
from pyspark.sql.types import StructType, StructField, IntegerType, StringType, FloatType, DateType

%run "../includes/includes/configuration"

# circuits_schema = StructType(fields=[StructField("RegionID", IntegerType(), False),
#                                      StructField(
#                                          "SizeRank", IntegerType(), True),
#                                      StructField(
#                                          "RegionName", StringType(), False),
#                                      StructField(
#                                          "StateName", StringType(), True),
#                                      StructField(
#                                          "BaseDate", DateType(), True),
#                                      StructField(
#                                          "2022-11-30", FloatType(), False),
#                                      StructField(
#                                          "2023-01-31", FloatType(), False),
#                                      StructField("2023-10-31", FloatType(), False)])


# spark = SparkSession.builder.getOrCreate()


# home_growth_df = spark.read\
#     .option('header', True)\
#     .option('inferSchema', True)\
#     .csv('/mnt/c/Users/Goldb/OneDrive/Desktop/real-estate-etl/raw-data/home_growth.csv').drop('RegionType')

home_growth_df = spark.read\
    .option('header', True)\
    .option('inferSchema', True)\
    .csv('/mnt/realestatedl/raw/raw-data/home_growth.csv')\
    .drop('RegionType')


home_growth_renamed_df = home_growth_df\
    .withColumnRenamed('RegionID', 'region_id')\
    .withColumnRenamed('SizeRank', 'size_rank')\
    .withColumnRenamed('RegionName', 'region')\
    .withColumnRenamed('StateName', 'state')\
    .withColumnRenamed('BaseDate', 'base_date')


home_growth_final_df = home_growth_renamed_df.withColumn(
    "ingestion_date", current_timestamp())

home_growth_final_df.printSchema()
# home_growth_final_df.describe().show()


# home_growth_final_df.write.mode("overwrite").parquet(
#     "/mnt/realestatedl/processed/home_growth")


# display(spark.read.parquet("/mnt/realestatedl/processed/home_growth"))
