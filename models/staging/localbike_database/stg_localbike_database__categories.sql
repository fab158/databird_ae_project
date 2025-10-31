select
  CAST(category_id AS INTEGER) AS category_id,
  CAST(category_name AS STRING) AS category_name
from
  {{ source('localbike_database','categories') }}