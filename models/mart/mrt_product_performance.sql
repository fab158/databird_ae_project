{{ config(
    tags=['weekly']
) }}
SELECT
    prd.product_id,
    prd.product_name,
    prd.category_name,
    prd.brand_name,
    SUM(order_item_total) AS total_sales,
    SUM(quantity) AS total_quantity_sold,
    SUM(order_item_discount) AS total_discount,
    COUNT(DISTINCT order_store_id) AS nb_stores_selling,
    COUNT(DISTINCT evt.order_id) AS nb_sales,
    COUNT(DISTINCT evt.order_date) AS nb_day_with_sales,
    round(
        safe_divide(SUM(order_item_total), COUNT(DISTINCT evt.order_store_id)), 2
    ) AS avg_sales_per_store,
    round(
        safe_divide(SUM(evt.order_item_discount), SUM(evt.order_item_without_discount)), 4
    ) AS avg_discount_rate,
    round(
        safe_divide(SUM(evt.order_item_discount), COUNT(DISTINCT evt.order_id)), 2
    ) AS avg_discount_amount_per_order
FROM {{ ref("int_order_items_event_enriched") }} evt
LEFT join {{ ref("int_products_joined") }} prd on evt.product_id = prd.product_id
WHERE evt.shipment_status = 'SHIPPED'
GROUP BY ALL
