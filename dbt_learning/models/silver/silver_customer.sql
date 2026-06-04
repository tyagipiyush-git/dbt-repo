select
    customer_sk,
    trim(concat(first_name, ' ', last_name)) as customer_name,
    lower(trim(email)) as email,
    case
        when UPPER(gender) =='M' then "Male"
        when UPPER(gender) == "F" then "Female"
        else gender
        end as gender,
    case
        when email is null or trim(email) = '' then false
        else true
    end as has_valid_email
from {{ ref('bronze_customer') }}
where customer_sk is not null