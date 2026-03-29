-- Q3: Average delivery time (purchase → delivered) per Brazilian state
--
-- julianday() converts a datetime string to a floating-point day number.
-- Subtracting two julianday() values gives the exact number of days elapsed.
-- HAVING total_orders >= 50 removes states with too few orders to be meaningful.

SELECT
    c.customer_state                                                AS state,
    COUNT(o.order_id)                                               AS total_orders,
    ROUND(
        AVG(
            julianday(o.order_delivered_customer_date)
            - julianday(o.order_purchase_timestamp)
        ), 1
    )                                                               AS avg_delivery_days

FROM orders o
    INNER JOIN customers c
        ON o.customer_id = c.customer_id

WHERE o.order_status                  = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_purchase_timestamp      IS NOT NULL

GROUP BY c.customer_state
HAVING total_orders >= 50
ORDER BY avg_delivery_days DESC