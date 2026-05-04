{{ config(materialized='table') }}

WITH stg_viajes AS (
    SELECT * FROM {{ ref('stg_taxis_nyc') }}
)

SELECT 
    -- CLAVES (Para conectar con las dimensiones)
    CAST(tpep_pickup_datetime AS DATE) AS fecha_id,
    PULocationID AS pickup_zona_id,
    DOLocationID AS dropoff_zona_id,
    payment_type AS codigo_pago_id,
    VendorID AS proveedor_id,

    -- MÉTRICAS (Lo que vamos a sumar/promediar)
    passenger_count AS pasajeros,
    trip_distance AS distancia_millas,
    fare_amount AS tarifa_base,
    extra AS cargos_extra,
    mta_tax AS impuesto_mta,
    tip_amount AS propina,
    tolls_amount AS peajes,
    improvement_surcharge AS recargo_mejora,
    total_amount AS total_pago,
    congestion_surcharge AS recargo_congestion,

    -- CÁLCULOS ÚTILES
    DATEDIFF(minute, tpep_pickup_datetime, tpep_dropoff_datetime) AS duracion_minutos,
    tpep_pickup_datetime AS fecha_hora_recogida,
    tpep_dropoff_datetime AS fecha_hora_entrega

FROM stg_viajes