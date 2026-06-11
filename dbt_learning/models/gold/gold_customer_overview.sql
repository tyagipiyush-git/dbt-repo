-- Customer-level purchase summary for CRM and marketing analytics.
-- Grain: one row per customer_sk

select
    c.customer_sk,
    c.customer_name,
    c.email,
    c.gender,
    c.has_valid_email,
    count(distinct s.sales_id) as order_count,
    coalesce(sum(s.quantity), 0) as units_purchased,
    {{ round_column('coalesce(sum(s.gross_amount), 0)') }} as lifetime_gross_spend,
    {{ round_column('coalesce(sum(s.net_amount), 0)') }} as lifetime_net_spend,
    {{ round_column('coalesce(avg(s.net_amount), 0)') }} as avg_order_value,
    max(d.calendar_date) as last_purchase_date,
    min(d.calendar_date) as first_purchase_date,
    count(distinct s.store_sk) as stores_shopped,
    sum(case when s.has_promotion then 1 else 0 end) as promoted_order_lines
from {{ ref('silver_customer') }} as c
left join {{ ref('silver_sales') }} as s
    on c.customer_sk = s.customer_sk
left join {{ ref('silver_date') }} as d
    on s.date_sk = d.date_sk
group by
    c.customer_sk,
    c.customer_name,
    c.email,
    c.gender,
    c.has_valid_email
