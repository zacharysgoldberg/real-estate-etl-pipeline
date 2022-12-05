# Databricks notebook source
v_result = dbutils.notebook.run("ingest_home_value", 0, {"p_data_source": "Zillow API"})

# COMMAND ----------

v_result

# COMMAND ----------

v_result = dbutils.notebook.run("ingest_home_growth", 0, {"p_data_source": "Zillow API"})

# COMMAND ----------

v_result

# COMMAND ----------

v_result = dbutils.notebook.run("ingest_median_sale_price", 0, {"p_data_source": "Zillow API"})

# COMMAND ----------

v_result

# COMMAND ----------

