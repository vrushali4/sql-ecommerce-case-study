--1️⃣ Row Count Check (Data Size Awareness)
SELECT COUNT(*) FROM orders; --count= 99,441
SELECT COUNT(*) FROM customers; --count= 99,441
SELECT COUNT(*) FROM order_items; --count= 1,12,650
SELECT COUNT(*) FROM order_payments; --count= 1,03,886
SELECT COUNT(*) FROM products;--count= 32951

SELECT COUNT(*) FROM order_reviews; --count= 99,224
SELECT COUNT(*) FROM sellers; --count= 3095
SELECT COUNT(*) FROM geolocation; --count= 10,00,163

--2️⃣ Time Range of Data (VERY IMPORTANT)
SELECT 
    MIN(order_purchase_timestamp) AS first_order,
    MAX(order_purchase_timestamp) AS last_order
FROM orders;
-- "first_order"	"last_order"
-- "2016-09-04 21:15:19"	"2018-10-17 17:30:18"


--3️⃣ Order Status Distribution
SELECT 
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;
-- "order_status"	"order_count"
-- "delivered"	96478
-- "shipped"	1107
-- "canceled"	625
-- "unavailable"	609
-- "invoiced"	314
-- "processing"	301
-- "created"	5
-- "approved"	2

--4️⃣ Customers vs Orders 
SELECT 
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders;
-- "total_customers"	"total_orders"
-- 99441	99441


--5️⃣ Revenue Column Understanding (CRITICAL)
SELECT 
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(price) AS avg_price
FROM order_items;


SELECT 
    MIN(freight_value),
    MAX(freight_value),
    AVG(freight_value)
FROM order_items;