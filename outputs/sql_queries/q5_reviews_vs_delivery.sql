-- Q5: For each review score (1–5), count how many reviews there are
-- and calculate the average delivery time for those orders.
-- Hypothesis: longer delivery → lower review score.

SELECT
    r.review_score,
    COUNT(r.review_id)                                              AS review_count,
    ROUND(
        AVG(
            julianday(o.order_delivered_customer_date)
            - julianday(o.order_purchase_timestamp)
        ), 1
    )                                                               AS avg_delivery_days

FROM reviews r
    INNER JOIN orders o
        ON r.order_id = o.order_id

WHERE o.order_status                  = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_purchase_timestamp      IS NOT NULL

GROUP BY r.review_score
ORDER BY r.review_score