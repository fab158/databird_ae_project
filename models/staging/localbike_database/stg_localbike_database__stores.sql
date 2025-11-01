SELECT

    CAST(store_id AS INTEGER)   AS store_id,  
    CAST(store_name AS STRING)  AS store_name, 
    CAST(phone AS STRING)       AS phone,
    CAST(email AS STRING)       AS email,
    CAST(street AS STRING)      AS street,
    CAST(city AS STRING)        AS city,
    CAST(state AS STRING)       AS state,
    CAST(state AS zip_code)     AS zip_code,
   
FROM
  {{ source('localbike_database','stores') }}

  