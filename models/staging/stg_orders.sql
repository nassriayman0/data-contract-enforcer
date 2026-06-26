{{ config(materialized='view') }}

WITH raw_data AS (
    SELECT * FROM {{ source('portfolio_raw', 'raw_orders') }}
)

SELECT
    order_id,
    customer_id,
    order_date,
    status
FROM raw_data