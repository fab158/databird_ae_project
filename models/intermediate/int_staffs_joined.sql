select
    emp.staff_id   as employee_id,
    emp.first_name as employee_first_name,
    emp.last_name  as employee_last_name,
    emp.email      as employee_email,
    emp.active     as employee_active,
    emp.store_id   as employee_store_id,
    sto.store_name as employee_store,
    sto.city       as employee_store_city,
    sto.zip_code   as employee_zip_code,
    sto.state      as employee_state,
    mng.staff_id   as manager_id,
    mng.first_name as manager_first_name,
    mng.last_name  as manager_last_name,
    mng.email      as manager_email,
    mng.store_id   as manager_store_id  
from {{ ref('stg_localbike_database__staffs') }} emp
left join {{ ref('stg_localbike_database__staffs') }} mng
     on cast(emp.manager_id as string)= cast(mng.staff_id as string)
left join {{ ref('stg_localbike_database__stores') }} sto
    ON emp.store_id = sto.store_id



