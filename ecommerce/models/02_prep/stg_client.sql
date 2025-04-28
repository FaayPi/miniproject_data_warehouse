

{{
        config(
        alias='stg_client',
        materialized = 'table',
        tags = ['staging']
    )
}}

with source as (
    select * from {{ source('ecommerce', 'client') }}
)

select * from source

