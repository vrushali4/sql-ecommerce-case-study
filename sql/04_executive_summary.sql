WITH base_metrics AS (
    SELECT 
        SUM(revenue) AS total_revenue,
        COUNT(DISTINCT order_id) AS total_orders,
        COUNT(DISTINCT customer_unique_id) AS total_customers
    FROM fact_order_items
),

repeat_metrics AS (
    SELECT 
        COUNT(*) FILTER (WHERE order_count > 1) AS repeat_customers
    FROM (
        SELECT 
            customer_unique_id,
            COUNT(DISTINCT order_id) AS order_count
        FROM fact_order_items
        GROUP BY customer_unique_id
    ) t
),

delivery_metrics AS (
    SELECT
        COUNT(DISTINCT order_id) FILTER (
            WHERE order_delivered_customer_date 
                  > order_estimated_delivery_date
        ) AS late_orders,
        COUNT(DISTINCT order_id) AS total_orders
    FROM fact_order_items
),

review_metrics AS (
    SELECT 
        ROUND(AVG(review_score),2) AS avg_review_score
    FROM fact_order_items
)

SELECT
    b.total_revenue,
    b.total_orders,
    b.total_customers,
    ROUND(r.repeat_customers::numeric / b.total_customers * 100,2) 
        AS repeat_rate_percent,
    ROUND(d.late_orders::numeric / d.total_orders * 100,2) 
        AS late_delivery_percent,
    rm.avg_review_score
FROM base_metrics b
CROSS JOIN repeat_metrics r
CROSS JOIN delivery_metrics d
CROSS JOIN review_metrics rm;