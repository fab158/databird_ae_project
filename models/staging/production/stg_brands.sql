select
  brand_id,
  brand_name
from
  {{ source('production_localbike','brands') }}