WITH sales_by_product AS (
    SELECT
        DATE(evt.order_date) AS order_date,
        evt.order_store_id,
        evt.order_store_name,
        evt.product_id,
        prd.product_name,
        prd.category_name,
        prd.brand_name,
        evt.order_store_city,
        evt.order_store_state,
        SUM(evt.order_item_total) AS total_orders,
        SUM(evt.quantity) AS total_quantities,
        SUM(evt.order_item_discount) AS orders_discount,
        SUM(evt.order_item_without_discount) AS orders_without_discount,
        COUNT(DISTINCT order_id) AS order_nb
    FROM 
        {{ ref('int_order_items_event_enriched') }} evt
    LEFT JOIN {{ ref('int_products_joined') }} prd
        ON evt.product_id=prd.product_id
    WHERE evt.shipment_status = 'SHIPPED'
    GROUP BY ALL
),
last_sales_date AS(
    SELECT 
        max(order_date) as max_order_date
    FROM 
        sales_by_product
),
restricted_years_calendar as (
    SELECT
        full_date,
        date_key,
        year,
        month,
        day,
        day_of_week,
        day_name,
        quarter_label,
        season,
    FROM {{ ref('int_calendar') }}
    CROSS JOIN last_sales_date
    WHERE 
         full_date 
    BETWEEN  
       DATE_SUB(max_order_date, INTERVAL 2 YEAR) AND max_order_date
)

SELECT
    dte.full_date,
    dte.date_key,
    dte.year,
    dte.month,
    dte.day,
    dte.day_of_week,
    dte.day_name,
    dte.quarter_label,
    dte.season,
    
    sls.order_store_id,
    sls.order_store_name,
    sls.product_id,
    sls.product_name,
    sls.category_name,
    sls.order_store_city,
    sls.order_store_state,
    COALESCE(sls.total_orders, 0) AS total_sales,
    COALESCE(sls.total_quantities, 0) AS total_quantities,
    COALESCE(sls.orders_discount, 0) AS total_sales_discount,
    {{ add_metadata_columns() }} 

 FROM restricted_years_calendar dte
 LEFT JOIN sales_by_product sls
    ON sls.order_date = dte.full_date
 ORDER BY full_date DESC