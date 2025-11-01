SELECT
   CAST(product_id  AS INTEGER)  AS product_id,
   CAST(product_name AS STRING)  AS product_name,
   CAST(brand_id  AS INTEGER)    AS brand_id,
   CAST(category_id  AS INTEGER) AS category_id,
   CAST(list_price AS FLOAT64)   AS list_price,
   CAST(model_year AS INTEGER)   AS model_year
FROM
  {{ source('localbike_database','products') }}