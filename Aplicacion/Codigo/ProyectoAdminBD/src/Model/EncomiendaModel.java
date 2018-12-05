/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JComboBox;
import javax.swing.JOptionPane;

/**
 *
 * @author Usuario-pc
 */
public class EncomiendaModel {

    private int ind_encomienda;
    private int ind_transporte;
    private int ind_cliente;
    private int ced_recibe;
    private String nom_recibe;
    private String des_origen;
    private String des_destino;
    private Date fec_salida;
    private Date fec_llegada;
    private int mon_precio;

    public EncomiendaModel() {

    }

    public EncomiendaModel(int ind_encomienda, int ind_transporte, int ind_cliente, int ced_recibe, String nom_recibe, String des_origen, String des_destino, Date fec_salida, Date fec_llegada, int mon_precio) {
        this.ind_encomienda = ind_encomienda;
        this.ind_transporte = ind_transporte;
        this.ind_cliente = ind_cliente;
        this.ced_recibe = ced_recibe;
        this.nom_recibe = nom_recibe;
        this.des_origen = des_origen;
        this.des_destino = des_destino;
        this.fec_salida = fec_salida;
        this.fec_llegada = fec_llegada;
        this.mon_precio = mon_precio;
    }

    /**
     * @return the ind_encomienda
     */
    public int getInd_encomienda() {
        return ind_encomienda;
    }

    /**
     * @param ind_encomienda the ind_encomienda to set
     */
    public void setInd_encomienda(int ind_encomienda) {
        this.ind_encomienda = ind_encomienda;
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
     * @return the ind_cliente
     */
    public int getInd_cliente() {
        return ind_cliente;
    }

    /**
     * @param ind_cliente the ind_cliente to set
     */
    public void setInd_cliente(int ind_cliente) {
        this.ind_cliente = ind_cliente;
    }

    /**
     * @return the ced_recibe
     */
    public int getCed_recibe() {
        return ced_recibe;
    }

    /**
     * @param ced_recibe the ced_recibe to set
     */
    public void setCed_recibe(int ced_recibe) {
        this.ced_recibe = ced_recibe;
    }

    /**
     * @return the nom_recibe
     */
    public String getNom_recibe() {
        return nom_recibe;
    }

    /**
     * @param nom_recibe the nom_recibe to set
     */
    public void setNom_recibe(String nom_recibe) {
        this.nom_recibe = nom_recibe;
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
