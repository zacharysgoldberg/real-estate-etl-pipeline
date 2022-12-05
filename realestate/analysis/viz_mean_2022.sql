-- Databricks notebook source
-- MAGIC %python
-- MAGIC html = """<h1 style="color:Black;text-align:center;font-family:Ariel">Report on the Mean Home Values and Sales Price Across Cities and States for 2022</h1>"""
-- MAGIC displayHTML(html)

-- COMMAND ----------

SELECT * FROM re_presentation.final_yearly_results
WHERE state != 'null'
AND year = '2022'
AND size_rank <= 20;


-- COMMAND ----------

