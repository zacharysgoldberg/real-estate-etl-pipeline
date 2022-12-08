-- Databricks notebook source
USE re_presentation;

-- COMMAND ----------

SHOW TABLES

-- COMMAND ----------

DESC HISTORY re_presentation.final_results

-- COMMAND ----------

SHOW PARTITIONS re_presentation.final_results;

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

SELECT * FROM final_results;

-- COMMAND ----------

DROP TABLE IF EXISTS re_presentation.final_results_for_viz;
CREATE TABLE re_presentation.final_results_for_viz
USING parquet
AS
SELECT id, SPLIT(region, ',')[0] city, TRIM(SPLIT(region, ',')[1]) state, size_rank, date, mean_home_value, median_sale_price, one_year_growth, data_source, created_at
FROM final_results
WHERE size_rank != 0;

-- COMMAND ----------

SELECT * FROM final_results_for_viz;

-- COMMAND ----------

SELECT * FROM final_results_for_viz
WHERE state = 'CA';

-- COMMAND ----------

