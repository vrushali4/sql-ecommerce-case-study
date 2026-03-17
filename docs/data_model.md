# 📊 Data Model Understanding

This document explains the structure of the dataset and how the tables relate to each other for analytical purposes.

The goal is to understand **table grain, relationships, and join logic** before building analytical queries.

---

# Table Grain

Understanding table grain is important to avoid **incorrect joins and revenue duplication**.

| Table | Grain |
|------|------|
customers | 1 row per customer |
orders | 1 row per order |
order_items | 1 row per item within an order |
order_payments | 1 row per payment transaction |
order_reviews | 1 row per order review |
products | 1 row per product |
sellers | 1 row per seller |
geolocation | 1 row per location |

Example:

If an order contains **3 products**, the `order_items` table will have **3 rows** for that order.

---

# Key Relationships

The dataset follows a **marketplace structure**.
customers → orders → order_items
↓
products / sellers

orders → order_reviews
orders → order_payments

Explanation:

* Customers place **orders**
* Orders contain **multiple order items**
* Each item belongs to a **product** and is fulfilled by a **seller**
* Orders may have **reviews and payment records**

🧩 ER Diagram : [`images/Er_diagram.png`](docs/data_model.md)

---

# Analytical Join Logic

When building analytical queries, the following join logic is used:

| Table | Join Key |
|------|------|
orders ↔ customers | customer_id |
order_items ↔ orders | order_id |
products ↔ order_items | product_id |
sellers ↔ order_items | seller_id |
order_reviews ↔ orders | order_id |
order_payments ↔ orders | order_id |

---

# Important Analytical Consideration

Some tables contain **multiple rows per order**, such as:

* `order_items`
* `order_reviews`
* `order_payments`

Joining them without aggregation can cause **row multiplication**, which inflates metrics like revenue.

To prevent this, aggregation is performed before joining when necessary.

Example:
SELECT
order_id,
AVG(review_score) AS review_score
FROM order_reviews
GROUP BY order_id;

---

# Key Analytical Takeaway

Before performing business analysis, it is important to understand:

* Table grain
* Relationship structure
* Potential row multiplication during joins

This ensures **accurate revenue calculations and reliable metrics**.