{{ config(
    materialized='table'
) }}

with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

payment as (
    select * from {{ ref('stg_payment') }}
)

select
    orders.order_id,
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    /*payment.payment_id,*/
    /*count(orders.order_id) as number_of_orders,*/
    /*min(orders.order_date) as first_order_date,
    max(orders.order_date) as most_recent_order_date*/
    count(payment.payment_id) as nb_of_payment,
    sum(payment.amount) as sum_of_payment

    from orders
    left join customers 
        on orders.customer_id = customers.customer_id
    left join payment
        on orders.order_id = payment.orderid

    group by 1, 2, 3, 4