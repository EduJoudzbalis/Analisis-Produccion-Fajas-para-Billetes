# 🏭 Optimización de Producción Industrial: Análisis de Eficiencia en Máquina de Producción de Fajas para Billetes (SQL + Python)

## 🚀 Executive Summary 
Este proyecto analiza el rendimiento operativo de una línea de corte de fajas para billetes bancarios durante el trimestre **Junio-Agosto 2025**. A partir de la digitalización de bitácoras manuales, se identificó que la inestabilidad del proceso provoca una **pérdida de producción del 24.4%** en días con fallas mecánicas.

El análisis detectó patrones estacionales de fallas (sensores en junio, contactores en agosto), permitiendo proponer una estrategia de mantenimiento preventivo que podría recuperar hasta **42,000 unidades diarias** en promedio.

## 💼 Business Problem 
La máquina es crítica para la entrega de insumos a entidades bancarias.
* **El Problema:** La producción es altamente variable, oscilando entre 9,000 y 222,000 unidades diarias, lo que genera incertidumbre en los plazos de entrega y costos por horas extra no planificadas.
* **El Objetivo:** Utilizar datos históricos para diagnosticar las causas raíz de los "tiempos muertos" y estandarizar el rendimiento.

## 🗂️ Estructura del Repositorio
* `/datos`: Contiene el dataset crudo y procesado (`FajasJnJlAg2025.csv`).
* `/sql`: Scripts para la creación de la base de datos y consultas de análisis.
* `/evidencia`: **Pruebas documentales.** Contiene los escaneos originales y capturas de pantalla de los resultados en MySQL Workbench.
* `/notebooks`: Análisis exploratorio y estadístico visual en Python (Google Colab).

## 🛠️ Tech Stack & Skills (Herramientas y Habilidades)
* **Data Cleaning (Excel & Python):** Transformación de registros manuscritos no estructurados a formato CSV normalizado.
* **SQL (MySQL):** Diseño de esquema relacional (`CREATE TABLE`), ingestión de datos y consultas de agregación para KPIs.
* **Statistical Analysis (Python/Pandas):** Cálculo de desviación estándar, coeficiente de variación (CV) e impacto porcentual de fallas.
* **Reporting:** Documentación técnica y traducción de métricas a lenguaje de negocio.

## 🔍 Metodología de Análisis SQL
El diagnóstico se realizó siguiendo un enfoque "Top-Down" (de lo general a lo particular) mediante consultas manuales en MySQL Workbench (Script disponible en: `sql/analisis_exploratorio.sql`):

1.  **Exploración Temporal:** Se agrupó la producción por mes, detectando la caída de rendimiento en Agosto.
2.  **Minería de Observaciones:** Se categorizaron las fallas mecánicas vs. operativas.
3.  **Cruce de Variables:** Se correlacionaron las fallas con los meses (Agosto = Contactores).
4.  **Cuantificación:** Cálculo del diferencial de producción diaria.

## 📊 Key Insights & Resultados 
Tras procesar los registros de 3 meses, se obtuvieron los siguientes hallazgos cuantitativos validados en SQL:

### 1. Diagnóstico de Fallas 
* **Agosto (Mes Crítico):** Sufrió una caída del **14.4%** en producción respecto a Julio (180k vs 154k).
* **Causa Raíz:** La consulta de frecuencia revela que la **"Falla de Contactor"** ocurrió 4 veces exclusivamente en agosto, mientras que junio sufrió por **"Falla de Sensor"**.
> 📂 *Evidencia:* [Ver captura de resultados SQL](evidencias/evidencia_ranking_fallas.png) y [Promedios Mensuales](evidencias/evidencia_promedio_mensual.png)

### 2. Impacto Financiero
Se comparó el rendimiento de días sin incidencias vs. días con reportes de mantenimiento:
* **Producción Objetivo (Sin Fallas):** ~171,900 fajas/día.
* **Producción Real (Con Fallas):** ~129,900 fajas/día.
* **📉 Impacto:** Las fallas mecánicas reducen la capacidad productiva en un **24.4%**.
> 📂 *Evidencia:* [Ver captura de tabla comparativa](evidencias/evidencia_impacto_economico.png)

### 3. Alta Inestabilidad del Proceso
El proceso tiene un **Coeficiente de Variación (CV) del 38%**, muy por encima del estándar industrial aceptable (<20%).
* **Promedio Diario Global:** 163,619 fajas.
* **Desviación Estándar:** ±62,429 fajas.

## 💡 Recomendaciones Estratégicas
Basado en los datos, se recomiendan las siguientes acciones para la gerencia de planta:
1.  **Stock Crítico:** Asegurar disponibilidad de *contactores* antes de agosto y *sensores* antes de junio para reducir el tiempo medio de reparación (MTTR).
2.  **Mantenimiento Preventivo:** Revisar la calibración de sensores  en lugar de esperar la falla, lo que evitaría la pérdida de ~40k unidades por evento.
3.  **Estandarización:** Investigar las causas del pico de eficiencia en Julio (+15% vs promedio) para replicar esas condiciones operativas.

## 🔮 Next Steps & Limitations 
* **Limitación:** La fuente de datos es manual (escrita a mano por operadores), lo que introduce un margen de error humano y sesgo en el reporte de fallas menores.
* **Próximo Paso:** Desarrollar un dashboard en **Power BI** conectado a la base de datos SQL para monitorear la producción en tiempo real y alertar cuando el rendimiento caiga por debajo de 150,000 unidades.

---
**Autor:** Eduardo Joudzbalis
*Data Analyst | Educación Matemática y Lógica | Optimización de Procesos*
[LinkedIn](https://www.linkedin.com/in/eduardo-joudzbalis-330067146/)
