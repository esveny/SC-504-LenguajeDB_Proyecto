package Vista.Factura;

import ConexionSQLDB.DataBaseConnect;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;
import oracle.jdbc.OracleTypes;

public class LogicaFactura extends javax.swing.JFrame {

    public LogicaFactura() {
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

    public boolean insertarFactura(double monto, int idOrden) {
        String sql = "{call Crear_Factura(?, ?)}";
        try (Connection cnx = DataBaseConnect.getConnection(); CallableStatement cs = cnx.prepareCall(sql)) {

            // Configurar parámetros
            cs.setDouble(1, monto);
            cs.setInt(2, idOrden);

            cs.execute();
            JOptionPane.showMessageDialog(null, "Factura guardada correctamente.");
            return true;
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "Error al insertar la factura: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            ex.printStackTrace();
        }
        return false;
    }

    public boolean actualizarFactura(int idFactura, double monto, int idOrden) {
    String sql = "{call Actualizar_Factura(?, ?, ?)}";
    try (Connection cnx = DataBaseConnect.getConnection();
         CallableStatement cs = cnx.prepareCall(sql)) {

        cs.setInt(1, idFactura);  
        cs.setDouble(2, monto);
        cs.setInt(3, idOrden);

        cs.execute();
        JOptionPane.showMessageDialog(null, "Factura actualizada correctamente.");
        return true;
    } catch (SQLException ex) {
        JOptionPane.showMessageDialog(null, "Error al actualizar la factura: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        ex.printStackTrace();
    }
    return false;
}

    public boolean eliminarFactura(int idFactura) {
        String sql = "{call Eliminar_Factura(?)}";
        try (Connection cnx = DataBaseConnect.getConnection(); CallableStatement cs = cnx.prepareCall(sql)) {

            cs.setInt(1, idFactura);
            cs.execute();
            return true;
        } catch (SQLException ex) {
            System.out.println("Error al eliminar factura: " + ex.getMessage());
        }
        return false;
    }

    public List<String[]> listarFacturas() {
        List<String[]> lista = new ArrayList<>();
        String sql = "{call Listar_Facturas(?)}";
        try (Connection cnx = DataBaseConnect.getConnection(); CallableStatement cs = cnx.prepareCall(sql)) {

            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();

            ResultSet rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                String[] fila = new String[3];
                fila[0] = rs.getString("ID_Factura");
                fila[1] = rs.getString("Monto");
                fila[2] = rs.getString("ID_Orden");
                lista.add(fila);
            }
        } catch (SQLException ex) {
            System.out.println("Error al listar facturas: " + ex.getMessage());
        }
        return lista;
    }


    // Variables declaration - do not modify//GEN-BEGIN:variables
    // End of variables declaration//GEN-END:variables
}
