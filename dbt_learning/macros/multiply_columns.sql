--This macro multiplies two columns and returns the result. It's a simple example of helper macro.

{% macro multiply_columns(column1, column2) %}
    {{ column1 }} * {{ column2 }}
{% endmacro %}