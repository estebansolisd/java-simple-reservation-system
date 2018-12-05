/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Conexion;
import Model.UsuarioModel;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JComboBox;
import javax.swing.JOptionPane;

/**
 *
 * @author Usuario-pc
 */
public class UsuarioControlador {

    public boolean verificar_usuario(UsuarioModel usua) {
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_verificar_usuario(?,?,?)}");
            cst.setString(1, usua.getLog_usuario());
            cst.setString(2, usua.getDes_clave());
            cst.registerOutParameter(3, java.sql.Types.BOOLEAN);
            cst.execute();

            if (cst.getBoolean(3)) {
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

    public boolean insertar_usuarios(UsuarioModel usuarios) {
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_insertar_usuarios(?,?,?,?,?,?)}");
            cst.setInt(1, usuarios.getInd_usuario());
            cst.setInt(2, usuarios.getInd_empleado());
            cst.setString(3, usuarios.getLog_usuario());
            cst.setString(4, usuarios.getDes_clave());
            cst.setString(5, usuarios.getInd_tipo());
            cst.registerOutParameter(6, java.sql.Types.BOOLEAN);
            cst.execute();

            if (cst.getBoolean(6)) {
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

    public boolean actualizar_usuarios(UsuarioModel usuarios) {
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_actualizar_usuarios(?,?,?,?,?,?)}");
            cst.setInt(1, usuarios.getInd_usuario());
            cst.setInt(2, usuarios.getInd_empleado());
            cst.setString(3, usuarios.getLog_usuario());
            cst.setString(4, usuarios.getDes_clave());
            cst.setString(5, usuarios.getInd_tipo());
            cst.registerOutParameter(6, java.sql.Types.BOOLEAN);
            cst.execute();

            if (cst.getBoolean(6)) {
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

    public boolean eliminar_usuarios(UsuarioModel usuarios) {
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_eliminar_usuarios(?,?)}");
            cst.setInt(1, usuarios.getInd_usuario());
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
