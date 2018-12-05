/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Conexion;
import Model.ClientesModel;
import java.sql.CallableStatement;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author Usuario-pc
 */
public class ClientesControlador {
    public boolean insertar_clientes(ClientesModel clientes){
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_insertar_clientes(?,?,?,?,?,?,?,?,?,?)}");
            cst.setInt(1, clientes.getInd_cliente());
            cst.setString(2, clientes.getNum_cedula());
            cst.setString(3, clientes.getDes_nombre());
            cst.setString(4, clientes.getDes_direccion());
            cst.setString(5, clientes.getNom_pais());
            cst.setString(6, clientes.getNom_distrito());
            cst.setString(7, clientes.getNom_canton());
            cst.setString(8, clientes.getNum_telefono());
            cst.setString(9, clientes.getDes_email());
            cst.registerOutParameter(10, java.sql.Types.BOOLEAN);
            cst.execute();
            
            if (cst.getBoolean(10)) {
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
    public boolean actualizar_clientes(ClientesModel clientes){
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_actualizar_clientes(?,?,?,?,?,?,?,?,?,?)}");
            cst.setInt(1, clientes.getInd_cliente());
            cst.setString(2, clientes.getNum_cedula());
            cst.setString(3, clientes.getDes_nombre());
            cst.setString(4, clientes.getDes_direccion());
            cst.setString(5, clientes.getNom_pais());
            cst.setString(6, clientes.getNom_distrito());
            cst.setString(7, clientes.getNom_canton());
            cst.setString(8, clientes.getNum_telefono());
            cst.setString(9, clientes.getDes_email());
            cst.registerOutParameter(10, java.sql.Types.BOOLEAN);
            cst.execute();
            
            if (cst.getBoolean(10)) {
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
    public boolean eliminar_clientes(ClientesModel clientes){
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_eliminar_clientes(?,?)}");
            cst.setInt(1, clientes.getInd_cliente());
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
