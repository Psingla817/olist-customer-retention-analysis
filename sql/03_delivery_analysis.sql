-- ============================================================
-- 03_delivery_analysis.sql
-- Olist Customer Retention Analysis
-- Purpose: Measure repeat purchase rate by first delivery experience
-- ============================================================

WITH customer_orders AS (
    SELECT
        o.customer_unique_id,
        o.order_id,
        o.order_purchase_timestamp,
        ROW_NUMBER() OVER (
            PARTITION BY o.customer_unique_id
            ORDER BY o.order_purchase_timestamp, o.order_id
        ) AS order_number
    FROM orders o
),

first_orders AS (
    SELECT
        customer_unique_id,
        order_id AS first_order_id
    FROM customer_orders
    WHERE order_number = 1
),

customer_order_counts AS (
    SELECT
        customer_unique_id,
        COUNT(DISTINCT order_id) AS total_orders
    FROM orders
    GROUP BY customer_unique_id
),

first_delivery AS (
    SELECT
        f.customer_unique_id,

        CASE
            WHEN o.order_delivered_customer_date IS NULL
                THEN 'Not delivered'

            WHEN o.order_delivered_customer_date
                 <= o.order_estimated_delivery_date
                THEN 'On time'

            ELSE 'Late'
        END AS first_delivery_status

    FROM first_orders f
    JOIN orders o
        ON f.first_order_id = o.order_id
)

SELECT
    fd.first_delivery_status,
    COUNT(DISTINCT fd.customer_unique_id) AS total_customers,

    COUNT(DISTINCT CASE
        WHEN coc.total_orders >= 2
        THEN fd.customer_unique_id
    END) AS repeat_customers,

    COUNT(DISTINCT fd.customer_unique_id)
    -
    COUNT(DISTINCT CASE
        WHEN coc.total_orders >= 2
        THEN fd.customer_unique_id
    END) AS non_repeat_customers,

    ROUND(
        100.0 *
        COUNT(DISTINCT CASE
            WHEN coc.total_orders >= 2
            THEN fd.customer_unique_id
        END)
        / NULLIF(COUNT(DISTINCT fd.customer_unique_id), 0),
        2
    ) AS repeat_purchase_rate

FROM first_delivery fd

JOIN customer_order_counts coc
    ON fd.customer_unique_id = coc.customer_unique_id

GROUP BY fd.first_delivery_status

ORDER BY repeat_purchase_rate DESC;