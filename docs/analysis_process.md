# ⚙️ Analysis Process

This document describes the steps followed to prepare and analyze the dataset using PostgreSQL.

The goal was to simulate a **real-world data analysis workflow**, starting from raw data ingestion to business insights.

---

# 1. Data Acquisition

The dataset used in this project is the **Brazilian E-Commerce Public Dataset by Olist**, available on Kaggle.

It contains information about:

* Orders
* Customers
* Products
* Sellers
* Payments
* Reviews
* Geolocation

The dataset includes **100k+ orders between 2016 and 2018**.

---

# 2. Database Setup

A PostgreSQL database was created for the analysis.


Database name: e_commerce

Tables were created manually to match the dataset schema.
The schema creation queries are included in:
sql/00_data_preparation.sql


---

# 3. Data Import

CSV files were imported into PostgreSQL tables.

Steps used:


Right Click Table → Import/Export Data
Choose CSV File
Header = YES
Delimiter = ,
Encoding = UTF8


Each CSV file was loaded into its corresponding table.

---

# 4. Data Quality Checks

Before applying constraints and performing analysis, several checks were conducted.

### Orphan Record Detection

Foreign keys were validated by checking for records that did not have matching parent rows.

Example check:


SELECT *
FROM orders
WHERE customer_id NOT IN (
SELECT customer_id
FROM customers
);


This ensures referential integrity before enforcing foreign key constraints.

---

# 5. Data Exploration

Initial exploration was performed to understand the dataset.

Key checks included:

* Row counts per table
* Order status distribution
* Data time range
* Customers vs orders comparison

Example:


SELECT
MIN(order_purchase_timestamp),
MAX(order_purchase_timestamp)
FROM orders;


This revealed that the dataset spans **September 2016 to October 2018**.

---

# 6. Business Metric Definition

Key metrics were defined before performing analysis.

| Metric | Definition |
|------|------|
Revenue | SUM(price + freight_value) |
Orders | COUNT(DISTINCT order_id) |
Customers | COUNT(DISTINCT customer_unique_id) |
AOV | Revenue / Orders |
Repeat Rate | Repeat Customers / Total Customers |

These metrics form the foundation for marketplace performance analysis.

---

# 7. Advanced Analytical Queries

Advanced SQL queries were written to analyze:

* Revenue growth trends
* Category performance
* Customer repeat behavior
* Delivery performance and review scores

These queries are located in:


sql/03_advanced_analysis.sql


---

# Analysis Outcome

Following a structured analytical process ensures:

* reliable metrics
* correct joins
* meaningful business insights

This workflow mirrors how data analysts approach **real-world marketplace data analysis**.