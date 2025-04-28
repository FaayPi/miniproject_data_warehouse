
{{
        config(
        alias='stg_client_types',
        materialized = 'table',
        tags = ['staging']
    )
}}

with source as (
    select * from {{ source('ecommerce', 'client_type') }}
)

select * from source

