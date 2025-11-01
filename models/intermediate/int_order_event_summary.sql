select
    iee.order_id,
    iee.order_date,
    iee.order_status,
    iee.required_date,
    iee.shipped_date,
    iee.shipment_status,
    iee.shipment_type,
    count(distinct item_id) as item_id_nb,
    sum(iee.quantity) as quantity_order,
    sum(iee.order_item_discount) as discount_order,
    sum(iee.order_item_total) as total_amount_order,
    sum(iee.order_item_without_discount) as total_without_discount,
    iee.order_store_id,
    iee.order_store_name,
    iee.order_store_city,
    iee.order_store_state,
    iee.order_zip_code,
    iee.customer_id,
    iee.staff_id
   

from 
    {{ ref('int_order_items_event_enriched') }} iee
group by all
   