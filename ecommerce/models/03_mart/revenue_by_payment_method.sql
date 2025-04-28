{{
    config(
        alias='revenue_by_payment_method',
        materialized='table',
        tags=['mart', 'sales']
    )
}}

with fact_sales as (
    select * 
    from {{ ref('fact_sales') }}
)

select 
    sum(total_order_price) as total_revenue,
    payment_method
from fact_sales
group by payment_method