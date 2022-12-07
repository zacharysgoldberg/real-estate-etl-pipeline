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

def overwrite_partition(input_df, db_name, table_name, partition_column):
    output_df = re_arrange_patition_column(input_df, partition_column)
    spark.conf.set("spark.sql.sources.partitionOverwriteMode", "dynamic")
    
    if (spark._jsparkSession.catalog().tableExists(f"{db_name}.{table_name}")):
        output_df.write.mode("overwrite").insertInto(f"{db_name}.{table_name}")
    else:
        output_df.write.mode("overwrite").partitionBy(partition_column).format("parquet").saveAsTable(f"{db_name}.{table_name}")

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
    mhv_dates = set()
    for c in df.columns:
        if 'msp' in c:
            msp_dates.add(c[4:])
            
    df1 = df.select([col for col in df.columns if 'msp' not in col])
    df2 = df.select(df.columns[0:len(msp_dates)])
    return df1, df2


# COMMAND ----------

def mean_months_table(input_df, mean_column):
    # [Iterate over each region and get the mean home values and sale price for each month]
    df_copy = input_df.select(input_df.region, input_df.size_rank)
    means_list = []
    for c in input_df.columns[4:]:
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
                elif 'msp' in key:
                    rows.append(Row(region=v[0], size_rank=v[1], date=key[4:], mean=v[3]))
                    
    R = Row("region", "size_rank", "date", f"{mean_column}")
    new_month_df = spark.createDataFrame(
        [R(v[0], v[1], v[2], v[3]) for v in rows]).withColumn('id', monotonically_increasing_id())
    # .replace("-", "")
    return new_month_df

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

"""def mean_home_value_years(df):
    # [Calculate mean home valuations per region per year]
    df_copy = df.select(df.region_id, df.region, df.size_rank)
    # [Iterate over each region and calculate mean home values for each year]
    years = set()
    dates = set()
    mean_home_values = []
    for c in df.columns:        
        if '-' in c and 'msp' not in c and 'oyg' not in c:
            year = c[0:4]
            date = col(c)
#             month = c[5:7]
            if year not in years and not dates:
                years.add(year)
                dates.add(date)
            elif year not in years and dates:
                years.add(year)
#                 prev_year = str(int(year) + 1)
                mhv = new_df.select(new_df["*"]).collect()
                mean_home_values.append(mhv)
                dates.clear()
                dates.add(date)
            elif year in years and dates:
                total = 0
                for el in dates:
                    total += el
                dates.add(date)      
                new_df = df.select(df.region, df[f"{year}-{c[5:]}"], (round((date + total)/len(dates), 2)).alias("mean_home_value"))
    rows = []
    for mhv in mean_home_values:
        for v in mhv:
            d = v.asDict()
            for key, item in d.items():
                if "-" in key:
                    rows.append(Row(region=v[0], year=key[0:4], mhv=v[2]))
                    
    R = Row("region", "year", "mean_home_value")
    mhv_year_df = spark.createDataFrame([R(v[0], v[1], v[2]) for v in rows])
    df_copy = df_copy.alias('a')\
    .join(mhv_year_df.alias('b'), df_copy.region == mhv_year_df.region)\
    .select('a.*', 'b.year', 'b.mean_home_value')
    
    return df_copy"""

# COMMAND ----------

"""def mean_years_table(input_df, mean_column):
    # [Calculate mean home valuations per region per year]
    years = set()
    dates = set()
    rows = set()
    
    for row in input_df.collect():
        year = str(row.market_date)[0:4]
        if year not in years and not dates:
            years.add(year)
            dates.add(row.market_date)
        elif year not in years and dates:
            years.add(year)
            prev_year = str(int(year) + 1)
            
            new_mean_list = new_df.select(first(new_df.region), first(new_df.size_rank), mean(f"{mean_column}")).collect()
            for v in new_mean_list:
                rows.add(Row(region=v[0], size_rank=v[1], year=prev_year, mean=v[2]))

            dates.clear()
            dates.add(row.market_date)
        elif year in years and dates:
            years.add(year)
            dates.add(row.market_date)
            
            new_df = input_df.select(input_df.region, input_df.size_rank, input_df[mean_column])\
                .filter(input_df.market_date.like(f"{year}%"))\
                .filter(input_df.region == row.region)

    R = Row("region", "size_rank", 'year', f'{mean_column}')
    new_year_df = spark.createDataFrame(
        [R(v[0], v[1], v[2], v[3]) for v in rows])
    return new_year_df"""