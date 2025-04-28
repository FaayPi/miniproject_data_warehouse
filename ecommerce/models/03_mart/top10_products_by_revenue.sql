{{
    config(
        alias='top10_products_by_revenue',
        materialized='table',
        tags=['mart', 'sales']
    )
}}

with fact_sales as (
    select * 
    from {{ ref('fact_sales') }}
),

dim_product as (
    select *
    from {{ ref('dim_product') }}
),

total_orders as (
    select 
        f.total_order_price as revenue,
        p.product_name
    from fact_sales f
    left join dim_product p
        on p.product_id = f.product_id
)

select 
    product_name,
    sum(revenue) as total_revenue
from total_orders
group by product_name
order by total_revenue desc
limit 10