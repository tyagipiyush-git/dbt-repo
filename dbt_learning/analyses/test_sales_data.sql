with sales_data as (
    select
        sales_id,
        date_sk,
        store_sk,
        product_sk,
        customer_sk,
        promotion_sk,
        quantity,
        {{ round_column('unit_price') }} as unit_price,
        {{ round_column('gross_amount') }} as gross_amount,
        {{ round_column('discount_amount') }} as discount_amount,
        {{ round_column('net_amount') }} as net_amount,
        trim(payment_method) as payment_method,
        promotion_sk is not null as has_promotion,
        case
            when gross_amount > 0
            then {{ round_column('discount_amount / gross_amount') }}
            else 0
        end as discount_rate
    from {{ ref('bronze_sales') }}
    where sales_id is not null
      and date_sk is not null
      and store_sk is not null
      and product_sk is not null
      and customer_sk is not null
      and quantity > 0
      and gross_amount >= 0
      and discount_amount >= 0
      and net_amount >= 0
),

total_sales_at_silver_level as (
    select count(*) as total_sales
    from sales_data
),

total_sales_at_bronze_level as (
    select count(*) as total_sales
    from {{ ref('bronze_sales') }}
)

select
    s.total_sales as silver_row_count,
    b.total_sales as bronze_row_count,
    b.total_sales - s.total_sales as rows_filtered_out
from total_sales_at_silver_level as s
cross join total_sales_at_bronze_level as b
