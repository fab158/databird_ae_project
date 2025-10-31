select
    prd.product_id,
    prd.product_name,
    prd.brand_id,
    brd.brand_name,
    prd.category_id,
    cat.category_name
  
from 
    {{ ref('stg_localbike_database__products') }} prd
left join {{ ref('stg_localbike_database__categories') }} cat 
    ON prd.category_id = cat.category_id
left join {{ ref('stg_localbike_database__brands') }}  brd 
    ON prd.brand_id = brd.brand_id