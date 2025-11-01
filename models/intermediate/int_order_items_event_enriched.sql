with order_items_enriched as (

    select 
       item_id,
       order_id,
       product_id,
       quantity,
       list_price,
       discount,
       quantity * list_price * (1 - discount) as order_item_total,
       quantity * list_price * discount       as order_item_discount,
       quantity * list_price                  as order_item_without_discount
    from 
        {{ ref('stg_localbike_database__order_items') }}

),
order_enriched as (
    select
        order_id,
        order_date,
        order_status,
        required_date,
        shipped_date,
        store_id,  
        customer_id,
        staff_id,  
        case 
            when shipped_date is null then
               "NOT_SHIPPED"
            else
               "SHIPPED"
        end as shipment_status,
        case shipped_date is not null
            when shipped_date > required_date then
               "LATE_ORDER"
            when shipped_date <= required_date then
               "ON_TIME_ORDER"
            else
            "{{ var('default_string_not_applicable') }}"
        end as shipment_type
    from 
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
