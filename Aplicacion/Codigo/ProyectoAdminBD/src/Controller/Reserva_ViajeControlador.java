/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Conexion;
import Model.Reserva_ViajeModel;
import java.sql.CallableStatement;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author Usuario-pc
 */
public class Reserva_ViajeControlador {

    public boolean insertar_reservas(Reserva_ViajeModel reserva) {
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_insertar_reservas(?,?,?,?,?,?,?,?,?,?)}");
            cst.setInt(1, reserva.getInd_Re_viaje());
            cst.setInt(2, reserva.getInd_cliente());
            cst.setInt(3, reserva.getInd_empleado());
            cst.setInt(4, reserva.getInd_transporte());
            cst.setInt(5, reserva.getInd_destino());
            cst.setDate(6, reserva.getFec_inicio());
            cst.setDate(7, reserva.getFec_final());
            cst.setString(8, reserva.getFor_pago());
            cst.setInt(9, reserva.getNum_plazas());
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

    public boolean actualizar_reservas(Reserva_ViajeModel reserva) {
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_actualizar_reservas(?,?,?,?,?,?,?,?,?,?)}");
            cst.setInt(1, reserva.getInd_Re_viaje());
            cst.setInt(2, reserva.getInd_cliente());
            cst.setInt(3, reserva.getInd_empleado());
            cst.setInt(4, reserva.getInd_transporte());
            cst.setInt(5, reserva.getInd_destino());
            cst.setDate(6, reserva.getFec_inicio());
            cst.setDate(7, reserva.getFec_final());
            cst.setString(8, reserva.getFor_pago());
            cst.setInt(9, reserva.getNum_plazas());
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

    public boolean eliminar_reservas(Reserva_ViajeModel reserva) {
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_eliminar_reservas(?,?)}");
            cst.setInt(1, reserva.getInd_Re_viaje());
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
