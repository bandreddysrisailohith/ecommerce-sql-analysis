-- Q1: Total revenue per product category (English names), top 15
-- Revenue = sum of item prices; freight excluded to reflect product demand only
--
-- JOIN logic:
--   order_items → products   : get the category name for each sold item
--   products → category_translation : translate Portuguese → English

SELECT
    COALESCE(ct.product_category_name_english, 'Unknown / Not Translated') AS category,
    COUNT(DISTINCT oi.order_id)                                             AS total_orders,
    ROUND(SUM(oi.price), 2)                                                 AS total_revenue,
    ROUND(AVG(oi.price), 2)                                                 AS avg_item_price

FROM order_items oi
    INNER JOIN products p
        ON oi.product_id = p.product_id
    LEFT JOIN category_translation ct           -- LEFT JOIN keeps items with no translation
        ON p.product_category_name = ct.product_category_name

GROUP BY category
ORDER BY total_revenue DESC
LIMIT 15