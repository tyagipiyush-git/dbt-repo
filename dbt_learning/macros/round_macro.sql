{%- set default_decimal_places = 2 -%}

{%- macro round_column(column_name, decimal_places) -%}
    {%- if decimal_places is none -%}
        {%- set decimal_places = default_decimal_places -%}
    {%- endif -%}
    round({{ column_name }}, {{ decimal_places }})
{%- endmacro -%}