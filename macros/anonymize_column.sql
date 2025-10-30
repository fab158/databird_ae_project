{% macro anonymize_column(col, method='md5') %}
    {% set val = "COALESCE(" ~ col ~ ", '')" %}
    {% if method == 'md5' %}
        MD5({{ val }})
    {% else %}
        SHA256({{ val }})
    {% endif %}
{% endmacro %}