{%- macro round_column(column_name, decimal_places=2) -%}
    round({{ column_name }}, {{ decimal_places }})
{%- endmacro -%}