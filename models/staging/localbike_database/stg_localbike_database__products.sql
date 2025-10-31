select
   CAST(product_id  AS INTEGER)  as product_id,
   CAST(product_name AS STRING)  as product_name,
   CAST(brand_id  AS INTEGER)    as brand_id,
   CAST(category_id  AS INTEGER) as category_id,
   CAST(list_price AS FLOAT64)   as list_price,
   CAST(model_year AS INTEGER)   as model_year
from
  {{ source('localbike_database','products') }}