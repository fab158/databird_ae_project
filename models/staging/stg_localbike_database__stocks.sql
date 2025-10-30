select 
    store_id, 
    product_id, 
    quantity
from   
   {{ source('localbike_database','stocks') }}