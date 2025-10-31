select 
    CAST(order_id AS INTEGER)        as order_id,
    CAST(customer_id AS INTEGER)     as customer_id,
    CAST(order_status AS INTEGER)    as order_status, 
    SAFE_CAST(order_date AS DATE)    as order_date,
    SAFE_CAST(required_date AS DATE) as required_date,
    SAFE_CAST(shipped_date  AS DATE) as shipped_date,
    CAST(store_id AS INTEGER)        as store_id,
    CAST(staff_id AS INTEGER)        as staff_id
from 
    {{ source('localbike_database','orders') }}