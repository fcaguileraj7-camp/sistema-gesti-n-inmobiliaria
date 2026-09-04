USE inmobiliaria;

-- ==========================================
-- 1. PRUEBAS DE FUNCIONES
-- ==========================================

-- Comision de una venta
SELECT calcular_comision_venta(2) comision_venta;

-- Deuda pendiente de contratos de arriendo
SELECT calcular_deuda_arriendo(1) deuda_contrato_1;
SELECT calcular_deuda_arriendo(3) deuda_contrato_3;

-- Propiedades disponibles por tipo
SELECT total_propiedades_disponibles('Casa') casas_disponibles;
SELECT total_propiedades_disponibles('Apartamento') apartamentos_disponibles;
SELECT total_propiedades_disponibles('Local comercial') locales_disponibles;


-- ==========================================
-- 2. PRUEBA TRIGGER CAMBIO DE ESTADO
-- ==========================================

SELECT
    propiedad_id,
    direccion,
    estado
FROM propiedades
WHERE propiedad_id = 1;

UPDATE propiedades
SET estado = 'Arrendada'
WHERE propiedad_id = 1;

SELECT *
FROM historial_estado_propiedad
WHERE propiedad_id = 1;


-- ==========================================
-- 3. PRUEBA TRIGGER NUEVO CONTRATO
-- ==========================================

INSERT INTO contratos
(
    propiedad_id,
    cliente_id,
    agente_id,
    tipo_contrato,
    fecha_inicio,
    fecha_fin,
    valor,
    estado
)
VALUES
(
    3,
    5,
    2,
    'Arriendo',
    CURRENT_DATE(),
    '2027-08-31',
    2500000,
    'Activo'
);

SELECT *
FROM auditoria_contratos
ORDER BY auditoria_id DESC;


-- ==========================================
-- 4. PRUEBAS DE INDICES
-- ==========================================

SHOW INDEX FROM propiedades;
SHOW INDEX FROM contratos;
SHOW INDEX FROM pagos;


-- ==========================================
-- 5. PRUEBA DEL EVENTO
-- ==========================================

SHOW EVENTS;

SELECT
    c.contrato_id,
    c.cliente_id,
    c.propiedad_id,
    calcular_deuda_arriendo(c.contrato_id) deuda_pendiente
FROM contratos c
WHERE c.tipo_contrato = 'Arriendo'
AND c.estado = 'Activo'
AND calcular_deuda_arriendo(c.contrato_id) > 0;


-- Insercion manual para validar la logica del evento

INSERT INTO reporte_pagos_pendientes
(
    fecha_generado,
    contrato_id,
    cliente_id,
    propiedad_id,
    deuda_pendiente
)

SELECT
    NOW(),
    c.contrato_id,
    c.cliente_id,
    c.propiedad_id,
    calcular_deuda_arriendo(c.contrato_id)
FROM contratos c
WHERE c.tipo_contrato = 'Arriendo'
AND c.estado = 'Activo'
AND calcular_deuda_arriendo(c.contrato_id) > 0;

SELECT *
FROM reporte_pagos_pendientes;


-- ==========================================
-- 6. PRUEBA DE PRIVILEGIOS
-- ==========================================

SHOW GRANTS
FOR 'admin_inmobiliaria'@'localhost';

SHOW GRANTS
FOR 'agente_inmobiliaria'@'localhost';

SHOW GRANTS
FOR 'contador_inmobiliaria'@'localhost';