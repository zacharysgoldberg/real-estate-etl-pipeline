# Databricks notebook source
from pyspark.sql.functions import current_timestamp

def add_ingestion_date(input_df):
    output_df = input_df.withColumn("ingestion_date", current_timestamp())
    return output_df

# COMMAND ----------

def re_arrange_patition_column(input_df, partition_column):
    column_list = []
    for column_name in input_df.schema.names:
        if column_name != partition_column:
            column_list.append(column_name)
    column_list.append(partition_column)
#     print(column_list)
    output_df = input_df.select(column_list)
    return output_df

# COMMAND ----------

# Upsert using merge
def merge_delta_data(input_df, db_name, table_name, folder_path, merge_condition, partition_column):
    spark.conf.set("spark.databricks.optimizer.dynamicPartitionPruning", "true")

    from delta.tables import DeltaTable
    if (spark._jsparkSession.catalog().tableExists(f"{db_name}.{table_name}")):
        deltaTable = DeltaTable.forPath(spark, f"{folder_path}/{table_name}")
        deltaTable.alias("tgt").merge(
            input_df.alias("src"),
            merge_condition) \
          .whenMatchedUpdateAll()\
          .whenNotMatchedInsertAll()\
          .execute()
        print("------------Inserted/Updated-------------")
    else:
        input_df.write.mode("overwrite").partitionBy(partition_column).format("delta").saveAsTable(f"{db_name}.{table_name}")
        try:
            dbutils.fs.ls(f"{folder_path}/{table_name}")
            print('---------ADLS Path Found----------')
        except:
            input_df.write.mode("overwrite").partitionBy(partition_column).format("delta").save(f"{folder_path}/{table_name}")
            print("------------Created ADLS Path-------------")            
        
        print("------------Overwritten-------------")

# COMMAND ----------

def col_exists(col1, col2):
    cols = []
    for col in col1.columns:
        if col in col2.columns and '-' in col or col == 'region':
            cols.append(col)
    return cols

# COMMAND ----------

def find_difference(df1, df2, id_column, cols):
#     data_difference = df1.subtract(df2) # First find the difference in rows
    data_difference = df1.join(df2.select([F.col(i).alias(f'msp_{i}') if i in cols and '-' in i\
                                                         else i for i in df2.columns]), on = id_column, how = 'left')
    return data_difference

# COMMAND ----------

def split_dataframe(df):
    msp_dates = set()
    for c in df.columns:
        if 'msp' in c:
            msp_dates.add(c[4:])
            
    df1 = df.select([col for col in df.columns if 'msp' not in col])
    df2 = df.select(df.columns[0:len(msp_dates) - 1])
    return df1, df2


# COMMAND ----------

def mean_months_table(input_df, mean_column):
    # [Iterate over each region and get the mean home values and sale price for each month]
    df_copy = input_df.select(input_df.region, input_df.size_rank)
    means_list = []
    for c in input_df.columns[3:]:
        date = c
        new_df = input_df.select(input_df.region, input_df.size_rank, input_df[date], (input_df[date]).alias(f"{mean_column}"))
        mean = new_df.select(new_df["*"]).collect()
        means_list.append(mean)

    rows = []
    for mean in means_list:
        for v in mean:
            d = v.asDict()
            for key, item in d.items():
                if "-" in key and 'msp' not in key:
                    rows.append(Row(region=v[0], size_rank=v[1], date=key, mean=v[3]))
                if 'msp' in key:
                    rows.append(Row(region=v[0], size_rank=v[1], date=key[4:], mean=v[3]))
    R = Row("region", "size_rank", "date", f"{mean_column}")
    new_df = spark.createDataFrame(
        [R(v[0], v[1], v[2], v[3]) for v in rows]).withColumn('id', monotonically_increasing_id())
    # .replace("-", "")
    return new_df

# COMMAND ----------

# MAGIC %md
# MAGIC --------------
# MAGIC ## Deprecated

# COMMAND ----------

def get_new_entries(presentation_tablename, processed_tablename):
    if (spark._jsparkSession.catalog().tableExists(f"re_presentation.{presentation_tablename}")):
        output_list = spark.read.parquet(f"{presentation_folder_path}/{presentation_tablename}") \
        .select('date') \
        .distinct() \
        .collect()
        
        date_list = [date[0] for date in output_list]
        output_df = spark.read.parquet(f"{processed_folder_path}/{processed_tablename}") \
        .filter(~col('date').isin(date_list))
        return output_df

    else:
        output_df = spark.read.parquet(f"{processed_folder_path}/{processed_tablename}")
        return output_df

# COMMAND ----------

def overwrite_partition(input_df, db_name, table_name, partition_column):
    output_df = re_arrange_patition_column(input_df, partition_column)
    spark.conf.set("spark.sql.sources.partitionOverwriteMode", "dynamic")
    
    if (spark._jsparkSession.catalog().tableExists(f"{db_name}.{table_name}")):
        output_df.write.mode("overwrite").insertInto(f"{db_name}.{table_name}")
        print("------------Inserted-------------")
    else:
        output_df.write.mode("overwrite").partitionBy(partition_column).format("parquet").saveAsTable(f"{db_name}.{table_name}")
        print("------------Overwritten-------------")
        