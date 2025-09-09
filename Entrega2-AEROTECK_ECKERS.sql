-- ======================================================
-- PROYECTO FINAL - ENTREGA 2
-- Alumno: Eckers Patricio
-- Curso: SQL - CODERHOUSE
-- Archivo: Entrega2_Eckers.sql
-- Contenido: Creación de Vistas, Funciones, Stored Procedures,
--            Triggers e Inserción de datos
-- ======================================================

-- Selección de la base de datos

use aeroteck;

-- 1) insercion de datos
-- ======================================================

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
        
        
-- ======================================================
-- 2) CREACIÓN DE VISTAS
-- ======================================================
  
					
	-- Vista 1: Pasajeros con reservas confirmadas
    
CREATE VIEW vista_pasajeros_confirmados AS
	SELECT p.nombre, p.apellido, r.id_vuelo, r.asiento
	FROM pasajeros p
	JOIN reservas r ON p.id_pasajero = r.id_pasajero
	WHERE r.estado = 'CONFIRMADA';

-- SELECT * FROM vista_pasajeros_confirmados;

	-- Vista 2: Vuelos con su tripulación
    
CREATE VIEW vista_tripulacion_vuelos AS
SELECT v.id_vuelo, v.origen, v.destino, t.nombre, t.apellido, r.nombre_rol
FROM vuelos v
JOIN vuelo_tripulacion vt ON v.id_vuelo = vt.id_vuelo
JOIN tripulantes t ON vt.id_tripulante = t.id_tripulante
JOIN roles_tripulacion r ON t.id_rol = r.id_rol;

-- SELECT* FROM vista_tripulacion_vuelos;

	-- vista 3: la cantidad de reservas confirmadas por vuelos

CREATE VIEW vista_vuelos_reservas AS
SELECT 
    v.id_vuelo,
    v.origen,
    v.destino,
    v.fecha_salida,
    COUNT(r.id_reserva) AS reservas_confirmadas
FROM vuelos v
LEFT JOIN reservas r ON v.id_vuelo = r.id_vuelo AND r.estado = 'CONFIRMADA'
GROUP BY v.id_vuelo, v.origen, v.destino, v.fecha_salida;

-- select* FROM vista_vuelos_reservas;

	-- vista 4: tripulacion por vuelo y el rol q cumplen
    
CREATE VIEW vista_tripulacion_por_rol AS
SELECT 
    v.id_vuelo,
    v.origen,
    v.destino,
    r.nombre_rol,
    GROUP_CONCAT(t.nombre, ' ', t.apellido SEPARATOR ', ') AS tripulantes
FROM vuelos v
JOIN vuelo_tripulacion vt ON v.id_vuelo = vt.id_vuelo
JOIN tripulantes t ON vt.id_tripulante = t.id_tripulante
JOIN roles_tripulacion r ON t.id_rol = r.id_rol
GROUP BY v.id_vuelo, r.nombre_rol;

-- select* from vista_tripulacion_por_rol;

	-- vista 5: pasajeros con varias reservas
    
CREATE VIEW vista_pasajeros_frecuentes AS
SELECT 
    p.id_pasajero,
    p.nombre,
    p.apellido,
    COUNT(r.id_reserva) AS cantidad_reservas,
    GROUP_CONCAT(CONCAT(v.origen, ' → ', v.destino, ' (', v.fecha_salida, ')') SEPARATOR '; ') AS vuelos
FROM pasajeros p
JOIN reservas r ON p.id_pasajero = r.id_pasajero
JOIN vuelos v ON r.id_vuelo = v.id_vuelo
GROUP BY p.id_pasajero, p.nombre, p.apellido
HAVING cantidad_reservas > 1;

-- SELECT * FROM vista_pasajeros_frecuentes;

-- ======================================================
-- 3) CREACIÓN DE FUNCIONES
-- ======================================================


	--  FUNCION 1: Cantidad de reservas de un pasajero

DELIMITER //
CREATE FUNCTION cantidad_reservas(idPas INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total 
    FROM reservas 
    WHERE id_pasajero = idPas;
    RETURN total;
END //
DELIMITER ;

-- SELECT cantidad_reservas(1) AS total_reservas;

	-- FUNCION 2: Calcular ocupación de un vuelo en porcentaje.
    
DELIMITER //
CREATE FUNCTION ocupacion_vuelo(idVuelo INT) RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE total_asientos INT;
    DECLARE reservados INT;
    SELECT a.capacidad INTO total_asientos
    FROM aviones a
    JOIN vuelos v ON a.id_avion = v.id_avion
    WHERE v.id_vuelo = idVuelo;

    SELECT COUNT(*) INTO reservados 
    FROM reservas r 
    WHERE r.id_vuelo = idVuelo AND r.estado = 'CONFIRMADA';

    RETURN (reservados / total_asientos) * 100;
END //
DELIMITER ;

-- SELECT ocupacion_vuelo(2) AS porcentaje_ocupacion;

-- ======================================================
-- 4) CREACIÓN DE STORED PROCEDURES
-- ======================================================

	-- stored procedures 1: registra una nueva reserva
    
DELIMITER //
CREATE PROCEDURE registrar_reserva (
    IN p_id_pasajero INT,
    IN p_id_vuelo INT,
    IN p_asiento VARCHAR(10)
)
BEGIN
    INSERT INTO reservas (id_pasajero, id_vuelo, fecha_reserva, asiento, estado)
    VALUES (p_id_pasajero, p_id_vuelo, CURDATE(), p_asiento, 'PENDIENTE');
END //
DELIMITER ;

	-- stored procedures 2: actualiza el estado del vuelo
    
DELIMITER //
CREATE PROCEDURE actualizar_estado_vuelo (
    IN p_id_vuelo INT,
    IN p_estado VARCHAR(20)
)
BEGIN
    UPDATE vuelos
    SET estado = p_estado
    WHERE id_vuelo = p_id_vuelo;
END //
DELIMITER ;

	-- stored procedures 3: Listar reservas confirmadas por vuelo
    

DELIMITER //
CREATE PROCEDURE listar_reservas_confirmadas (
    IN p_id_vuelo INT
)
BEGIN
    SELECT r.id_reserva, p.nombre, p.apellido, r.asiento
    FROM reservas r
    JOIN pasajeros p ON r.id_pasajero = p.id_pasajero
    WHERE r.id_vuelo = p_id_vuelo AND r.estado = 'CONFIRMADA';
END //
DELIMITER ;

-- ======================================================
-- 5) CREACIÓN DE TRIGGERS
-- ======================================================

	-- trigger 1 :evitar doble reserva
    
DELIMITER //
CREATE TRIGGER before_insert_reserva
BEFORE INSERT ON reservas
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM reservas
        WHERE id_vuelo = NEW.id_vuelo
        AND asiento = NEW.asiento
        AND estado <> 'CANCELADA'
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El asiento ya está reservado en este vuelo';
    END IF;
END //
DELIMITER ;

	-- trigger 2: asignar estado por defecto
    

DELIMITER //
CREATE TRIGGER before_insert_default_estado
BEFORE INSERT ON reservas
FOR EACH ROW
BEGIN
    IF NEW.estado IS NULL THEN
        SET NEW.estado = 'PENDIENTE';
    END IF;
END //
DELIMITER ;

	-- trigger 3: actualizar el estado de vuelo

DELIMITER //
CREATE TRIGGER after_insert_reserva
AFTER INSERT ON reservas
FOR EACH ROW
BEGIN
    DECLARE total_asientos INT;
    DECLARE reservados INT;

    SELECT a.capacidad INTO total_asientos
    FROM vuelos v
    JOIN aviones a ON v.id_avion = a.id_avion
    WHERE v.id_vuelo = NEW.id_vuelo;

    SELECT COUNT(*) INTO reservados
    FROM reservas r
    WHERE r.id_vuelo = NEW.id_vuelo AND r.estado = 'CONFIRMADA';

    IF reservados = total_asientos THEN
        UPDATE vuelos
        SET estado = 'COMPLETADO'
        WHERE id_vuelo = NEW.id_vuelo;
    END IF;
END //
DELIMITER ;


