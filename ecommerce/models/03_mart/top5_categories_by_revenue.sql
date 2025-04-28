{{
    config(
        alias='top5_categories_by_revenue',
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
        p.category
    from fact_sales f
    left join dim_product p
        on p.product_id = f.product_id
)

select 
    category,
    sum(revenue) as total_revenue
from total_orders
group by category
order by total_revenue desc
limit 5