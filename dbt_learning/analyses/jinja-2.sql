{%- set apples = ["red", "green", "yellow"] -%}

{%- for i in apples -%}
   
    {% if i != "red" %}
        {{ i }}
    {%- else -%}
    I hate {{ i }}
    {%- endif -%}

{%- endfor -%}