
select
    {{ round_column('gross_amount', 2) }} as gross_rounded
from {{ ref('bronze_sales') }}