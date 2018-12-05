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
public class Reserva_ViajeModel {

    private int ind_re_viaje;
    private int ind_cliente;
    private int ind_empleado;
    private int ind_transporte;
    private int ind_destino;
    private Date fec_inicio;
    private Date fec_final;
    private String for_pago;
    private int num_plazas;

    public Reserva_ViajeModel() {

    }

    public Reserva_ViajeModel(int ind_re_viaje, int ind_cliente, int ind_empleado, int ind_transporte, int ind_destino, Date fec_inicio, Date fec_final, String for_pago, int num_plazas) {
        this.ind_re_viaje = ind_re_viaje;
        this.ind_cliente = ind_cliente;
        this.ind_empleado = ind_empleado;
        this.ind_transporte = ind_transporte;
        this.ind_destino = ind_destino;
        this.fec_inicio = fec_inicio;
        this.fec_final = fec_final;
        this.for_pago = for_pago;
        this.num_plazas = num_plazas;
    }

    /**
     * @return the ind_re_viaje
     */
    public int getInd_Re_viaje() {
        return ind_re_viaje;
    }

    /**
     * @param ind_re_viaje the ind_re_viaje to set
     */
    public void setInd_Re_viaje(int ind_re_viaje) {
        this.ind_re_viaje = ind_re_viaje;
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
     * @return the ind_empleado
     */
    public int getInd_empleado() {
        return ind_empleado;
    }

    /**
     * @param ind_empleado the ind_empleado to set
     */
    public void setInd_empleado(int ind_empleado) {
        this.ind_empleado = ind_empleado;
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
     * @return the fec_inicio
     */
    public Date getFec_inicio() {
        return fec_inicio;
    }

    /**
     * @param fec_inicio the fec_inicio to set
     */
    public void setFec_inicio(Date fec_inicio) {
        this.fec_inicio = fec_inicio;
    }

    /**
     * @return the fec_final
     */
    public Date getFec_final() {
        return fec_final;
    }

    /**
     * @param fec_final the fec_final to set
     */
    public void setFec_final(Date fec_final) {
        this.fec_final = fec_final;
    }

    /**
     * @return the for_pago
     */
    public String getFor_pago() {
        return for_pago;
    }

    /**
     * @param for_pago the for_pago to set
     */
    public void setFor_pago(String for_pago) {
        this.for_pago = for_pago;
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
    
}
