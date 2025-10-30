select
   product_id,
   product_name,
   brand_id,
   category_id,
   list_price,
   model_year
from
  {{ source('localbike','brands') }}