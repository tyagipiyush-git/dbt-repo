-- Store-level performance: sales, returns, and net metrics.
-- Grain: one row per store_sk

with sales_agg as (
    select
        store_sk,
        count(distinct sales_id) as order_count,
        sum(quantity) as units_sold,
        sum(gross_amount) as gross_revenue,
        sum(discount_amount) as total_discount,
        sum(net_amount) as net_revenue,
        count(distinct customer_sk) as unique_customers
    from {{ ref('silver_sales') }}
    group by store_sk
),

returns_agg as (
    select
        store_sk,
        count(*) as return_line_count,
        sum(returned_qty) as units_returned,
        sum(refund_amount) as total_refunds,
        sum(case when is_product_issue then 1 else 0 end) as product_issue_returns,
        sum(case when is_fulfillment_issue then 1 else 0 end) as fulfillment_issue_returns,
        sum(case when is_customer_initiated then 1 else 0 end) as customer_initiated_returns
    from {{ ref('silver_returns') }}
    group by store_sk
)

select
    st.store_sk,
    st.store_name,
    st.city,
    st.region,
    st.country_code,
    st.is_us_store,
    coalesce(sa.order_count, 0) as order_count,
    coalesce(sa.units_sold, 0) as units_sold,
    {{ round_column('coalesce(sa.gross_revenue, 0)') }} as gross_revenue,
    {{ round_column('coalesce(sa.total_discount, 0)') }} as total_discount,
    {{ round_column('coalesce(sa.net_revenue, 0)') }} as net_revenue,
    coalesce(sa.unique_customers, 0) as unique_customers,
    coalesce(ra.return_line_count, 0) as return_line_count,
    coalesce(ra.units_returned, 0) as units_returned,
    {{ round_column('coalesce(ra.total_refunds, 0)') }} as total_refunds,
    {{ round_column('coalesce(sa.net_revenue, 0) - coalesce(ra.total_refunds, 0)') }} as net_revenue_after_returns,
    coalesce(ra.product_issue_returns, 0) as product_issue_returns,
    coalesce(ra.fulfillment_issue_returns, 0) as fulfillment_issue_returns,
    coalesce(ra.customer_initiated_returns, 0) as customer_initiated_returns
from {{ ref('silver_store') }} as st
left join sales_agg as sa
    on st.store_sk = sa.store_sk
left join returns_agg as ra
    on st.store_sk = ra.store_sk
