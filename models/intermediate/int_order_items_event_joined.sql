SELECT
    ord.order_id,
    ord.order_date,
    ord.required_date,
    ord.shipped_date,
   
    oit.item_id,
    oit.quantity,
    oit.list_price,
    oit.discount,

    ord.store_id       AS order_store_id,
    sto.store_name     AS order_store_name,
    sto.city           AS order_store_city,
    sto.state          AS order_state,
    sto.zip_code       AS order_zip_code,

    cus.customer_id,  
    cus.first_name      AS customer_first_name,  
    cus.last_name       AS customer_last_name,
    cus.phone           AS customer_phone,
    cus.email           AS customer_email, 
    cus.street          AS customer_street, 
    cus.city            AS customer_city,
    cus.state           AS customer_state,
    cus.zip_code        AS customer_zip_code,

    ipj.product_id,
    ipj.product_name,
    ipj.brand_name,
    ipj.category_name,

    isj.employee_id,
    isj.employee_first_name,
    isj.employee_last_name,
    isj.employee_email,
    isj.employee_store,
    isj.employee_store_city,
    isj.employee_state,

    stk.quantity as stock_product_qty_in_store

FROM {{ ref('stg_localbike_database__order_items') }} oit
INNER JOIN {{ ref('stg_localbike_database__orders') }} ord
    ON oit.order_id = ord.order_id
INNER JOIN {{ ref('int_products_joined') }} ipj
    ON oit.product_id = ipj.product_id
INNER JOIN {{ ref('int_staffs_joined') }} isj
    ON ord.staff_id = isj.employee_id
INNER JOIN {{ ref('stg_localbike_database__customers') }} cus
    ON ord.customer_id = cus.customer_id
INNER JOIN {{ ref('stg_localbike_database__stores') }} sto
    ON ord.store_id = sto.store_id
LEFT JOIN {{ ref('stg_localbike_database__stocks') }} stk
    ON  oit.product_id = stk.product_id
    AND ord.store_id = stk.store_id
