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




