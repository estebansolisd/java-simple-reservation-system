/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JComboBox;
import javax.swing.JOptionPane;

/**
 *
 * @author Usuario-pc
 */
public class DestinoModel {
    private int ind_destino;
    private String des_destino;
    private String des_observacion;
    private int mon_precio;
    
    public DestinoModel(){
        
    }
    
    public DestinoModel(int ind_destino, String des_destino, String des_observacion, int mon_precio){
        this.ind_destino = ind_destino;
        this.des_destino = des_destino;
        this.des_observacion = des_observacion;
        this.mon_precio = mon_precio;
    }
    
    public DestinoModel(int ind_destino, String des_destino){
        this.ind_destino = ind_destino;
        this.des_destino = des_destino;
        
    }

    /**
     * @return the ind_destino
     */
    public int getInd_destino() {
        return ind_destino;
    }

    /**
     * @param ind_destino the ind_destino to set
     */
    public void setInd_destino(int ind_destino) {
        this.ind_destino = ind_destino;
    }

    /**
     * @return the des_destino
     */
    public String getDes_destino() {
        return des_destino;
    }

    /**
     * @param des_destino the des_destino to set
     */
    public void setDes_destino(String des_destino) {
        this.des_destino = des_destino;
    }

    /**
     * @return the des_observacion
     */
    public String getDes_observacion() {
        return des_observacion;
    }

    /**
     * @param des_observacion the des_observacion to set
     */
    public void setDes_observacion(String des_observacion) {
        this.des_observacion = des_observacion;
    }

    /**
     * @return the mon_precio
     */
    public int getMon_precio() {
        return mon_precio;
    }

    /**
     * @param mon_precio the mon_precio to set
     */
    public void setMon_precio(int mon_precio) {
        this.mon_precio = mon_precio;
    }
    public void mostrarCombo(JComboBox<DestinoModel> comboDestino) {
        try {
            Conexion conexion = new Conexion();
            conexion.ejecutarSqlSelect("select * from v_reservaDestino");
            ResultSet rs = conexion.Fetch();

            while (rs.next()) {
                comboDestino.addItem(
                        new DestinoModel(
                                rs.getInt(1),
                                rs.getString(2)
                        )
                );
            }
            rs.close();
        } catch (Exception ex) {
            Logger.getLogger(DestinoModel.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showMessageDialog(null, "Ha ocurrido un error a la hora de seleccion un nombre de destino");
        }
    }

    @Override
    public String toString() {
        return this.des_destino;
    }
    
}
