-- Top 10 stores per transacted amount
SELECT
s.id AS store_id, -- added because different stores might have same name
s.name AS store_name,
SUM(t.amount) AS transacted_amount

FROM sandbox.transactions t
LEFT JOIN sandbox.device d ON t.device_id = d.id
LEFT JOIN sandbox.store s ON d.store_id = s.id

WHERE LOWER(t.status) = 'accepted'
--AND DATE(t.happened_at) BETWEEEN DATETRUNC(TODAY(), MONTH) AND TODAY() -- in real life there will be limitation
GROUP BY 1,2 ORDER BY 3 DESC
LIMIT 10