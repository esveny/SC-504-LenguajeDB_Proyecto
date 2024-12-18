set SERVEROUTPUT ON;
SET VERIFY OFF;

-- Procedimiento para Crear una Factura
CREATE OR REPLACE PROCEDURE Crear_Factura(
    p_Monto IN NUMBER,
    p_IDOrden IN NUMBER
) AS
BEGIN
    BEGIN
        INSERT INTO Factura (ID_Factura, Monto, ID_Orden)
        VALUES (Factura_SEQ.NEXTVAL, p_Monto, p_IDOrden);
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
    p_IDOrden IN NUMBER
) AS
BEGIN
    BEGIN
        UPDATE Factura
        SET Monto = p_Monto,
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
