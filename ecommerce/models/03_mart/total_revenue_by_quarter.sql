{{
    config(
        alias='total_revenue_by_quarter',
        materialized='table',
        tags=['mart', 'sales']
    )
}}

with fact_sales as (
    select * 
    from {{ ref('fact_sales') }}
),

dim_time as (
    select *
    from {{ ref('dim_time') }}
),

sales_with_time as (
    select 
        f.total_order_price as revenue,
        t.cal_year,
        t.cal_quarter_name
    from fact_sales f
    left join dim_time t
        on f.date_id = t.date_id
)

select 
    cal_year,
    cal_quarter_name,
    sum(revenue) as total_revenue
from sales_with_time
group by cal_year, cal_quarter_name
order by cal_year, cal_quarter_name
