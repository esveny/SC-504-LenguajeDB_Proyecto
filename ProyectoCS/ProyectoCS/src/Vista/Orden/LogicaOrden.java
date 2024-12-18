package Vista.Orden;

import ConexionSQLDB.DataBaseConnect;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import oracle.jdbc.OracleTypes;
import javax.swing.JOptionPane;


public class LogicaOrden extends javax.swing.JFrame {
    public LogicaOrden() {
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
//AQUI VA LA LÓGICA

     public boolean insertarOrden(String fechaOrden, String estadoOrden, int idProducto, int idUsuario) {
        String sql = "{call Gestion_Ordenes.Crear_Orden(TO_DATE(?, 'YYYY-MM-DD'), ?, ?, ?)}";
        try (Connection cnx = DataBaseConnect.getConnection();
             CallableStatement cs = cnx.prepareCall(sql)) {

            cs.setString(1, fechaOrden); 
            cs.setString(2, estadoOrden); 
            cs.setInt(3, idProducto); 
            cs.setInt(4, idUsuario); 

            cs.execute();
            JOptionPane.showMessageDialog(null, "Orden creada correctamente.");
            return true;
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "Error al crear la orden: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            ex.printStackTrace();
        }
        return false;
    }

    // Método para actualizar el estado de una orden
    public boolean actualizarEstadoOrden(int idOrden, String nuevoEstado) {
        String sql = "{call Gestion_Ordenes.Actualizar_Estado_Orden(?, ?)}";
        try (Connection cnx = DataBaseConnect.getConnection();
             CallableStatement cs = cnx.prepareCall(sql)) {

            cs.setInt(1, idOrden); 
            cs.setString(2, nuevoEstado); 

            cs.execute();
            JOptionPane.showMessageDialog(null, "Orden actualizada correctamente.");
            return true;
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "Error al actualizar la orden: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            ex.printStackTrace();
        }
        return false;
    }

    // Método para eliminar una orden
    public boolean eliminarOrden(int idOrden) {
        String sql = "{call Gestion_Ordenes.Eliminar_Orden(?)}";
        try (Connection cnx = DataBaseConnect.getConnection();
             CallableStatement cs = cnx.prepareCall(sql)) {

            cs.setInt(1, idOrden); 
            cs.execute();
            JOptionPane.showMessageDialog(null, "Orden eliminada correctamente.");
            return true;
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "Error al eliminar la orden: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            ex.printStackTrace();
        }
        return false;
    }

    // Método para listar todas las órdenes
    public List<String[]> listarOrden() {
        List<String[]> lista = new ArrayList<>();
        String sql = "{call Gestion_Ordenes.Listar_Ordenes(?)}";
        try (Connection cnx = DataBaseConnect.getConnection();
             CallableStatement cs = cnx.prepareCall(sql)) {

            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();

            ResultSet rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                String[] fila = new String[5];
                fila[0] = rs.getString("ID_Orden");
                fila[1] = rs.getString("Fecha_Orden");
                fila[2] = rs.getString("Estado_Orden");
                fila[3] = rs.getString("ID_Producto");
                fila[4] = rs.getString("ID_TipoUsuario");
                lista.add(fila);
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "Error al listar las órdenes: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            ex.printStackTrace();
        }
        return lista;
    }





    // Variables declaration - do not modify//GEN-BEGIN:variables
    // End of variables declaration//GEN-END:variables
}
