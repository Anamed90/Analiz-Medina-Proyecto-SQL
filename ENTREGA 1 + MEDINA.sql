CREATE DATABASE IF NOT EXISTS Autolavado;

USE Autolavado;

CREATE TABLE Cliente (
ID_CLIENTE INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
NOMBRE_CLIENTE VARCHAR(50) NOT NULL,
APELLIDO_CLIENTE VARCHAR(50) NOT NULL,
DIRECCION_CLIENTE VARCHAR(50),
TELEFONO_CLIENTE INT(12) NOT NULL UNIQUE
);

CREATE TABLE Tipo_Auto(
ID_TIPO INT NOT NULL UNIQUE,
DESCRIPCION_TIPO VARCHAR(20) NOT NULL
);

CREATE TABLE Auto(
ID_AUTO INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
PLACA_AUTO VARCHAR(6) NOT NULL UNIQUE,
ID_CLIENTE INT NOT NULL,
ID_TIPO INT NOT NULL,
FOREIGN KEY (ID_CLIENTE)
   REFERENCES Cliente(ID_CLIENTE)
   ON DELETE CASCADE
   ON UPDATE CASCADE,
FOREIGN KEY (ID_TIPO)
   REFERENCES Tipo_Auto(ID_TIPO)
   ON DELETE CASCADE
   ON UPDATE CASCADE
);

CREATE TABLE Empleado(
ID_EMPLEADO INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
NOMBRE_EMPLEADO VARCHAR(50) NOT NULL,
APELLIDO_EMPLEADO VARCHAR(50) NOT NULL,
FUNCION_EMPLEADO VARCHAR(50) NOT NULL,
SUELDO_EMPLEADO DECIMAL(5,2) NOT NULL
);

CREATE TABLE Horario(
  ID_HORARIO INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
  ID_EMPLEADO INT NOT NULL,
  HORA_ENTRADA TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  HORA_SALIDA TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(ID_EMPLEADO)
    REFERENCES Empleado(ID_EMPLEADO)
    ON DELETE CASCADE 
    ON UPDATE CASCADE
);

CREATE TABLE Proveedor(
  ID_PROVEEDOR INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
  NOMBRE_PROVEEDOR VARCHAR(50) NOT NULL UNIQUE,
  DIRECCION_PROVEEDOR VARCHAR(50) NOT NULL,
  TELEFONO_PROVEEDOR INT(12) NOT NULL UNIQUE
  );

CREATE TABLE Producto(
ID_PRODUCTO INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
ID_PROVEEDOR INT NOT NULL,
NOMBRE_PRODUCTO VARCHAR(50) NOT NULL,
CANTIDAD_PRODUCTO INT NOT NULL,
PRECIO_PRODUCTO DECIMAL(5,2) NOT NULL,
FOREIGN KEY(ID_PRODUCTO)
  REFERENCES Producto(ID_PRODUCTO)
  ON DELETE CASCADE
  ON UPDATE CASCADE
  );

CREATE TABLE Servicio(
ID_SERVICIO INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
ID_TIPO INT NOT NULL,
ID_PRODUCTO INT NOT NULL,
DESCRIPCION_SERVICIO VARCHAR(50),
COSTO_SERVICIO DECIMAL(4,2) NOT NULL,
PRECIO_TOTAL DECIMAL(4,2) NOT NULL,
FOREIGN KEY(ID_TIPO)
  REFERENCES Tipo_Auto(ID_TIPO)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
FOREIGN KEY(ID_PRODUCTO)
  REFERENCES Producto(ID_PRODUCTO)
  ON DELETE CASCADE 
  ON UPDATE CASCADE
);

CREATE TABLE Venta(
ID_VENTA INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
ID_AUTO INT NOT NULL,
ID_SERVICIO INT NOT NULL,
ID_EMPLEADO INT NOT NULL,
FOREIGN KEY(ID_AUTO)
  REFERENCES Auto(ID_AUTO)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

USE autolavado;

INSERT INTO Cliente(ID_CLIENTE, NOMBRE_CLIENTE, APELLIDO_CLIENTE, DIRECCION_CLIENTE, TELEFONO_CLIENTE)
VALUES
(1,'Jose', 'Carrero', 'Cuareim 1506,apto 504', '099501988'),
(2,'Maira', 'Rivero', 'Bvlar. Artigas 3968', '093357679'),
(3,'Samuel', 'Medina', 'Cuareim 1506,apto 504', '096767808'),
(4,'Analiz', 'Medina', 'La Paz 3024, apto 001', '098398048')
;

INSERT INTO Tipo_Auto(ID_TIPO, DESCRIPCION_TIPO)
VALUES
(1, 'Monovolumen'),
(2, 'HatchBack'),
(3, 'Sedan'),
(4, 'Familiar'),
(5, 'SUV'),
(6,'Pickup')
;

INSERT INTO Auto(ID_AUTO, PLACA_AUTO, ID_CLIENTE, ID_TIPO)
VALUES
(1, 'ARJ398', 1, 1),
(2, 'AAU386', 2, 6),
(3, 'WAA54Z', 3, 4),
(4, 'SAA69P', 4, 2)
;

INSERT INTO Empleado(ID_EMPLEADO, NOMBRE_EMPLEADO, APELLIDO_EMPLEADO, FUNCION_EMPLEADO, SUELDO_EMPLEADO)
VALUES
(1, 'Jose', 'Dirinott', 'Lavadero', '145.35'),
(2, 'Ruben', 'Briceno', 'Lavadero', '145.35'),
(3, 'Marcos', 'Gutierrez', 'Administrador', '340.75'),
(4, 'Luisa', 'Salas', 'Encargada', '405.75')
;

INSERT INTO Horario(ID_HORARIO, ID_EMPLEADO, HORA_ENTRADA, HORA_SALIDA)
VALUES
(1, 1, CURRENT_TIME(),DATE_SUB(now(),INTERVAL 8 hour)),
(2, 2, CURRENT_TIME(),DATE_SUB(now(),INTERVAL 8 hour)),
(3, 3, CURRENT_TIME(),DATE_SUB(now(),INTERVAL 8 hour)),
(4, 4, CURRENT_TIME(),DATE_SUB(now(),INTERVAL 8 hour))
;

INSERT INTO Proveedor(ID_PROVEEDOR, NOMBRE_PROVEEDOR, DIRECCION_PROVEEDOR, TELEFONO_PROVEEDOR)
VALUES
(1, 'Quimicos Guacara', 'Ruta 1 km 63', '29093048'),
(2, ' Argimax', 'Av Italia 2145', '29683400'),
(3, 'Aspiradorex', '8 de Octubre 1221', '29903455'),
(4, 'Climatonic', 'Av Uruguay 1230', '29907766')
;

INSERT INTO Producto(ID_PRODUCTO, ID_PROVEEDOR, NOMBRE_PRODUCTO, CANTIDAD_PRODUCTO, PRECIO_PRODUCTO)
VALUES
(1, 1, 'Limpiador para cuero', '20', '2.50'),
(2, 1, 'Quitamanchas', '42', '7.50'),
(3, 2, 'Baldes', '39', '1.25'),
(4, 2, 'Trapeador', '100', '0.55'),
(5, 3, 'Aspiradora de mano', '2', '35.79'),
(6, 3, 'Aspiradora industrial', '1', '123.89'),
(7, 4, 'Ambientador para guindar', '100','0.35'),
(8, 4, 'Ambientador para aires', '80', '1.20')
;

INSERT INTO Servicio(ID_SERVICIO, ID_TIPO, ID_PRODUCTO, DESCRIPCION_SERVICIO, COSTO_SERVICIO, PRECIO_TOTAL)
VALUES
(1, 1, 1, 'Limpieza de asientos y tablero', '1.50', '3.00'),
(2, 1, 2, 'Quitamanchas en asientos de tela', '3.00', '6.00'),
(3, 1, 3, 'Lavado externo de auto', '3.45', '6.70'),
(4, 1, 4, 'Secado externo de auto', '3.00', '6.00'),
(5, 1, 5, 'Aspirado de asientos de tela', '1.45', '2.90'),
(6, 1, 6, 'Aspirado Auto completo', '4.00', '8.00'),
(7, 1, 7, 'Ambientador económico', '0.35', '0.70'),
(8, 1, 8, 'Ambientador premium', '1.20', '2.40'),
(9, 2, 1, 'Limpieza de asientos y tablero', '1.80', '3.60'),
(10, 2, 2, 'Quitamanchas en asientos de tela', '3.60', '7.20'),
(11, 2, 3, 'Lavado externo de auto', '3.80', '7.60'),
(12, 2, 4, 'Secado externo de auto', '4.00', '8.00'),
(13, 2, 5, 'Aspirado de asientos de tela', '1.80', '3.60'),
(14, 2, 6, 'Aspirado Auto completo', '4.50', '9.00'),
(15, 2, 7, 'Ambientador económico', '0.35', '0.70'),
(16, 2, 8, 'Ambientador premium', '1.20', '2.40'),
(17, 3, 1, 'Limpieza de asientos y tablero', '2.10', '4.20'),
(18, 3, 2, 'Quitamanchas en asientos de tela', '4.00', '8.00'),
(19, 3, 3, 'Lavado externo de auto', '4.20', '8.40'),
(20, 3, 4, 'Secado externo de auto', '4.50', '9.00'),
(21, 3, 5, 'Aspirado de asientos de tela', '2.20', '4.40'),
(22, 3, 6, 'Aspirado Auto completo', '5.10', '10.20'),
(23, 3, 7, 'Ambientador económico', '0.35', '0.70'),
(24, 3, 8, 'Ambientador premium', '1.20', '2.40'),
(25, 4, 1, 'Limpieza de asientos y tablero', '3.50', '7.00'),
(26, 4, 2, 'Quitamanchas en asientos de tela', '5.10', '10.20'),
(27, 4, 3, 'Lavado externo de auto', '5.30', '10.60'),
(28, 4, 4, 'Secado externo de auto', '5.30', '10.60'),
(29, 4, 5, 'Aspirado de asientos de tela', '3.90', '7.80'),
(30, 4, 6, 'Aspirado Auto completo', '7.20', '14.40'),
(31, 4, 7, 'Ambientador económico', '0.35', '0.70'),
(32, 4, 8, 'Ambientador premium', '1.20', '2.40'),
(33, 5, 1, 'Limpieza de asientos y tablero', '4.50', '9.00'),
(34, 5, 2, 'Quitamanchas en asientos de tela', '6.10', '12.20'),
(35, 5, 3, 'Lavado externo de auto', '6.30', '12.60'),
(36, 5, 4, 'Secado externo de auto', '6.30', '12.60'),
(37, 5, 5, 'Aspirado de asientos de tela', '4.90', '9.80'),
(38, 5, 6, 'Aspirado Auto completo', '8.20', '16.40'),
(39, 5, 7, 'Ambientador económico', '0.35', '0.70'),
(40, 5, 8, 'Ambientador premium', '1.20', '2.40'),
(41, 6, 1, 'Limpieza de asientos y tablero', '6.30', '12.60'),
(42, 6, 2, 'Quitamanchas en asientos de tela', '8.40', '16.80'),
(43, 6, 3, 'Lavado externo de auto', '10.20', '20.40'),
(44, 6, 4, 'Secado externo de auto', '10.20', '20.40'),
(45, 6, 5, 'Aspirado de asientos de tela', '6.40', '12.80'),
(46, 6, 6, 'Aspirado Auto completo', '9.45', '18.90'),
(47, 6, 7, 'Ambientador económico', '0.35', '0.70'),
(48, 6, 8, 'Ambientador premium', '1.20', '2.40')
;

INSERT INTO Venta(ID_VENTA, ID_AUTO, ID_SERVICIO, ID_EMPLEADO)
VALUES
(1, 1, 1, 2),
(2, 1, 3, 2),
(3, 1, 4, 2),
(4, 1, 7, 2),
(5, 2, 43, 1),
(6, 2, 44, 1),
(7, 2, 48, 1),
(8, 3, 27, 2),
(9, 3, 28, 2),
(10, 3, 30, 2),
(11, 4, 11, 2),
(12, 4, 12, 2),
(13, 4, 15, 2)
;

CREATE VIEW AUTO_CLIENTE AS
    SELECT 
        A1.NOMBRE_CLIENTE cliente, B1.PLACA_AUTO auto
    FROM
        cliente A1,
        auto B1
    WHERE
        A1.ID_CLIENTE = B1.ID_CLIENTE
    GROUP BY A1.NOMBRE_CLIENTE;

SELECT * FROM AUTO_CLIENTE

CREATE VIEW SERVICIO_TIPO_UNO AS
    SELECT 
        DESCRIPCION_SERVICIO, PRECIO_TOTAL
    FROM
        servicio
    WHERE
        ID_TIPO = 1;

SELECT * FROM SERVICIO_TIPO_UNO

CREATE VIEW SERVICIOS_PREMIUM AS
    SELECT 
        ID_SERVICIO, DESCRIPCION_SERVICIO, PRECIO_TOTAL
    FROM
        servicio
    WHERE
        PRECIO_TOTAL >= 10;

SELECT * FROM SERVICIOS_PREMIUM

CREATE VIEW PROVEEDOR_ARGIMAX AS
    SELECT 
        producto.ID_PROVEEDOR,
        producto.NOMBRE_PRODUCTO,
        producto.CANTIDAD_PRODUCTO,
        producto.PRECIO_PRODUCTO
    FROM
        producto
            INNER JOIN
        proveedor ON producto.ID_PROVEEDOR = proveedor.ID_PROVEEDOR
    WHERE
        proveedor.ID_PROVEEDOR = 2;

SELECT * FROM PROVEEDOR_ARGIMAX

CREATE VIEW HORARIO_RUBEN AS
    SELECT 
       horario.ID_EMPLEADO, horario.HORA_ENTRADA, horario.HORA_SALIDA
    FROM
        horario
            INNER JOIN
        empleado ON horario.ID_EMPLEADO = empleado.ID_EMPLEADO
    WHERE
        empleado.ID_EMPLEADO = 2;

SELECT * FROM HORARIO_RUBEN

CREATE DEFINER=`root`@`localhost` FUNCTION `COMISION_SERVICIOS`(COSTO_SERVICIO float, PRECIO_TOTAL float) RETURNS decimal(9,2)
    NO SQL
BEGIN
    DECLARE comision DECIMAL(9,2);
    SET comision = PRECIO_TOTAL - COSTO_SERVICIO;
    RETURN comision;
END

SELECT * , COMISION_SERVICIOS 
(COSTO_SERVICIO, PRECIO_TOTAL) 
FROM servicio
AS total_comision;

CREATE DEFINER=`root`@`localhost` FUNCTION `INVERSION_TOTAL`(CANTIDAD_PRODUCTO FLOAT,PRECIO_PRODUCTO FLOAT ) RETURNS decimal(9,2)
    NO SQL
BEGIN
DECLARE inversion DECIMAL(9,2);
SET inversion = CANTIDAD_PRODUCTO * PRECIO_PRODUCTO;
RETURN inversion;
END

SELECT * , INVERSION_TOTAL 
(CANTIDAD_PRODUCTO, PRECIO_PRODUCTO) 
FROM producto
AS total_inversion;

CREATE DEFINER=`root`@`localhost` PROCEDURE `ORDENAMIENTO_PRECIO_TOTAL_SERVICIO`()
BEGIN
SELECT * FROM servicio
ORDER BY precio_total DESC;
END

CALL ORDENAMIENTO_PRECIO_TOTAL_SERVICIO

CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERT_AUTO`(PLACA_NUEVA VARCHAR(6),ID_CLIENTE INT, ID_TIPO INT)
BEGIN
    DECLARE existe_placa INT;
    DECLARE ID_AUTO INT;
    SET existe_placa = (SELECT COUNT(*) FROM auto WHERE PLACA_AUTO = PLACA_NUEVA);
    IF existe_placa = 0 THEN
    INSERT INTO auto(PLACA_AUTO,ID_CLIENTE, ID_TIPO) VALUES(PLACA_NUEVA, ID_CLIENTE, ID_TIPO);
    SET ID_AUTO = LAST_INSERT_ID();
    ELSE
    SET ID_AUTO= 0;
    END IF;
    SELECT ID_AUTO;
END

CALL INSERT_AUTO('ARJ400',4, 2);

CREATE TABLE nuevos_clientes (
id_cliente INT PRIMARY KEY,
NOMBRE_CLIENTE VARCHAR (100),
APELLIDO_CLIENTE VARCHAR (100),
DIRECCION_CLIENTE VARCHAR (200),
TELEFONO_CLIENTE INT
);

//creacion triggers 

CREATE TABLE nuevos_clientes (
id_cliente INT PRIMARY KEY,
NOMBRE_CLIENTE VARCHAR (100),
APELLIDO_CLIENTE VARCHAR (100),
DIRECCION_CLIENTE VARCHAR (200),
TELEFONO_CLIENTE INT
);

#agregar nuevo cliente en la tabla 'nuevos_clientes' y actualizacion en la tabla 'cliente'

CREATE TRIGGER `agregar_nuevo_cliente`
AFTER INSERT ON `cliente`
FOR EACH ROW 
INSERT INTO `nuevos_clientes`(id_cliente, NOMBRE_CLIENTE, APELLIDO_CLIENTE, DIRECCION_CLIENTE, TELEFONO_CLIENTE)
VALUES (NEW.id_cliente,NEW.NOMBRE_CLIENTE, NEW.APELLIDO_CLIENTE, NEW.DIRECCION_CLIENTE, NEW.TELEFONO_CLIENTE);

INSERT into cliente (id_cliente, NOMBRE_CLIENTE, APELLIDO_CLIENTE, DIRECCION_CLIENTE, TELEFONO_CLIENTE)
VALUES 
(5, 'Daniela', 'Pereira', 'Gaboto 3492', 098766542),
(6, 'Yessika', 'Pereira', 'Gaboto 3492', 093708990),
(7, 'Orlando', 'Urdaneta', 'General Paz 1420', 097203345);

SELECT * FROM nuevos_clientes;

#actualizacion de la direccion del cliente en la tabla de 'cliente' con mensaje definido en el trigger
DELIMITER $$
CREATE TRIGGER `actualizar_direccion_cliente`
BEFORE UPDATE ON `cliente`
FOR EACH ROW
BEGIN
 IF NEW.DIRECCION_CLIENTE <> OLD.DIRECCION_CLIENTE
 THEN
 SET NEW.DIRECCION_CLIENTE = 'Valor introducido desde el Trigger';
 ELSE
 SET NEW.DIRECCION_CLIENTE= DIRECCION_CLIENTE;
 END IF;
END$$

UPDATE cliente SET DIRECCION_CLIENTE = 'Paraguay 1530' WHERE id_cliente=5;
UPDATE cliente SET DIRECCION_CLIENTE = 'Paraguay 1530' WHERE id_cliente=6;

SELECT * FROM cliente;

#actualizacion de precios totales de los servicios, y del costo del servicio.
DELIMITER $$
CREATE TRIGGER `actualizar_precio_total_servicios`
BEFORE UPDATE ON `servicio`
FOR EACH ROW
BEGIN
  IF NEW.PRECIO_TOTAL <> OLD.PRECIO_TOTAL
    THEN
      SET NEW.PRECIO_TOTAL = NEW.COSTO_SERVICIO * 2;
  END IF ;
END$$

UPDATE servicio SET PRECIO_TOTAL = 8.00 WHERE id_servicio=2;
UPDATE servicio SET PRECIO_TOTAL = 8.00 WHERE id_servicio=4;
UPDATE servicio SET PRECIO_TOTAL = 6.00 WHERE id_servicio=1;
UPDATE servicio SET PRECIO_TOTAL = 6.00 WHERE id_servicio=5;
UPDATE servicio SET PRECIO_TOTAL = 6.00 WHERE id_servicio=8;

SELECT * FROM servicio;

CREATE TABLE LOG_servicios (
ACCION VARCHAR(200),
DESCRIPCION VARCHAR (200),
FECHA DATE
);

#Registro de LOG para la tabla de Servicios
CREATE TRIGGER `registro_LOG`
AFTER INSERT ON `servicio`
FOR EACH ROW 
INSERT INTO `LOG_servicios`(ACCION, DESCRIPCION, FECHA)
VALUES ('Insert',NEW.DESCRIPCION_SERVICIO, NOW());

INSERT into servicio (ID_SERVICIO, ID_TIPO, ID_PRODUCTO, DESCRIPCION_SERVICIO, COSTO_SERVICIO, PRECIO_TOTAL)
VALUES 
(52, 1, 4, 'Secado tapiceria', 3.00, 6.00),
(53, 2, 5, 'Aspirado asientos traseros', 4.50, 9.00),
(54, 3, 6, 'Lavado de neumaticos', 15.00, 30.00);

SELECT * FROM LOG_servicios;
DROP TRIGGER `registro_LOG`;
SELECT * FROM servicio;

USE MYSQL;

#creacion de usuario 'normaluser' 
CREATE USER 'normaluser@localhost' IDENTIFIED BY 'normaluser123.';
SELECT * FROM mysql.user WHERE user LIKE 'normaluser'; 

#asignacion de permiso de lectura para 'normaluser'
GRANT SELECT ON *.* TO 'normaluser@localhost';
SHOW GRANTS FOR 'normaluser@localhost';

#creacion de usuario 'adminuser' 
CREATE USER 'adminuser@localhost' IDENTIFIED BY 'adminuser123.';
SELECT * FROM mysql.user WHERE user LIKE 'adminuser'; 

#asignacion de permiso de lectura para 'adminuser'
GRANT SELECT, INSERT, UPDATE ON *.* TO 'adminuser@localhost';
SHOW GRANTS FOR 'adminuser@localhost';
