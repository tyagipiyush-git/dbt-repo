
select
    {{ round_column('gross_amount') }} as gross_rounded
from {{ ref('bronze_sales') }}