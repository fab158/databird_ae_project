WITH order_items_enriched AS (

    SELECT 
       item_id,
       order_id,
       product_id,
       quantity,
       list_price,
       discount,
       quantity * list_price * (1 - discount) AS order_item_total,
       quantity * list_price * discount       AS order_item_discount,
       quantity * list_price                  AS order_item_without_discount
    FROM 
        {{ ref('stg_localbike_database__order_items') }}

),
order_enriched AS (
    
    SELECT
        order_id,
        order_date,
        order_status,
        required_date,
        shipped_date,
        store_id,  
        customer_id,
        staff_id,  
        CASE  
            WHEN shipped_date IS NULL THEN
               "NOT_SHIPPED"
            ELSE
               "SHIPPED"
        END AS shipment_status,
        CASE shipped_date IS NOT NULL
            WHEN shipped_date > required_date THEN
               "LATE_ORDER"
            WHEN shipped_date <= required_date THEN
               "ON_TIME_ORDER"
            ELSE
            "{{ var('default_string_not_applicable') }}"
        END AS shipment_type
    FROM 
        {{ ref('stg_localbike_database__orders') }}

)


select
    ore.order_id,
    ore.order_date,
    ore.order_status,
    ore.required_date,
    ore.shipped_date,
    ore.shipment_status,
    ore.shipment_type,
    ore.customer_id,
    ore.staff_id,  

    oie.item_id,
    oie.product_id,
    oie.quantity,
    oie.list_price,
    oie.discount,
    oie.order_item_total,
    oie.order_item_discount,
    oie.order_item_without_discount,
    

    stock_id,
    stk.quantity       as stock_qty_in_store,

    sto.store_id       as order_store_id,
    sto.store_name     as order_store_name,
    sto.city           as order_store_city,
    sto.state          as order_store_state,
    sto.zip_code       as order_zip_code

from 
    order_items_enriched oie
inner join order_enriched ore
    on oie.order_id = ore.order_id
inner join {{ ref('stg_localbike_database__stores') }} sto
    on ore.store_id = sto.store_id
left join {{ ref('stg_localbike_database__stocks') }} stk
    on  oie.product_id = stk.product_id
    and sto.store_id = stk.store_id
