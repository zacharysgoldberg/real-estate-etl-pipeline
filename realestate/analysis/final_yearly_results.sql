-- Databricks notebook source
USE re_presentation;

-- COMMAND ----------

SHOW TABLES

-- COMMAND ----------

-- DROP TABLE IF EXISTS re_presentation.ranked_yearly_mhv;
-- CREATE TABLE re_presentation.ranked_yearly_mhv
-- USING parquet
-- AS
-- SELECT SPLIT(region, ',')[0] city, SPLIT(region, ',')[1] state, year, mean_home_value, RANK() OVER(ORDER BY mean_home_value DESC) AS home_value_rank
-- FROM mean_home_value_yearly_results
-- ORDER BY home_value_rank;

-- COMMAND ----------

-- SELECT * FROM re_presentation.ranked_yearly_mhv;

-- COMMAND ----------

SELECT * FROM mean_yearly_results;

-- COMMAND ----------

DROP TABLE IF EXISTS re_presentation.final_yearly_results;
CREATE TABLE re_presentation.final_yearly_results
USING parquet
AS
SELECT id, SPLIT(region, ',')[0] city, TRIM(SPLIT(region, ',')[1]) state, size_rank, year, mean_home_value, mean_sale_price, data_source, created_at
FROM mean_yearly_results
WHERE size_rank != 0;

-- COMMAND ----------

SELECT * FROM final_yearly_results;

-- COMMAND ----------

SELECT * FROM final_yearly_results
WHERE state = 'CA';

-- COMMAND ----------

