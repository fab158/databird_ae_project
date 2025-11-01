SELECT 
    CONCAT(CAST(store_id AS STRING),
           CAST(product_id AS STRING))  AS stock_id,
    CAST(store_id AS STRING)            AS store_id,         
    CAST(product_id AS STRING)          AS product_id,
    CAST(quantity AS INTEGER)           AS quantity,
FROM   
   {{ source('localbike_database','stocks') }}