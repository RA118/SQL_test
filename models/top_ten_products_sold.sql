-- Top 10 products sold
SELECT
t.product_sku, -- added because different products might have same name
t.product_name AS product_name,
SUM(t.amount) AS transacted_amount

FROM sandbox.transactions t
--LEFT JOIN device d ON t.device_id = d.id -- don't need them here as all the fields are from t
--LEFT JOIN store s ON d.store_id = s.id -- don't need them here as all the fields are from t

WHERE LOWER(status) = 'accepted'
--AND DATE(t.happened_at) BETWEEEN DATETRUNC(TODAY(), MONTH) AND TODAY() -- in real life there will be limitation
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 10
