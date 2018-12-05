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
public class MantenimientoModel {
    private int ind_mantenimiento;
    private int ind_transporte;
    private Date fec_entrada;
    private Date fec_salidad;
    private String des_mantenimiento;
    private int can_mantenimiento;
    private int val_mantenimiento;
    
    public MantenimientoModel(){
        
    }
    public MantenimientoModel(int ind_mantenimiento, int ind_transporte, Date fec_entrada, Date fec_salidad, String des_mantenimiento, int can_mantenimiento, int val_mantenimiento){
        this.ind_mantenimiento = ind_mantenimiento;
        this.ind_transporte = ind_transporte;
        this.fec_entrada = fec_entrada;
        this.fec_salidad = fec_salidad;
        this.des_mantenimiento = des_mantenimiento;
        this.val_mantenimiento = val_mantenimiento;
    }

    /**
     * @return the ind_mantenimiento
     */
    public int getInd_mantenimiento() {
        return ind_mantenimiento;
    }

    /**
     * @param ind_mantenimiento the ind_mantenimiento to set
     */
    public void setInd_mantenimiento(int ind_mantenimiento) {
        this.ind_mantenimiento = ind_mantenimiento;
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
     * @return the fec_entrada
     */
    public Date getFec_entrada() {
        return fec_entrada;
    }

    /**
     * @param fec_entrada the fec_entrada to set
     */
    public void setFec_entrada(Date fec_entrada) {
        this.fec_entrada = fec_entrada;
    }

    /**
     * @return the fec_salidad
     */
    public Date getFec_salidad() {
        return fec_salidad;
    }

    /**
     * @param fec_salidad the fec_salidad to set
     */
    public void setFec_salidad(Date fec_salidad) {
        this.fec_salidad = fec_salidad;
    }

    /**
     * @return the des_mantenimiento
     */
    public String getDes_mantenimiento() {
        return des_mantenimiento;
    }

    /**
     * @param des_mantenimiento the des_mantenimiento to set
     */
    public void setDes_mantenimiento(String des_mantenimiento) {
        this.des_mantenimiento = des_mantenimiento;
    }

    /**
     * @return the can_mantenimiento
     */
    public int getCan_mantenimiento() {
        return can_mantenimiento;
    }

    /**
     * @param can_mantenimiento the can_mantenimiento to set
     */
    public void setCan_mantenimiento(int can_mantenimiento) {
        this.can_mantenimiento = can_mantenimiento;
    }

    /**
     * @return the val_mantenimiento
     */
    public int getVal_mantenimiento() {
        return val_mantenimiento;
    }

    /**
     * @param val_mantenimiento the val_mantenimiento to set
     */
    public void setVal_mantenimiento(int val_mantenimiento) {
        this.val_mantenimiento = val_mantenimiento;
    }
}
