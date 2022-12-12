-- Databricks notebook source
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

SELECT * FROM re_presentation.final_results_for_viz a
WHERE size_rank = (SELECT MIN( b.size_rank )
              FROM re_presentation.final_results_for_viz b
              WHERE a.city = b.city AND a.state = b.state)
AND date LIKE "%-12-31" 
AND date LIKE "202%" 
AND median_sale_price IS NOT NULL
ORDER BY size_rank;

-- COMMAND ----------


