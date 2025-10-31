select 
    CAST(staff_id AS INTEGER)        as staff_id,
    CAST(first_name AS STRING)       as first_name,
    CAST(last_name AS STRING)        as last_name,
    CAST(email AS STRING)            as email,
    COALESCE(CAST(phone AS STRING),"{{ var('default_string_unknown') }}") as phone,
    CAST(active AS BOOLEAN)          as active,
    CAST(store_id AS INTEGER)        as store_id,
    SAFE_CAST(manager_id AS INTEGER) as manager_id
from
    {{ source('localbike_database','staffs') }}