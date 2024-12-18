package Vista.TipoUsuario;

import ConexionSQLDB.DataBaseConnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author branb
 */
public class LogicaTipoUsuario extends javax.swing.JFrame {

    /**
     * Creates new form LogicaTipoUsuario
     */
    public LogicaTipoUsuario() {
        initComponents();
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 400, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 300, Short.MAX_VALUE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents
    // Método para listar tipos de usuarios

    public List<String[]> listarTipoUsuarios() {
        List<String[]> lista = new ArrayList<>();
        String sql = "{call Listar_TipoUsuarios(?)}"; // Procedimiento almacenado

        try (Connection cnx = DataBaseConnect.getConnection(); CallableStatement cs = cnx.prepareCall(sql)) {

            // Registrar el parámetro de salida (SYS_REFCURSOR)
            cs.registerOutParameter(1, oracle.jdbc.OracleTypes.CURSOR);

            // Ejecutar el procedimiento
            cs.execute();

            // Obtener el cursor como ResultSet
            ResultSet rs = (ResultSet) cs.getObject(1);

            // Depuración: Imprimir los nombres de las columnas
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
            System.out.println("Columnas devueltas por el cursor:");
            for (int i = 1; i <= columnCount; i++) {
                System.out.println("Columna " + i + ": " + metaData.getColumnName(i));
            }

            // Obtener datos del ResultSet usando índices
            while (rs.next()) {
                String[] fila = new String[3];
                fila[0] = rs.getString("ID_TIPOUSUARIO"); // Columna 1
                fila[1] = rs.getString("TIPOUSUARIO");    // Columna 2
                fila[2] = rs.getString("DESCRIPCION");    // Columna 3
                lista.add(fila);
            }

        } catch (SQLException ex) {
            System.out.println("Error al listar tipos de usuarios: " + ex.getMessage());
        }
        return lista;
    }

    // Método para insertar un Tipo de Usuario
    public boolean insertarTipoUsuario(int id, String tipoUsuario, String descripcion) {
        String sql = "{call Crear_TipoUsuario(?, ?, ?)}";
        try (Connection cnx = DataBaseConnect.getConnection();
             CallableStatement cs = cnx.prepareCall(sql)) {
            cs.setInt(1, id);
            cs.setString(2, tipoUsuario);
            cs.setString(3, descripcion);
            cs.execute();
            return true;
        } catch (SQLException ex) {
            System.out.println("Error al insertar tipo de usuario: " + ex.getMessage());
        }
        return false;
    }

    // Método para actualizar un Tipo de Usuario
    public boolean actualizarTipoUsuario(int id, String tipoUsuario, String descripcion) {
        String sql = "{call Actualizar_TipoUsuario(?, ?, ?)}";
        try (Connection cnx = DataBaseConnect.getConnection();
             CallableStatement cs = cnx.prepareCall(sql)) {
            cs.setInt(1, id);
            cs.setString(2, tipoUsuario);
            cs.setString(3, descripcion);
            cs.execute();
            return true;
        } catch (SQLException ex) {
            System.out.println("Error al actualizar tipo de usuario: " + ex.getMessage());
        }
        return false;
    }

    // Método para eliminar un Tipo de Usuario
    public boolean eliminarTipoUsuario(int id) {
        String sql = "{call Eliminar_TipoUsuario(?)}";
        try (Connection cnx = DataBaseConnect.getConnection();
             CallableStatement cs = cnx.prepareCall(sql)) {
            cs.setInt(1, id);
            cs.execute();
            return true;
        } catch (SQLException ex) {
            System.out.println("Error al eliminar tipo de usuario: " + ex.getMessage());
        }
        return false;
    }


    // Variables declaration - do not modify//GEN-BEGIN:variables
    // End of variables declaration//GEN-END:variables
}
