select *
from {{ref("lookup_test")}}
where customer_id <= 5