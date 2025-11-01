SELECT
    emp.staff_id   AS employee_id,
    emp.first_name AS employee_first_name,
    emp.last_name  AS employee_last_name,
    emp.email      AS employee_email,
    emp.active     AS employee_active,
    emp.store_id   AS employee_store_id,
    sto.store_name AS employee_store,
    sto.city       AS employee_store_city,
    sto.zip_code   AS employee_zip_code,
    sto.state      AS employee_state,
    mng.staff_id   AS manager_id,
    mng.first_name AS manager_first_name,
    mng.last_name  AS manager_last_name,
    mng.email      AS manager_email,
    mng.store_id   AS manager_store_id  
FROM {{ ref('stg_localbike_database__staffs') }} emp
LEFT JOIN {{ ref('stg_localbike_database__staffs') }} mng
    ON emp.manager_id = mng.staff_id
LEFT join {{ ref('stg_localbike_database__stores') }} sto
    ON emp.store_id = sto.store_id



