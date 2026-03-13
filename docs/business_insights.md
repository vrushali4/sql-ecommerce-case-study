# 📈 Business Insights

This document summarizes the key insights discovered through the SQL analysis of the Olist e-commerce dataset.

The analysis focuses on **marketplace growth, customer behavior, and operational performance**.

---

# Marketplace Overview

| Metric | Value |
|------|------|
Total Revenue | 15.4M |
Total Orders | 96,478 |
Total Customers | 93,358 |
Repeat Rate | 3% |
Late Deliveries | 8.11% |
Average Review Score | 4.08 |

The marketplace processed **nearly 96K orders generating ~15.4M in revenue** during the dataset period.

---

# 1. Revenue Growth

Revenue by year:

| Year | Revenue |
|------|------|
2016 | 46K |
2017 | 6.92M |
2018 | 8.45M |

Revenue increased significantly between 2017 and 2018.

Growth from 2017 to 2018 was approximately **22%**, indicating strong marketplace expansion.

However, 2016 is considered a **partial launch year**, so growth comparisons focus on 2017 onward.

---

# 2. Category Performance

Top categories by revenue share:

| Category | Revenue Share |
|------|------|
Beauty & Health | 9.16% |
Watches & Gifts | 8.20% |
Bed Bath Table | 7.95% |
Sports & Leisure | 7.25% |
Electronics Accessories | 6.70% |

The top five categories contribute **~39% of total revenue**, showing that demand is spread across multiple categories rather than concentrated in a single product segment.

---

# 3. Customer Behavior

Customer metrics:

| Metric | Value |
|------|------|
Total Customers | 93,358 |
Repeat Customers | 2,801 |
Repeat Rate | 3% |

The repeat rate is relatively low, indicating that most customers purchase only once.

However, repeat customers generate **higher revenue per customer**.

| Customer Type | Avg Revenue |
|------|------|
Single Order | 160 |
Repeat | 308 |

Repeat customers spend **almost twice as much**, suggesting that improving retention could significantly increase overall revenue.

---

# 4. Delivery Performance

Delivery performance was analyzed using order delivery timestamps.

Late deliveries account for:


8.11% of total orders


Customer reviews were compared for late vs on-time deliveries.

| Delivery Status | Avg Review Score |
|------|------|
On Time | 4.21 |
Late | 2.55 |

Late deliveries result in a **significant drop in customer satisfaction**, highlighting the operational impact of logistics performance.

---

# Key Business Takeaways

1. The marketplace experienced strong revenue growth during the observed period.

2. Revenue is distributed across multiple product categories, reducing dependence on a single category.

3. Customer retention is low, with only **3% repeat customers**, indicating growth relies heavily on new customer acquisition.

4. Delivery delays strongly correlate with lower review scores, suggesting operational improvements could enhance customer experience.

---

# Strategic Recommendations

Based on the analysis, the following actions may improve business performance:

### Improve Customer Retention

* Loyalty programs
* Personalized product recommendations
* Targeted marketing for returning customers

### Improve Delivery Reliability

* Monitor seller shipping performance
* Improve delivery time estimation
* Strengthen logistics partnerships

### Invest in High-Growth Categories

Expanding high-performing categories such as **Beauty & Health** could accelerate marketplace growth.

---

# Conclusion

This analysis demonstrates how SQL-based exploration of marketplace data can uncover meaningful busines