{{ config(materialized='incremental') }}

WITH trip_data AS (
    SELECT 
        -- Identificadores y fechas
        CAST(VendorID AS INT) AS proveedor_id,
        CAST(tpep_pickup_datetime AS DATETIME2(6)) AS fecha_recogida,
        CAST(tpep_dropoff_datetime AS DATETIME2(6)) AS fecha_dejada,
        
        -- Métricas del viaje
        CAST(passenger_count AS INT) AS numero_pasajeros,
        CAST(trip_distance AS FLOAT) AS distancia_viaje,
        CAST(RatecodeID AS INT) AS tarifa_id,
        
        -- Ubicaciones
        CAST(PULocationID AS INT) AS zona_recogida_id,
        CAST(DOLocationID AS INT) AS zona_dejada_id,
        
        -- Costes (usamos FLOAT por los decimales)
        CAST(payment_type AS INT) AS tipo_pago,
        CAST(fare_amount AS FLOAT) AS importe_tarifa,
        CAST(mta_tax AS FLOAT) AS impuesto_mta,
        CAST(tip_amount AS FLOAT) AS importe_propina,
        CAST(total_amount AS FLOAT) AS importe_total,
        CAST(congestion_surcharge AS FLOAT) AS recargo_congestion

    FROM {{ source('staging_data', 'stg_taxis_raw') }}
)

SELECT * 
FROM trip_data
WHERE importe_total > 0 and distancia_viaje > 0 and numero_pasajeros > 0