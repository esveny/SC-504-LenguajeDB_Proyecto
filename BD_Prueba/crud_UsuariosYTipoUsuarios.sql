
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



