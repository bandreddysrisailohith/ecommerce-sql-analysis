-- Q7: Classify customers as one-time or repeat buyers, compare revenue contribution
--
-- Two-step logic:
--   Inner subquery : aggregate to one row per UNIQUE customer
--                    (customer_id is per-order; customer_unique_id is per person)
--   Outer query    : classify and sum by type
--
-- Note: we use customer_unique_id (not customer_id) so a person who placed
-- 3 orders is counted as ONE customer, not three.

SELECT
    customer_type,
    COUNT(*)                            AS customer_count,
    ROUND(SUM(customer_revenue), 2)     AS total_revenue,
    ROUND(AVG(customer_revenue), 2)     AS avg_revenue_per_customer

FROM (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id)               AS order_count,
        SUM(oi.price)                            AS customer_revenue,
        CASE
            WHEN COUNT(DISTINCT o.order_id) = 1  THEN 'One-time buyer'
            ELSE                                      'Repeat buyer'
        END                                      AS customer_type

    FROM customers c
        INNER JOIN orders o
            ON c.customer_id = o.customer_id
        INNER JOIN order_items oi
            ON o.order_id = oi.order_id

    WHERE o.order_status = 'delivered'

    GROUP BY c.customer_unique_id
) AS customer_summary

GROUP BY customer_type
ORDER BY customer_count DESC