{{
  config(
    materialized='incremental',
    unique_key='id_unico'
  )
}}

WITH trip_data AS (
    SELECT 
        -- Creamos un ID único compuesto para evitar duplicados si se relanza el proceso
        -- Esto concatena el ID del proveedor con la fecha exacta del viaje
        CONCAT(VendorID, '_', tpep_pickup_datetime) AS id_unico,

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
        
        -- Costes
        CAST(payment_type AS INT) AS tipo_pago,
        CAST(fare_amount AS FLOAT) AS importe_tarifa,
        CAST(mta_tax AS FLOAT) AS impuesto_mta,
        CAST(tip_amount AS FLOAT) AS importe_propina,
        CAST(total_amount AS FLOAT) AS importe_total,
        CAST(congestion_surcharge AS FLOAT) AS recargo_congestion

    FROM {{ source('staging_data', 'stg_taxis_raw') }}

    WHERE total_amount > 0 
      AND trip_distance > 0 
      AND passenger_count > 0

    {% if is_incremental() %}
      -- Este bloque solo se ejecuta cuando la tabla ya existe en Fabric
      -- Filtramos para traer solo viajes cuya fecha sea posterior a la última guardada
      AND tpep_pickup_datetime > (SELECT MAX(fecha_recogida) FROM {{ this }})
    {% endif %}
)

SELECT * 
FROM trip_data