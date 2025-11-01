SELECT 
    CAST(staff_id AS INTEGER)        AS staff_id,
    CAST(first_name AS STRING)       AS first_name,
    CAST(last_name AS STRING)        AS last_name,
    CAST(email AS STRING)            AS email,
    COALESCE(CAST(phone AS STRING),"{{ var('default_string_unknown') }}") AS phone,
    CAST(active AS BOOLEAN)          AS active,
    CAST(store_id AS INTEGER)        AS store_id,
    SAFE_CAST(manager_id AS INTEGER) AS manager_id
FROM
    {{ source('localbike_database','staffs') }}