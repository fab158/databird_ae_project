select 
    order_id, 
    item_id, 
    product_id,     
    quantity, 
    list_price, 
    discount 
from 
    {{ source('localbike_database','order_items') }}