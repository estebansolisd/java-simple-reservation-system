/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Conexion;
import Model.EmpleadosModel;
import java.sql.CallableStatement;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author Usuario-pc
 */
public class EmpleadosControlador {
    public boolean insertar_empleados(EmpleadosModel empleados){
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_insertar_empleados(?,?,?,?,?,?,?,?,?,?,?)}");
            cst.setInt(1, empleados.getInd_empleado());
            cst.setString(2, empleados.getNum_cedula());
            cst.setString(3, empleados.getDes_nombre());
            cst.setString(4, empleados.getTip_cargo());
            cst.setString(5, empleados.getDes_direccion());
            cst.setString(6, empleados.getNom_pais());
            cst.setString(7, empleados.getNom_distrito());
            cst.setString(8, empleados.getNom_canton());
            cst.setString(9, empleados.getNum_telefono());
            cst.setString(10, empleados.getDes_email());
            cst.registerOutParameter(11, java.sql.Types.BOOLEAN);
            cst.execute();
            
            if (cst.getBoolean(11)) {
                return true;
            }

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, e.getMessage());
            return false;
        } finally {
            //Cerrar la conexion
            conexion.desconectar();
        }
        return false;
    }
    public boolean actualizar_empleados(EmpleadosModel empleados){
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_actualizar_empleados(?,?,?,?,?,?,?,?,?,?,?)}");
            cst.setInt(1, empleados.getInd_empleado());
            cst.setString(2, empleados.getNum_cedula());
            cst.setString(3, empleados.getDes_nombre());
            cst.setString(4, empleados.getTip_cargo());
            cst.setString(5, empleados.getDes_direccion());
            cst.setString(6, empleados.getNom_pais());
            cst.setString(7, empleados.getNom_distrito());
            cst.setString(8, empleados.getNom_canton());
            cst.setString(9, empleados.getNum_telefono());
            cst.setString(10, empleados.getDes_email());
            cst.registerOutParameter(11, java.sql.Types.BOOLEAN);
            cst.execute();
            
            if (cst.getBoolean(11)) {
                return true;
            }

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, e.getMessage());
            return false;
        } finally {
            //Cerrar la conexion
            conexion.desconectar();
        }
        return false;
    }
    public boolean eliminar_empleados(EmpleadosModel empleados){
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_eliminar_empleados(?,?)}");
            cst.setInt(1, empleados.getInd_empleado());
            cst.registerOutParameter(2, java.sql.Types.BOOLEAN);
            cst.execute();
            
            
            if (cst.getBoolean(2)) {
                return true;
            }

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, e.getMessage());
            return false;
        } finally {
            //Cerrar la conexion
            conexion.desconectar();
        }
        return false;
    }
}
