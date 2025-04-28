{{
    config(
        alias='dim_client',
        materialized='table',
        tags=['star_schema']
    )

}}

with client_status as (
    select * 
    from {{ source('ecommerce', 'client_status')}}
),

client_type as (
    select * 
    from {{ source('ecommerce', 'client_type') }}
),

client as (
    select *
    from {{ source('ecommerce', 'client') }}
)

SELECT 
    {{ dbt_utils.generate_surrogate_key(['c.client_id', 'c.client_name', 'c.address']) }} as client_sk,
    c.client_id,
    c.client_name,
    t.type_id,
    s.status_name,
    c.email,
    {{data_anonymization('c.phone_number')}} as phone_number_masked,
    {{data_anonymization('c.address')}} as address_masked,
    TO_DATE(c.registration_date) as registration_date
FROM 
    client as c
LEFT JOIN client_status as s
    on c.status_id = s.status_id
LEFT JOIN client_type as t
    on c.type_id = t.type_id
