/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Conexion;
import Model.MantenimientoModel;
import java.sql.CallableStatement;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author Usuario-pc
 */
public class MantenimientoControlador {

    public boolean insertar_mantenimientos(MantenimientoModel mantenimiento) {
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_insertar_mantenimientos(?,?,?,?,?,?,?,?)}");
            cst.setInt(1, mantenimiento.getInd_mantenimiento());
            cst.setInt(2, mantenimiento.getInd_transporte());
            cst.setDate(3, mantenimiento.getFec_entrada());
            cst.setDate(4, mantenimiento.getFec_salidad());
            cst.setString(5, mantenimiento.getDes_mantenimiento());
            cst.setInt(6, mantenimiento.getCan_mantenimiento());
            cst.setInt(7, mantenimiento.getVal_mantenimiento());
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

    public boolean actualizar_mantenimientos(MantenimientoModel mantenimiento) {
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_actualizar_mantenimientos(?,?,?,?,?,?,?,?)}");
            cst.setInt(1, mantenimiento.getInd_mantenimiento());
            cst.setInt(2, mantenimiento.getInd_transporte());
            cst.setDate(3, mantenimiento.getFec_entrada());
            cst.setDate(4, mantenimiento.getFec_salidad());
            cst.setString(5, mantenimiento.getDes_mantenimiento());
            cst.setInt(6, mantenimiento.getCan_mantenimiento());
            cst.setInt(7, mantenimiento.getVal_mantenimiento());
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

    public boolean eliminar_mantenimientos(MantenimientoModel mantenimiento) {
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_eliminar_mantenimientos(?,?)}");
            cst.setInt(1, mantenimiento.getInd_mantenimiento());
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
