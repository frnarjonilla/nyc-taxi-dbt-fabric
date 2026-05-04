{{ config(materialized='table') }}

SELECT
    CAST(LocationID AS INT) AS zona_id,
    CAST(Borough AS VARCHAR(100)) AS distrito,
    CAST(Zone AS VARCHAR(255)) AS nombre_zona,
    CAST(service_zone AS VARCHAR(100)) AS zona_servicio
FROM {{ source('staging_data', 'dim_taxi_zones_raw') }}