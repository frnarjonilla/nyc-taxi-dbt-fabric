CREATE TABLE [dbo].[stg_taxis_nyc] (

	[id_unico] varchar(8000) NOT NULL, 
	[fecha_carga_sistema] datetime2(6) NULL, 
	[proveedor_id] int NULL, 
	[fecha_recogida] datetime2(6) NULL, 
	[fecha_dejada] datetime2(6) NULL, 
	[numero_pasajeros] float NULL, 
	[distancia_viaje] float NULL, 
	[tarifa_id] float NULL, 
	[zona_recogida_id] int NULL, 
	[zona_dejada_id] int NULL, 
	[tipo_pago] float NULL, 
	[importe_tarifa] float NULL, 
	[impuesto_mta] float NULL, 
	[importe_propina] float NULL, 
	[importe_total] float NULL, 
	[recargo_congestion] float NULL
);