
with customer_order_profile as(
    select 
        evt.order_id,
        evt.customer_id,
        sum(evt.order_item_total) as total_amount_order,
        sum(evt.quantity) AS order_quantity
    from {{ ref('int_order_items_event_joined') }} evt
    group by order_id, customer_id
)
select 
    evt.customer_id,
    MIN(evt.order_date) as first_order_date,
	MAX(evt.order_date) as last_order_date,
    DATE_DIFF(MAX(evt.order_date), MIN(evt.order_date), DAY) as customer_lifetime,
    COUNT(DISTINCT evt.order_id) as total_orders,
    MAX(orp.total_amount_order) as max_order_amount,
    MAX(orp.order_quantity) as max_order_quantity,
    SUM(orp.order_quantity) as total_order_quantity,
    DATE_DIFF(CURRENT_DATE(), MAX(evt.order_date), DAY) as delay_since_last_order

    from {{ ref('int_order_items_event_joined') }} evt
    inner join customer_order_profile orp
        on evt.order_id=orp.order_id
        and evt.customer_id=orp.customer_id
    group by customer_id