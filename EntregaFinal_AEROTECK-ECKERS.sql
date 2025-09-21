-- ===============================================
-- Archivo: Entregafinal_AEROTECK-ECKERS.sql
-- Pruebas de funciones, SP, triggers y vistas
-- Proyecto Final: AEROTECK - Patricio Eckers
-- ===============================================

USE aeroteck;

-- ======================================================
-- 1) PRUEBAS DE FUNCIONES
-- ======================================================

-- Función: cantidad_reservas
-- Devuelve la cantidad de reservas de un pasajero
SELECT cantidad_reservas(1) AS reservas_pasajero1;
SELECT cantidad_reservas(4) AS reservas_pasajero4;

-- Función: ocupacion_vuelo
-- Devuelve el porcentaje de ocupación de un vuelo
SELECT ocupacion_vuelo(1) AS ocupacion_vuelo1;
SELECT ocupacion_vuelo(2) AS ocupacion_vuelo2;

-- ======================================================
-- 2) PRUEBAS DE STORED PROCEDURES
-- ======================================================

-- SP 1: registrar_reserva
-- Inserta nuevas reservas (estado por defecto PENDIENTE)
CALL registrar_reserva(1, 2, '15A');
CALL registrar_reserva(3, 5, '10B');

-- SP 2: actualizar_estado_vuelo
-- Cambia el estado de un vuelo
CALL actualizar_estado_vuelo(2, 'EN VUELO');
CALL actualizar_estado_vuelo(5, 'CANCELADO');

-- SP 3: listar_reservas_confirmadas
-- Muestra todas las reservas confirmadas de un vuelo
CALL listar_reservas_confirmadas(1);
CALL listar_reservas_confirmadas(2);

-- ======================================================
-- 3) PRUEBAS DE TRIGGERS
-- ======================================================

-- Trigger 1: evitar doble reserva
-- Intentar insertar un asiento ya ocupado (debería dar error si el asiento existe)
INSERT INTO reservas (id_pasajero, id_vuelo, fecha_reserva, asiento, estado)
VALUES (2, 1, CURDATE(), '12A', 'CONFIRMADA');

-- Trigger 2: asignar estado por defecto
-- Insertar sin especificar estado, se asigna PENDIENTE automáticamente
INSERT INTO reservas (id_pasajero, id_vuelo, fecha_reserva, asiento)
VALUES (6, 3, CURDATE(), '2A');

-- Trigger 3: actualizar estado de vuelo
-- Insertar reservas hasta completar el vuelo 4
-- Suponiendo que capacidad del vuelo 4 = 4
INSERT INTO reservas (id_pasajero, id_vuelo, fecha_reserva, asiento)
VALUES (7, 4, CURDATE(), '1A'),
       (8, 4, CURDATE(), '1B'),
       (9, 4, CURDATE(), '1C'),
       (10, 4, CURDATE(), '1D');

-- Verificar que el vuelo 4 cambió automáticamente a COMPLETADO
SELECT id_vuelo, estado FROM vuelos WHERE id_vuelo = 4;

-- ======================================================
-- 4) PRUEBAS DE VISTAS
-- ======================================================

SELECT * FROM vista_pasajeros_confirmados;
SELECT * FROM vista_tripulacion_vuelos;
SELECT * FROM vista_vuelos_reservas;
SELECT * FROM vista_tripulacion_por_rol;
SELECT * FROM vista_pasajeros_frecuentes;

-- ======================================================
-- FIN DE ARCHIVO DE PRUEBAS
-- ===============================================