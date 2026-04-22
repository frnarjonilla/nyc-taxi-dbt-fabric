# NYC Yellow Taxi Analytics 🚕

Este proyecto implementa un flujo de datos moderno (Modern Data Stack), con DBT y MS Fabric, para analizar los viajes de los taxis amarillos de Nueva York utilizando el dataset de **Kaggle**.

## 🚀 Arquitectura
El proyecto sigue una **Arquitectura de Medallón**:
- **Bronze**: Datos crudos cargados en Microsoft Fabric.
- **Silver**: Limpieza y normalización mediante **dbt**.
- **Gold**: Agregaciones de negocio listas para Power BI.

## 🛠️ Stack Tecnológico
* **Almacenamiento:** Microsoft Fabric (Data Warehouse).
* **Transformación:** dbt (Data Build Tool) con el adaptador `dbt-fabric`.
* **Control de Versiones:** GitHub.
* **Orquestación:** Integración nativa de Fabric Git.

## 📁 Estructura del Repositorio
* `dbt_nyc_taxi/`: Contiene los modelos, tests y macros de dbt.
* `notebooks/`: (Opcional) Scripts de Python para exploración inicial.
* `.gitignore`: Archivos excluidos del control de versiones.

## ⚙️ Configuración del Entorno
1. Clonar el repositorio.
2. Instalar dependencias: `pip install dbt-fabric`.
3. Configurar el archivo `profiles.yml` con el SQL Connection String de Fabric.
4. Ejecutar `dbt seed` y `dbt run`.

---
*Proyecto creado como parte de un pipeline de Ingeniería de Datos.*
*Proyecto en construcción*
