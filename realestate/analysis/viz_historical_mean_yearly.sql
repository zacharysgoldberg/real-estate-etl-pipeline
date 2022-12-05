-- Databricks notebook source
-- MAGIC %python
-- MAGIC html = """<h1 style="color:Black;text-align:center;font-family:Ariel">Report on the Yearly Mean Home Values and Sales Price Across Cities and States</h1>"""
-- MAGIC displayHTML(html)

-- COMMAND ----------

-- SELECT * FROM re_presentation.final_yearly_results
-- WHERE mean_home_value >= 600000 
-- AND state != 'null'
-- AND year = '2022'
-- LIMIT 10;

SELECT * FROM re_presentation.final_yearly_results
WHERE state != 'null';

-- COMMAND ----------

