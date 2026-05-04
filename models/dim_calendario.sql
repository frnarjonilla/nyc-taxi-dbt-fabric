{{ config(materialized='table') }}

with fechas as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2020-01-01' as date)",
        end_date="cast('2026-12-31' as date)"
    ) }}
),

final as (
    select
        cast(date_day as date) as fecha,
        year(date_day) as anio,
        month(date_day) as mes,
        day(date_day) as dia,
        datepart(quarter, date_day) as trimestre,
        datepart(week, date_day) as semana,
        -- Traducción de nombres de mes a español
        case month(date_day)
            when 1 then 'Enero' when 2 then 'Febrero' when 3 then 'Marzo' 
            when 4 then 'Abril' when 5 then 'Mayo' when 6 then 'Junio'
            when 7 then 'Julio' when 8 then 'Agosto' when 9 then 'Septiembre' 
            when 10 then 'Octubre' when 11 then 'Noviembre' when 12 then 'Diciembre'
        end as nombre_mes,
        -- Día de la semana (1 es Domingo o Lunes según config, pero sacamos el nombre)
        case datepart(weekday, date_day)
            when 1 then 'Domingo' when 2 then 'Lunes' when 3 then 'Martes' 
            when 4 then 'Miércoles' when 5 then 'Jueves' when 6 then 'Viernes' when 7 then 'Sábado'
        end as nombre_dia
    from fechas
)

select * from final