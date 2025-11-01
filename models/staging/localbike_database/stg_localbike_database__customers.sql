SELECT 
	CAST(customer_id AS INTEGER)     AS customer_id,  
	CAST(first_name AS STRING)       AS first_name,  
	CAST(last_name AS STRING)        AS last_name,
	{{ anonymize_column('phone') }}  AS phone,
	{{ anonymize_column('email') }}  AS email, 
	{{ anonymize_column('street') }} AS street, 
	CAST(city AS STRING)             AS city,
	CAST(state AS STRING)            AS state,
	CAST(zip_code AS INTEGER)        AS zip_code
FROM 
   {{ source('localbike_database','customers') }}