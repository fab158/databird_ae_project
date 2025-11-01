SELECT
    iee.order_id,
    iee.order_date,
    iee.order_status,
    iee.required_date,
    iee.shipped_date,
    iee.shipment_status,
    iee.shipment_type,
    COUNT(DISTINCT item_id)              AS item_id_nb,
    SUM(iee.quantity)                    AS quantity_order,
    SUM(iee.order_item_discount)         AS discount_order,
    SUM(iee.order_item_total)            AS total_amount_order,
    SUM(iee.order_item_without_discount) AS total_without_discount,
    iee.order_store_id,
    iee.order_store_name,
    iee.order_store_city,
    iee.order_store_state,
    iee.order_zip_code,
    iee.customer_id,
    iee.staff_id

FROM 
    {{ ref('int_order_items_event_enriched') }} iee
GROUP BY ALL
   