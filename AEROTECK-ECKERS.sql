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

