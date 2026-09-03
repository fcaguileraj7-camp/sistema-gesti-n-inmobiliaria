drop database if exists inmobiliaria;

create database inmobiliaria;

use inmobiliaria;

create table tipos_propiedad (
	tipo_propiedad_id INT auto_increment primary key,
	nombre VARCHAR(50) not null 
);

CREATE TABLE propiedades (
    propiedad_id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_propiedad_id INT NOT NULL,
    direccion VARCHAR(150) NOT NULL,
    ciudad VARCHAR(60) NOT NULL,
    area_m2 DECIMAL(10,2) NOT NULL,
    precio_venta DECIMAL(15,2),
    canon_arriendo DECIMAL(15,2),
    estado VARCHAR(20) NOT NULL,
    FOREIGN KEY (tipo_propiedad_id)
        REFERENCES tipos_propiedad(tipo_propiedad_id)
);

CREATE TABLE clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    documento VARCHAR(20) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE agentes (
    agente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    documento VARCHAR(20) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    email VARCHAR(100),
    porcentaje_comision DECIMAL(5,2) NOT NULL
);

CREATE TABLE contratos (
    contrato_id INT AUTO_INCREMENT PRIMARY KEY,
    propiedad_id INT NOT NULL,
    cliente_id INT NOT NULL,
    agente_id INT NOT NULL,
    tipo_contrato VARCHAR(20) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    valor DECIMAL(15,2) NOT NULL,
    estado VARCHAR(20) NOT NULL,

    FOREIGN KEY (propiedad_id)
        REFERENCES propiedades(propiedad_id),

    FOREIGN KEY (cliente_id)
        REFERENCES clientes(cliente_id),

    FOREIGN KEY (agente_id)
        REFERENCES agentes(agente_id)
);

CREATE TABLE pagos (
    pago_id INT AUTO_INCREMENT PRIMARY KEY,
    contrato_id INT NOT NULL,
    fecha_pago DATE NOT NULL,
    valor_pago DECIMAL(15,2) NOT NULL,

    FOREIGN KEY (contrato_id)
        REFERENCES contratos(contrato_id)
);

CREATE TABLE historial_estado_propiedad (
    historial_id INT AUTO_INCREMENT PRIMARY KEY,
    propiedad_id INT NOT NULL,
    estado_anterior VARCHAR(20),
    estado_nuevo VARCHAR(20) NOT NULL,
    fecha_cambio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (propiedad_id)
        REFERENCES propiedades(propiedad_id)
);

CREATE TABLE auditoria_contratos (
    auditoria_id INT AUTO_INCREMENT PRIMARY KEY,
    contrato_id INT NOT NULL,
    propiedad_id INT NOT NULL,
    cliente_id INT NOT NULL,
    tipo_contrato VARCHAR(20) NOT NULL,
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE reporte_pagos_pendientes (
    reporte_id INT AUTO_INCREMENT PRIMARY KEY,
    fecha_generado DATETIME NOT NULL,
    contrato_id INT NOT NULL,
    cliente_id INT NOT NULL,
    propiedad_id INT NOT NULL,
    deuda_pendiente DECIMAL(15,2) NOT NULL
);

show TABLES;