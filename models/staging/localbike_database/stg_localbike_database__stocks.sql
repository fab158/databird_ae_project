SELECT 
    CONCAT(CAST(store_id AS INTEGER),
           CAST(product_id AS INTEGER)) AS stock_id,
    CAST(store_id AS INTEGER)           AS store_id,         
    CAST(product_id AS INTEGER)         AS product_id,
    CAST(quantity AS INTEGER)           AS quantity,
FROM   
   {{ source('localbike_database','stocks') }}