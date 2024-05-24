
-- Use the `ref` function to select from other models
{{config(
    schema="TRANSFORMED_POS")}}
select *
from {{ ref('my_first_dbt_model') }}

