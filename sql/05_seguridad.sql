USE inmobiliaria;

-- USUARIO ADMINISTRADOR

DROP USER IF EXISTS 'admin_inmobiliaria'@'localhost';

CREATE USER 'admin_inmobiliaria'@'localhost'
IDENTIFIED BY 'Admin123*';


-- USUARIO AGENTE

DROP USER IF EXISTS 'agente_inmobiliaria'@'localhost';

CREATE USER 'agente_inmobiliaria'@'localhost'
IDENTIFIED BY 'Agente123*';


-- USUARIO CONTADOR

DROP USER IF EXISTS 'contador_inmobiliaria'@'localhost';

CREATE USER 'contador_inmobiliaria'@'localhost'
IDENTIFIED BY 'Contador123*';

-- ADMINISTRADOR - Acceso completo.

GRANT ALL PRIVILEGES
ON inmobiliaria.*
TO 'admin_inmobiliaria'@'localhost';

-- AGENTE INMOBILIARIO

GRANT SELECT
ON inmobiliaria.propiedades
TO 'agente_inmobiliaria'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON inmobiliaria.clientes
TO 'agente_inmobiliaria'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON inmobiliaria.contratos
TO 'agente_inmobiliaria'@'localhost';

GRANT SELECT
ON inmobiliaria.tipos_propiedad
TO 'agente_inmobiliaria'@'localhost';

GRANT SELECT
ON inmobiliaria.agentes
TO 'agente_inmobiliaria'@'localhost';

-- CONTADOR

GRANT SELECT
ON inmobiliaria.clientes
TO 'contador_inmobiliaria'@'localhost';

GRANT SELECT
ON inmobiliaria.propiedades
TO 'contador_inmobiliaria'@'localhost';

GRANT SELECT
ON inmobiliaria.contratos
TO 'contador_inmobiliaria'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON inmobiliaria.pagos
TO 'contador_inmobiliaria'@'localhost';

GRANT SELECT
ON inmobiliaria.reporte_pagos_pendientes
TO 'contador_inmobiliaria'@'localhost';

SHOW GRANTS
FOR 'admin_inmobiliaria'@'localhost';

SHOW GRANTS
FOR 'admin_inmobiliaria'@'localhost';

SHOW GRANTS
FOR 'agente_inmobiliaria'@'localhost';

SHOW GRANTS
FOR 'contador_inmobiliaria'@'localhost';