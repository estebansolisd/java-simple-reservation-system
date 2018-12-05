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
public class EmpleadosModel {
    private int ind_empleado;
    private String num_cedula;
    private String des_nombre;
    private String tip_cargo;
    private String des_direccion;
    private String nom_pais;
    private String nom_distrito;
    private String nom_canton;
    private String num_telefono;
    private String des_email;
    
    public EmpleadosModel(){
        
    }
    public EmpleadosModel(int ind_empleado, String num_cedula, String des_nombre, String tip_cargo, String des_direccion, String nom_pais, String nom_distrito, String nom_canton, String num_telefono, String des_email){
        this.ind_empleado = ind_empleado;
        this.num_cedula = num_cedula;
        this.des_nombre = des_nombre;
        this.tip_cargo = tip_cargo;
        this.des_direccion = des_direccion;
        this.nom_pais = nom_pais;
        this.nom_distrito = nom_distrito;
        this.nom_canton = nom_canton;
        this.num_telefono = num_telefono;
        this.des_email = des_email;
    }
    public EmpleadosModel(int ind_empleado, String des_nombre){
        this.ind_empleado = ind_empleado;
        this.des_nombre = des_nombre;
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
     * @return the num_cedula
     */
    public String getNum_cedula() {
        return num_cedula;
    }

    /**
     * @param num_cedula the num_cedula to set
     */
    public void setNum_cedula(String num_cedula) {
        this.num_cedula = num_cedula;
    }

    /**
     * @return the des_nombre
     */
    public String getDes_nombre() {
        return des_nombre;
    }

    /**
     * @param des_nombre the des_nombre to set
     */
    public void setDes_nombre(String des_nombre) {
        this.des_nombre = des_nombre;
    }

    /**
     * @return the tip_cargo
     */
    public String getTip_cargo() {
        return tip_cargo;
    }

    /**
     * @param tip_cargo the tip_cargo to set
     */
    public void setTip_cargo(String tip_cargo) {
        this.tip_cargo = tip_cargo;
    }

    /**
     * @return the des_direccion
     */
    public String getDes_direccion() {
        return des_direccion;
    }

    /**
     * @param des_direccion the des_direccion to set
     */
    public void setDes_direccion(String des_direccion) {
        this.des_direccion = des_direccion;
    }

    /**
     * @return the nom_pais
     */
    public String getNom_pais() {
        return nom_pais;
    }

    /**
     * @param nom_pais the nom_pais to set
     */
    public void setNom_pais(String nom_pais) {
        this.nom_pais = nom_pais;
    }

    /**
     * @return the nom_distrito
     */
    public String getNom_distrito() {
        return nom_distrito;
    }

    /**
     * @param nom_distrito the nom_distrito to set
     */
    public void setNom_distrito(String nom_distrito) {
        this.nom_distrito = nom_distrito;
    }

    /**
     * @return the nom_canton
     */
    public String getNom_canton() {
        return nom_canton;
    }

    /**
     * @param nom_canton the nom_canton to set
     */
    public void setNom_canton(String nom_canton) {
        this.nom_canton = nom_canton;
    }

    /**
     * @return the num_telefono
     */
    public String getNum_telefono() {
        return num_telefono;
    }

    /**
     * @param num_telefono the num_telefono to set
     */
    public void setNum_telefono(String num_telefono) {
        this.num_telefono = num_telefono;
    }

    /**
     * @return the des_email
     */
    public String getDes_email() {
        return des_email;
    }

    /**
     * @param des_email the des_email to set
     */
    public void setDes_email(String des_email) {
        this.des_email = des_email;
    }
    public void mostrarCombo(JComboBox<EmpleadosModel> comboEmpleado) {
        try {
            Conexion conexion = new Conexion();
            conexion.ejecutarSqlSelect("select * from v_reservaEmpleado");
            ResultSet rs = conexion.Fetch();

            while (rs.next()) {
                comboEmpleado.addItem(
                        new EmpleadosModel(
                                rs.getInt(1),
                                rs.getString(2)
                        )
                );
            }
            rs.close();
        } catch (Exception ex) {
            Logger.getLogger(EmpleadosModel.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showMessageDialog(null, "Ha ocurrido un error a la hora de seleccion un nombre de empleado");
        }
    }

    @Override
    public String toString() {
        return this.des_nombre;
    }
}
