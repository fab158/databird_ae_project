select
  CAST(brand_id AS INTEGER) AS brand_id,
  CAST(brand_name AS STRING) AS brand_name
from
  {{ source('localbike_database','brands') }}