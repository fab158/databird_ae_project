SELECT
   CAST(product_id  AS STRING)   AS product_id,
   CAST(product_name AS STRING)  AS product_name,
   CAST(brand_id  AS STRING)     AS brand_id,
   CAST(category_id  AS STRING)  AS category_id,
   CAST(list_price AS FLOAT64)   AS list_price,
   CAST(model_year AS STRING)    AS model_year
FROM
  {{ source('localbike_database','products') }}