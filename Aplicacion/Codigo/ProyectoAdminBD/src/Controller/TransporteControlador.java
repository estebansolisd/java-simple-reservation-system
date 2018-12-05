/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Conexion;
import Model.TransporteModel;
import java.sql.CallableStatement;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author Usuario-pc
 */
public class TransporteControlador {

    public boolean insertar_transportes(TransporteModel transporte) {
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_insertar_transportes(?,?,?,?,?,?,?,?,?,?,?)}");
            cst.setInt(1, transporte.getInd_transporte());
            cst.setString(2, transporte.getTip_transporte());
            cst.setString(3, transporte.getDes_origen());
            cst.setString(4, transporte.getDes_destino());
            cst.setDate(5, transporte.getFec_salida());
            cst.setTime(6, transporte.getHor_salida());
            cst.setDate(7, transporte.getFec_llegada());
            cst.setTime(8, transporte.getHor_llegada());
            cst.setInt(9, transporte.getNum_plazas());
            cst.setInt(10, transporte.getMon_precio());
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

    public boolean actualizar_transportes(TransporteModel transporte) {
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_actualizar_transportes(?,?,?,?,?,?,?,?,?,?,?)}");
            cst.setInt(1, transporte.getInd_transporte());
            cst.setString(2, transporte.getTip_transporte());
            cst.setString(3, transporte.getDes_origen());
            cst.setString(4, transporte.getDes_destino());
            cst.setDate(5, transporte.getFec_salida());
            cst.setTime(6, transporte.getHor_salida());
            cst.setDate(7, transporte.getFec_llegada());
            cst.setTime(8, transporte.getHor_llegada());
            cst.setInt(9, transporte.getNum_plazas());
            cst.setInt(10, transporte.getMon_precio());
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

    public boolean eliminar_transportes(TransporteModel transporte) {
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_eliminar_transportes(?,?)}");
            cst.setInt(1, transporte.getInd_transporte());
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
