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
    ano_fabricacion YEAR NOT NULL
);

-- TABLA VUELOS
CREATE TABLE IF NOT EXISTS vuelos (
    id_vuelo INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    origen VARCHAR(30) NOT NULL,
    destino VARCHAR(30) NOT NULL,
    fecha_salida DATE NOT NULL,
    hora_salida TIME NOT NULL,
    id_avion INT NOT NULL,
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

-- TABLA TRIPULANTES
CREATE TABLE IF NOT EXISTS tripulantes (
    id_tripulante INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    dni INT NOT NULL UNIQUE,
    rol ENUM('PILOTO', 'AZAFATA', 'COPILOTO') NOT NULL
);

-- TABLA TRIPULACION_POR_VUELO
CREATE TABLE IF NOT EXISTS tripulacion_por_vuelo (
    id_vuelo INT NOT NULL,
    id_tripulante INT NOT NULL,
    FOREIGN KEY (id_vuelo) REFERENCES vuelos(id_vuelo),
    FOREIGN KEY (id_tripulante) REFERENCES tripulantes(id_tripulante),
    PRIMARY KEY (id_vuelo, id_tripulante)
);

-- INSERT PASAJEROS
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

-- INSERT AVIONES
INSERT INTO aviones (modelo, capacidad, ano_fabricacion) 
		VALUES
		('Boeing 737 800', 150, 2023),
		('Boeing 737 800', 150, 2022),
		('Airbus A320neo', 189, 2025),
		('Embraer E190', 140, 2022);

-- INSERT VUELOS
INSERT INTO vuelos (origen, destino, fecha_salida, hora_salida, id_avion)
	VALUES
	('Buenos Aires', 'Madrid', '2025-08-15', '22:30:00', 1),
	('Madrid', 'Buenos Aires', '2025-08-20', '10:15:00', 1),
	('Buenos Aires', 'Santiago', '2025-08-18', '08:45:00', 2),
	('Santiago', 'Buenos Aires', '2025-08-18', '14:00:00', 2),
	('Buenos Aires', 'Miami', '2025-09-01', '23:50:00', 3),
	('Miami', 'Buenos Aires', '2025-09-10', '07:20:00', 3),
	('Buenos Aires', 'Roma', '2025-09-05', '21:10:00', 4),
	('Roma', 'Buenos Aires', '2025-09-12', '12:00:00', 4);

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
	INSERT INTO tripulantes (nombre, apellido, dni, rol) 
		VALUES
		('Carlos', 'Fernández', 30215478, 'PILOTO'),
		('María', 'Gómez', 33456789, 'AZAFATA'),
		('Javier', 'Martínez', 29874512, 'COPILOTO'),
		('Lucía', 'Pérez', 31547896, 'AZAFATA'),
		('Sofía', 'López', 32654789, 'AZAFATA'),
		('Miguel', 'Torres', 30124587, 'COPILOTO'),
		('Paula', 'Díaz', 33987456, 'AZAFATA'),
		('Hernán', 'Suárez', 29347851, 'PILOTO'),
		('Florencia', 'Méndez', 31254879, 'AZAFATA');

-- INSERT TRIPULACION_POR_VUELO
INSERT INTO tripulacion_por_vuelo (id_vuelo, id_tripulante) 
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
