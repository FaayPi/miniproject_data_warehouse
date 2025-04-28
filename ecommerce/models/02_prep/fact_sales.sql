{{
    config(
        alias='fact_sales',
        materialized='table',
        tags=['star_schema']
    )

}}

with orders as (
    select 
        order_id,
        client_id,
        payment_id,
        status,
        total_amount,
        order_date
    from {{ source('ecommerce', 'orders')}}
),

order_product as (
    select 
        order_id,
        order_product_id,
        product_id,
        quantity,
        price_unit
    from {{ source('ecommerce', 'order_product')}}
),

payment_method as (
    select 
        *
    from {{ source('ecommerce', 'payment_method')}}
),

dim_time as (
    select *
    from
        {{ ref('dim_time') }}
),

orders_with_dates as(
    select 
        o.order_id,
        o.client_id,
        pm.payment_method,
        o.status as order_status,
        op.order_product_id,
        op.product_id,
        op.quantity,
        op.price_unit,
        o.total_amount as total_order_price,
        t.date_id 
    from
        orders as o
    join order_product as op
        on o.order_id = op.order_id
    left join payment_method as pm
        on o.payment_id = pm.payment_id
    left join dim_time as t
        on t.calendar_date = TO_DATE(o.order_date)
 )

SELECT
    {{ dbt_utils.generate_surrogate_key(['client_id', 'product_id', 'date_id', 'order_id', 'order_product_id']) }} as sales_id,
    client_id,
    product_id,
    date_id,
    order_id,
    order_product_id,
    order_status,
    quantity,
    payment_method,
    price_unit as unit_price,
    total_order_price
FROM
    orders_with_dates