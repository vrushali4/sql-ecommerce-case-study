# 🛒 E-Commerce SQL Business Analysis (Olist Dataset)

## 📌 Project Overview

This project analyzes the **Brazilian E-Commerce Public Dataset by Olist** using **PostgreSQL** to evaluate marketplace performance, customer behavior, and operational efficiency.

The goal was to simulate a **real business analysis scenario**, answering questions such as:

* Is the platform growing sustainably?
* Which product categories drive the most revenue?
* Are customers returning to make repeat purchases?
* Do delivery delays affect customer satisfaction?

The project builds a **clean analytical model**, performs **data validation**, and generates **business insights from ~96K orders**.

For detailed technical documentation:

* 📊 Data Model → [`docs/data_model.md`](docs/data_model.md)
* ⚙️ Analysis Process → [`docs/analysis_process.md`](docs/analysis_process.md)
* 📈 Business Insights → [`docs/business_insights.md`](docs/business_insights.md)

---

# 🏢 Business Context

An e-commerce marketplace wants to understand its **financial and operational performance**.

Leadership needs answers to key questions:

* Are we generating sustainable revenue growth?
* Which product categories contribute the most revenue?
* Do customers return to purchase again?
* Are delivery issues impacting customer satisfaction?

This project approaches the dataset from a **data analyst perspective**, transforming raw transactional data into **actionable business insights**.

---

# 📊 Dataset

**Source**

Kaggle:
Brazilian E-Commerce Public Dataset by Olist

Dataset includes:

* 100K+ orders
* Customer information
* Product and seller details
* Payment transactions
* Customer reviews
* Delivery timestamps
* Geolocation data

Time period:

```
September 2016 → October 2018
```

---

# 🧰 Tools Used

* **PostgreSQL** → Data storage and querying
* **SQL** → Data transformation and business analysis
* **GitHub** → Version control and documentation

---

# 📁 Project Structure

```
sql-ecommerce-case-study
│
├── README.md
│
├── data
│   └── raw_csv_files
│
├── sql
│   ├── 00_data_preparation.sql
│   ├── 01_data_exploration.sql
│   ├── 02_business_queries.sql
│   ├── 03_advanced_analysis.sql
│   └── 04_executive_summary.sql
│
├── docs
│   ├── data_model.md
│   ├── analysis_process.md
│   └── business_insights.md
│
└── images
```

SQL files contain the full analytical workflow from **data preparation to business insights**.

---

# 📊 Key Metrics Snapshot

| Metric               | Value  |
| -------------------- | ------ |
| Total Revenue        | 15.4M  |
| Total Orders         | 96,478 |
| Total Customers      | 93,358 |
| Repeat Customers     | 2,801  |
| Repeat Rate          | 3%     |
| Late Deliveries      | 8.11%  |
| Average Review Score | 4.08   |

---

# 💡 Key Insights

### Marketplace Growth

Revenue grew significantly between **2017 and 2018 (~22%)**, indicating strong platform expansion.

---

### Low Customer Retention

Only **3% of customers return for another purchase**.

However, repeat customers spend **almost twice as much per person**, suggesting that improving retention could significantly increase revenue.

---

### Delivery Performance Impacts Satisfaction

Late deliveries represent **8.11% of orders**.

Customer review comparison:

| Delivery Status | Avg Review Score |
| --------------- | ---------------- |
| On Time         | 4.21             |
| Late            | 2.55             |

Late deliveries correlate strongly with **lower customer satisfaction**.

---

# 🚀 Business Recommendations

### Improve Customer Retention

Possible initiatives:

* Loyalty programs
* Personalized recommendations
* Targeted marketing campaigns
* Incentives for repeat purchases

Even small improvements in repeat rate could significantly increase **customer lifetime value**.

---

### Improve Delivery Reliability

Operational improvements may include:

* Monitoring seller shipping performance
* Improving delivery time estimation
* Optimizing logistics partnerships

Reducing delivery delays could improve **customer satisfaction and retention**.

---

### Invest in High-Growth Categories

Top-performing categories include:

* Beauty & Health
* Watches & Gifts
* Bed Bath Table

Expanding these categories could further accelerate marketplace growth.

---

# 👤 Author

**Vrushali Chilka**
Data Analyst

📍 Pune, India

🔗 LinkedIn
[https://www.linkedin.com/in/vrushali-chilka/](https://www.linkedin.com/in/vrushali-chilka/)

---