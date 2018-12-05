/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Time;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JComboBox;
import javax.swing.JOptionPane;

/**
 *
 * @author Usuario-pc
 */
public class TransporteModel {

    private int ind_transporte;
    private String tip_transporte;
    private String des_origen;
    private String des_destino;
    private Date fec_salida;
    private Time hor_salida;
    private Date fec_llegada;
    private Time hor_llegada;
    private int num_plazas;
    private int mon_precio;

    public TransporteModel() {

    }
    
    public TransporteModel(int ind_transporte, String tip_transporte) {
        this.ind_transporte = ind_transporte;
        this.tip_transporte = tip_transporte;
    }

    public TransporteModel(int ind_transporte, String tip_transporte, String des_origen, String des_destino, Date fec_salida, Time hor_salida, Date fec_llegada, Time hor_llegada, int num_plazas, int mon_precio) {
        this.ind_transporte = ind_transporte;
        this.tip_transporte = tip_transporte;
        this.des_origen = des_origen;
        this.des_destino = des_destino;
        this.fec_salida = fec_salida;
        this.hor_salida = hor_salida;
        this.fec_llegada = fec_llegada;
        this.hor_llegada = hor_llegada;
        this.num_plazas = num_plazas;
        this.mon_precio = mon_precio;
    }

    /**
     * @return the ind_transporte
     */
    public int getInd_transporte() {
        return ind_transporte;
    }

    /**
     * @param ind_transporte the ind_transporte to set
     */
    public void setInd_transporte(int ind_transporte) {
        this.ind_transporte = ind_transporte;
    }

    /**
     * @return the tip_transporte
     */
    public String getTip_transporte() {
        return tip_transporte;
    }

    /**
     * @param tip_transporte the tip_transporte to set
     */
    public void setTip_transporte(String tip_transporte) {
        this.tip_transporte = tip_transporte;
    }

    /**
     * @return the des_origen
     */
    public String getDes_origen() {
        return des_origen;
    }

    /**
     * @param des_origen the des_origen to set
     */
    public void setDes_origen(String des_origen) {
        this.des_origen = des_origen;
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
     * @return the fec_salida
     */
    public Date getFec_salida() {
        return fec_salida;
    }

    /**
     * @param fec_salida the fec_salida to set
     */
    public void setFec_salida(Date fec_salida) {
        this.fec_salida = fec_salida;
    }

    /**
     * @return the hor_salida
     */
    public Time getHor_salida() {
        return hor_salida;
    }

    /**
     * @param hor_salida the hor_salida to set
     */
    public void setHor_salida(Time hor_salida) {
        this.hor_salida = hor_salida;
    }

    /**
     * @return the fec_llegada
     */
    public Date getFec_llegada() {
        return fec_llegada;
    }

    /**
     * @param fec_llegada the fec_llegada to set
     */
    public void setFec_llegada(Date fec_llegada) {
        this.fec_llegada = fec_llegada;
    }

    /**
     * @return the hor_llegada
     */
    public Time getHor_llegada() {
        return hor_llegada;
    }

    /**
     * @param hor_llegada the hor_llegada to set
     */
    public void setHor_llegada(Time hor_llegada) {
        this.hor_llegada = hor_llegada;
    }

    /**
     * @return the num_plazas
     */
    public int getNum_plazas() {
        return num_plazas;
    }

    /**
     * @param num_plazas the num_plazas to set
     */
    public void setNum_plazas(int num_plazas) {
        this.num_plazas = num_plazas;
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

    public void mostrarCombo(JComboBox<TransporteModel> comboTransporte) {
        try {
            Conexion conexion = new Conexion();
            conexion.ejecutarSqlSelect("select * from v_encomiendaTransporte");
            ResultSet rs = conexion.Fetch();
            while (rs.next()) {
                comboTransporte.addItem(
                        new TransporteModel(
                                rs.getInt(1),
                                rs.getString(2)
                        )
                );
            }
            rs.close();
        } catch (Exception ex) {
            Logger.getLogger(TransporteModel.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showMessageDialog(null, "Ha ocurrido un error a la hora de seleccionar el tipo de transporte");
        }
    }
    
    
    @Override
    public String toString() {
        return this.tip_transporte;
    }

}
