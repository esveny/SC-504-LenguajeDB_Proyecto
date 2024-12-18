set SERVEROUTPUT ON;
SET VERIFY OFF;
CREATE TABLE Tipo_Usuario (
    ID_TipoUsuario NUMBER PRIMARY KEY,
    TipoUsuario VARCHAR2(255),
    Descripcion VARCHAR2(255)
);

CREATE TABLE Producto (
    ID_Producto NUMBER PRIMARY KEY,
    Nombre_Producto VARCHAR2(255),
    Tipo_Producto VARCHAR2(255),
    Numero_Lote NUMBER
);

CREATE TABLE Usuario (
    ID_Usuario NUMBER PRIMARY KEY,
    Nombre VARCHAR2(255),
    Apellido1 VARCHAR2(255),
    Apellido2 VARCHAR2(255),
    CorreoElectronico VARCHAR2(255),
    Telefono VARCHAR2(255),
    TipoUsuario NUMBER,
    FOREIGN KEY (TipoUsuario) REFERENCES Tipo_Usuario(ID_TipoUsuario)
);

CREATE TABLE Orden (
    ID_Orden NUMBER PRIMARY KEY,
    Fecha_Orden DATE,
    Estado_Orden VARCHAR2(150),
    ID_Producto NUMBER,
    ID_TipoUsuario NUMBER,
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto),
    FOREIGN KEY (ID_TipoUsuario) REFERENCES Tipo_Usuario(ID_TipoUsuario)
);

CREATE TABLE Factura (
    ID_Factura NUMBER PRIMARY KEY,
    Monto NUMBER(10,2),
    Fecha_factura DATE,
    ID_Orden NUMBER,
    FOREIGN KEY (ID_Orden) REFERENCES Orden(ID_Orden)
);

ALTER TABLE Factura DROP COLUMN Fecha_factura;


CREATE TABLE Detalle_Factura (
    ID_detalle_factura NUMBER PRIMARY KEY,
    Descripcion_factura VARCHAR2(255),
    ID_usuario NUMBER,
    ID_orden NUMBER,
    ID_Producto NUMBER,
    FOREIGN KEY (ID_usuario) REFERENCES Usuario(ID_Usuario),
    FOREIGN KEY (ID_orden) REFERENCES Orden(ID_Orden),
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto)
);

ALTER TABLE Usuario ADD (
    ID_Factura NUMBER,
    FOREIGN KEY (ID_Factura) REFERENCES Factura(ID_Factura)
);


CREATE SEQUENCE TipoUsuario_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Producto_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Usuario_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Orden_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Factura_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE DetalleFactura_SEQ START WITH 1 INCREMENT BY 1;

INSERT INTO Tipo_Usuario (ID_TipoUsuario, TipoUsuario, Descripcion)
VALUES (TipoUsuario_SEQ.NEXTVAL, 'Administrador', 'Gestión completa del sistema');

INSERT INTO Tipo_Usuario (ID_TipoUsuario, TipoUsuario, Descripcion)
VALUES (TipoUsuario_SEQ.NEXTVAL, 'Cliente', 'Realiza pedidos y consulta historial de compras');

INSERT INTO Tipo_Usuario (ID_TipoUsuario, TipoUsuario, Descripcion)
VALUES (TipoUsuario_SEQ.NEXTVAL, 'Vendedor', 'Gestión de pedidos y atención al cliente');



INSERT INTO Usuario (ID_Usuario, Nombre, Apellido1, Apellido2, CorreoElectronico, Telefono, TipoUsuario) VALUES 
(Usuario_SEQ.NEXTVAL, 'Carlos', 'Méndez', 'Salazar', 'carlos.mendez@example.com', '88889999', 2);

INSERT INTO Usuario (ID_Usuario, Nombre, Apellido1, Apellido2, CorreoElectronico, Telefono, TipoUsuario) VALUES 
(Usuario_SEQ.NEXTVAL, 'Ana', 'Soto', 'Jiménez', 'ana.soto@example.com', '87778888', 2);

INSERT INTO Usuario (ID_Usuario, Nombre, Apellido1, Apellido2, CorreoElectronico, Telefono, TipoUsuario) VALUES 
(Usuario_SEQ.NEXTVAL, 'Luis', 'Rojas', 'Hernández', 'luis.rojas@example.com', '86667777', 1);



INSERT INTO Producto (ID_Producto, Nombre_Producto, Tipo_Producto, Numero_Lote) VALUES 
(Producto_SEQ.NEXTVAL, 'Hamburguesa Clásica', 'Comida', 101);

INSERT INTO Producto (ID_Producto, Nombre_Producto, Tipo_Producto, Numero_Lote) VALUES 
(Producto_SEQ.NEXTVAL, 'Papas Fritas', 'Comida', 102);

INSERT INTO Producto (ID_Producto, Nombre_Producto, Tipo_Producto, Numero_Lote) VALUES 
(Producto_SEQ.NEXTVAL, 'Bebida Gaseosa', 'Bebida', 201);


INSERT INTO Producto (ID_Producto, Nombre_Producto, Tipo_Producto, Numero_Lote) VALUES 
(Producto_SEQ.NEXTVAL, 'Gomitas Rojas', 'Gomaitas', 150);

INSERT INTO Orden (ID_Orden, Fecha_Orden, Estado_Orden, ID_Producto, ID_TipoUsuario) VALUES 
(Orden_SEQ.NEXTVAL, CURRENT_DATE, 'Pendiente', 1, 2);

INSERT INTO Orden (ID_Orden, Fecha_Orden, Estado_Orden, ID_Producto, ID_TipoUsuario) VALUES 
(Orden_SEQ.NEXTVAL, CURRENT_DATE, 'Completada', 2, 2);

INSERT INTO Orden (ID_Orden, Fecha_Orden, Estado_Orden, ID_Producto, ID_TipoUsuario) VALUES 
(Orden_SEQ.NEXTVAL, CURRENT_DATE, 'Pendiente', 3, 2);



INSERT INTO Factura (ID_Factura, Monto, Fecha_factura, ID_Orden) VALUES 
(Factura_SEQ.NEXTVAL, 12.50, CURRENT_DATE, 1);

INSERT INTO Factura (ID_Factura, Monto, Fecha_factura, ID_Orden) VALUES 
(Factura_SEQ.NEXTVAL, 8.75, CURRENT_DATE, 2);

INSERT INTO Factura (ID_Factura, Monto, Fecha_factura, ID_Orden) VALUES 
(Factura_SEQ.NEXTVAL, 15.00, CURRENT_DATE, 3);



INSERT INTO Detalle_Factura (ID_detalle_factura, Descripcion_factura, ID_usuario, ID_orden, ID_Producto) VALUES 
(DetalleFactura_SEQ.NEXTVAL, 'Hamburguesa Clásica y papas fritas', 1, 1, 1);

INSERT INTO Detalle_Factura (ID_detalle_factura, Descripcion_factura, ID_usuario, ID_orden, ID_Producto) VALUES 
(DetalleFactura_SEQ.NEXTVAL, 'Papas fritas y bebida gaseosa', 2, 2, 2);

INSERT INTO Detalle_Factura (ID_detalle_factura, Descripcion_factura, ID_usuario, ID_orden, ID_Producto) VALUES 
(DetalleFactura_SEQ.NEXTVAL, 'Hamburguesa Clásica y bebida gaseosa', 3, 3, 3);




-- PRUEBAS
select * from USRPROYECTO_PRUEBA.usuario;

DESC Usuario;

SELECT *
FROM USER_ERRORS
WHERE NAME = 'GESTION_FACTURAS';


DESC Factura;
ALTER TABLE Factura ADD ID_Usuario NUMBER;

SELECT * FROM Usuario WHERE ID_Usuario = 1;
SELECT * FROM Orden WHERE ID_Orden = 1;

INSERT INTO Factura (ID_FACTURA, MONTO, FECHA_FACTURA, ID_ORDEN, ID_USUARIO)
VALUES (Factura_SEQ.NEXTVAL, 100.50, SYSDATE, 1, 1);

SELECT * FROM USER_OBJECTS WHERE OBJECT_NAME = 'FACTURA_SEQ';


SELECT * FROM Usuario WHERE ID_Usuario = 1;
SELECT * FROM Orden WHERE ID_Orden = 1;
SELECT * FROM Producto WHERE ID_Producto = 1;
SELECT * FROM Factura;

/*
DROP TABLE Detalle_Factura CASCADE CONSTRAINTS;
DROP TABLE Factura CASCADE CONSTRAINTS;
DROP TABLE Orden CASCADE CONSTRAINTS;
DROP TABLE Usuario CASCADE CONSTRAINTS;
DROP TABLE Producto CASCADE CONSTRAINTS;
DROP TABLE Tipo_Usuario CASCADE CONSTRAINTS;
*/