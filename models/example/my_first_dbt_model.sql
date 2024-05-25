
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (

   SELECT CHANNEL,CASE
        WHEN length(DATE) = 10 AND substr(DATE, 5, 1) = '-' AND substr(DATE, 8, 1) = '-' THEN DATE
        WHEN length(DATE) = 10 AND substr(DATE, 3, 1) = '-' AND substr(DATE, 6, 1) = '-' 
        THEN concat(substring(DATE, 7, 4), '-', substring(DATE, 4, 2), '-', substring(DATE, 1, 2))
        ELSE NULL
    END AS DATE,
DIVISION,
CASE 
    WHEN SUBSTR(SKU, 1, 3) IN ('ABC', 'DEF', 'GHI') THEN SUBSTR(SKU, 1, 3)
    ELSE NULL 
END AS BRAND,
REGEXP_REPLACE(SUBSTR(SKU, 4, POSITION(' ' IN SKU) - 4), '[^0-9]', '') AS PRODUCT,
POS_UNITS,
PARTNER,SALES_ORG,cast(SALES AS FLOAT) AS SALES,UNITS_ON_HAND,STORE FROM CUSTOMER_POS

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
