SELECT
    prd.product_id,
    prd.product_name,
    prd.brand_id,
    brd.brand_name,
    prd.category_id,
    cat.category_name
  
FROM 
    {{ ref('stg_localbike_database__products') }} prd
LEFT JOIN {{ ref('stg_localbike_database__categories') }} cat 
    ON prd.category_id = cat.category_id
LEFT JOIN {{ ref('stg_localbike_database__brands') }}  brd 
    ON prd.brand_id = brd.brand_id