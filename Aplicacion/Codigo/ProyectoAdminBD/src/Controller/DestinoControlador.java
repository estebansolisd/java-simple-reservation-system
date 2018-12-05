/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Conexion;
import Model.ClientesModel;
import Model.DestinoModel;
import java.sql.CallableStatement;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author Usuario-pc
 */
public class DestinoControlador {
    public boolean insertar_destinos(DestinoModel destinos){
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_insertar_destinos(?,?,?,?,?)}");
            cst.setInt(1, destinos.getInd_destino());
            cst.setString(2, destinos.getDes_destino());
            cst.setString(3, destinos.getDes_observacion());
            cst.setInt(4, destinos.getMon_precio());
            cst.registerOutParameter(5, java.sql.Types.BOOLEAN);
            cst.execute();
            
            if (cst.getBoolean(5)) {
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
    public boolean actualizar_destinos(DestinoModel destinos){
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_actualizar_destinos(?,?,?,?,?)}");
            cst.setInt(1, destinos.getInd_destino());
            cst.setString(2, destinos.getDes_destino());
            cst.setString(3, destinos.getDes_observacion());
            cst.setInt(4, destinos.getMon_precio());
            cst.registerOutParameter(5, java.sql.Types.BOOLEAN);
            cst.execute();
            
            if (cst.getBoolean(5)) {
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
    public boolean eliminar_destinos(DestinoModel destinos){
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_eliminar_destinos(?,?)}");
            cst.setInt(1, destinos.getInd_destino());
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
