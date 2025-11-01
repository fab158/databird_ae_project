WITH customer_metrics AS (
    SELECT
        customer_id,
        COUNT(order_id) AS nb_orders,
        MIN(order_date) AS first_order,
        MAX(order_date) AS last_order,
        MAX(quantity_order) AS max_quantity_in_order,
        MAX(item_id_nb) AS max_diff_products_in_order,
        COUNTIF(shipment_status = 'SHIPPED') AS nb_orders_shipped,
        COUNTIF(shipment_status != 'SHIPPED') AS nb_orders_not_shipped,
        SUM(IF(shipment_status = 'SHIPPED', quantity_order, 0)) AS total_quantity_shipped,
        SUM(IF(shipment_status != 'SHIPPED', quantity_order, 0)) AS total_quantity_not_shipped,
        MAX(IF(shipment_status = 'SHIPPED', quantity_order, NULL)) AS max_shipped_quantity,
        MAX(IF(shipment_status != 'SHIPPED', quantity_order, NULL)) AS max_not_shipped_quantity,
        COUNTIF(shipment_type = 'ON_TIME_ORDER') AS nb_on_time_orders,
        COUNTIF(shipment_type = 'LATE_ORDER') AS nb_late_orders,
        COUNTIF(shipment_status = 'SHIPPED' AND shipment_type = 'ON_TIME_ORDER') AS nb_shipped_on_time_orders,
        COUNTIF(shipment_status = 'SHIPPED' AND shipment_type = 'LATE_ORDER') AS nb_shipped_late_orders,
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

    SELECT
        customer_id,
        AVG(delay_since_prev_order) AS avg_delay_between_shipped_orders
    FROM orders_with_prev_shipped
    WHERE delay_since_prev_order IS NOT NULL
    GROUP BY customer_id
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
    IFNULL(adc.avg_delay_between_shipped_orders, 0) AS avg_delay_between_shipped_orders,
    CASE
        WHEN cmt.nb_orders > 1 THEN 'RECURRENT'
        WHEN cmt.nb_orders = 1 AND cmt.first_order < DATE_SUB(CURRENT_DATE(), INTERVAL 180 DAY) THEN 'OLD'
        ELSE 'NEW'
    END AS customer_segment,
    {{ add_metadata_columns() }} 

FROM {{ ref('stg_localbike_database__customers') }} cus
LEFT JOIN customer_metrics cmt
    ON cus.customer_id = cmt.customer_id
LEFT JOIN avg_delay_per_customer adc
    ON cmt.customer_id = adc.customer_id