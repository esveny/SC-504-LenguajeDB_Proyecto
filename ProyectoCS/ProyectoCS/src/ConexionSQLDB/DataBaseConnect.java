package ConexionSQLDB;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DataBaseConnect {
    public static Connection getConnection() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver"); 
            String myDB = "jdbc:oracle:thin:@localhost:1521:orcl"; 
            String usuario = "USRPROYECTO_PRUEBA";
            String password = "proyecto1234";
            Connection cnx = DriverManager.getConnection(myDB, usuario, password);
            return cnx;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DataBaseConnect.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
