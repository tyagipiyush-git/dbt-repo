-- Product and category sales performance.
-- Grain: one row per product_sk

select
    p.product_sk,
    p.product_code,
    p.product_name,
    p.department,
    p.category,
    p.price_tier,
    p.list_price,
    count(distinct s.sales_id) as order_line_count,
    coalesce(sum(s.quantity), 0) as units_sold,
    {{ round_column('coalesce(sum(s.gross_amount), 0)') }} as gross_revenue,
    {{ round_column('coalesce(sum(s.discount_amount), 0)') }} as total_discount,
    {{ round_column('coalesce(sum(s.net_amount), 0)') }} as net_revenue,
    count(distinct s.store_sk) as stores_sold_in,
    count(distinct s.customer_sk) as unique_buyers,
    coalesce(max(r.return_line_count), 0) as return_line_count,
    coalesce(max(r.units_returned), 0) as units_returned,
    {{ round_column('coalesce(max(r.total_refunds), 0)') }} as total_refunds
from {{ ref('silver_product') }} as p
left join {{ ref('silver_sales') }} as s
    on p.product_sk = s.product_sk
left join (
    select
        product_sk,
        count(*) as return_line_count,
        sum(returned_qty) as units_returned,
        sum(refund_amount) as total_refunds
    from {{ ref('silver_returns') }}
    group by product_sk
) as r
    on p.product_sk = r.product_sk
group by
    p.product_sk,
    p.product_code,
    p.product_name,
    p.department,
    p.category,
    p.price_tier,
    p.list_price
