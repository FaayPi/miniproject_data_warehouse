# 🛠️ Mini Project: End-to-End Data Pipeline with Cloud and Data Warehouse

## 📚 Overview

In this mini project, I built an end-to-end ingestion pipeline in the cloud, combining skills in **cloud computing**, **data warehousing**, and **data modeling**.  
The objective was to populate a data warehouse and produce **reporting-ready tables** from an e-commerce dataset.

---

## ⚙️ Setup

- Worked individually following the daily checklist provided in the lab materials.
- Cloud environment: **AWS S3** and **Snowflake**.
- Data modeling and transformation tool: **dbt (Data Build Tool)**.

---

## ✨ Project Brief

Imagine being hired by an e-commerce company:  
The company’s OLTP (Online Transaction Processing) system exports CSV files every hour into an **AWS S3** bucket.  
My mission was to design and implement a pipeline that:

1. **Ingests** this operational data into a **data warehouse** (Snowflake).
2. **Transforms** raw data into structured, analysis-ready formats.
3. **Models** a star schema to support efficient analytics.
4. **Builds** a **sales data mart** with aggregated, reporting-ready tables.

---

## 📅 Timeline

| Day    | Goal |
|:-------|:-----|
| **Day 1** | Ingest OLTP data into AWS S3 and load it into Snowflake using Snowpipe (with auto-ingest) |
| **Day 2** | Start using dbt to transform raw data into a structured layer |
| **Day 3** | Design the OLAP system by creating a star schema |
| **Day 4** | Build the final sales mart with aggregated, reporting-ready tables |

---

## 🛠️ Technologies Used

- **AWS S3** (data storage)
- **Snowflake** (data warehouse)
- **Snowpipe** (continuous ingestion)
- **dbt** (data transformations and modeling)
- **SQL** (data manipulation and schema design)
- **Cloud services and storage integrations)

---
