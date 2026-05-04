{{ config(materialized='table') }}

WITH viajes_estaging AS (
    SELECT * FROM {{ ref('stg_taxis_nyc') }}
)

SELECT 
    -- CLAVES PARA DIMENSIONES (IDs)
    CAST(fecha_recogida AS DATE) AS fecha_id, -- Conecta con dim_calendario
    zona_recogida_id AS pickup_zona_id,       -- Conecta con dim_zones
    zona_dejada_id AS dropoff_zona_id,         -- Conecta con dim_zones
    tipo_pago AS codigo_pago_id,               -- Conecta con cat_tipos_pago
    proveedor_id,

    -- MÉTRICAS
    numero_pasajeros,
    distancia_viaje,
    importe_tarifa,
    importe_propina,
    importe_total,
    recargo_congestion,
    impuesto_mta,
    
    -- CÁLCULOS ADICIONALES
    DATEDIFF(minute, fecha_recogida, fecha_dejada) AS duracion_minutos,
    fecha_recogida,
    fecha_dejada

FROM viajes_estaging