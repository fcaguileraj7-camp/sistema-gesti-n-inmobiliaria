USE inmobiliaria;

-- INDICES

CREATE INDEX idx_propiedades_estado
ON propiedades(estado);

CREATE INDEX idx_contratos_tipo_estado
ON contratos(tipo_contrato, estado);

CREATE INDEX idx_pagos_fecha
ON pagos(fecha_pago);

SHOW INDEX FROM propiedades;

SHOW INDEX FROM contratos;

SHOW INDEX FROM pagos;

SHOW VARIABLES LIKE 'event_scheduler';

-- EVENTO

DROP EVENT IF EXISTS ev_reporte_pagos_pendientes;

CREATE EVENT ev_reporte_pagos_pendientes

ON SCHEDULE EVERY 1 MONTH

STARTS CURRENT_TIMESTAMP

ON COMPLETION PRESERVE

ENABLE

COMMENT 'Genera mensualmente el reporte de contratos de arriendo con pagos pendientes'

DO

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

show events;