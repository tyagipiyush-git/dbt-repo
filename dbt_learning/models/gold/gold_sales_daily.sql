-- Daily sales KPIs by store and date.
-- Grain: one row per calendar_date + store_sk

select
    d.calendar_date,
    d.year_month,
    d.calendar_year,
    d.quarter,
    s.store_sk,
    s.store_name,
    s.city,
    s.region,
    s.country_code,
    count(distinct sa.sales_id) as order_count,
    sum(sa.quantity) as units_sold,
    {{ round_column('sum(sa.gross_amount)') }} as gross_revenue,
    {{ round_column('sum(sa.discount_amount)') }} as total_discount,
    {{ round_column('sum(sa.net_amount)') }} as net_revenue,
    count(distinct sa.customer_sk) as unique_customers,
    count(distinct sa.product_sk) as unique_products_sold,
    sum(case when sa.has_promotion then 1 else 0 end) as promoted_order_lines
from {{ ref('silver_sales') }} as sa
inner join {{ ref('silver_date') }} as d
    on sa.date_sk = d.date_sk
inner join {{ ref('silver_store') }} as s
    on sa.store_sk = s.store_sk
group by
    d.calendar_date,
    d.year_month,
    d.calendar_year,
    d.quarter,
    s.store_sk,
    s.store_name,
    s.city,
    s.region,
    s.country_code
