select 
    CONCAT(CAST(store_id AS INTEGER),
           CAST(product_id AS INTEGER)) as stock_id,
    CAST(store_id AS INTEGER)           as store_id,         
    CAST(product_id AS INTEGER)         as product_id,
    CAST(quantity AS INTEGER)           as quantity,
from   
   {{ source('localbike_database','stocks') }}