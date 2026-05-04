# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "d0b569d7-9f51-4944-931a-e43cb055a308",
# META       "default_lakehouse_name": "NYC_Taxi_Staging",
# META       "default_lakehouse_workspace_id": "9c6a165d-0129-4ce4-97cf-94fc79edb6a0",
# META       "known_lakehouses": [
# META         {
# META           "id": "d0b569d7-9f51-4944-931a-e43cb055a308"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

path = "Files/taxi+_zone_lookup.csv"

# 2. Leer el CSV asegurando que trate bien las cabeceras y tipos
df_zones = spark.read.format("csv") \
    .option("header", "true") \
    .option("inferSchema", "true") \
    .option("sep", ",") \
    .load(path)

# 3. Limpieza rápida
# Quitamos espacios en blanco de los nombres de las columnas si los hubiera
for col in df_zones.columns:
    df_zones = df_zones.withColumnRenamed(col, col.strip())

# 4. Guardar en el Lakehouse como tabla Delta
# Usamos 'overwrite' para que si lo ejecutas de nuevo, se refresque sin duplicados
df_zones.write.format("delta").mode("overwrite").saveAsTable("dim_taxi_zones_raw")

print("¡Tabla dim_taxi_zones_raw creada con éxito en el Lakehouse!")
display(df_zones.limit(10))

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
