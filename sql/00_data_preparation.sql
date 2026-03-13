CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state CHAR(2)
);

CREATE TABLE geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat NUMERIC(10, 7),
    geolocation_lng NUMERIC(10, 7),
    geolocation_city VARCHAR(100),
    geolocation_state CHAR(2)
);


CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price NUMERIC(10, 2),
    freight_value NUMERIC(10, 2)
);


CREATE TABLE order_payments (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(30),
    payment_installments INT,
    payment_value NUMERIC(10, 2)
);


CREATE TABLE order_reviews (
    review_id VARCHAR(50) PRIMARY KEY,
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);


CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date DATE
);


CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);


CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state CHAR(2)
);


--🧪 Validation Queries (Run Before Adding FKs)

-- orders without customers
SELECT customer_id
FROM orders
WHERE customer_id NOT IN (SELECT customer_id FROM customers);

-- order_items without orders
SELECT order_id
FROM order_items
WHERE order_id NOT IN (SELECT order_id FROM orders);

--1️ orders → customers
ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers (customer_id);

--2 order_items → orders
ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_orders
FOREIGN KEY (order_id)
REFERENCES orders (order_id);

--3️⃣ order_items → products
ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_products
FOREIGN KEY (product_id)
REFERENCES products (product_id);

--4️⃣ order_items → sellers
ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_sellers
FOREIGN KEY (seller_id)
REFERENCES sellers (seller_id);

--5️⃣ order_payments → orders
ALTER TABLE order_payments
ADD CONSTRAINT fk_order_payments_orders
FOREIGN KEY (order_id)
REFERENCES orders (order_id);

--6️⃣ order_reviews → orders
ALTER TABLE order_reviews
ADD CONSTRAINT fk_order_reviews_orders
FOREIGN KEY (order_id)
REFERENCES orders (order_id);

--⭐ Recommended (But Optional) Composite Keys
--These improve data integrity and query logic.
--order_items composite key
ALTER TABLE order_items
ADD CONSTRAINT pk_order_items
PRIMARY KEY (order_id, order_item_id);
--order_payments composite key
ALTER TABLE order_payments
ADD CONSTRAINT pk_order_payments
PRIMARY KEY (order_id, payment_sequential);

--Solve the issue with order_review table (data was not getting loaded in table)
--Step 1: Drop existing primary key
ALTER TABLE order_reviews
DROP CONSTRAINT order_reviews_pkey;

--Step 2: Add a surrogate primary key
ALTER TABLE order_reviews
ADD COLUMN review_pk BIGSERIAL PRIMARY KEY;


