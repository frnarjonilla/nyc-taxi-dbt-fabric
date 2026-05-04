CREATE TABLE [dbo].[dim_calendario] (

	[fecha] date NULL, 
	[anio] int NULL, 
	[mes] int NULL, 
	[dia] int NULL, 
	[trimestre] int NULL, 
	[semana] int NULL, 
	[nombre_mes] varchar(10) NULL, 
	[nombre_dia] varchar(10) NULL
);