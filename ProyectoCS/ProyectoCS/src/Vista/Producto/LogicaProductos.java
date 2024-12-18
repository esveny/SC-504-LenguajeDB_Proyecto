package Vista.Producto;
import ConexionSQLDB.DataBaseConnect;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;
import oracle.jdbc.OracleTypes;

public class LogicaProductos extends javax.swing.JFrame {
    public LogicaProductos() {
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
    public boolean insertarProducto(int id, String nombre, String tipo, int numeroLote) {
    String sql = "{call CrearProducto(?, ?, ?, ?)}"; // Llamada al procedimiento

    try (Connection cnx = DataBaseConnect.getConnection();
         CallableStatement cs = cnx.prepareCall(sql)) {

        // Configurar parámetros para el procedimiento
        cs.setInt(1, id);
        cs.setString(2, nombre);
        cs.setString(3, tipo);
        cs.setInt(4, numeroLote);

        cs.execute(); // Aquí se ejecuta el procedimiento que activa el trigger

        JOptionPane.showMessageDialog(null, "Producto guardado correctamente.");
        return true;

    } catch (SQLException ex) {
        // Captura el error del trigger
        if (ex.getErrorCode() == -20001) {
            JOptionPane.showMessageDialog(null, "Error: El número de lote debe ser mayor a cero y no puede ser nulo.", "Error de Validación", JOptionPane.ERROR_MESSAGE);
        } else {
            // Captura otros errores
            JOptionPane.showMessageDialog(null, "Error al insertar el producto: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
        ex.printStackTrace();
    }
    return false;
}
    
    // Método para actualizar un producto
    public boolean actualizarProducto(int id, String nombre, String tipo, int numeroLote) {
        String sql = "{call ActualizarProducto(?, ?, ?, ?)}";
        try (Connection cnx = DataBaseConnect.getConnection();
             CallableStatement cs = cnx.prepareCall(sql)) {

            cs.setInt(1, id);
            cs.setString(2, nombre);
            cs.setString(3, tipo);
            cs.setInt(4, numeroLote);
            cs.execute();
            return true;
        } catch (SQLException ex) {
            System.out.println("Error al actualizar producto: " + ex.getMessage());
        }
        return false;
    }

    // Método para eliminar un producto
    public boolean eliminarProducto(int id) {
        String sql = "{call EliminarProducto(?)}";
        try (Connection cnx = DataBaseConnect.getConnection();
             CallableStatement cs = cnx.prepareCall(sql)) {

            cs.setInt(1, id);
            cs.execute();
            return true;
        } catch (SQLException ex) {
            System.out.println("Error al eliminar producto: " + ex.getMessage());
        }
        return false;
    }

    // Método para listar todos los productos
    public List<String[]> listarProductos() {
        List<String[]> lista = new ArrayList<>();
        String sql = "{call MostrarTodosLosProductos(?)}";
        try (Connection cnx = DataBaseConnect.getConnection();
             CallableStatement cs = cnx.prepareCall(sql)) {

            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();

            ResultSet rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                String[] fila = new String[4];
                fila[0] = rs.getString("ID_Producto");
                fila[1] = rs.getString("Nombre_Producto");
                fila[2] = rs.getString("Tipo_Producto");
                fila[3] = rs.getString("Numero_Lote");
                lista.add(fila);
            }
        } catch (SQLException ex) {
            System.out.println("Error al listar productos: " + ex.getMessage());
        }
        return lista;
    }
    
    public int contarProductosDinamico(String columna, String valor) {
    String sql = "{ ? = call ContarProductosDinamico(?, ?) }"; // SQL para llamar a la función
    int total = -1;

    try (Connection cnx = DataBaseConnect.getConnection();
         CallableStatement cs = cnx.prepareCall(sql)) {

        // Configurar parámetros
        cs.registerOutParameter(1, java.sql.Types.INTEGER); // Valor de retorno
        cs.setString(2, columna); // Primer parámetro: nombre de la columna
        cs.setString(3, valor);   // Segundo parámetro: valor a buscar

        cs.execute();

        // Obtener el valor de retorno
        total = cs.getInt(1);

    } catch (SQLException ex) {
        System.out.println("Error al contar productos dinámicamente: " + ex.getMessage());
    }
    return total; // Retorna el resultado o -1 si hubo un error
}

    
    

    // Variables declaration - do not modify//GEN-BEGIN:variables
    // End of variables declaration//GEN-END:variables
}
