--1️⃣ Total Revenue, Orders, Customers
SELECT
    SUM(oi.price + oi.freight_value) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';

-- "total_revenue"	"total_orders"	"total_customers"
-- 15419773.75	96478	96478


--2️⃣ Average Order Value (AOV)
SELECT
    SUM(oi.price + oi.freight_value) / COUNT(DISTINCT o.order_id) AS avg_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';
-- "avg_order_value"
-- 159.8268387611683493


--3️⃣ Monthly Revenue Trend (TIME INTELLIGENCE)
SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS order_month,
    SUM(oi.price + oi.freight_value) AS monthly_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY order_month
ORDER BY order_month;
-- "order_month"	"monthly_revenue"
-- "2016-09-01 00:00:00"	143.46
-- "2016-10-01 00:00:00"	46490.66
-- "2016-12-01 00:00:00"	19.62
-- "2017-01-01 00:00:00"	127482.37
-- "2017-02-01 00:00:00"	271239.32
-- "2017-03-01 00:00:00"	414330.95
-- "2017-04-01 00:00:00"	390812.40
-- "2017-05-01 00:00:00"	566851.40
-- "2017-06-01 00:00:00"	490050.37
-- "2017-07-01 00:00:00"	566299.08
-- "2017-08-01 00:00:00"	645832.36
-- "2017-09-01 00:00:00"	701077.49
-- "2017-10-01 00:00:00"	751117.01
-- "2017-11-01 00:00:00"	1153364.20
-- "2017-12-01 00:00:00"	843078.29
-- "2018-01-01 00:00:00"	1077887.46
-- "2018-02-01 00:00:00"	966168.41
-- "2018-03-01 00:00:00"	1120598.24
-- "2018-04-01 00:00:00"	1132878.93
-- "2018-05-01 00:00:00"	1128774.52
-- "2018-06-01 00:00:00"	1011978.29
-- "2018-07-01 00:00:00"	1027807.28
-- "2018-08-01 00:00:00"	985491.64

--4️⃣ Orders vs Customers (Repeat Behavior)
SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    COUNT(DISTINCT o.order_id)::float
    / COUNT(DISTINCT o.customer_id) AS orders_per_customer
FROM orders o
WHERE o.order_status = 'delivered';
-- "total_orders"	"total_customers"	"orders_per_customer"
-- 96478	96478	1


--5️⃣ Top Customers by Revenue
SELECT
    o.customer_id,
    SUM(oi.price + oi.freight_value) AS customer_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY o.customer_id
ORDER BY customer_revenue DESC
LIMIT 10;

-- "customer_id"	"customer_revenue"
-- "1617b1357756262bfa56ab541c47bc16"	13664.08
-- "ec5b2ba62e574342386871631fafd3fc"	7274.88
-- "c6e2731c5b391845f6800c97401a43a9"	6929.31
-- "f48d464a0baaea338cb25f816991ab1f"	6922.21
-- "3fd6777bbce08a352fddd04e4a7cc8f6"	6726.66
-- "05455dfa7cd02f13d132aa7a6a9729c6"	6081.54
-- "df55c14d1476a9a3467f131269c2477f"	4950.34
-- "24bbf5fd2f2e1b359ee7de94defc4a15"	4764.34
-- "3d979689f636322c62418b6346b1c6d2"	4681.78
-- "1afc82cd60e303ef09b4ef9837c9505c"	4513.32

