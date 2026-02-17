/* ============================================================================
ANÁLISIS EXPLORATORIO DE DATOS (EDA) - MÁQUINA LAURENTI
Autor: Eduardo Joudzbalis
Objetivo: Diagnóstico inicial para detectar patrones de falla.
============================================================================
*/

-- 1. PANORAMA GENERAL: ¿Cómo se comportó la producción mes a mes?
-- (Buscamos volumen para ver si hay meses bajos)
SELECT 
    MONTHNAME(fecha) as Mes,
    COUNT(*) as Dias_Trabajados,
    SUM(total_fajas) as Produccion_Total,
    AVG(total_fajas) as Promedio_Diario
FROM produccion_fajas
GROUP BY MONTHNAME(fecha)
ORDER BY FIELD(Mes, 'June', 'July', 'August');
-- HALLAZGO: Agosto tiene el promedio más bajo (154k) vs Julio (180k). 

-- 2. IDENTIFICACIÓN DE PROBLEMAS: ¿Qué tipos de observaciones existen?
SELECT DISTINCT observaciones 
FROM produccion_fajas 
WHERE observaciones <> '' AND observaciones IS NOT NULL;
-- HALLAZGO: Aparecen "Falla sensor", "Falla contactor", "Cambio cuchilla", etc.

-- 3. FRECUENCIA DE FALLAS: ¿Cuáles son las más comunes y en qué mes ocurren?
-- (Esta consulta es clave: Cruza el tipo de falla con el mes)
SELECT 
    observaciones as Tipo_Falla,
    MONTHNAME(fecha) as Mes,
    COUNT(*) as Cantidad_Eventos
FROM produccion_fajas
WHERE observaciones LIKE '%Falla%'  -- Filtramos solo fallas técnicas, no cambios de turno
GROUP BY observaciones, Mes
ORDER BY Cantidad_Eventos DESC;
-- HALLAZGO CRÍTICO: 
-- 1. "Falla Contactor" aparece masivamente en AGOSTO.
-- 2. "Falla Sensor" es el problema principal de JUNIO.

-- 4. IMPACTO CUANTITATIVO: ¿Cuánto perdemos cuando la máquina falla?
-- (Comparamos el promedio de un día limpio vs un día sucio)
SELECT 
    CASE 
        WHEN observaciones = '' OR observaciones IS NULL THEN 'Operación Normal'
        ELSE 'Con Incidencias'
    END as Estado_Maquina,
    ROUND(AVG(total_fajas), 0) as Promedio_Produccion,
    COUNT(*) as Cantidad_Dias
FROM produccion_fajas
GROUP BY Estado_Maquina;
-- HALLAZGO: La producción cae de ~172k a ~130k. Una pérdida del 24%.

-- 5. DETALLE PROFUNDO (Drill-down): Revisión específica de los Contactores
-- (Ya sabiendo que Agosto es el problema, listamos esos casos puntuales)
SELECT * FROM produccion_fajas
WHERE observaciones LIKE '%Contactor%';
-- CONCLUSIÓN: Se requiere revisar stock de contactores antes de Agosto.