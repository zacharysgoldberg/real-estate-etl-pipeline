# Databricks notebook source
# MAGIC %run "../includes/configuration"

# COMMAND ----------

# MAGIC %run "../includes/common_functions"

# COMMAND ----------

from pyspark.sql import Row
import pyspark.sql.functions as F
from pyspark.sql.functions import count, countDistinct, lit, col, round, split
from pyspark.sql.types import DoubleType, StringType

# COMMAND ----------

# Renaming one year growth column
# home_growth_df = spark.read.parquet(f"{processed_folder_path}/home_growth")
# year_growth_col = home_growth_df.select(home_growth_df[-3])
# year_growth_col = year_growth_col.dtypes[0][0]
# home_growth_df = home_growth_df.withColumnRenamed(year_growth_col, f"oyg_{year_growth_col}")

# COMMAND ----------

# cols = col_exists(home_value_df, median_sale_price_df)

# COMMAND ----------

# home_value_df = home_value_df.select(*cols)

# COMMAND ----------

# home_value_med_sale_df = find_difference(home_value_df, median_sale_price_df, 'region_id', cols)

# COMMAND ----------

# home_value_med_sale_df = home_value_med_sale_df.select(sorted(home_value_med_sale_df.columns, reverse=True))

# COMMAND ----------

# final_df = home_value_med_sale_df.alias('a')\
# .join(home_growth_df.alias('b'), home_value_med_sale_df['region'] == home_growth_df['region'])\
# .select("a.*", f"b.oyg_{year_growth_col}")


# COMMAND ----------

# cols = mean_home_value_years.columns[4:]

final_yearly_df = mean_home_value_years.alias('a')\
.join(mean_sale_price_years.alias('b'), mean_home_value_years.size_rank == mean_sale_price_years.size_rank)\
.select("a.region_id", "a.region", "a.size_rank", "a.year", "a.mean_home_value", "b.mean_sale_price")

# .dropDuplicates(['region_id', 'region', 'size_rank', 'year'])

# COMMAND ----------

final_yearly_df = final_yearly_df.withColumn('data_source', lit('Zillow API')).withColumn('created_at', current_timestamp())

# COMMAND ----------

display(final_yearly_df)

# COMMAND ----------

# oyg = f"oyg_{year_growth_col}"
# display(final_yearly_df.filter(final_yearly_df.state == "CA").orderBy(final_yearly_df[oyg].desc()))

# COMMAND ----------

from pyspark.sql.functions import desc, rank, asc
from pyspark.sql.window import Window

# COMMAND ----------

# date = mean_sale_price_years_df.select(mean_sale_price_years_df[3])
# date = date.dtypes[0][0]

# region_rank_spec = Window.orderBy(desc(date))
# mean_sale_price_years_df = mean_sale_price_years_df.withColumn('rank', rank().over(region_rank_spec))

# COMMAND ----------

# final_monthly_df.write.mode('overwrite').parquet(f"{presentation_folder_path}/mean_monthly_results")
# mean_home_value_years_df.write.mode('overwrite').parquet(f"{presentation_folder_path}/mean_home_value_yearly_results")
# mean_sale_price_years_df.write.mode('overwrite').parquet(f"{presentation_folder_path}/mean_sale_price_yearly_results")
# final_yearly_df.write.mode('overwrite').parquet(f"{presentation_folder_path}/mean_yearly_results")

# COMMAND ----------

output_df = re_arrange_patition_column(final_yearly_df, 'year')

# COMMAND ----------

# final_yearly_df.write.mode('overwrite').format("parquet").saveAsTable("re_presentation.mean_yearly_results")
overwrite_partition(final_yearly_df, 're_processed', 'mean_yearly_results', 'year')

# COMMAND ----------

display(spark.read.parquet(f"{presentation_folder_path}/mean_yearly_results"))

# COMMAND ----------

