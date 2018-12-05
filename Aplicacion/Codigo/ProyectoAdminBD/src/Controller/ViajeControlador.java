/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Conexion;
import Model.ViajeModel;
import java.sql.CallableStatement;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author Usuario-pc
 */
public class ViajeControlador {

    public boolean insertar_viajes(ViajeModel viaje) {
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_insertar_viajes(?,?,?,?,?,?,?,?)}");
            cst.setInt(1, viaje.getInd_viaje());
            cst.setInt(2, viaje.getInd_re_viaje());
            cst.setString(3, viaje.getDes_origen());
            cst.setString(4, viaje.getDes_destino());
            cst.setDate(5, viaje.getFec_salida());
            cst.setDate(6, viaje.getFec_llegada());
            cst.setInt(7, viaje.getMon_precio());
            cst.registerOutParameter(8, java.sql.Types.BOOLEAN);
            cst.execute();

            if (cst.getBoolean(8)) {
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

    public boolean actualizar_viajes(ViajeModel viaje) {
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_actualizar_viajes(?,?,?,?,?,?,?,?)}");
            cst.setInt(1, viaje.getInd_viaje());
            cst.setInt(2, viaje.getInd_re_viaje());
            cst.setString(3, viaje.getDes_origen());
            cst.setString(4, viaje.getDes_destino());
            cst.setDate(5, viaje.getFec_salida());
            cst.setDate(6, viaje.getFec_llegada());
            cst.setInt(7, viaje.getMon_precio());
            cst.registerOutParameter(8, java.sql.Types.BOOLEAN);
            cst.execute();

            if (cst.getBoolean(8)) {
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

    public boolean eliminar_viajes(ViajeModel viaje) {
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_eliminar_viajes(?,?)}");
            cst.setInt(1, viaje.getInd_viaje());
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
