-- Q8: Order volume by hour of day and day of week — for a heatmap
--
-- strftime('%H', ...) → '00' to '23' (two-digit hour)
-- strftime('%w', ...) → '0' (Sunday) to '6' (Saturday)
-- Counting all orders regardless of status to capture when customers click 'buy'

SELECT
    strftime('%w', order_purchase_timestamp)   AS day_of_week_num,
    strftime('%H', order_purchase_timestamp)   AS hour_of_day,
    COUNT(order_id)                            AS order_count

FROM orders
WHERE order_purchase_timestamp IS NOT NULL

GROUP BY day_of_week_num, hour_of_day
ORDER BY day_of_week_num, hour_of_day