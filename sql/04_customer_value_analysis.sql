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

first_order_value AS (
    SELECT
        f.customer_unique_id,
        f.first_order_id,
        COALESCE(SUM(oi.price + oi.freight_value), 0) AS first_order_value
    FROM first_orders f
    LEFT JOIN order_items oi
        ON f.first_order_id = oi.order_id
    GROUP BY
        f.customer_unique_id,
        f.first_order_id
),

ranked_customers AS (
    SELECT
        *,
        NTILE(3) OVER (
            ORDER BY first_order_value
        ) AS value_bucket
    FROM first_order_value
),

customer_segments AS (
    SELECT
        customer_unique_id,
        first_order_value,

        CASE
            WHEN value_bucket = 1 THEN 'Low Value'
            WHEN value_bucket = 2 THEN 'Medium Value'
            WHEN value_bucket = 3 THEN 'High Value'
        END AS customer_value_segment

    FROM ranked_customers
)

SELECT
    cs.customer_value_segment,
    COUNT(DISTINCT cs.customer_unique_id) AS customers,

    COUNT(DISTINCT CASE
        WHEN coc.total_orders >= 2
        THEN cs.customer_unique_id
    END) AS repeat_customers,

    ROUND(
        100.0 *
        COUNT(DISTINCT CASE
            WHEN coc.total_orders >= 2
            THEN cs.customer_unique_id
        END)
        / NULLIF(COUNT(DISTINCT cs.customer_unique_id), 0),
        2
    ) AS repeat_purchase_rate,

    ROUND(AVG(cs.first_order_value), 2)
        AS avg_first_order_value

FROM customer_segments cs

JOIN customer_order_counts coc
    ON cs.customer_unique_id = coc.customer_unique_id

GROUP BY cs.customer_value_segment

ORDER BY
    CASE cs.customer_value_segment
        WHEN 'Low Value' THEN 1
        WHEN 'Medium Value' THEN 2
        WHEN 'High Value' THEN 3
    END;