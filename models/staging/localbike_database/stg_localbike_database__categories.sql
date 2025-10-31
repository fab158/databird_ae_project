select
  CAST(category_id AS INTEGER)  as category_id,
  CAST(category_name AS STRING) as category_name
from
  {{ source('localbike_database','categories') }}