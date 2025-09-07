-- CREAR BASE DE DATOS
CREATE DATABASE IF NOT EXISTS aeroteck;
USE aeroteck;

-- TABLA PASAJEROS

CREATE TABLE IF NOT EXISTS pasajeros (
    id_pasajero INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni INT NOT NULL UNIQUE,
    email VARCHAR(50) UNIQUE,
    nacionalidad VARCHAR(30) DEFAULT 'ARGENTINA'
);

-- TABLA AVIONES

CREATE TABLE IF NOT EXISTS aviones (
    id_avion INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    modelo VARCHAR(30) NOT NULL,
    capacidad INT NOT NULL,
    matricula VARCHAR(20) UNIQUE NOT NULL
);
-- TABLA ROLES TRIPULACIÓN

CREATE TABLE IF NOT EXISTS roles_tripulacion (
    id_rol INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre_rol VARCHAR(30) UNIQUE NOT NULL
);
-- Insertamos roles básicos

INSERT INTO roles_tripulacion (nombre_rol)
VALUES ('PILOTO'), ('COPILOTO'), ('AZAFATA');

-- TABLA TRIPULANTES

CREATE TABLE IF NOT EXISTS tripulantes (
    id_tripulante INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni INT UNIQUE NOT NULL,
    id_rol INT NOT NULL,
    FOREIGN KEY (id_rol) REFERENCES roles_tripulacion(id_rol)
);
-- TABLA VUELOS

CREATE TABLE IF NOT EXISTS vuelos (
    id_vuelo INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_avion INT NOT NULL,
    origen VARCHAR(50) NOT NULL,
    destino VARCHAR(50) NOT NULL,
    fecha_salida DATE NOT NULL,
    hora_salida TIME NOT NULL,
    fecha_llegada DATE,
    hora_llegada TIME,
    estado ENUM('PROGRAMADO', 'EN VUELO', 'CANCELADO', 'COMPLETADO') DEFAULT 'PROGRAMADO',
    FOREIGN KEY (id_avion) REFERENCES aviones(id_avion)
);

-- TABLA RESERVAS

CREATE TABLE IF NOT EXISTS reservas (
    id_reserva INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_pasajero INT NOT NULL,
    id_vuelo INT NOT NULL,
    fecha_reserva DATE,
    asiento VARCHAR(10) NOT NULL,
    estado ENUM('CANCELADA', 'CONFIRMADA', 'PENDIENTE') DEFAULT 'PENDIENTE',
    FOREIGN KEY (id_pasajero) REFERENCES pasajeros(id_pasajero),
    FOREIGN KEY (id_vuelo) REFERENCES vuelos(id_vuelo),
    UNIQUE (id_vuelo, asiento) -- No se repiten asientos en mismo vuelo
);
-- TABLA ASIGNACIÓN TRIPULACIÓN A VUELOS

CREATE TABLE IF NOT EXISTS vuelo_tripulacion (
    id_asignacion INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_vuelo INT NOT NULL,
    id_tripulante INT NOT NULL,
    FOREIGN KEY (id_vuelo) REFERENCES vuelos(id_vuelo),
    FOREIGN KEY (id_tripulante) REFERENCES tripulantes(id_tripulante)
);

-- INSERTAMOS PASAJEROS
INSERT INTO pasajeros (nombre, apellido, dni, email) 
	VALUES
	('Juan', 'Pérez', 30123456, 'juan.perez@mail.com'),
	('María', 'Gómez', 29567890, 'maria.gomez@mail.com'),
	('Agustina', 'Cruz', 30123457, 'agus@gmail.com'),
	('Patricio', 'Eckers', 38092498, 'patricioeckers@gmail.com'),
	('Isaias', 'Arteaga', 40613581, 'isaiasarteaga@gmail.com'),
	('Martina', 'Aguirre', 50431255, 'martiagui@hotmail.com'),
	('Ariadna', 'Espinoza', 44531235, 'ariespin@yahoo.com.ar'),
	('Gastón', 'Picún', 37541223, 'gaston@yahoo.com.ar'),
	('Adrián', 'Alarcón', 33502652, 'adrialr@gmail.com'),
	('Santiago', 'Barboza', 36526478, 'barbosanti@hotmail.com');


-- INSERTAMOS AVIONES
INSERT INTO aviones (modelo, capacidad, matricula) 
	VALUES
	('Boeing 737 800', 150, 'LV-BAA'),
	('Boeing 737 800', 150, 'LV-BBB'),
	('Airbus A320neo', 189, 'LV-CCC'),
	('Embraer E190', 140, 'LV-DDD');

-- INSERTAMOS LOS VUELOS

INSERT INTO vuelos (origen, destino, fecha_salida, hora_salida, fecha_llegada, hora_llegada, estado, id_avion)
VALUES
('Buenos Aires', 'Madrid', '2025-08-15', '22:30:00', '2025-08-16', '13:45:00', 'COMPLETADO', 1),
('Madrid', 'Buenos Aires', '2025-08-20', '10:15:00', '2025-08-20', '18:30:00', 'PROGRAMADO', 1),
('Buenos Aires', 'Santiago', '2025-08-18', '08:45:00', '2025-08-18', '10:30:00', 'COMPLETADO', 2),
('Santiago', 'Buenos Aires', '2025-08-18', '14:00:00', '2025-08-18', '16:15:00', 'COMPLETADO', 2),
('Buenos Aires', 'Miami', '2025-09-01', '23:50:00', '2025-09-02', '07:45:00', 'PROGRAMADO', 3),
('Miami', 'Buenos Aires', '2025-09-10', '07:20:00', '2025-09-10', '16:20:00', 'PROGRAMADO', 3),
('Buenos Aires', 'Roma', '2025-09-05', '21:10:00', '2025-09-06', '14:10:00', 'PROGRAMADO', 4),
('Roma', 'Buenos Aires', '2025-09-12', '12:00:00', '2025-09-12', '20:30:00', 'PROGRAMADO', 4);

-- INSERT RESERVAS
INSERT INTO reservas (id_pasajero, id_vuelo, fecha_reserva, asiento, estado) 	
	VALUES
	(1, 1, '2025-08-01', '12A', 'CONFIRMADA'),
	(2, 1, '2025-08-02', '12B', 'PENDIENTE'),
	(3, 1, '2025-08-03', '14C', 'CANCELADA'),
	(1, 2, '2025-08-04', '5A', 'CONFIRMADA'),
	(4, 2, '2025-08-05', '5B', 'CONFIRMADA'),
	(5, 3, '2025-08-06', '1A', 'PENDIENTE'),
	(6, 3, '2025-08-07', '1B', 'CONFIRMADA'),
	(7, 4, '2025-08-08', '22A', 'CANCELADA'),
	(8, 4, '2025-08-09', '22B', 'CONFIRMADA'),
	(9, 5, '2025-08-10', '10A', 'CONFIRMADA');
    
    -- INSERT TRIPULANTES
	INSERT INTO tripulantes (nombre, apellido, dni, id_rol) 
VALUES
('Carlos', 'Fernández', 30215478, 1), 
('María', 'Gómez', 33456789, 3),      
('Javier', 'Martínez', 29874512, 2),  
('Lucía', 'Pérez', 31547896, 3),      
('Sofía', 'López', 32654789, 3),      
('Miguel', 'Torres', 30124587, 2),    
('Paula', 'Díaz', 33987456, 3),       
('Hernán', 'Suárez', 29347851, 1),    
('Florencia', 'Méndez', 31254879, 3); 
        
        -- INSERT TRIPULACION_POR_VUELO
INSERT INTO vuelo_tripulacion (id_vuelo, id_tripulante) 
		VALUES
		(1, 1),
		(1, 3),
		(1, 2),
		(1, 4),

		(2, 8),
		(2, 6),
		(2, 5),
		(2, 7),

		(3, 9),
		(3, 3),
		(3, 2),
		(3, 4),

		(4, 1),
		(4, 6),
		(4, 5),
		(4, 9);
