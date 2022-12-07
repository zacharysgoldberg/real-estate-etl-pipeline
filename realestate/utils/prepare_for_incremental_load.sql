-- Databricks notebook source
-- MAGIC %md
-- MAGIC ### Drop tables

-- COMMAND ----------

DROP TABLE IF EXISTS re_prrocessed CASCADE

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS re_processed
LOCATION "/mnt/realestatedl/processed";

-- COMMAND ----------

DROP DATABASE IF EXISTS re_presentation CASCADE;

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS re_presentation
LOCATION "mnt/realestatedl/presentation";