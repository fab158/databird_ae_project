select 
	customer_id, 
	first_name, 
	last_name, 
	{{ anonymize_column('phone') }} as phone,
	{{ anonymize_column('email') }} as email, 
	{{ anonymize_column('street') }} as street, 
	city, 
	state, 
	zip_code 
from 
   {{ source('localbike_database','customers') }}