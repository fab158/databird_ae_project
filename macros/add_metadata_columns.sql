{% macro add_metadata_columns() %}
DATETIME(CURRENT_TIMESTAMP(),"Europe/Paris") AS dbt_created_at,
DATETIME(CURRENT_TIMESTAMP(),"Europe/Paris") AS dbt_updated_at
{% endmacro %}