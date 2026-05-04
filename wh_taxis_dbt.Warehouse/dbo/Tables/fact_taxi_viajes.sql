CREATE TABLE [dbo].[fact_taxi_viajes] (

	[fecha_id] date NULL, 
	[pickup_zona_id] int NULL, 
	[dropoff_zona_id] int NULL, 
	[codigo_pago_id] float NULL, 
	[proveedor_id] int NULL, 
	[numero_pasajeros] float NULL, 
	[distancia_viaje] float NULL, 
	[importe_tarifa] float NULL, 
	[importe_propina] float NULL, 
	[importe_total] float NULL, 
	[recargo_congestion] float NULL, 
	[impuesto_mta] float NULL, 
	[duracion_minutos] int NULL, 
	[fecha_recogida] datetime2(6) NULL, 
	[fecha_dejada] datetime2(6) NULL
);