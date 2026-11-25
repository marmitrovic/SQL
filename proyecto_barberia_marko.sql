-- ============================================================================
-- PROYECTO INTEGRADOR 1.º DAM - BASES DE DATOS Y ENTORNOS DE DESARROLLO
-- Negocio: Barbería Madrid Centro
-- Autor: Marko Mitrovic
-- ============================================================================

-- 1. CREACIÓN DE LA BASE DE DATOS
DROP DATABASE IF EXISTS barberiaMadridDB;
CREATE DATABASE barberiaMadridDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE barberiaMadridDB;

-- 2. CREACIÓN DE TABLAS Y RELACIONES (5 tablas en camelCase, normalizadas 3FN)

CREATE TABLE cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100),
    fechaRegistro DATE NOT NULL
);

CREATE TABLE barbero (
    idBarbero INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    especialidad VARCHAR(60) NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE servicio (
    idServicio INT AUTO_INCREMENT PRIMARY KEY,
    nombreServicio VARCHAR(80) NOT NULL,
    duracionMinutos INT NOT NULL,
    precio DECIMAL(6,2) NOT NULL
);

CREATE TABLE cita (
    idCita INT AUTO_INCREMENT PRIMARY KEY,
    fechaCita DATE NOT NULL,
    horaCita TIME NOT NULL,
    estado ENUM('Pendiente', 'Completada', 'Cancelada') NOT NULL DEFAULT 'Pendiente',
    idCliente INT NOT NULL,
    idBarbero INT NOT NULL,
    idServicio INT NOT NULL,
    CONSTRAINT fkCitaCliente FOREIGN KEY (idCliente) REFERENCES cliente(idCliente),
    CONSTRAINT fkCitaBarbero FOREIGN KEY (idBarbero) REFERENCES barbero(idBarbero),
    CONSTRAINT fkCitaServicio FOREIGN KEY (idServicio) REFERENCES servicio(idServicio)
);

CREATE TABLE pago (
    idPago INT AUTO_INCREMENT PRIMARY KEY,
    fechaPago DATE NOT NULL,
    metodoPago ENUM('Efectivo', 'Tarjeta', 'Bizum') NOT NULL,
    importeTotal DECIMAL(6,2) NOT NULL,
    idCita INT NOT NULL UNIQUE,
    CONSTRAINT fkPagoCita FOREIGN KEY (idCita) REFERENCES cita(idCita)
);

-- 3. INSERCIÓN DE REGISTROS FICTICIOS (Total: 55 registros)

-- 15 Clientes
INSERT INTO cliente (nombre, apellido, telefono, email, fechaRegistro) VALUES
('Carlos', 'Gómez', '611000101', 'carlos.gomez@email.com', '2026-01-10'),
('Javier', 'Ruiz', '611000102', 'javier.ruiz@email.com', '2026-01-15'),
('Miguel', 'Torres', '611000103', 'miguel.torres@email.com', '2026-02-02'),
('David', 'Navarro', '611000104', 'david.navarro@email.com', '2026-02-14'),
('Alejandro', 'Serrano', '611000105', 'ale.serrano@email.com', '2026-03-01'),
('Daniel', 'Molina', '611000106', 'daniel.molina@email.com', '2026-03-12'),
('Pablo', 'Ortega', '611000107', 'pablo.ortega@email.com', '2026-04-05'),
('Adrián', 'Delgado', '611000108', 'adrian.delgado@email.com', '2026-04-18'),
('Hugo', 'Castro', '611000109', 'hugo.castro@email.com', '2026-05-03'),
('Lucas', 'Ortiz', '611000110', 'lucas.ortiz@email.com', '2026-05-20'),
('Álvaro', 'Rubio', '611000111', 'alvaro.rubio@email.com', '2026-06-11'),
('Diego', 'Marín', '611000112', 'diego.marin@email.com', '2026-07-04'),
('Marcos', 'Sanz', '611000113', 'marcos.sanz@email.com', '2026-08-19'),
('Iván', 'Iglesias', '611000114', 'ivan.iglesias@email.com', '2026-09-07'),
('Rubén', 'Nuñez', '611000115', 'ruben.nunez@email.com', '2026-10-01');

-- 5 Barberos
INSERT INTO barbero (nombre, apellido, especialidad, activo) VALUES
('Antonio', 'Morales', 'Corte clásico y navaja', TRUE),
('Sergio', 'Vega', 'Degradados modernos (Fade)', TRUE),
('Raúl', 'Jiménez', 'Arreglo de barba y ritual', TRUE),
('Fernando', 'Blanco', 'Corte a tijera y color', TRUE),
('Óscar', 'Medina', 'Estilismo general', FALSE);

-- 8 Servicios
INSERT INTO servicio (nombreServicio, duracionMinutos, precio) VALUES
('Corte de pelo clásico', 30, 15.00),
('Corte degradado (Fade)', 40, 18.00),
('Arreglo de barba con toalla caliente', 25, 12.00),
('Pack Corte + Barba', 60, 25.00),
('Afeitado completo a navaja', 30, 14.00),
('Corte infantil', 25, 11.00),
('Tinte y matiz de barba', 35, 16.00),
('Tratamiento capilar hidratante', 20, 10.00);

-- 15 Citas
INSERT INTO cita (fechaCita, horaCita, estado, idCliente, idBarbero, idServicio) VALUES
('2026-11-18', '10:00:00', 'Completada', 1, 1, 1),
('2026-11-18', '10:30:00', 'Completada', 2, 2, 2),
('2026-11-18', '11:00:00', 'Completada', 3, 3, 4),
('2026-11-18', '12:00:00', 'Completada', 4, 1, 3),
('2026-11-19', '10:00:00', 'Completada', 5, 2, 4),
('2026-11-19', '11:30:00', 'Completada', 6, 4, 1),
('2026-11-19', '16:00:00', 'Cancelada', 7, 2, 2),
('2026-11-19', '17:00:00', 'Completada', 8, 3, 5),
('2026-11-20', '10:00:00', 'Completada', 9, 1, 4),
('2026-11-20', '11:00:00', 'Completada', 10, 2, 2),
('2026-11-20', '12:30:00', 'Completada', 11, 3, 3),
('2026-11-20', '17:30:00', 'Completada', 12, 4, 7),
('2026-11-21', '10:00:00', 'Completada', 1, 2, 2),
('2026-11-25', '10:30:00', 'Pendiente', 13, 1, 1),
('2026-11-25', '11:30:00', 'Pendiente', 14, 3, 4);

-- 12 Pagos (correspondientes a las 12 citas completadas)
INSERT INTO pago (fechaPago, metodoPago, importeTotal, idCita) VALUES
('2026-11-18', 'Tarjeta', 15.00, 1),
('2026-11-18', 'Bizum', 18.00, 2),
('2026-11-18', 'Efectivo', 25.00, 3),
('2026-11-18', 'Tarjeta', 12.00, 4),
('2026-11-19', 'Bizum', 25.00, 5),
('2026-11-19', 'Efectivo', 15.00, 6),
('2026-11-19', 'Tarjeta', 14.00, 8),
('2026-11-20', 'Tarjeta', 25.00, 9),
('2026-11-20', 'Bizum', 18.00, 10),
('2026-11-20', 'Efectivo', 12.00, 11),
('2026-11-20', 'Tarjeta', 16.00, 12),
('2026-11-21', 'Bizum', 18.00, 13);


-- 4. CONSULTAS SQL ÚTILES PARA EL NEGOCIO (10 consultas comentadas)

-- Consulta 1: ¿Qué barberos están trabajando actualmente en el salón?
SELECT idBarbero, nombre, apellido, especialidad
FROM barbero
WHERE activo = TRUE
ORDER BY nombre ASC;

-- Consulta 2: ¿Cuál es la lista de servicios ordenados del más barato al más caro?
SELECT nombreServicio, duracionMinutos, precio
FROM servicio
ORDER BY precio ASC;

-- Consulta 3: ¿Qué servicios cuestan 15 euros o más?
SELECT nombreServicio, precio
FROM servicio
WHERE precio >= 15.00
ORDER BY precio DESC;

-- Consulta 4: ¿Qué clientes se registraron a partir del segundo semestre de 2026?
SELECT nombre, apellido, telefono, fechaRegistro
FROM cliente
WHERE fechaRegistro >= '2026-07-01'
ORDER BY fechaRegistro DESC;

-- Consulta 5: ¿Cuántas citas hay en cada estado (Pendiente, Completada, Cancelada)?
SELECT estado, COUNT(*) AS totalCitas
FROM cita
GROUP BY estado;

-- Consulta 6 (JOIN): Agenda completa de citas con el nombre del cliente, el barbero y el servicio.
SELECT c.fechaCita, c.horaCita, c.estado,
       CONCAT(cl.nombre, ' ', cl.apellido) AS cliente,
       b.nombre AS barbero,
       s.nombreServicio AS servicio
FROM cita c
JOIN cliente cl ON c.idCliente = cl.idCliente
JOIN barbero b ON c.idBarbero = b.idBarbero
JOIN servicio s ON c.idServicio = s.idServicio
ORDER BY c.fechaCita ASC, c.horaCita ASC;

-- Consulta 7 (JOIN): ¿Qué citas están pendientes para atender próximamente?
SELECT c.fechaCita, c.horaCita,
       CONCAT(cl.nombre, ' ', cl.apellido) AS cliente,
       cl.telefono,
       b.nombre AS barbero,
       s.nombreServicio
FROM cita c
JOIN cliente cl ON c.idCliente = cl.idCliente
JOIN barbero b ON c.idBarbero = b.idBarbero
JOIN servicio s ON c.idServicio = s.idServicio
WHERE c.estado = 'Pendiente'
ORDER BY c.fechaCita, c.horaCita;

-- Consulta 8 (JOIN): ¿Cuánto dinero ha generado cada barbero en citas completadas?
SELECT b.nombre, b.apellido,
       COUNT(p.idPago) AS citasCobradas,
       SUM(p.importeTotal) AS ingresosTotales
FROM barbero b
JOIN cita c ON b.idBarbero = c.idBarbero
JOIN pago p ON c.idCita = p.idCita
GROUP BY b.idBarbero, b.nombre, b.apellido
ORDER BY ingresosTotales DESC;

-- Consulta 9 (JOIN): ¿Cuáles son los servicios más solicitados por los clientes?
SELECT s.nombreServicio, COUNT(c.idCita) AS vecesSolicitado
FROM servicio s
JOIN cita c ON s.idServicio = c.idServicio
GROUP BY s.idServicio, s.nombreServicio
ORDER BY vecesSolicitado DESC;

-- Consulta 10: ¿Cuánto dinero se ha recaudado según cada método de pago (Tarjeta, Bizum, Efectivo)?
SELECT metodoPago,
       COUNT(*) AS numeroPagos,
       SUM(importeTotal) AS totalRecaudado
FROM pago
GROUP BY metodoPago
ORDER BY totalRecaudado DESC;



-- select * FROM cita ;

-- DELETE FROM cita WHERE idCita = 5;


INSERT INTO cliente (nombre, apellido, telefono, email, fechaRegistro)
VALUES ('marko', 'Silva', '454339213', 'mateo.silva@email.com', '2026-11-25');

-- INSERT INTO cita (fechaCita, horaCita, estado, idCliente, idBarbero, idServicio)
-- VALUES ('2026-11-26', '12:00:00', 'Pendiente', 16, 1, 2);