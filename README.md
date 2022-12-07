# Real Estate Data ETL

**--Description--**

Ingested, transformed, and loaded real estate data from Zillow API.
Created a pipeline that utilizes both historical and current market data to clean, structure, and analyze the potential return on real estate investment that each region would yield.

**--Design--**

- Built a solution architecture for a data engineering solution using Azure Databricks, Azure Data Lake Gen2, Azure Data Factory, and Power BI

- Created, configured, and monitored Databricks clusters, cluster pools, and jobs

- Mounted Azure Storage in Databricks using secrets stored in Azure Key Vault

- Created dashboards to visualise the outputs

- Connected to the Azure Databricks tables from PowerBI

- PySpark for Ingestion of CSV files into the data lake as parquet files/ tables.

- Spark SQL for creating databases, tables, views, and transformations such as Filter, Join, Simple Aggregations, GroupBy, Window functions

- **Implemented full refresh and incremental load patterns using partitions**

- Read, Write, Update, Delete and Merge to delta lake using both PySpark as well as Spark SQL

- History, Time Travel, and Vacuum

- Converting Parquet files to Delta files

- Implemented incremental load pattern using delta lake

- Created pipelines to execute Databricks notebooks

- Designed robust pipelines to deal with unexpected scenarios such as missing files

- Creating dependencies between activities as well as pipelines

- Scheduled the pipelines using data factory triggers to execute at regular intervals

- Monitored the triggers/ pipelines to check for errors/ outputs.

**--Future Improvements--**

Hosted Web app with real-time data streaming

**--Demo--**
