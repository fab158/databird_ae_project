select
    prd.product_id,
    prd.product_name,
    prd.category_name,
    prd.brand_name,
    sum(order_item_total) as total_sales,
    sum(quantity) as total_quantity_sold,
    sum(order_item_discount) as total_discount,
    count(distinct order_store_id) as nb_stores_selling,
    count(distinct evt.order_id) as nb_sales,
    count(distinct evt.order_date) as nb_day_with_sales,
    round(
        safe_divide(sum(order_item_total), count(distinct evt.order_store_id)), 2
    ) as avg_sales_per_store,
    round(
        safe_divide(sum(evt.order_item_discount), sum(evt.order_item_without_discount)), 4
    ) as avg_discount_rate,
    round(
        safe_divide(sum(evt.order_item_discount), count(distinct evt.order_id)), 2
    ) as avg_discount_amount_per_order
from {{ ref("int_order_items_event_enriched") }} evt
left join {{ ref("int_products_joined") }} prd on evt.product_id = prd.product_id
where evt.shipment_status = 'SHIPPED'
group by all
