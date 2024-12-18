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


-- PAQUETE DE GESTION_ORDENES
CREATE OR REPLACE PACKAGE Gestion_Ordenes AS
    PROCEDURE Crear_Orden(
        p_FechaOrden IN DATE,
        p_EstadoOrden IN VARCHAR2,
        p_IDProducto IN NUMBER,
        p_IDUsuario IN NUMBER
    );

    PROCEDURE Actualizar_Estado_Orden(
        p_IDOrden IN NUMBER,
        p_NuevoEstado IN VARCHAR2
    );

    PROCEDURE Eliminar_Orden(
        p_IDOrden IN NUMBER
    );

    PROCEDURE Listar_Ordenes(
        p_Cursor OUT SYS_REFCURSOR
    );
END Gestion_Ordenes;
/

-- BODY DE ORDENES
/*
create or replace NONEDITIONABLE PACKAGE BODY Gestion_Ordenes AS
    PROCEDURE Crear_Orden(
        p_FechaOrden IN DATE,
        p_EstadoOrden IN VARCHAR2,
        p_IDProducto IN NUMBER,
        p_IDUsuario IN NUMBER
    ) IS
    BEGIN
        INSERT INTO Orden (ID_Orden, Fecha_Orden, Estado_Orden, ID_Producto, ID_TipoUsuario)
        VALUES (Orden_SEQ.NEXTVAL, p_FechaOrden, p_EstadoOrden, p_IDProducto, 
               (SELECT TipoUsuario FROM Usuario WHERE ID_Usuario = p_IDUsuario));
        COMMIT;
    END;

    PROCEDURE Actualizar_Estado_Orden(
        p_IDOrden IN NUMBER,
        p_NuevoEstado IN VARCHAR2
    ) IS
    BEGIN
        UPDATE Orden
        SET Estado_Orden = p_NuevoEstado
        WHERE ID_Orden = p_IDOrden;
        COMMIT;
    END;

    PROCEDURE Eliminar_Orden(
        p_IDOrden IN NUMBER
    ) IS
    BEGIN
        DELETE FROM Orden WHERE ID_Orden = p_IDOrden;
        COMMIT;
    END;

    PROCEDURE Listar_Ordenes(
        p_Cursor OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN p_Cursor FOR
        SELECT * FROM Orden;
    END;

END Gestion_Ordenes;
*/



-- PAQUETE DE FACTURAS
create or replace NONEDITIONABLE PACKAGE Gestion_Facturas AS
    PROCEDURE Crear_Factura(
        p_Monto IN NUMBER,
        p_FechaFactura IN DATE,
        p_IDUsuario IN NUMBER,
        p_IDOrden IN NUMBER
    );

    PROCEDURE Actualizar_Factura(
        p_IDFactura IN NUMBER,
        p_NuevoMonto IN NUMBER
    );

    PROCEDURE Eliminar_Factura(
        p_IDFactura IN NUMBER
    );

    PROCEDURE Listar_Facturas(
        p_Cursor OUT SYS_REFCURSOR
    );
END Gestion_Facturas;

--BODY DE FACTURAS
/*
CREATE OR REPLACE PACKAGE BODY Gestion_Facturas AS

    PROCEDURE Crear_Factura(
        p_Monto IN NUMBER,
        p_FechaFactura IN DATE,
        p_IDUsuario IN NUMBER,
        p_IDOrden IN NUMBER
    ) IS
        v_FacturaExiste NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_FacturaExiste
        FROM Factura
        WHERE ID_Orden = p_IDOrden
          AND ID_Usuario = p_IDUsuario;

        IF v_FacturaExiste > 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Ya existe una factura con esta orden y usuario.');
        END IF;

        INSERT INTO Factura (ID_Factura, Monto, Fecha_factura, ID_Orden, ID_Usuario)
        VALUES (Factura_SEQ.NEXTVAL, p_Monto, p_FechaFactura, p_IDOrden, p_IDUsuario);

        COMMIT;
    END;


    PROCEDURE Actualizar_Factura(
        p_IDFactura IN NUMBER,
        p_NuevoMonto IN NUMBER
    ) IS
    BEGIN
        UPDATE Factura
        SET Monto = p_NuevoMonto
        WHERE ID_Factura = p_IDFactura;
    END;

    PROCEDURE Eliminar_Factura(
        p_IDFactura IN NUMBER
    ) IS
    BEGIN
        DELETE FROM Factura WHERE ID_Factura = p_IDFactura;
        
    END;

    PROCEDURE Listar_Facturas(
        p_Cursor OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN p_Cursor FOR
        SELECT * FROM Factura;
    END;

END Gestion_Facturas;
*/


-- LLAMAR A GESTION_ORDENES
BEGIN
    Gestion_Ordenes.Crear_Orden(
        SYSDATE,               -- Fecha de la orden (hoy)
        'Pendiente',           -- Estado inicial
        1,                     -- ID del Producto (asegúrate de que exista)
        1                      -- ID del Usuario (asegúrate de que exista)
    );
END;
/
BEGIN
    Gestion_Ordenes.Actualizar_Estado_Orden(
        1,          -- ID de la Orden (asegúrate de que exista)
        'Entregado' -- Nuevo estado
    );
END;
/
BEGIN
    Gestion_Ordenes.Eliminar_Orden(1); -- ID de la Orden para eliminar
END;
/


DECLARE
    cur SYS_REFCURSOR;
    v_IDOrden NUMBER;
    v_FechaOrden DATE;
    v_EstadoOrden VARCHAR2(50);
BEGIN
    Gestion_Ordenes.Listar_Ordenes(cur);

    LOOP
        FETCH cur INTO v_IDOrden, v_FechaOrden, v_EstadoOrden;
        EXIT WHEN cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_IDOrden || ', Fecha: ' || v_FechaOrden || ', Estado: ' || v_EstadoOrden);
    END LOOP;

    CLOSE cur;
END;
/

-- SQL DINAMICO PARA PRODUCTOS (FILTRAR POR PARAMETRO)
CREATE OR REPLACE PROCEDURE Buscar_Productos (
    p_nombre_producto IN VARCHAR2 DEFAULT NULL,
    p_tipo_producto IN VARCHAR2 DEFAULT NULL,
    p_numero_lote IN NUMBER DEFAULT NULL,
    p_result OUT SYS_REFCURSOR
) AS
    v_sql VARCHAR2(1000);
BEGIN
    v_sql := 'SELECT * FROM Producto WHERE 1=1';

    IF p_nombre_producto IS NOT NULL THEN
        v_sql := v_sql || ' AND Nombre_Producto LIKE ''%' || p_nombre_producto || '%''';
    END IF;

    IF p_tipo_producto IS NOT NULL THEN
        v_sql := v_sql || ' AND Tipo_Producto = ''' || p_tipo_producto || '''';
    END IF;

    IF p_numero_lote IS NOT NULL THEN
        v_sql := v_sql || ' AND Numero_Lote = ' || p_numero_lote;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Consulta generada: ' || v_sql);

    OPEN p_result FOR v_sql;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocurrió un error: ' || SQLERRM);
        RAISE; 
END;
/
EXEC Buscar_Productos('Bebida Gaseosa ', NULL, NULL, v_cursor); -- Solo por nombre

Select * from producto;






-- TRIGGER DE ARON

-- Trigger para manejar el inventario al crear una orden con manipulación de cantidades
CREATE OR REPLACE TRIGGER Trg_Actualizar_Inventario
AFTER INSERT ON Orden
FOR EACH ROW
DECLARE
    v_producto_existe NUMBER;
    v_numero_lote NUMBER;
BEGIN
    -- Verificar si el producto existe en la tabla Producto
    SELECT COUNT(*)
    INTO v_producto_existe
    FROM Producto
    WHERE ID_Producto = :NEW.ID_Producto;

    IF v_producto_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'El producto especificado no existe en la base de datos.');
    END IF;

    -- Verificar el número de lote y manejar cantidades (asumimos que Número_Lote es el stock)
    SELECT Numero_Lote
    INTO v_numero_lote
    FROM Producto
    WHERE ID_Producto = :NEW.ID_Producto;

    IF v_numero_lote <= 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Stock insuficiente para el producto.');
    END IF;

    -- Reducir la cantidad disponible
    UPDATE Producto
    SET Numero_Lote = Numero_Lote - 1
    WHERE ID_Producto = :NEW.ID_Producto;

    -- Registro de salida
    DBMS_OUTPUT.PUT_LINE('Orden creada y cantidad actualizada para el producto con ID: ' || :NEW.ID_Producto);
END;
/




-- Funcion de Joel

CREATE OR REPLACE FUNCTION Calcular_Total_Factura(p_IDUsuario IN NUMBER) RETURN NUMBER IS
    v_Total NUMBER := 0;
BEGIN
    -- Sumar todos los montos de las facturas asociadas al cliente
    SELECT NVL(SUM(Monto), 0)
    INTO v_Total
    FROM Factura
    WHERE ID_Usuario = p_IDUsuario;

    -- Devolver el total calculado
    RETURN v_Total;
END;
/




  -- CREAR Producto
CREATE OR REPLACE PROCEDURE CrearProducto(
    p_ID_Producto IN NUMBER,
    p_Nombre_Producto IN VARCHAR2,
    p_Tipo_Producto IN VARCHAR2,
    p_Numero_Lote IN NUMBER
)
IS
BEGIN
    INSERT INTO Producto (ID_Producto, Nombre_Producto, Tipo_Producto, Numero_Lote)
    VALUES (p_ID_Producto, p_Nombre_Producto, p_Tipo_Producto, p_Numero_Lote);
    DBMS_OUTPUT.PUT_LINE('Producto creado exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al crear el producto: ' || SQLERRM);
END;
/

-- LEER Producto (Consulta por ID)
CREATE OR REPLACE PROCEDURE LeerProducto(
    p_ID_Producto IN NUMBER
)
IS
    v_Nombre_Producto VARCHAR2(255);
    v_Tipo_Producto VARCHAR2(255);
    v_Numero_Lote NUMBER;
BEGIN
    SELECT Nombre_Producto, Tipo_Producto, Numero_Lote
    INTO v_Nombre_Producto, v_Tipo_Producto, v_Numero_Lote
    FROM Producto
    WHERE ID_Producto = p_ID_Producto;

    DBMS_OUTPUT.PUT_LINE('Producto encontrado:');
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_Nombre_Producto);
    DBMS_OUTPUT.PUT_LINE('Tipo: ' || v_Tipo_Producto);
    DBMS_OUTPUT.PUT_LINE('Número de Lote: ' || v_Numero_Lote);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Producto no encontrado.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al leer el producto: ' || SQLERRM);
END;
/

-- ACTUALIZAR Producto
CREATE OR REPLACE PROCEDURE ActualizarProducto(
    p_ID_Producto IN NUMBER,
    p_Nombre_Producto IN VARCHAR2,
    p_Tipo_Producto IN VARCHAR2,
    p_Numero_Lote IN NUMBER
)
IS
BEGIN
    UPDATE Producto
    SET Nombre_Producto = p_Nombre_Producto,
        Tipo_Producto = p_Tipo_Producto,
        Numero_Lote = p_Numero_Lote
    WHERE ID_Producto = p_ID_Producto;

    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Producto actualizado exitosamente.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Producto no encontrado.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al actualizar el producto: ' || SQLERRM);
END;
/

-- ELIMINAR Producto
CREATE OR REPLACE PROCEDURE EliminarProducto(
    p_ID_Producto IN NUMBER
)
IS
BEGIN
    DELETE FROM Producto
    WHERE ID_Producto = p_ID_Producto;

    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Producto eliminado exitosamente.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Producto no encontrado.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al eliminar el producto: ' || SQLERRM);
END;
/

-- MOSTRAR TODOS LOS PRODUCTOS
CREATE OR REPLACE PROCEDURE MostrarTodosLosProductos
IS
BEGIN
    FOR producto IN (SELECT ID_Producto, Nombre_Producto, Tipo_Producto, Numero_Lote 
                     FROM Producto)
    LOOP
        DBMS_OUTPUT.PUT_LINE('ID Producto: ' || producto.ID_Producto);
        DBMS_OUTPUT.PUT_LINE('Nombre Producto: ' || producto.Nombre_Producto);
        DBMS_OUTPUT.PUT_LINE('Tipo Producto: ' || producto.Tipo_Producto);
        DBMS_OUTPUT.PUT_LINE('Número de Lote: ' || producto.Numero_Lote);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al mostrar los productos: ' || SQLERRM);
END;
/



--pruebas
--crear
EXEC CrearProducto(100, 'Producto A', 'Tipo A', 123);

--leer
EXEC LeerProducto(100);


--actualizar
EXEC ActualizarProducto(10, 'Producto A Modificado', 'Tipo B', 456);



--eliminar
EXEC EliminarProducto(100);

-- MOSTRAR TODOS LOS PRODUCTOS
EXEC MostrarTodosLosProductos;


set SERVEROUTPUT ON;
SET VERIFY OFF;

-- Procedimiento para Crear una Factura
CREATE OR REPLACE PROCEDURE Crear_Factura(
    p_Monto IN NUMBER,
    p_FechaFactura IN DATE,
    p_IDOrden IN NUMBER
) AS
BEGIN
    BEGIN
        INSERT INTO Factura (ID_Factura, Monto, Fecha_factura, ID_Orden)
        VALUES (Factura_SEQ.NEXTVAL, p_Monto, p_FechaFactura, p_IDOrden);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'Error al crear la factura: ' || SQLERRM);
    END;
END;
/

-- Procedimiento para Leer una Factura por ID
CREATE OR REPLACE PROCEDURE Leer_Factura(
    p_IDFactura IN NUMBER,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    BEGIN
        OPEN p_Cursor FOR
        SELECT * FROM Factura WHERE ID_Factura = p_IDFactura;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'Error al leer la factura: ' || SQLERRM);
    END;
END;
/

-- Procedimiento para Listar todas las Facturas
CREATE OR REPLACE PROCEDURE Listar_Facturas(
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    BEGIN
        OPEN p_Cursor FOR
        SELECT * FROM Factura;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20003, 'Error al listar las facturas: ' || SQLERRM);
    END;
END;
/

-- Procedimiento para Actualizar una Factura
CREATE OR REPLACE PROCEDURE Actualizar_Factura(
    p_IDFactura IN NUMBER,
    p_Monto IN NUMBER,
    p_FechaFactura IN DATE,
    p_IDOrden IN NUMBER
) AS
BEGIN
    BEGIN
        UPDATE Factura
        SET Monto = p_Monto,
            Fecha_factura = p_FechaFactura,
            ID_Orden = p_IDOrden
        WHERE ID_Factura = p_IDFactura;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, 'Error al actualizar la factura: ' || SQLERRM);
    END;
END;
/

-- Procedimiento para Eliminar una Factura
CREATE OR REPLACE PROCEDURE Eliminar_Factura(
    p_IDFactura IN NUMBER
) AS
BEGIN
    BEGIN
        DELETE FROM Factura WHERE ID_Factura = p_IDFactura;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20005, 'Error al eliminar la factura: ' || SQLERRM);
    END;
END;
/

-- Procedimiento para Crear un Detalle de Factura
CREATE OR REPLACE PROCEDURE Crear_Detalle_Factura(
    p_DescripcionFactura IN VARCHAR2,
    p_IDUsuario IN NUMBER,
    p_IDOrden IN NUMBER,
    p_IDProducto IN NUMBER
) AS
BEGIN
    BEGIN
        INSERT INTO Detalle_Factura (ID_detalle_factura, Descripcion_factura, ID_usuario, ID_orden, ID_Producto)
        VALUES (DetalleFactura_SEQ.NEXTVAL, p_DescripcionFactura, p_IDUsuario, p_IDOrden, p_IDProducto);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20006, 'Error al crear el detalle de factura: ' || SQLERRM);
    END;
END;
/

-- Procedimiento para Leer un Detalle de Factura por ID
CREATE OR REPLACE PROCEDURE Leer_Detalle_Factura(
    p_IDDetalleFactura IN NUMBER,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    BEGIN
        OPEN p_Cursor FOR
        SELECT * FROM Detalle_Factura WHERE ID_detalle_factura = p_IDDetalleFactura;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20007, 'Error al leer el detalle de factura: ' || SQLERRM);
    END;
END;
/



-- Procedimiento para Listar Detalles de una Factura
CREATE OR REPLACE PROCEDURE Listar_Detalles_Factura(
    p_IDFactura IN NUMBER,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    BEGIN
        OPEN p_Cursor FOR
        SELECT *
        FROM Detalle_Factura
        WHERE ID_orden = (SELECT ID_Orden FROM Factura WHERE ID_Factura = p_IDFactura);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20008, 'Error al listar los detalles de la factura: ' || SQLERRM);
    END;
END;
/



-- Procedimiento para Actualizar un Detalle de Factura
CREATE OR REPLACE PROCEDURE Actualizar_Detalle_Factura(
    p_IDDetalleFactura IN NUMBER,
    p_DescripcionFactura IN VARCHAR2,
    p_IDUsuario IN NUMBER,
    p_IDOrden IN NUMBER,
    p_IDProducto IN NUMBER
) AS
BEGIN
    BEGIN
        UPDATE Detalle_Factura
        SET Descripcion_factura = p_DescripcionFactura,
            ID_usuario = p_IDUsuario,
            ID_orden = p_IDOrden,
            ID_Producto = p_IDProducto
        WHERE ID_detalle_factura = p_IDDetalleFactura;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20010, 'Error al actualizar el detalle de factura: ' || SQLERRM);
    END;
END;
/

-- Procedimiento para Eliminar un Detalle de Factura
CREATE OR REPLACE PROCEDURE Eliminar_Detalle_Factura(
    p_IDDetalleFactura IN NUMBER
) AS
BEGIN
    BEGIN
        DELETE FROM Detalle_Factura WHERE ID_detalle_factura = p_IDDetalleFactura;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20009, 'Error al eliminar el detalle de factura: ' || SQLERRM);
    END;
END;
/




---------------------------------------------------------------------------------------------------------

-- CREAR UNA FACTURA
BEGIN
    Crear_Factura(
        p_Monto => 100.50,              -- Monto de la factura
        p_FechaFactura => SYSDATE,      -- Fecha de la factura
        p_IDOrden => 1                  -- ID de la orden existente
    );
END;
/



-- LEER UNA FACTURA POR ID
DECLARE
    v_Cursor SYS_REFCURSOR;
    v_IDFactura NUMBER := 1;            -- ID de la factura a leer
    v_Monto NUMBER;
    v_FechaFactura DATE;
    v_IDOrden NUMBER;
BEGIN
    Leer_Factura(p_IDFactura => v_IDFactura, p_Cursor => v_Cursor);

    LOOP
        FETCH v_Cursor INTO v_IDFactura, v_Monto, v_FechaFactura, v_IDOrden;
        EXIT WHEN v_Cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_IDFactura || ', Monto: ' || v_Monto ||
                             ', Fecha: ' || v_FechaFactura || ', Orden: ' || v_IDOrden);
    END LOOP;

    CLOSE v_Cursor;
END;
/



-- LISTAR TODAS LAS FACTURAS
DECLARE
    v_Cursor SYS_REFCURSOR;
BEGIN
    Listar_Facturas(p_Cursor => v_Cursor);

    LOOP
        FETCH v_Cursor INTO v_IDFactura, v_Monto, v_FechaFactura, v_IDOrden;
        EXIT WHEN v_Cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_IDFactura || ', Monto: ' || v_Monto ||
                             ', Fecha: ' || v_FechaFactura || ', Orden: ' || v_IDOrden);
    END LOOP;

    CLOSE v_Cursor;
END;
/


-- ACTUALIZAR TODAS LAS FACTURAS
BEGIN
    Actualizar_Factura(
        p_IDFactura => 1,        -- ID de la factura existente
        p_Monto => 120.75,       -- Nuevo monto
        p_FechaFactura => SYSDATE, -- Nueva fecha
        p_IDOrden => 2           -- Nuevo ID de orden
    );
END;
/



-- ELIMINAR FACTURA




-- CREAR UN DETALLE DE UNA FACTURA
BEGIN
    Crear_Detalle_Factura(
        p_DescripcionFactura => 'Producto A',
        p_IDUsuario => 1,         -- ID del usuario 
        p_IDOrden => 1,           -- ID de la orden 
        p_IDProducto => 1         -- ID del producto 
    );
END;
/

-- LISTAR DETALLES DE UNA FACTURA
DECLARE
    v_Cursor SYS_REFCURSOR;
BEGIN
    Listar_Detalles_Factura(p_IDFactura => 1, p_Cursor => v_Cursor);

    LOOP
        FETCH v_Cursor INTO v_IDDetalleFactura, v_DescripcionFactura, v_IDUsuario, v_IDOrden, v_IDProducto;
        EXIT WHEN v_Cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID Detalle: ' || v_IDDetalleFactura || ', Descripción: ' || v_DescripcionFactura ||
                             ', Usuario: ' || v_IDUsuario || ', Orden: ' || v_IDOrden || ', Producto: ' || v_IDProducto);
    END LOOP;

    CLOSE v_Cursor;
END;
/

-- EDITAR EL DETALLE DE UNA FACTURA
BEGIN
    Actualizar_Detalle_Factura(
        p_IDDetalleFactura => 1,            -- ID del detalle de factura a actualizar
        p_DescripcionFactura => 'Producto X actualizado', -- Nueva descripción
        p_IDUsuario => 2,                   -- Nuevo ID de usuario
        p_IDOrden => 3,                     -- Nuevo ID de orden
        p_IDProducto => 5                   -- Nuevo ID de producto
    );
END;
/


-- ELIMINAR EL DETALLE DE UNA FACTURA
BEGIN
    Eliminar_Detalle_Factura(
        p_IDDetalleFactura => 1 -- ID del detalle 
    );
END;
/





-- SP PARA TIPOS DE USUARIO
-- Procedimiento para Crear un Tipo de Usuario
CREATE OR REPLACE PROCEDURE Crear_TipoUsuario(
    p_IDTipoUsuario IN NUMBER,
    p_TipoUsuario IN VARCHAR2,
    p_Descripcion IN VARCHAR2
) AS
BEGIN
    BEGIN
        INSERT INTO Tipo_Usuario (ID_TipoUsuario, TipoUsuario, Descripcion)
        VALUES (p_IDTipoUsuario, p_TipoUsuario, p_Descripcion);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'Error al crear el Tipo de Usuario: ' || SQLERRM);
    END;
END;
/

-- Procedimiento para Leer un Tipo de Usuario por ID
CREATE OR REPLACE PROCEDURE Leer_TipoUsuario(
    p_IDTipoUsuario IN NUMBER,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT * FROM Tipo_Usuario WHERE ID_TipoUsuario = p_IDTipoUsuario;
END;
/

-- Procedimiento para Listar Todos los Tipos de Usuario
CREATE OR REPLACE PROCEDURE Listar_TipoUsuarios(
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT ID_TIPOUSUARIO, TIPOUSUARIO, DESCRIPCION FROM TIPO_USUARIO;
END;
/



select * from TIPO_USUARIO;




-- Procedimiento para Actualizar un Tipo de Usuario
CREATE OR REPLACE PROCEDURE Actualizar_TipoUsuario(
    p_IDTipoUsuario IN NUMBER,
    p_TipoUsuario IN VARCHAR2,
    p_Descripcion IN VARCHAR2
) AS
BEGIN
    BEGIN
        UPDATE Tipo_Usuario
        SET TipoUsuario = p_TipoUsuario,
            Descripcion = p_Descripcion
        WHERE ID_TipoUsuario = p_IDTipoUsuario;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20002, 'Error al actualizar el Tipo de Usuario: ' || SQLERRM);
    END;
END;
/

-- Procedimiento para Eliminar un Tipo de Usuario
CREATE OR REPLACE PROCEDURE Eliminar_TipoUsuario(
    p_IDTipoUsuario IN NUMBER
) AS
BEGIN
    BEGIN
        DELETE FROM Tipo_Usuario WHERE ID_TipoUsuario = p_IDTipoUsuario;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003, 'Error al eliminar el Tipo de Usuario: ' || SQLERRM);
    END;
END;
/






-- SP PARA USUARIOS

-- Procedimiento para Crear un Usuario
CREATE OR REPLACE PROCEDURE Crear_Usuario(
    p_IDUsuario IN NUMBER,
    p_Nombre IN VARCHAR2,
    p_Apellido1 IN VARCHAR2,
    p_Apellido2 IN VARCHAR2,
    p_CorreoElectronico IN VARCHAR2,
    p_Telefono IN VARCHAR2,
    p_TipoUsuario IN NUMBER
) AS
BEGIN
    BEGIN
        INSERT INTO Usuario (ID_Usuario, Nombre, Apellido1, Apellido2, CorreoElectronico, Telefono, TipoUsuario)
        VALUES (p_IDUsuario, p_Nombre, p_Apellido1, p_Apellido2, p_CorreoElectronico, p_Telefono, p_TipoUsuario);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, 'Error al crear el Usuario: ' || SQLERRM);
    END;
END;
/

-- Procedimiento para Leer un Usuario por ID
CREATE OR REPLACE PROCEDURE Leer_Usuario(
    p_IDUsuario IN NUMBER,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT * FROM Usuario WHERE ID_Usuario = p_IDUsuario;
END;
/

-- Procedimiento para Listar Todos los Usuarios
CREATE OR REPLACE PROCEDURE Listar_Usuarios(
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT * FROM Usuario;
END;
/

-- Procedimiento para Actualizar un Usuario
CREATE OR REPLACE PROCEDURE Actualizar_Usuario(
    p_IDUsuario IN NUMBER,
    p_Nombre IN VARCHAR2,
    p_Apellido1 IN VARCHAR2,
    p_Apellido2 IN VARCHAR2,
    p_CorreoElectronico IN VARCHAR2,
    p_Telefono IN VARCHAR2,
    p_TipoUsuario IN NUMBER
) AS
BEGIN
    BEGIN
        UPDATE Usuario
        SET Nombre = p_Nombre,
            Apellido1 = p_Apellido1,
            Apellido2 = p_Apellido2,
            CorreoElectronico = p_CorreoElectronico,
            Telefono = p_Telefono,
            TipoUsuario = p_TipoUsuario
        WHERE ID_Usuario = p_IDUsuario;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20005, 'Error al actualizar el Usuario: ' || SQLERRM);
    END;
END;
/

-- Procedimiento para Eliminar un Usuario
CREATE OR REPLACE PROCEDURE Eliminar_Usuario(
    p_IDUsuario IN NUMBER
) AS
BEGIN
    BEGIN
        DELETE FROM Usuario WHERE ID_Usuario = p_IDUsuario;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20006, 'Error al eliminar el Usuario: ' || SQLERRM);
    END;
END;
/






