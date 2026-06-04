select
    sales_id,
    date_sk,
    store_sk,
    product_sk,
    returned_qty,
    trim(return_reason) as return_reason,
    {{ round_column('refund_amount') }} as refund_amount,
    return_reason in ('Damaged', 'Defective') as is_product_issue,
    return_reason in ('Late Delivery', 'Wrong Item') as is_fulfillment_issue,
    return_reason = 'Changed Mind' as is_customer_initiated
from {{ ref('bronze_returns') }}
where sales_id is not null
  and date_sk is not null
  and store_sk is not null
  and product_sk is not null
  and returned_qty > 0
  and refund_amount >= 0
