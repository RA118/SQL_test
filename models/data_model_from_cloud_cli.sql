SELECT
country, count(distinct store_id) as stores
FROM
(SELECT
    store.id,
    store.name,
    store.address,
    store.city,
    store.country,
    store.created_at,
    store.typology,
    store.customer_id,
    device.id AS device_id,
    device.type AS device_type,
    device.store_id,
    transactions.id AS transactions_id,
    transactions.device_id AS transactions_device_id,
    transactions.product_name,
    transactions.product_sku,
    transactions.category_name,
    transactions.amount,
    transactions.status,
    transactions.card_number,
    transactions.cvv,
    transactions.created_at AS transactions_created_at,
    transactions.happened_at
  FROM
    `clean-wonder-435309-m2.sandbox.store` AS store
    LEFT OUTER JOIN `clean-wonder-435309-m2.sandbox.device` AS device ON store.id = device.store_id
    LEFT OUTER JOIN `clean-wonder-435309-m2.sandbox.transactions` AS transactions ON device.id = transactions.device_id)
GROUP BY 1
ORDER BY 2 DESC