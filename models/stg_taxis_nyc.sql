{{
  config(
    materialized='incremental',
    unique_key='id_unico'
  )
}}

WITH trip_data AS (
    SELECT 
        CONCAT(VendorID, '_', tpep_pickup_datetime) AS id_unico,

        -- Identificadores y fechas
        CAST(VendorID AS INT) AS proveedor_id,
        CAST(tpep_pickup_datetime AS DATETIME2(6)) AS fecha_recogida,
        CAST(tpep_dropoff_datetime AS DATETIME2(6)) AS fecha_dejada,
        
        -- Métricas del viaje (CAMBIADO A FLOAT PARA EVITAR EL ERROR)
        CAST(passenger_count AS FLOAT) AS numero_pasajeros, 
        CAST(trip_distance AS FLOAT) AS distancia_viaje,
        CAST(RatecodeID AS FLOAT) AS tarifa_id,
        
        -- Ubicaciones
        CAST(PULocationID AS INT) AS zona_recogida_id,
        CAST(DOLocationID AS INT) AS zona_dejada_id,
        
        -- Costes (Asegúrate de que TODOS sean FLOAT)
        CAST(payment_type AS FLOAT) AS tipo_pago,
        CAST(fare_amount AS FLOAT) AS importe_tarifa,
        CAST(mta_tax AS FLOAT) AS impuesto_mta,
        CAST(tip_amount AS FLOAT) AS importe_propina,
        CAST(total_amount AS FLOAT) AS importe_total, -- Aquí estaba el error con el '17.16'
        CAST(congestion_surcharge AS FLOAT) AS recargo_congestion

    FROM {{ source('staging_data', 'stg_taxis_raw') }}

    -- Usamos FLOAT en los filtros para que coincidan con los CAST de arriba
    WHERE CAST(total_amount AS FLOAT) > 0 
      AND CAST(trip_distance AS FLOAT) > 0 
      AND CAST(passenger_count AS FLOAT) > 0

    {% if is_incremental() %}
      AND tpep_pickup_datetime > (SELECT MAX(fecha_recogida) FROM {{ this }})
    {% endif %}
)

SELECT * 
FROM trip_data