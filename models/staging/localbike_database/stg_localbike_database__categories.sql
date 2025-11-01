SELECT
  CAST(category_id AS STRING)  AS category_id,
  CAST(category_name AS STRING) AS category_name
FROM
  {{ source('localbike_database','categories') }}