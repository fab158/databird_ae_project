select 
    CONCAT(CAST(order_id AS STRING),
           '_', 
           CAST(item_id AS STRING)) as order_items_id,
    CAST(order_id   AS INTEGER)     as order_id,
    CAST(item_id    AS INTEGER)     as item_id, 
    CAST(product_id AS INTEGER)     as product_id, 
    CAST(quantity   AS INTEGER)     as quantity, 
    CAST(list_price AS FLOAT64)     as list_price,
    CAST(discount   AS FLOAT64)     as discount, 
    CAST(quantity * list_price * (1 - discount) AS FLOAT64) as total_price
  
from 
    {{ source('localbike_database','order_items') }}