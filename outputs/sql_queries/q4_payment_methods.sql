-- Q4: Payment type share by transactions, revenue, and average order value
--
-- payment_sequential = 1 means "first payment slice for an order".
-- Some customers split payment across two cards (sequential = 1, 2 ...).
-- Filtering to sequential = 1 gives us exactly ONE row per order,
-- which is what we need for counting orders and average order value.

SELECT
    payment_type,
    COUNT(*)                      AS transaction_count,
    ROUND(SUM(payment_value), 2)  AS total_revenue,
    ROUND(AVG(payment_value), 2)  AS avg_order_value

FROM payments
WHERE payment_sequential = 1
  AND payment_type        != 'not_defined'

GROUP BY payment_type
ORDER BY transaction_count DESC