USE inmobiliaria;

INSERT INTO tipos_propiedad (nombre) VALUES
('Casa'),
('Apartamento'),
('Local comercial');

INSERT INTO agentes
(nombre, documento, telefono, email, porcentaje_comision)
VALUES
('Laura Gomez', '1001001001', '3001111111', 'laura@inmobiliaria.com', 3.00),
('Carlos Ramirez', '1001001002', '3002222222', 'carlos@inmobiliaria.com', 2.50),
('Ana Torres', '1001001003', '3003333333', 'ana@inmobiliaria.com', 3.50);

INSERT INTO clientes
(nombre, documento, telefono, email)
VALUES
('Juan Perez', '2002002001', '3101111111', 'juan@gmail.com'),
('Maria Lopez', '2002002002', '3102222222', 'maria@gmail.com'),
('Pedro Martinez', '2002002003', '3103333333', 'pedro@gmail.com'),
('Sofia Hernandez', '2002002004', '3104444444', 'sofia@gmail.com'),
('Andres Diaz', '2002002005', '3105555555', 'andres@gmail.com'),
('Camila Rojas', '2002002006', '3106666666', 'camila@gmail.com');

-- PROPIEDADES

INSERT INTO propiedades
(tipo_propiedad_id, direccion, ciudad, area_m2, precio_venta, canon_arriendo, estado)
VALUES
(1, 'Calle 10 # 20-30', 'Bucaramanga', 120.00, 350000000, 1800000, 'Disponible'),
(2, 'Carrera 27 # 45-60', 'Bucaramanga', 75.00, 220000000, 1400000, 'Arrendada'),
(3, 'Calle 35 # 18-22', 'Bucaramanga', 90.00, 300000000, 2500000, 'Disponible'),
(1, 'Carrera 15 # 10-15', 'Floridablanca', 150.00, 420000000, 2200000, 'Vendida'),
(2, 'Calle 50 # 30-40', 'Floridablanca', 80.00, 240000000, 1500000, 'Arrendada'),
(3, 'Carrera 33 # 52-10', 'Bucaramanga', 65.00, 280000000, 2100000, 'Disponible'),
(1, 'Calle 5 # 8-12', 'Giron', 110.00, 310000000, 1700000, 'Disponible'),
(2, 'Carrera 8 # 22-14', 'Piedecuesta', 70.00, 200000000, 1300000, 'Vendida');

-- CONTRATOS

INSERT INTO contratos
(propiedad_id, cliente_id, agente_id, tipo_contrato, fecha_inicio, fecha_fin, valor, estado)
VALUES
(2, 1, 1, 'Arriendo', '2026-01-01', '2026-12-31', 1400000, 'Activo'),
(4, 2, 2, 'Venta', '2026-02-10', NULL, 410000000, 'Finalizado'),
(5, 3, 1, 'Arriendo', '2026-03-01', '2027-02-28', 1500000, 'Activo'),
(8, 4, 3, 'Venta', '2026-04-15', NULL, 195000000, 'Finalizado');

-- PAGOS

INSERT INTO pagos
(contrato_id, fecha_pago, valor_pago)
VALUES
(1, '2026-01-05', 1400000),
(1, '2026-02-05', 1400000),
(1, '2026-03-05', 1400000),
(1, '2026-04-05', 1400000),
(2, '2026-02-10', 410000000),
(3, '2026-03-05', 1500000),
(3, '2026-04-05', 1500000),
(4, '2026-04-15', 195000000);

select * from tipos_propiedad tp;

select * from agentes a;

select * from clientes c;

select * from propiedades p;

select * from contratos c;

select * from pagos p;