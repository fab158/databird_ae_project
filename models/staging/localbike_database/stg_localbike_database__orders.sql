SELECT 
    CAST(order_id AS STRING)         AS order_id,
    CAST(customer_id AS STRING)      AS customer_id,
    CAST(order_status AS STRING)     AS order_status, 
    SAFE_CAST(order_date AS DATE)    AS order_date,
    SAFE_CAST(required_date AS DATE) AS required_date,
    SAFE_CAST(shipped_date  AS DATE) AS shipped_date,
    CAST(store_id AS STRING)         AS store_id,
    CAST(staff_id AS STRING)         AS staff_id
FROM 
    {{ source('localbike_database','orders') }}