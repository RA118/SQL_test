-- Percentage of transactions per device type
WITH t1 AS (

	SELECT SUM(t.amount) as total_amount

	FROM transaction t
	--LEFT JOIN device d ON t.device_id = d.id -- don't need joins
	--LEFT JOIN store s ON d.store_id = s.id -- don't need joins

	WHERE LOWER(t.status) = 'accepted'
	--AND DATE(t.happened_at) BETWEEEN DATETRUNC(TODAY(), month) AND TODAY() -- in real life there will be limitation
)

SELECT

d.type AS device_type
AVG(t.amount) AS transacted_amount / t1.total_amount

-- we can use (SELECT SUM(t.amount) from transaction) and DON"T use t1 and WITH
-- but I think it might be more efficient to call it just once
-- and I'd like to show that I have no problem using 'WITH' clause

FROM transaction t
LEFT JOIN device d ON t.device_id = d.id
--LEFT JOIN store s ON d.store_id = s.id -- switching off unnecesary joins
CROSS join t1

WHERE LOWER(status) = 'accepted'
--AND DATE(t.happened_at) BETWEEEN DATETRUNC(TODAY(), month) AND TODAY() -- in real life there will be limitation
GROUP BY 1 ORDER BY 2 DESC;
