
  
    

    create or replace table `clean-wonder-435309-m2`.`dbt_ra118`.`percentage_of_transactions_per_device_type`
      
    
    

    OPTIONS()
    as (
      SELECT AVG(diff_hours) AS avg_time --overall avg
FROM
	(SELECT 
	-- here we calculate differences
		store_id
		, store_name
		, MAX(happened_at) OVER (PARTITION BY store_id) AS fifth_transaction_time -- for presentation and qa purpose
		, MIN(happened_at) OVER (PARTITION BY store_id) AS first_transaction_time -- for presentation and qa purpose
		, DATETIME_DIFF(
				MAX(happened_at) OVER (PARTITION BY store_id) 
		  , MIN(happened_at) OVER (PARTITION BY store_id)
		  , HOUR
		) AS diff_hours -- DATETIME_DIFF is BQ function, might be different in another DB
		FROM
			(SELECT
			-- here we count transactions per store
			s.id AS store_id,
			s.name AS store_name,
			happened_at,
			ROW_NUMBER() OVER (PARTITION BY s.id ORDER BY happened_at ASC) AS nth_transaction,
			COUNT(*) OVER (PARTITION BY s.id) AS max_transactions_per_store

			FROM sandbox.transactions t
			LEFT JOIN sandbox.device d ON t.device_id = d.id
			LEFT JOIN sandbox.store s ON d.store_id = s.id

			WHERE LOWER(status) = 'accepted'
			--AND DATE(t.happened_at) BETWEEEN DATETRUNC(TODAY(), month) AND TODAY()
			GROUP BY 1,2,3
			--ORDER BY 1,3 DESC;
			)
	WHERE max_transactions_per_store >=5 -- stores have 5 or more transactions
	AND nth_transaction = 1 OR nth_transaction = 5 -- we need 1st and 5th
)
    );
  