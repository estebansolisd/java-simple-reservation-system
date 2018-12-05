/**
 * try {
 * this.datos.first();
 * } catch (SQLException ex) {
 * Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
 * } */
/*

 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import Controller.WinRegistry;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

/**
 *
 * @author Jonathan Moreno
 */
public class Conexion {

    private Connection conexion;

    private Statement sql;
    private ResultSet datos;

    public ResultSet getDatos() {
        return datos;
    }

    public Connection getConexion() {
        return conexion;
    }

    public void setConexion(Connection conexion) {
        this.conexion = conexion;
    }

    private boolean cargarControlador() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return true;
        } catch (ClassNotFoundException ex) {
            JOptionPane.showMessageDialog(null, "Error...No se cargó el controlador de Bases de Datos " + ex.getMessage());
            return false;
        }
    }

    public boolean conectar() {
        this.cargarControlador();
        try {
            this.conexion = DriverManager.getConnection("jdbc:sqlserver://" + WinRegistry.readString(WinRegistry.HKEY_CURRENT_USER, "SOFTWARE\\JAVAPROYECTO", "Ip") + ":1433;databaseName=agencia_viajes", WinRegistry.readString(WinRegistry.HKEY_CURRENT_USER, "SOFTWARE\\JAVAPROYECTO", "User"), WinRegistry.readString(WinRegistry.HKEY_CURRENT_USER, "SOFTWARE\\JAVAPROYECTO", "Clave"));
            this.sql = this.conexion.createStatement();
            return true;
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Error...No hay conexión con la Base de Datos o pusiste mal los datos de conexion, si es asi cambialos \n" + ex.getMessage());
            return false;
        }
    }

    public void desconectar() {
        try {
            this.sql.close();
            this.conexion.close();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "Error al cerrar la conexión con la Base de Datos " + ex.getMessage());
        }
    }

    //para mostrar o crear
    public void ejecutarSqlSelect(String consulta) {
        this.conectar();
        try {
            this.datos = this.sql.executeQuery(consulta);
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "Error al ejecutar consulta Select " + ex.getMessage());
        }
        //this.desconectar();   
    }

    //ejecutar consultas de tipo insert, update y delete
    public void ejecutarSqlUpdate(String sql) {
        this.conectar();
        try {
            this.sql.executeUpdate(sql);
        } catch (SQLException ex) {
            //JOptionPane.showMessageDialog(null, "Error al ejecutar consulta de actualización de datos " + ex.getMessage());
        }
        this.desconectar();
    }

    //devuelve la tabla del resultado pero luego devuelve el puntero a this.datos.first();
    public ResultSet Fetch() {
        return this.datos;
    }
}
