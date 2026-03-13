# 🛒 E-Commerce SQL Business Analysis (Olist Dataset)

## 📌 Project Overview

This project analyzes the **Brazilian E-Commerce Public Dataset by Olist** using **PostgreSQL** to understand marketplace performance, customer behavior, and operational efficiency.

The goal was to simulate a **real business analysis scenario**, answering leadership questions such as:

* Is the platform growing?
* Which product categories drive revenue?
* Are customers returning or buying only once?
* Are delivery delays affecting customer satisfaction?

The project builds a **clean analytical model**, performs **data validation**, and derives **business insights** from ~96K orders.

---

# 🏢 Business Context

An e-commerce marketplace wants to understand its operational and financial health.

Leadership needs answers to questions like:

* Are we generating sustainable revenue growth?
* Which categories contribute most to revenue?
* Do customers return to purchase again?
* Are delivery issues impacting customer satisfaction?

The analysis focuses on **revenue, customer behavior, and operational performance**.

---

# 📊 Dataset

**Source**

Kaggle:
Brazilian E-Commerce Public Dataset by Olist

The dataset contains **100k+ orders from 2016–2018** across multiple Brazilian marketplaces.

---

# 🧰 Tools Used

* **PostgreSQL** – Data storage and analysis
* **SQL** – Data transformation and business queries
* **GitHub** – Project version control

---

# 📁 Project Structure

```
sql-ecommerce-case-study

├── data
│   └── CSV files

├── sql
│   ├── 00_data_preparation.sql
│   ├── 01_data_exploration.sql
│   ├── 02_business_queries.sql
│   ├── 03_advanced_analysis.sql
│   └── 04_executive_summary.sql
|
└── README.md
```

---

# ⚙️ Data Preparation

Steps performed before analysis:

1. Downloaded dataset CSV files from Kaggle
2. Created PostgreSQL database `e_commerce`
3. Created tables manually
4. Imported CSV data into tables
5. Validated **orphan records before applying foreign keys**
6. Added **foreign key constraints** for referential integrity

Example workflow:

```
Right Click Table → Import/Export Data
Choose CSV
Header = YES
Delimiter = ,
Encoding = UTF8
```

---

# 🧠 Data Model Understanding

### Table Grain

| Table          | Grain                          |
| -------------- | ------------------------------ |
| customers      | 1 row per customer             |
| orders         | 1 row per order                |
| order_items    | 1 row per item within an order |
| order_payments | 1 row per payment transaction  |
| order_reviews  | 1 row per order review         |
| products       | 1 row per product              |
| sellers        | 1 row per seller               |
| geolocation    | 1 row per location             |

---

### Key Relationships

```
customers → orders → order_items
                       ↓
                products / sellers

orders → order_reviews
orders → order_payments
```

---

# 📐 Key Business Metrics

| Metric      | Definition                         |
| ----------- | ---------------------------------- |
| Revenue     | SUM(price + freight_value)         |
| Orders      | COUNT(DISTINCT order_id)           |
| Customers   | COUNT(DISTINCT customer_unique_id) |
| AOV         | Revenue / Orders                   |
| Repeat Rate | Repeat Customers / Total Customers |

---

# 🔎 Analysis Performed

## 1️⃣ Revenue Growth Analysis

Revenue by year:

| Year | Revenue |
| ---- | ------- |
| 2016 | 46K     |
| 2017 | 6.92M   |
| 2018 | 8.45M   |

Revenue grew **~22% from 2017 to 2018**, indicating strong marketplace expansion.

Note:
2016 is a **partial launch year**, so growth comparisons start from 2017.

---

## 2️⃣ Category Revenue Analysis

Top categories by revenue share:

| Category                | Revenue Share |
| ----------------------- | ------------- |
| Beauty & Health         | 9.16%         |
| Watches & Gifts         | 8.20%         |
| Bed Bath Table          | 7.95%         |
| Sports & Leisure        | 7.25%         |
| Electronics Accessories | 6.70%         |

The **top 5 categories contribute ~39% of total revenue**, indicating diversified demand.

---

## 3️⃣ Customer Behavior Analysis

Customer metrics:

| Metric           | Value  |
| ---------------- | ------ |
| Total Customers  | 93,358 |
| Repeat Customers | 2,801  |
| Repeat Rate      | 3%     |

Key insight:

Repeat customers spend **almost twice as much per person** compared to single-order customers.

| Customer Type | Avg Revenue |
| ------------- | ----------- |
| Single Order  | 160         |
| Repeat        | 308         |

This suggests **retention improvements could significantly increase revenue**.

---

## 4️⃣ Delivery Performance Analysis

Delivery performance was analyzed against review scores.

| Delivery Status | Avg Review |
| --------------- | ---------- |
| On Time         | 4.21       |
| Late            | 2.55       |

Late deliveries cause a **significant drop in customer satisfaction**, indicating operational impact on customer experience.

Late delivery rate:

```
8.11% of total orders
```

---

# 🧪 Data Validation & Quality Checks

Before finalizing metrics, several validation steps were performed.

### Revenue Validation

Revenue calculated via:

1. Fact table aggregation
2. Manual joins

A mismatch revealed **row duplication due to many-to-one joins**.

### Fix Applied

Reviews were **aggregated before joining**, ensuring correct grain.

This prevented inflated revenue calculations.

---

# 📊 Final Executive Metrics

| Metric           | Value  |
| ---------------- | ------ |
| Total Revenue    | 15.4M  |
| Total Orders     | 96,478 |
| Total Customers  | 93,358 |
| Repeat Rate      | 3%     |
| Late Deliveries  | 8.11%  |
| Avg Review Score | 4.08   |

---

# 💡 Key Insights

### 1️⃣ Strong Marketplace Growth

Revenue increased significantly between 2017 and 2018, showing strong expansion.

---

### 2️⃣ Low Customer Retention

Only **3% of customers return**.

However, repeat customers spend **~2x more**, making retention a major opportunity.

---

### 3️⃣ Delivery Performance Impacts Satisfaction

Late deliveries correlate strongly with poor customer reviews.

Improving delivery reliability could improve customer satisfaction and retention.

---

# 🚀 Business Recommendations

### Improve Customer Retention

* Loyalty programs
* Personalized recommendations
* Targeted email campaigns
* Incentives for repeat purchases

---

### Improve Delivery Reliability

* Monitor seller shipping performance
* Improve delivery time estimation
* Optimize logistics partnerships

---

### Invest in High-Growth Categories

Focus on expanding fast-growing categories like:

* Beauty & Health
* Watches & Gifts

---

# 🎯 Project Outcome

This project demonstrates how **SQL can be used to transform raw marketplace data into business insights**, covering:

* Data modeling
* Data validation
* KPI design
* Business analysis
* Strategic recommendations

---

# 👤 Author

**Vrushali Chilka**
Data Analyst

📍 Pune, India
🔗 LinkedIn: [https://www.linkedin.com/in/vrushali-chilka/](https://www.linkedin.com/in/vrushali-chilka/)
