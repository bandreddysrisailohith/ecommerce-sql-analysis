-- Q2: Monthly order count and revenue for delivered orders only
-- strftime('%Y-%m', ...) extracts the YYYY-MM string for grouping
-- We filter to 'delivered' status so cancelled/pending orders don't inflate revenue

SELECT
    strftime('%Y-%m', o.order_purchase_timestamp)  AS year_month,
    COUNT(DISTINCT o.order_id)                     AS total_orders,
    ROUND(SUM(oi.price), 2)                        AS total_revenue

FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id

WHERE o.order_status            = 'delivered'
  AND o.order_purchase_timestamp IS NOT NULL

GROUP BY year_month
ORDER BY year_month