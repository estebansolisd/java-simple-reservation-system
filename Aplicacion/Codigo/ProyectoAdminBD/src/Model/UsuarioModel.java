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
public class UsuarioModel {
    private int ind_usuario;
    private int ind_empleado;
    private String log_usuario;
    private String des_clave;
    private String ind_tipo;
    private String nombre;
    
    public UsuarioModel(int ind_empleado, String nombre){
        this.ind_empleado = ind_empleado;
        this.nombre = nombre;
    }
    
    public UsuarioModel(){
        
    }
    
    public UsuarioModel(int ind_usuario, int ind_empleado, String log_usuario, String des_clave, String ind_tipo){
        this.ind_usuario = ind_usuario;
        this.ind_empleado = ind_empleado;
        this.log_usuario = log_usuario;
        this.des_clave = des_clave;
        this.ind_tipo = ind_tipo;
    }

    /**
     * @return the ind_usuario
     */
    public int getInd_usuario() {
        return ind_usuario;
    }

    /**
     * @param ind_usuario the ind_usuario to set
     */
    public void setInd_usuario(int ind_usuario) {
        this.ind_usuario = ind_usuario;
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
     * @return the log_usuario
     */
    public String getLog_usuario() {
        return log_usuario;
    }

    /**
     * @param log_usuario the log_usuario to set
     */
    public void setLog_usuario(String log_usuario) {
        this.log_usuario = log_usuario;
    }

    /**
     * @return the des_clave
     */
    public String getDes_clave() {
        return des_clave;
    }

    /**
     * @param des_clave the des_clave to set
     */
    public void setDes_clave(String des_clave) {
        this.des_clave = des_clave;
    }

    /**
     * @return the ind_tipo
     */
    public String getInd_tipo() {
        return ind_tipo;
    }

    /**
     * @param ind_tipo the ind_tipo to set
     */
    public void setInd_tipo(String ind_tipo) {
        this.ind_tipo = ind_tipo;
    }

    /**
     * @return the nombre
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * @param nombre the nombre to set
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    
    
    //Rompe la logica MVC para excepcionar la obtencion de datos al ComboBox
        public void mostrarUsuarios(JComboBox<UsuarioModel> comboUsuario) {
        try {
            Conexion conexion = new Conexion();
            conexion.ejecutarSqlSelect("select * from v_usuarioEmpleado");
            ResultSet rs = conexion.Fetch(); 
            
            while (rs.next()) {
                comboUsuario.addItem(
                        new UsuarioModel(
                                rs.getInt(1),
                                rs.getString(2)
                        )
                );
            }
        } catch (Exception ex) {
            Logger.getLogger(UsuarioModel.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showMessageDialog(null, "Ha ocurrido un error a la hora de seleccionar el nombre del empleado" );
        }
    }
    @Override
    public String toString(){
        return this.nombre;
    }
}
