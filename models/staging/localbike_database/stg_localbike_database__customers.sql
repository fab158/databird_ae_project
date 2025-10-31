select 
	CAST(customer_id AS INTEGER)     as customer_id,  
	CAST(first_name AS STRING)       as first_name,  
	CAST(last_name AS STRING)        as last_name,
	{{ anonymize_column('phone') }}  as phone,
	{{ anonymize_column('email') }}  as email, 
	{{ anonymize_column('street') }} as street, 
	CAST(city AS STRING)             as city,
	CAST(state AS STRING)            as state,
	CAST(zip_code AS INTEGER)        as zip_code
from 
   {{ source('localbike_database','customers') }}