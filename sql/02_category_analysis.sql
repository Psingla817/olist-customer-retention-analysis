-- ============================================================
-- 02_category_analysis.sql
-- Olist Customer Retention Analysis
-- Purpose: Measure repeat purchase rate by first-purchase category
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

first_order_categories AS (
    SELECT DISTINCT
        f.customer_unique_id,
        f.first_order_id,
        COALESCE(
            pct.product_category_name_english,
            'Unknown'
        ) AS first_category
    FROM first_orders f
    LEFT JOIN order_items oi
        ON f.first_order_id = oi.order_id
    LEFT JOIN products p
        ON oi.product_id = p.product_id
    LEFT JOIN product_category_name_translation pct
        ON p.product_category_name = pct.product_category_name
)

SELECT
    foc.first_category,
    COUNT(DISTINCT foc.customer_unique_id) AS total_customers,

    COUNT(DISTINCT CASE
        WHEN coc.total_orders >= 2
        THEN foc.customer_unique_id
    END) AS repeat_customers,

    COUNT(DISTINCT foc.customer_unique_id)
    -
    COUNT(DISTINCT CASE
        WHEN coc.total_orders >= 2
        THEN foc.customer_unique_id
    END) AS non_repeat_customers,

    ROUND(
        100.0 *
        COUNT(DISTINCT CASE
            WHEN coc.total_orders >= 2
            THEN foc.customer_unique_id
        END)
        / NULLIF(COUNT(DISTINCT foc.customer_unique_id), 0),
        2
    ) AS repeat_purchase_rate

FROM first_order_categories foc

JOIN customer_order_counts coc
    ON foc.customer_unique_id = coc.customer_unique_id

GROUP BY foc.first_category
ORDER BY repeat_purchase_rate DESC;