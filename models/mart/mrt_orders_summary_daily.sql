

WITH sales AS (
    SELECT
        DATE(order_date) AS order_date,
        order_store_id,
        order_store_name,
        product_id,
        product_name,
        category_name,
        order_store_city,
        order_store_state,
        SUM(order_item_total) AS total_sales,
        SUM(quantity) AS total_quantity,
        COUNT(DISTINCT order_id) AS total_orders
    FROM {{ ref('int_order_items_event_joined') }} evt
    where evt.order_status = 4
    GROUP BY 
        order_date,
        order_store_id,
        order_store_name,
        product_id,
        product_name,
        category_name,
        order_store_city,
        order_store_state
),
last_sales_date as(
    select max(order_date) as max_order_date
    from sales
),
restricted_years_calandar as (
    select
    full_date,
    date_key,
    year,
    month,
    day,
    day_of_week,
    day_name,
    quarter_label,
    season,
    from {{ ref('int_calendar') }}
    cross join last_sales_date
     WHERE 
         full_date 
    between  
       DATE_SUB(max_order_date, INTERVAL 2 YEAR) - 2 and max_order_date
)
SELECT
    d.full_date,
    d.date_key,
    d.year,
    d.month,
    d.day,
    d.day_of_week,
    d.day_name,
    d.quarter_label,
    d.season,
    
    s.order_store_id,
    s.order_store_name,
    s.product_id,
    s.product_name,
    s.category_name,
    s.order_store_city,
    s.order_store_state,
    COALESCE(s.total_sales, 0) AS total_sales,
    COALESCE(s.total_quantity, 0) AS total_quantity,
    COALESCE(s.total_orders, 0) AS total_orders

 from restricted_years_calandar d
LEFT JOIN sales s
    ON s.order_date = d.full_date
order by full_date desc

