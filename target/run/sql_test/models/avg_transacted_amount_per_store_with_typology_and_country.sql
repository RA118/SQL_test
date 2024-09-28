

  create or replace view `clean-wonder-435309-m2`.`dbt_ra118`.`avg_transacted_amount_per_store_with_typology_and_country`
  OPTIONS()
  as --Average transacted amount per store with typology and country
SELECT

s.country AS store_country,
s.typology AS store_typology,
AVG(t.amount) AS transacted_amount

FROM sandbox.transactions t
LEFT JOIN sandbox.device d ON t.device_id = d.id
LEFT JOIN sandbox.store s ON d.store_id = s.id

WHERE LOWER(status) = 'accepted'
--AND DATE(t.happened_at) BETWEEEN DATETRUNC(TODAY(), month) AND TODAY() -- in real life there will be limitation
GROUP BY 1,2;

