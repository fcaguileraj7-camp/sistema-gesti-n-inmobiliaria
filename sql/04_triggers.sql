USE inmobiliaria;

-- TRIGGER 1
-- Registrar cambios de estado de una propiedad

DROP TRIGGER IF EXISTS trg_cambio_estado_propiedad;

DELIMITER $$

CREATE TRIGGER trg_cambio_estado_propiedad

AFTER UPDATE
ON propiedades

FOR EACH ROW

BEGIN

    IF OLD.estado <> NEW.estado THEN

        INSERT INTO historial_estado_propiedad
            (propiedad_id, estado_anterior, estado_nuevo)

        VALUES
            (NEW.propiedad_id, OLD.estado, NEW.estado);

    END IF;

END $$

DELIMITER ;

-- TRIGGER 2
-- Registrar la creacion de un nuevo contrato

DROP TRIGGER IF EXISTS trg_nuevo_contrato;

DELIMITER $$

CREATE TRIGGER trg_nuevo_contrato

AFTER INSERT
ON contratos

FOR EACH ROW

BEGIN

    INSERT INTO auditoria_contratos
        (
            contrato_id,
            propiedad_id,
            cliente_id,
            tipo_contrato
        )

    VALUES
        (
            NEW.contrato_id,
            NEW.propiedad_id,
            NEW.cliente_id,
            NEW.tipo_contrato
        );

END $$

DELIMITER ;