-- Databricks notebook source
-- MAGIC %python
-- MAGIC html = """<h1 style="color:Black;text-align:center;font-family:Ariel">Report on Current and Historical Real Estate Market Data Across Cities and States</h1>"""
-- MAGIC displayHTML(html)

-- COMMAND ----------

-- SELECT * FROM re_presentation.final_results_for_viz
-- WHERE size_rank != 0 AND size_rank < 100;
SELECT * FROM re_presentation.final_results_for_viz;

-- COMMAND ----------

SELECT * FROM re_presentation.final_results_for_viz a
WHERE size_rank = (SELECT MIN( b.size_rank )
              FROM re_presentation.final_results_for_viz b
              WHERE a.city = b.city AND a.state = b.state)
AND date LIKE "2022-07%"
ORDER BY size_rank
LIMIT 50;

-- COMMAND ----------

