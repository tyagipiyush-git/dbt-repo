select
    product_sk,
    upper(trim(product_code)) as product_code,
    trim(product_name) as product_name,
    trim(department) as department,
    trim(category) as category,
    supplier_sk,
    {{ round_column('list_price') }} as list_price,
    lower(trim(uom)) as uom,
    case
        when list_price < 10 then 'low'
        when list_price < 100 then 'medium'
        else 'high'
    end as price_tier
from {{ ref('bronze_product') }}
where product_sk is not null
  and product_code is not null
