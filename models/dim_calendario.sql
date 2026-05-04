{{ config(materialized='table') }}

with fechas as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2020-01-01' as date)",
        end_date="cast('2026-12-31' as date)"
    ) }}
)
select
    date_day as fecha,
    year(date_day) as anio,
    month(date_day) as mes,
    day(date_day) as dia,
    date_format(date_day, 'EEEE') as nombre_dia_semana, -- Esto te lo da en inglés o español según config del server
    quarter(date_day) as trimestre
from fechas