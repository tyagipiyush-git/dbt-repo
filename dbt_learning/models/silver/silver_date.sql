select
    date_sk,
    cast(`date` as date) as calendar_date,
    day,
    month,
    month_name,
    quarter,
    year as calendar_year,
    day_of_week,
    day_name,
    lower(trim(is_weekend)) = 'true' as is_weekend,
    lower(trim(is_month_end)) = 'true' as is_month_end,
    lower(trim(is_month_start)) = 'true' as is_month_start,
    lower(trim(is_quarter_end)) = 'true' as is_quarter_end,
    lower(trim(is_quarter_start)) = 'true' as is_quarter_start,
    concat(cast(year as string), '-', lpad(cast(month as string), 2, '0')) as year_month
from {{ ref('bronze_date') }}
where date_sk is not null
