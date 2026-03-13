-- 🧱 STEP 1: Create Delivered Orders View
CREATE OR REPLACE VIEW delivered_orders AS
SELECT *
FROM orders
WHERE order_status = 'delivered';

--🧱 STEP 2: Create Fact View
CREATE OR REPLACE VIEW fact_order_items AS
SELECT 
    o.order_id,
    o.customer_id,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    oi.product_id,
    oi.seller_id,
    oi.price,
    oi.freight_value,
    (oi.price + oi.freight_value) AS revenue,
    r.review_score
FROM delivered_orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
LEFT JOIN order_reviews r 
    ON o.order_id = r.order_id;


--1️⃣ Does revenue match manual calculation?
SELECT SUM(revenue) 
FROM fact_order_items;
--15489665.55

--Compare with:--Numbers must match.

SELECT SUM(price + freight_value)
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered';
-- 15419773.75---not match


-- 2️⃣ Row Count Awareness
SELECT COUNT(*) FROM fact_order_items;
--110840

--🛠️ Fix: Aggregate Reviews First
CREATE OR REPLACE VIEW fact_order_items AS
WITH review_agg AS (
    SELECT 
        order_id,
        AVG(review_score) AS review_score
    FROM order_reviews
    GROUP BY order_id
)

SELECT 
    o.order_id,
    o.customer_id,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    oi.product_id,
    oi.seller_id,
    oi.price,
    oi.freight_value,
    (oi.price + oi.freight_value) AS revenue,
    r.review_score
FROM delivered_orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
LEFT JOIN review_agg r 
    ON o.order_id = r.order_id;
-- ERROR:  cannot change data type of view column "review_score" from integer to numeric 

DROP VIEW fact_order_items;

CREATE VIEW fact_order_items AS
WITH review_agg AS (
    SELECT 
        order_id,
        AVG(review_score)::numeric(10,2) AS review_score
    FROM order_reviews
    GROUP BY order_id
)

SELECT 
    o.order_id,
    o.customer_id,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    oi.product_id,
    oi.seller_id,
    oi.price,
    oi.freight_value,
    (oi.price + oi.freight_value) AS revenue,
    r.review_score
FROM delivered_orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
LEFT JOIN review_agg r 
    ON o.order_id = r.order_id;


SELECT SUM(revenue) 
FROM fact_order_items;
--15419773.75


--==================================================
-- 🧱 Step 1: Yearly Revenue
-- From your clean fact_order_items view:

SELECT 
    EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
    SUM(revenue) AS total_revenue
FROM fact_order_items
GROUP BY 1
ORDER BY 1;
-- "year"	"total_revenue"
-- 2016	46653.74
-- 2017	6921535.24
-- 2018	8451584.77

-- 🧱 Step 2: YoY Growth %
-- Now we calculate percentage growth:
WITH yearly_revenue AS (
    SELECT 
        EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
        SUM(revenue) AS total_revenue
    FROM fact_order_items
    GROUP BY 1
)
SELECT 
    year,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY year) AS previous_year_revenue,
    ROUND(
        (total_revenue - LAG(total_revenue) OVER (ORDER BY year)) 
        / LAG(total_revenue) OVER (ORDER BY year) * 100,
        2
    ) AS yoy_growth_percent
FROM yearly_revenue
ORDER BY year;
-- "year"	"total_revenue"	"previous_year_revenue"	"yoy_growth_percent"
-- 2016	46653.74		
-- 2017	6921535.24	46653.74	14735.97
-- 2018	8451584.77	6921535.24	22.11


--Category-Level Revenue
WITH category_revenue AS (
    SELECT 
        p.product_category_name,
        SUM(f.revenue) AS total_revenue
    FROM fact_order_items f
    JOIN products p 
        ON f.product_id = p.product_id
    GROUP BY 1
)

SELECT 
    product_category_name,
    total_revenue,
    ROUND(
        total_revenue / SUM(total_revenue) OVER () * 100,
        2
    ) AS revenue_percent,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM category_revenue
ORDER BY total_revenue DESC;
-- "product_category_name"	"total_revenue"	"revenue_percent"	"revenue_rank"
-- "beleza_saude"	1412089.53	9.16	1
-- "relogios_presentes"	1264333.12	8.20	2
-- "cama_mesa_banho"	1225209.26	7.95	3
-- "esporte_lazer"	1118256.91	7.25	4
-- "informatica_acessorios"	1032723.77	6.70	5


WITH category_yearly AS (
    SELECT 
        EXTRACT(YEAR FROM f.order_purchase_timestamp) AS year,
        p.product_category_name,
        SUM(f.revenue) AS total_revenue
    FROM fact_order_items f
    JOIN products p 
        ON f.product_id = p.product_id
    GROUP BY 1,2
)

SELECT *
FROM category_yearly
WHERE year IN (2017, 2018)
ORDER BY product_category_name, year;
-- "year"	"product_category_name"	"total_revenue"
-- 2017	"beleza_saude"	540949.44
-- 2018	"beleza_saude"	866810.34
-- 2017	"cama_mesa_banho"	580949.20
-- 2018	"cama_mesa_banho"	643653.48
-- 2017	"esporte_lazer"	511372.28
-- 2018	"esporte_lazer"	604393.87
-- 2017	"informatica_acessorios"	447872.56
-- 2018	"informatica_acessorios"	583989.37
-- 2017	"relogios_presentes"	511800.97
-- 2018	"relogios_presentes"	749738.44


SELECT 
    COUNT(*) AS total_customers,
    COUNT(CASE WHEN order_count > 1 THEN 1 END) AS repeat_customers
FROM (
    SELECT 
        customer_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM fact_order_items
    GROUP BY customer_id
) t;
-- "total_customers"	"repeat_customers"
-- 96478	0

SELECT COUNT(DISTINCT customer_id) FROM customers; 
-- "count"
-- 99441
SELECT COUNT(DISTINCT customer_unique_id) FROM customers;
-- "count"
-- 96096


-- 🛠️ Fix the Repeat Analysis
-- We need to rebuild the fact view to include customer_unique_id.
DROP VIEW fact_order_items;

CREATE VIEW fact_order_items AS
WITH review_agg AS (
    SELECT 
        order_id,
        AVG(review_score)::numeric(10,2) AS review_score
    FROM order_reviews
    GROUP BY order_id
)

SELECT 
    o.order_id,
    c.customer_unique_id,
    o.customer_id,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    oi.product_id,
    oi.seller_id,
    oi.price,
    oi.freight_value,
    (oi.price + oi.freight_value) AS revenue,
    r.review_score
FROM delivered_orders o
JOIN customers c 
    ON o.customer_id = c.customer_id
JOIN order_items oi 
    ON o.order_id = oi.order_id
LEFT JOIN review_agg r 
    ON o.order_id = r.order_id;


SELECT 
    COUNT(*) AS total_customers,
    COUNT(CASE WHEN order_count > 1 THEN 1 END) AS repeat_customers
FROM (
    SELECT 
        customer_unique_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM fact_order_items
    GROUP BY customer_unique_id
) t;
-- "total_customers"	"repeat_customers"
-- 93358	2801


WITH customer_orders AS (
    SELECT 
        customer_unique_id,
        COUNT(DISTINCT order_id) AS order_count,
        SUM(revenue) AS total_revenue
    FROM fact_order_items
    GROUP BY customer_unique_id
)

SELECT 
    CASE 
        WHEN order_count = 1 THEN 'Single Order'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customer_count,
    SUM(total_revenue) AS total_revenue,
    ROUND(AVG(total_revenue),2) AS avg_revenue_per_customer
FROM customer_orders
GROUP BY 1;
-- "customer_type"	"customer_count"	"total_revenue"	"avg_revenue_per_customer"
-- "Single Order"	90557	14555586.29	160.73
-- "Repeat Customer"	2801	864187.46	308.53

-- 🚚 Delivery Delay vs Review Score
WITH delivery_performance AS (
    SELECT
        order_id,
        review_score,
        CASE
            WHEN order_delivered_customer_date 
                 <= order_estimated_delivery_date 
            THEN 'On Time or Early'
            ELSE 'Late'
        END AS delivery_status
    FROM fact_order_items
)

SELECT 
    delivery_status,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(review_score),2) AS avg_review_score
FROM delivery_performance
GROUP BY delivery_status;
