select
    store_name,
    store_id,
    phone,
    email,
    street,
    city,
    state,
    zip_code
from
  {{ source('localbike_database','stores') }}