{{ config(materialized='table') }}

WITH RegistroFechas AS (
    -- Definimos el inicio y el fin del calendario
    SELECT CAST('2020-01-01' AS DATE) AS fecha
    UNION ALL
    SELECT DATEADD(day, 1, fecha)
    FROM RegistroFechas
    WHERE fecha < '2026-12-31'
)
SELECT
    fecha,
    YEAR(fecha) AS anio,
    MONTH(fecha) AS mes,
    DAY(fecha) AS dia,
    DATEPART(QUARTER, fecha) AS trimestre,
    DATEPART(WEEK, fecha) AS semana,
    -- Nombres en español
    CASE MONTH(fecha)
        WHEN 1 THEN 'Enero' WHEN 2 THEN 'Febrero' WHEN 3 THEN 'Marzo' 
        WHEN 4 THEN 'Abril' WHEN 5 THEN 'Mayo' WHEN 6 THEN 'Junio'
        WHEN 7 THEN 'Julio' WHEN 8 THEN 'Agosto' WHEN 9 THEN 'Septiembre' 
        WHEN 10 THEN 'Octubre' WHEN 11 THEN 'Noviembre' WHEN 12 THEN 'Diciembre'
    END AS nombre_mes,
    CASE DATEPART(WEEKDAY, fecha)
        WHEN 1 THEN 'Domingo' WHEN 2 THEN 'Lunes' WHEN 3 THEN 'Martes' 
        WHEN 4 THEN 'Miércoles' WHEN 5 THEN 'Jueves' WHEN 6 THEN 'Viernes' WHEN 7 THEN 'Sábado'
    END AS nombre_dia
FROM RegistroFechas
-- Importante: Fabric necesita esto para recursiones de más de 100 días
OPTION (MAXRECURSION 0)