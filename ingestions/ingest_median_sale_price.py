# from pyspark.sql import SparkSession
from pyspark.sql.functions import current_timestamp, col

%run "../includes/includes/configuration"


# spark = SparkSession.builder.getOrCreate()


# median_sale_price_df = spark.read\
#     .option('header', True)\
#     .option('inferSchema', True)\
#     .csv('/mnt/c/Users/Goldb/OneDrive/Desktop/real-estate-etl/raw-data/median_sale_price.csv').drop('RegionType')

median_sale_price_df = spark.read\
    .option('header', True)\
    .option('inferSchema', True)\
    .csv('/mnt/realestatedl/raw/raw-data/median_sale_price.csv')\
    .drop('RegionType')


median_sale_price_renamed_df = median_sale_price_df\
    .withColumnRenamed('RegionID', 'region_id')\
    .withColumnRenamed('SizeRank', 'size_rank')\
    .withColumnRenamed('RegionName', 'region')\
    .withColumnRenamed('StateName', 'state')


median_sale_price_final_df = median_sale_price_renamed_df.withColumn(
    "ingestion_date", current_timestamp())

median_sale_price_final_df.printSchema()
# median_sale_price_final_df.describe().show()


# median_sale_price_final_df.write.mode("overwrite").parquet(
#     "/mnt/realestatedl/processed/median_sale_price")


# display(spark.read.parquet("/mnt/realestatedl/processed/median_sale_price"))
