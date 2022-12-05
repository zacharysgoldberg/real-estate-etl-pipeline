# Databricks notebook source
# MAGIC %run "../includes/configuration"

# COMMAND ----------

home_value_df = spark.read.parquet(f"{processed_folder_path}/home_value")

# COMMAND ----------

median_sale_price_df = spark.read.parquet(f"{processed_folder_path}/median_sale_price")

# COMMAND ----------

# Renaming one year growth column
home_growth_df = spark.read.parquet(f"{processed_folder_path}/home_growth")
year_growth_col = home_growth_df.select(home_growth_df[-3])
year_growth_col = year_growth_col.dtypes[0][0]
home_growth_df = home_growth_df.withColumnRenamed(year_growth_col, f"oyg_{year_growth_col}")

# COMMAND ----------

from pyspark.sql.functions import lit, current_timestamp
from pyspark.sql import Row
import pyspark.sql.functions as F
from pyspark.sql.functions import monotonically_increasing_id

# COMMAND ----------

def col_exists(col1, col2):
    cols = []
    for col in col1.columns:
        if col in col2.columns and '-' in col or col == 'region_id':
            cols.append(col)
    return cols

# COMMAND ----------

def find_difference(df1, df2, id_column, cols):
#     data_difference = df1.subtract(df2) # First find the difference in rows
    data_difference = df1.join(df2.select([F.col(i).alias(f'msp_{i}') if i in cols and '-' in i\
                                                         else i for i in df2.columns]), on = id_column, how = 'left')
    return data_difference
 

# COMMAND ----------

cols = col_exists(home_value_df, median_sale_price_df)

# COMMAND ----------

# median_sale_price_years_df = median_sale_price_df.select(median_sale_price_df.columns[4:])

# COMMAND ----------

home_value_df = home_value_df.select(*cols)

# COMMAND ----------

home_value_med_sale_df = find_difference(home_value_df, median_sale_price_df, 'region_id', cols)

# COMMAND ----------

home_value_med_sale_df = home_value_med_sale_df.select(sorted(home_value_med_sale_df.columns, reverse=True))

# COMMAND ----------

final_df = home_value_med_sale_df.alias('a')\
.join(home_growth_df.alias('b'), home_value_med_sale_df['region'] == home_growth_df['region'])\
.select("a.*", f"b.oyg_{year_growth_col}")


# COMMAND ----------

display(final_df)

# COMMAND ----------

from pyspark.sql.functions import count, countDistinct, lit, col, round, split
from pyspark.sql.types import DoubleType, StringType

# COMMAND ----------

"""def mean_home_value_sale_price_months(df):
    # [Iterate over each region and get the mean home values and sale price for each month]
    df_copy = df.select(df.region_id, df.region, df.size_rank)
    mhvs = []
    msps = []
    for c in df.columns:
        if '-' in c and 'oyg' not in c:
            if 'msp' in c:
                date = c[4:]
                new_df = df.select(df.region, df[f"msp_{date}"], (df[f"msp_{date}"]).alias("msp"))
                msp = new_df.select(new_df["*"]).collect()
#                 print(msp)
                msps.append(msp)
            elif 'msp' not in c:
                date = c
                new_df = df.select(df.region, df[date], (df[date]).alias("mhv"))
                mhv = new_df.select(new_df["*"]).collect()
#                 print(mhv)
                mhvs.append(mhv)
    
    mhv_rows = []
    for mhv in mhvs:
        for v in mhv:
            d = v.asDict()
            for key, item in d.items():
                if "-" in key:
                    mhv_rows.append(Row(region=v[0], date=key, mean=v[2]))
                    
    msp_rows = []
    for msp in msps:
        for v in msp:
            d = v.asDict()
            for key, item in d.items():
                if 'msp' in key:
                    msp_rows.append(Row(region=v[0], date=key[4:], mean=v[2]))
                    
    R1 = Row("region", "date", "mean_home_value")
    R2 = Row("region", "date", "mean_sale_price")
    mhv_month_df = spark.createDataFrame([R1(v[0], v[1], v[2]) for v in mhv_rows])
    msp_month_df = spark.createDataFrame([R2(v[0], v[1], v[2]) for v in msp_rows])
    
    mhv_month_df = mhv_month_df.alias('a')\
    .join(msp_month_df.alias('b'), mhv_month_df.region == msp_month_df.region)\
    .select('a.*', 'b.mean_sale_price')

    
    df_copy = df_copy.alias('a')\
    .join(mhv_month_df.alias('b'), df_copy.region == mhv_month_df.region)\
    .select('a.*', 'b.date', 'b.mean_home_value', 'b.mean_sale_price')
        
    return df_copy
"""

# COMMAND ----------

# final_monthly_df = mean_home_value_sale_price_months(final_df)

# COMMAND ----------

# final_monthly_df = final_monthly_df.dropDuplicates(['region_id', 'region', 'date', 'mean_home_value'])

# COMMAND ----------

# display(final_monthly_df)

# COMMAND ----------

"""def mean_home_value_years(df):
    # [Calculate mean home valuations per region per year]
    df_copy = df.select(df.region_id, df.region, df.state)
    # [Iterate over each region and calculate mean home values for each year]
    years = []
    months = []
    for c in df.columns:
        if '-' in c and 'msp' not in c and 'oyg' not in c:
            year = c[0:4]
            month = col(c)
            if year not in years and not months:
                years.append(year)
                months.append(month)
            elif year not in years and months:
                years.append(year)
                prev_year = str(int(year) + 1)
                df_copy = df_copy.alias('a')\
                .join(new_df.alias('b'), df_copy.region_id == new_df.region_id, 'full')\
                .select('a.*', f'b.mhv_{prev_year}')
                months.clear()
                months.append(month)
            elif year in years and months:
                total = 0
                for el in months:
                    total += el
                months.append(month)
                new_df = df.select(df.region_id, (round((month + total)/len(months), 2)).alias(f"mhv_{year}"))
            
    return df_copy"""


"""def mean_sale_price_years(df):
    # [Calculate mean sale price per region per year]
    df_copy = df.select(df.region_id, df.region, df.state)
    # [Iterate over each region and calculate mean sale price for each year]
    years = []
    months = []
    for c in df.columns:
        if 'msp' in c:
            year = c[4:8]
            month = col(c)
            if year not in years and not months:
                years.append(year)
                months.append(month)
            elif year not in years and months:
                years.append(year)
                prev_year = str(int(year) + 1)
                df_copy = df_copy.alias('a')\
                .join(new_df.alias('b'), df_copy.region_id == new_df.region_id, 'full')\
                .select('a.*', f'b.msp_{prev_year}')
                months.clear()
                months.append(month)
            elif year in years and months:
                total = 0
                for el in months:
                    total += el
                months.append(month)
                new_df = df.select(df.region_id, (round((month + total)/len(months), 2)).alias(f"msp_{year}"))
            
    return df_copy"""

# COMMAND ----------

def mean_home_value_years(df):
    # [Calculate mean home valuations per region per year]
    df_copy = df.select(df.region_id, df.region, df.size_rank)
    # [Iterate over each region and calculate mean home values for each year]
    years = []
    dates = []
    mhvs = []
    for c in df.columns:        
        if '-' in c and 'msp' not in c and 'oyg' not in c:
            year = c[0:4]
            date = col(c)
#             month = c[5:7]
            if year not in years and not dates:
                years.append(year)
                dates.append(date)
            elif year not in years and dates:
                years.append(year)
#                 prev_year = str(int(year) + 1)
                mhv = new_df.select(new_df["*"]).collect()
                mhvs.append(mhv)
                dates.clear()
                dates.append(date)
            elif year in years and dates:
                total = 0
                for el in dates:
                    total += el
                dates.append(date)      
                new_df = df.select(df.region, df[f"{year}-{c[5:]}"], (round((date + total)/len(dates), 2)).alias("mhv"))
    rows = []
    for mhv in mhvs:
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
    
    return df_copy


# COMMAND ----------

mean_home_value_years = mean_home_value_years(final_df)

# COMMAND ----------

mean_home_value_years = mean_home_value_years.withColumn("id", monotonically_increasing_id())

# COMMAND ----------

display(mean_home_value_years)

# COMMAND ----------

def mean_sale_price_years(df):
    # [Calculate mean home sale pirce per region per year]
    df_copy = df.select(df.region_id, df.region, df.size_rank)
    # [Iterate over each region and calculate mean home sale price for each year]
    years = []
    dates = []
    msps = []
    for c in df.columns:        
        if 'msp' in c:
            year = c[4:8]
            date = col(c)
#             month = c[5:7]
            if year not in years and not dates:
                years.append(year)
                dates.append(date)
            elif year not in years and dates:
                years.append(year)
#                 prev_year = str(int(year) + 1)
                msp = new_df.select(new_df["*"]).collect()
                msps.append(msp)
                dates.clear()
                dates.append(date)
            elif year in years and dates:
                total = 0
                for el in dates:
                    total += el
                dates.append(date)      
                new_df = df.select(df.region, df[f"msp_{year}-{c[9:]}"], (round((date + total)/len(dates), 2)).alias("msp"))
    rows = []
    for msp in msps:
        for v in msp:
            d = v.asDict()
            for key, item in d.items():
                if "-" in key:
                    rows.append(Row(region=v[0], date=key[4:8], msp=v[2]))
                    
    R = Row("region", "year", "mean_sale_price")
    msp_year_df = spark.createDataFrame([R(v[0], v[1], v[2]) for v in rows])
    df_copy = df_copy.alias('a')\
    .join(msp_year_df.alias('b'), df_copy.region == msp_year_df.region)\
    .select('a.*', 'b.year', 'b.mean_sale_price')
    
    return df_copy


# COMMAND ----------

mean_sale_price_years = mean_sale_price_years(final_df)

# COMMAND ----------

mean_sale_price_years = mean_sale_price_years.withColumn("id", monotonically_increasing_id())

# COMMAND ----------

display(mean_sale_price_years)

# COMMAND ----------

# cols = mean_home_value_years.columns[4:]

final_yearly_df = mean_home_value_years.alias('a')\
.join(mean_sale_price_years.alias('b'), mean_home_value_years.id == mean_sale_price_years.id)\
.select("a.id", "a.region", "a.size_rank", "a.year", "a.mean_home_value", "b.mean_sale_price")

# .dropDuplicates(['region_id', 'region', 'size_rank', 'year'])

# COMMAND ----------

display(final_yearly_df)

# COMMAND ----------

# if final_yearly_df.count() > final_yearly_df.dropDuplicates(['region_id', 'region', 'size_rank', 'year', 'mean_home_value', 'mean_sale_price']).count():
#     raise ValueError('Data has duplicates')

# COMMAND ----------

mean_home_value_years_df = mean_home_value_years.withColumn('data_source', lit('Zillow API')).withColumn('created_at', current_timestamp())

# COMMAND ----------

mean_sale_price_years_df = mean_sale_price_years.withColumn('data_source', lit('Zillow API')).withColumn('created_at', current_timestamp())

# COMMAND ----------

final_yearly_df = final_yearly_df.withColumn('data_source', lit('Zillow API')).withColumn('created_at', current_timestamp())

# COMMAND ----------

display(final_yearly_df)

# COMMAND ----------

display(mean_sale_price_years_df)

# COMMAND ----------

# final_monthly_df = final_monthly_df.drop('created_at').drop('data_source').withColumn('data_source', lit('Zillow API')).withColumn('created_at', current_timestamp())

# COMMAND ----------

# display(final_monthly_df)

# COMMAND ----------

# oyg = f"oyg_{year_growth_col}"
# display(final_yearly_df.filter(final_yearly_df.state == "CA").orderBy(final_yearly_df[oyg].desc()))

# COMMAND ----------

from pyspark.sql.functions import desc, rank, asc
from pyspark.sql.window import Window

# COMMAND ----------

# date = mean_home_value_years_df.select(mean_home_value_years_df[3])
# date = date.dtypes[0][0]

# region_rank_spec = Window.orderBy(desc(date))
# mean_home_value_years_df = mean_home_value_years_df.withColumn('rank', rank().over(region_rank_spec))

# COMMAND ----------

display(mean_home_value_years_df)

# COMMAND ----------

# date = mean_sale_price_years_df.select(mean_sale_price_years_df[3])
# date = date.dtypes[0][0]

# region_rank_spec = Window.orderBy(desc(date))
# mean_sale_price_years_df = mean_sale_price_years_df.withColumn('rank', rank().over(region_rank_spec))

# COMMAND ----------

display(mean_sale_price_years_df)

# COMMAND ----------

# final_monthly_df.write.mode('overwrite').parquet(f"{presentation_folder_path}/mean_monthly_results")
# mean_home_value_years_df.write.mode('overwrite').parquet(f"{presentation_folder_path}/mean_home_value_yearly_results")
# mean_sale_price_years_df.write.mode('overwrite').parquet(f"{presentation_folder_path}/mean_sale_price_yearly_results")
# final_yearly_df.write.mode('overwrite').parquet(f"{presentation_folder_path}/mean_yearly_results")

# COMMAND ----------

mean_home_value_years_df.write.mode('overwrite').format("parquet").saveAsTable("re_presentation.mean_home_value_yearly_results")
mean_sale_price_years_df.write.mode('overwrite').format("parquet").saveAsTable("re_presentation.mean_sale_price_yearly_results")

# COMMAND ----------

# final_monthly_df.write.mode('overwrite').format("parquet").saveAsTable("re_presentation.mean_monthly_results")
final_yearly_df.write.mode('overwrite').format("parquet").saveAsTable("re_presentation.mean_yearly_results")

# COMMAND ----------

display(spark.read.parquet(f"{presentation_folder_path}/mean_yearly_results"))

# COMMAND ----------

