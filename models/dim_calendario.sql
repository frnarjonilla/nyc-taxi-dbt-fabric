{{ config(materialized='table') }}

WITH 
-- Generamos una base de números (10 x 10 x 10 x 10 = 10.000 filas posibles)
t0 AS (SELECT 1 AS n UNION ALL SELECT 1),
t1 AS (SELECT 1 AS n FROM t0 AS a CROSS JOIN t0 AS b),
t2 AS (SELECT 1 AS n FROM t1 AS a CROSS JOIN t1 AS b),
t3 AS (SELECT 1 AS n FROM t2 AS a CROSS JOIN t2 AS b),
numeros AS (
    SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS id
    FROM t3
),
fechas_base AS (
    SELECT 
        DATEADD(day, id, CAST('2020-01-01' AS DATE)) AS fecha
    FROM numeros
    WHERE id <= DATEDIFF(day, '2020-01-01', '2026-12-31')
)
SELECT
    fecha,
    YEAR(fecha) AS anio,
    MONTH(fecha) AS mes,
    DAY(fecha) AS dia,
    DATEPART(QUARTER, fecha) AS trimestre,
    DATEPART(WEEK, fecha) AS semana,
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
FROM fechas_base