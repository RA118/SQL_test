# SQL_test
Technical Test (Take Home Challenge)
--======================================================================--

UPD 2024-09-11

SQLs are optimized for BQ (project clean-wonder-435309-m2) where I created sandbox

dbt files contains connection info and project info

![image](https://github.com/user-attachments/assets/7615bcb7-f47a-4ca3-98ee-da70426a134d)


![image](https://github.com/user-attachments/assets/87cd78ff-ccca-4452-baf4-5efb1f2d5cf1)


--------------------------------------------------------------------------
-- **DATA MODEL**

SELECT

-- **store data**

s.id AS store_id,
s.name AS store_name,
s.address AS store_address,
s.city AS store_city,
s.country AS store_country,
s.created_at AS store_created,
s.typology AS store_typology,

-- **devices**

d.id AS device_id,
d.type AS device_type_id,

-- **transactions**

t.product_name,
t.product_sku,
t.category_name,
t.amount AS transaction_amount,
t.status AS transaction_status,
t.created_at AS transaction_created_at,
t.happened_at AS transaction_happened_at,

FROM transaction t

LEFT JOIN device d ON t.device_id = d.id

LEFT JOIN store s ON d.store_id = s.id
;

--======================================================================--
