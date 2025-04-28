{{
    config(
        alias='revenue_by_customer_group',
        materialized='table',
        tags=['mart', 'sales']
    )
}}

with fact_sales as (
    select *
    from {{ ref('fact_sales') }}
),

dim_client as (
    select *
    from {{ ref('dim_client') }}
),

-- Join fact table with dimension
sales_with_client as (
    select 
        f.order_id,
        f.client_id,  -- Verwende client_id aus fact_sales
        f.total_order_price as revenue,
        c.type_id
    from fact_sales f
    left join dim_client c
        on f.client_id = c.client_id  -- Wir joinen jetzt mit client_id
)

-- Aggregiere revenue nach client_type
select 
    type_id as customer_type,
    sum(revenue) as total_revenue
from sales_with_client
group by type_id
order by total_revenue desc
