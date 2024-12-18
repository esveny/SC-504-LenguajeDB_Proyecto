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




--pruebas
--crear
EXEC CrearProducto(10, 'Producto A', 'Tipo A', 123);

--leer
EXEC LeerProducto(1);


--actualizar
EXEC ActualizarProducto(10, 'Producto A Modificado', 'Tipo B', 456);



--eliminar
EXEC EliminarProducto(10);


CREATE OR REPLACE PROCEDURE MostrarTodosLosProductos(p_cursor OUT SYS_REFCURSOR)
IS
BEGIN
    OPEN p_cursor FOR
        SELECT ID_Producto, Nombre_Producto, Tipo_Producto, Numero_Lote
        FROM Producto;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al mostrar los productos: ' || SQLERRM);
END;
/




SET SERVEROUTPUT ON;





-- trigger
CREATE OR REPLACE TRIGGER trg_Validar_NumeroLote
BEFORE INSERT ON Producto
FOR EACH ROW
BEGIN
    IF :NEW.Numero_Lote IS NULL OR :NEW.Numero_Lote <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'La cantidad debe ser mayor a cero y no puede ser nulo.');
    END IF;
END;
/




INSERT INTO Producto (ID_Producto, Nombre_Producto, Tipo_Producto, Numero_Lote)
VALUES (1, 'Producto Test', 'Tipo Test', NULL);


EXEC CrearProducto(Producto_SEQ.NEXTVAL, 'Producto Válido', 'Tipo A', 123);

EXEC CrearProducto(Producto_SEQ.NEXTVAL, 'Producto Inválido', 'Tipo B', 0);

--funcion 
CREATE OR REPLACE FUNCTION ContarProductosDinamico(
    p_Columna IN VARCHAR2,
    p_Valor IN VARCHAR2
) RETURN NUMBER
IS
    v_Total NUMBER := 0;
    v_SQL VARCHAR2(500);
BEGIN
    -- Construir SQL dinámico
    v_SQL := 'SELECT COUNT(*) FROM Producto WHERE ' || p_Columna || ' = :valor';

    -- Ejecutar SQL dinámico
    EXECUTE IMMEDIATE v_SQL
        INTO v_Total
        USING p_Valor;

    RETURN v_Total;
EXCEPTION
    WHEN OTHERS THEN
        RETURN -1; -- Indica un error
END;
/

--prueba
-- Contar productos donde "Tipo_Producto" = 'Comida'
DECLARE
    v_Total NUMBER;
BEGIN
    v_Total := ContarProductosDinamico('Tipo_Producto', 'Bebida');
    DBMS_OUTPUT.PUT_LINE('Total de productos seleccionado: ' || v_Total);
END;
/

VARIABLE p_cursor REFCURSOR;

BEGIN
    MostrarTodosLosProductos(:p_cursor);
END;
/

PRINT :p_cursor;