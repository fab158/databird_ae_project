with customer_metrics AS (
    SELECT
        customer_id,
        count(order_id) as nb_orders,
        min(order_date) as first_order,
        max(order_date) as last_order,
        max(quantity_order) as max_quantity_in_order,
        max(item_id_nb) as max_diff_products_in_order,
        countif(shipment_status = 'SHIPPED') AS nb_orders_shipped,
        countif(shipment_status != 'SHIPPED') AS nb_orders_not_shipped,
        sum(if(shipment_status = 'SHIPPED', quantity_order, 0)) as total_quantity_shipped,
        sum(if(shipment_status != 'SHIPPED', quantity_order, 0)) as total_quantity_not_shipped,
        max(if(shipment_status = 'SHIPPED', quantity_order, NULL)) as max_shipped_quantity,
        max(if(shipment_status != 'SHIPPED', quantity_order, NULL)) as max_not_shipped_quantity,
        countif(shipment_type = 'ON_TIME_ORDER') AS nb_on_time_orders,
        countif(shipment_type = 'LATE_ORDER') AS nb_late_orders,
        countif(shipment_status = 'SHIPPED' AND shipment_type = 'ON_TIME_ORDER') AS nb_shipped_on_time_orders,
        countif(shipment_status = 'SHIPPED' AND shipment_type = 'LATE_ORDER') AS nb_shipped_late_orders,
        DATE_DIFF(CURRENT_DATE(), MIN(order_date), DAY) AS lifetime_days
    FROM {{ ref('int_order_event_summary') }}
    GROUP BY customer_id
),

orders_with_prev_shipped AS (
    SELECT
        customer_id,
        order_id,
        order_date,
        LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_order_date,
        DATE_DIFF(order_date, LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date), DAY) AS delay_since_prev_order
    FROM {{ ref('int_order_event_summary') }}
    WHERE shipment_status = 'SHIPPED'  
),

avg_delay_per_customer AS (
    select
        customer_id,
        AVG(delay_since_prev_order) AS avg_delay_between_shipped_orders
    from orders_with_prev_shipped
    where delay_since_prev_order IS NOT NULL
    group by customer_id
)

SELECT
    cus.customer_id, 
    cus.first_name,
    cus.last_name,
    cus.city,
    cus.state,
    cus.zip_code,
    cmt.nb_orders,
    cmt.first_order,
    cmt.last_order,
    cmt.max_quantity_in_order,
    cmt.max_diff_products_in_order,
    cmt.nb_orders_shipped,
    cmt.nb_orders_not_shipped,
    cmt.total_quantity_shipped,
    cmt.total_quantity_not_shipped,
    cmt.max_shipped_quantity,
    cmt.max_not_shipped_quantity,
    cmt.nb_on_time_orders,
    cmt.nb_late_orders,
    cmt.nb_shipped_on_time_orders,
    cmt.nb_shipped_late_orders,
    cmt.lifetime_days,
    ifnull(adc.avg_delay_between_shipped_orders, 0) AS avg_delay_between_shipped_orders,
    case
        when cmt.nb_orders > 1 then 'RECURRENT'
        when cmt.nb_orders = 1 and cmt.first_order < DATE_SUB(CURRENT_DATE(), INTERVAL 180 DAY) then 'OLD'
        else 'NEW'
    end as customer_segment

from {{ ref('stg_localbike_database__customers') }} cus
left join customer_metrics cmt
    on cus.customer_id = cmt.customer_id
left join avg_delay_per_customer adc
    on cmt.customer_id = adc.customer_id