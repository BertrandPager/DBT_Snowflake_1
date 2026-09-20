select
    id as payment_id,
    orderid,
    paymentmethod,
    status,
    amount,
    created,
    _batched_at

from {{ source('stripe', 'payment') }}