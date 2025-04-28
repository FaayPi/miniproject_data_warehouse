{{
    config(
        alias='dim_product',
        materialized='table',
        tags=['star_schema']
    )

}}

with product as (
    select
        {{ dbt_utils.generate_surrogate_key(['product_id', 'product_name', 'price']) }} as product_sk,
        product_id,
        product_name,
        category,
        price
    from {{ source('ecommerce', 'product')}}
)

select
    *
from product