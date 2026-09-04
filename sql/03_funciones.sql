USE inmobiliaria;

-- FUNCION 1
-- Calcular comision de un agente en una venta

DROP FUNCTION IF EXISTS calcular_comision_venta;

DELIMITER $$

CREATE FUNCTION calcular_comision_venta(
    p_contrato INT
)
RETURNS DECIMAL(15,2)
DETERMINISTIC
READS SQL DATA

BEGIN

    DECLARE v_valor DECIMAL(15,2);
    DECLARE v_porcentaje DECIMAL(5,2);
    DECLARE v_tipo VARCHAR(20);

    IF NOT EXISTS (
        SELECT 1
        FROM contratos
        WHERE contrato_id = p_contrato
    ) THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El contrato no existe';

    END IF;

    SELECT
        c.valor,
        a.porcentaje_comision,
        c.tipo_contrato
    INTO
        v_valor,
        v_porcentaje,
        v_tipo
    FROM contratos c
    JOIN agentes a
        ON c.agente_id = a.agente_id
    WHERE c.contrato_id = p_contrato;

    IF v_tipo <> 'Venta' THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El contrato no corresponde a una venta';

    END IF;

    RETURN v_valor * v_porcentaje / 100;

END $$

DELIMITER ;

SELECT calcular_comision_venta(2) comision;

SELECT calcular_comision_venta(1);


-- FUNCION 2
-- Calcular deuda pendiente de un contrato de arriendo

DROP FUNCTION IF EXISTS calcular_deuda_arriendo;

DELIMITER $$

CREATE FUNCTION calcular_deuda_arriendo(
    p_contrato INT
)
RETURNS DECIMAL(15,2)
DETERMINISTIC
READS SQL DATA

BEGIN

    DECLARE v_tipo VARCHAR(20);
    DECLARE v_fecha_inicio DATE;
    DECLARE v_valor DECIMAL(15,2);
    DECLARE v_total_pagado DECIMAL(15,2);
    DECLARE v_meses INT;
    DECLARE v_deuda DECIMAL(15,2);

    IF NOT EXISTS (
        SELECT 1
        FROM contratos
        WHERE contrato_id = p_contrato
    ) THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El contrato no existe';

    END IF;

    SELECT
        tipo_contrato,
        fecha_inicio,
        valor
    INTO
        v_tipo,
        v_fecha_inicio,
        v_valor
    FROM contratos
    WHERE contrato_id = p_contrato;

    IF v_tipo <> 'Arriendo' THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El contrato no corresponde a un arriendo';

    END IF;

    SELECT IFNULL(SUM(valor_pago), 0)
    INTO v_total_pagado
    FROM pagos
    WHERE contrato_id = p_contrato;

    SET v_meses =
        TIMESTAMPDIFF(MONTH, v_fecha_inicio, CURRENT_DATE()) + 1;

    SET v_deuda =
        (v_meses * v_valor) - v_total_pagado;

    RETURN v_deuda;

END $$

DELIMITER ;

SELECT calcular_deuda_arriendo(1) deuda;

SELECT calcular_deuda_arriendo(3) deuda;

SELECT calcular_deuda_arriendo(2);

-- FUNCION 3
-- Obtener total de propiedades disponibles por tipo

DROP FUNCTION IF EXISTS total_propiedades_disponibles;

DELIMITER $$

CREATE FUNCTION total_propiedades_disponibles(
    p_tipo VARCHAR(50)
)
RETURNS INT
DETERMINISTIC
READS SQL DATA

BEGIN

    DECLARE v_total INT;

    IF NOT EXISTS (
        SELECT 1
        FROM tipos_propiedad
        WHERE nombre = p_tipo
    ) THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El tipo de propiedad no existe';

    END IF;

    SELECT COUNT(*)
    INTO v_total
    FROM propiedades p
    JOIN tipos_propiedad tp
        ON p.tipo_propiedad_id = tp.tipo_propiedad_id
    WHERE tp.nombre = p_tipo
      AND p.estado = 'Disponible';

    RETURN v_total;

END $$

DELIMITER ;

SELECT total_propiedades_disponibles('Casa') total;

SELECT total_propiedades_disponibles('Apartamento') total;

SELECT total_propiedades_disponibles('Local comercial') total;

SELECT total_propiedades_disponibles('Bodega');

SHOW FUNCTION STATUS
WHERE Db = 'inmobiliaria';

-- PRUEBAS DE ERROR

SELECT calcular_comision_venta(1);
SELECT calcular_deuda_arriendo(2);
SELECT total_propiedades_disponibles('Bodega');