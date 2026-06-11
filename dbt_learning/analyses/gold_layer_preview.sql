-- Preview gold-layer outputs for dashboards and learning.
-- Compile only: dbt compile --select path:analyses/gold_layer_preview.sql

-- Top 5 stores by net revenue
select
    store_name,
    city,
    region,
    gross_revenue,
    total_refunds,
    net_revenue_after_returns,
    order_count,
    return_line_count
from {{ ref('gold_store_performance') }}
order by net_revenue_after_returns desc
limit 5
