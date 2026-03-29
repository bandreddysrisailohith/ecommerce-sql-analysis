-- Q6: Per-seller KPIs — orders, revenue, and average review score
--
-- Four-table join:
--   order_items  → sellers     : link each item to its seller
--   order_items  → orders      : filter to delivered orders only
--   orders       → reviews     : attach the customer's review score
--
-- LEFT JOIN on reviews because not every order has a review.
-- HAVING total_orders >= 50 keeps only statistically meaningful sellers.

SELECT
    oi.seller_id,
    s.seller_state,
    COUNT(DISTINCT oi.order_id)       AS total_orders,
    ROUND(SUM(oi.price), 2)           AS total_revenue,
    ROUND(AVG(r.review_score), 2)     AS avg_review_score

FROM order_items oi
    INNER JOIN sellers s
        ON oi.seller_id = s.seller_id
    INNER JOIN orders o
        ON oi.order_id = o.order_id
    LEFT JOIN reviews r
        ON oi.order_id = r.order_id

WHERE o.order_status = 'delivered'

GROUP BY oi.seller_id, s.seller_state
HAVING total_orders >= 50
ORDER BY total_revenue DESC