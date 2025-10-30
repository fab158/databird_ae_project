select
  category_id,
  category_name
from
  {{ source('localbike_database','categories') }}