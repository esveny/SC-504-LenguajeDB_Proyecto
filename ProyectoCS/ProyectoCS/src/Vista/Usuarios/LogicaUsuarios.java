package Vista.Usuarios;
import ConexionSQLDB.DataBaseConnect;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author branb
 */
public class LogicaUsuarios extends javax.swing.JFrame {

    
    public LogicaUsuarios() {
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
    //COGIGO
    
    
    
    public boolean insertarUsuario(int id, String nombre, String apellido1, String apellido2, 
                                   String correo, String telefono, int tipoUsuario) {
        String sql = "{call Crear_Usuario(?, ?, ?, ?, ?, ?, ?)}";
        try (Connection cnx = DataBaseConnect.getConnection();
             CallableStatement cs = cnx.prepareCall(sql)) {

            cs.setInt(1, id);
            cs.setString(2, nombre);
            cs.setString(3, apellido1);
            cs.setString(4, apellido2);
            cs.setString(5, correo);
            cs.setString(6, telefono);
            cs.setInt(7, tipoUsuario);
            cs.execute();
            return true;
        } catch (SQLException ex) {
            System.out.println("Error al insertar usuario: " + ex.getMessage());
        }
        return false;
    }

    // Método para actualizar un Usuario
    public boolean actualizarUsuario(int id, String nombre, String apellido1, String apellido2, 
                                     String correo, String telefono, int tipoUsuario) {
        String sql = "{call Actualizar_Usuario(?, ?, ?, ?, ?, ?, ?)}";
        try (Connection cnx = DataBaseConnect.getConnection();
             CallableStatement cs = cnx.prepareCall(sql)) {

            cs.setInt(1, id);
            cs.setString(2, nombre);
            cs.setString(3, apellido1);
            cs.setString(4, apellido2);
            cs.setString(5, correo);
            cs.setString(6, telefono);
            cs.setInt(7, tipoUsuario);
            cs.execute();
            return true;
        } catch (SQLException ex) {
            System.out.println("Error al actualizar usuario: " + ex.getMessage());
        }
        return false;
    }

    // Método para eliminar un Usuario
    public boolean eliminarUsuario(int id) {
        String sql = "{call Eliminar_Usuario(?)}";
        try (Connection cnx = DataBaseConnect.getConnection();
             CallableStatement cs = cnx.prepareCall(sql)) {

            cs.setInt(1, id);
            cs.execute();
            return true;
        } catch (SQLException ex) {
            System.out.println("Error al eliminar usuario: " + ex.getMessage());
        }
        return false;
    }

    // Método para listar todos los Usuarios
    public List<String[]> listarUsuarios() {
        List<String[]> lista = new ArrayList<>();
        String sql = "{call Listar_Usuarios(?)}";
        try (Connection cnx = DataBaseConnect.getConnection();
             CallableStatement cs = cnx.prepareCall(sql)) {

            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();

            ResultSet rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                String[] fila = new String[7];
                fila[0] = rs.getString("ID_USUARIO");
                fila[1] = rs.getString("NOMBRE");
                fila[2] = rs.getString("APELLIDO1");
                fila[3] = rs.getString("APELLIDO2");
                fila[4] = rs.getString("CORREOELECTRONICO");
                fila[5] = rs.getString("TELEFONO");
                fila[6] = rs.getString("TIPOUSUARIO");
                lista.add(fila);
            }
        } catch (SQLException ex) {
            System.out.println("Error al listar usuarios: " + ex.getMessage());
        }
        return lista;
    }


    

    // Variables declaration - do not modify//GEN-BEGIN:variables
    // End of variables declaration//GEN-END:variables
}
