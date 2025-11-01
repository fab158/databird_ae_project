SELECT 
    CONCAT(CAST(order_id AS STRING),
           '_', 
           CAST(item_id AS STRING)) AS order_items_id,
    CAST(order_id   AS STRING)      AS order_id,
    CAST(item_id    AS STRING)      AS item_id, 
    CAST(product_id AS STRING)      AS product_id, 
    CAST(quantity   AS INTEGER)     AS quantity, 
    CAST(list_price AS FLOAT64)     AS list_price,
    CAST(discount   AS FLOAT64)     AS discount
 
FROM 
    {{ source('localbike_database','order_items') }}