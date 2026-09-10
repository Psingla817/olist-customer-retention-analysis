-- ============================================================
-- 01_retention_analysis.sql
-- Olist Customer Retention Analysis
-- Purpose: Calculate baseline repeat purchase metrics
-- ============================================================

WITH customer_orders AS (
    SELECT
        customer_unique_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM orders
    GROUP BY customer_unique_id
)

SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE order_count >= 2) AS repeat_customers,
    COUNT(*) FILTER (WHERE order_count = 1) AS non_repeat_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE order_count >= 2)
        / COUNT(*),
        2
    ) AS repeat_purchase_rate
FROM customer_orders;