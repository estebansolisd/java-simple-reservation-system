/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Conexion;
import Model.EncomiendaModel;
import java.sql.CallableStatement;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author Usuario-pc
 */
public class EncomiendaControlador {

    public boolean insertar_encomiendas(EncomiendaModel encomienda) {
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_insertar_encomiendas(?,?,?,?,?,?,?,?,?,?,?)}");
            cst.setInt(1, encomienda.getInd_encomienda());
            cst.setInt(2, encomienda.getInd_transporte());
            cst.setInt(3, encomienda.getInd_cliente());
            cst.setInt(4, encomienda.getCed_recibe());
            cst.setString(5, encomienda.getNom_recibe());
            cst.setString(6, encomienda.getDes_origen());
            cst.setString(7, encomienda.getDes_destino());
            cst.setDate(8, encomienda.getFec_salida());
            cst.setDate(9, encomienda.getFec_llegada());
            cst.setInt(10, encomienda.getMon_precio());
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

    public boolean actualizar_encomiendas(EncomiendaModel encomienda) {
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_actualizar_encomiendas(?,?,?,?,?,?,?,?,?,?,?)}");
            cst.setInt(1, encomienda.getInd_encomienda());
            cst.setInt(2, encomienda.getInd_transporte());
            cst.setInt(3, encomienda.getInd_cliente());
            cst.setInt(4, encomienda.getCed_recibe());
            cst.setString(5, encomienda.getNom_recibe());
            cst.setString(6, encomienda.getDes_origen());
            cst.setString(7, encomienda.getDes_destino());
            cst.setDate(8, encomienda.getFec_salida());
            cst.setDate(9, encomienda.getFec_llegada());
            cst.setInt(10, encomienda.getMon_precio());
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

    public boolean eliminar_encomiendas(EncomiendaModel encomienda) {
        Conexion conexion = new Conexion();
        try {
            conexion.conectar();
            CallableStatement cst = conexion.getConexion().prepareCall("{ call pa_eliminar_encomiendas(?,?)}");
            cst.setInt(1, encomienda.getInd_encomienda());
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
