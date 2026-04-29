CREATE TABLE [dbo].[stg_taxis_nyc] (

	[proveedor_id] int NULL, 
	[fecha_recogida] datetime2(6) NULL, 
	[fecha_dejada] datetime2(6) NULL, 
	[numero_pasajeros] int NULL, 
	[distancia_viaje] float NULL, 
	[tarifa_id] int NULL, 
	[zona_recogida_id] int NULL, 
	[zona_dejada_id] int NULL, 
	[tipo_pago] int NULL, 
	[importe_tarifa] float NULL, 
	[impuesto_mta] float NULL, 
	[importe_propina] float NULL, 
	[importe_total] float NULL, 
	[recargo_congestion] float NULL
);