/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.sql.Date;

/**
 *
 * @author Usuario-pc
 */
public class ViajeModel {
    private int ind_viaje;
    private int ind_re_viaje;
    private String des_origen;
    private String des_destino;
    private Date fec_salida;
    private Date fec_llegada;
    private int mon_precio;
    
    
    public ViajeModel(){
        
    }
    public ViajeModel(int ind_viaje, int ind_re_viaje, String des_origen, String des_destino, Date fec_salida, Date fec_llegada, int mon_precio){
        this.ind_viaje = ind_viaje;
        this.ind_re_viaje = ind_re_viaje;
        this.des_origen = des_origen;
        this.des_destino = des_destino;
        this.fec_salida = fec_salida;
        this.fec_llegada = fec_llegada;
        this.mon_precio = mon_precio;
    }
    
    /**
     * @return the ind_viaje
     */
    public int getInd_viaje() {
        return ind_viaje;
    }

    /**
     * @param ind_viaje the ind_viaje to set
     */
    public void setInd_viaje(int ind_viaje) {
        this.ind_viaje = ind_viaje;
    }

    /**
     * @return the ind_re_viaje
     */
    public int getInd_re_viaje() {
        return ind_re_viaje;
    }

    /**
     * @param ind_re_viaje the ind_re_viaje to set
     */
    public void setInd_re_viaje(int ind_re_viaje) {
        this.ind_re_viaje = ind_re_viaje;
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
}

