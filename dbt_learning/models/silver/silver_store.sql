select
    store_sk,
    upper(trim(store_code)) as store_code,
    trim(store_name) as store_name,
    trim(city) as city,
    upper(trim(state_province)) as state_province,
    trim(region) as region,
    trim(country) as country,
    case
        when upper(trim(country)) in ('USA', 'UNITED STATES') then 'US'
        when upper(trim(country)) = 'CANADA' then 'CA'
        else upper(trim(country))
    end as country_code,
    cast(open_date as date) as open_date,
    sq_ft,
    upper(trim(country)) = 'USA' as is_us_store
from {{ ref('bronze_store') }}
where store_sk is not null
  and store_code is not null
