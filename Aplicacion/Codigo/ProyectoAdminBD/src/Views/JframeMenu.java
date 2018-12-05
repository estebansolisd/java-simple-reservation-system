/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Views;

import Controller.BitacoraControlador;
import Controller.WinRegistry;
import javax.swing.JOptionPane;

/**
 *
 * @author Usuario-pc
 */
public class JframeMenu extends javax.swing.JFrame {
    BitacoraControlador controlador = new BitacoraControlador();
    /**
     * Creates new form JframeMenu
     */
    public JframeMenu() {
        setExtendedState(java.awt.Frame.MAXIMIZED_BOTH);
        initComponents();
                try {
            if (WinRegistry.readString(WinRegistry.HKEY_CURRENT_USER, "SOFTWARE\\JAVAPROYECTO", "User").equals("jose")) {
                btnBackup.setEnabled(false);
            }
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(rootPane, "Ah ocurrido un error con la verificación del usuario de base de datos.");
        }
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        btnMantenimientoEmpleados = new javax.swing.JButton();
        btnMantenimientoCliente = new javax.swing.JButton();
        btnMantenimientoDestino = new javax.swing.JButton();
        btnMantenimientoTransporte = new javax.swing.JButton();
        btnMantenimientoUsuario = new javax.swing.JButton();
        btnMantenimientoEncomienda = new javax.swing.JButton();
        btnMantenimientoMantenimiento = new javax.swing.JButton();
        btnMantenimientoReserva = new javax.swing.JButton();
        btnMantenimientoViaje = new javax.swing.JButton();
        btnBackup = new javax.swing.JButton();
        jPanel2 = new javax.swing.JPanel();
        lblCerrarSesion = new javax.swing.JLabel();
        lblUsuario = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        lblFondo = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Menu");
        setMinimumSize(new java.awt.Dimension(800, 800));

        jPanel1.setBackground(new java.awt.Color(2, 60, 142));
        jPanel1.setToolTipText("Menu");
        jPanel1.setLayout(new javax.swing.BoxLayout(jPanel1, javax.swing.BoxLayout.Y_AXIS));

        btnMantenimientoEmpleados.setText("Mantenimiento de Empleados");
        btnMantenimientoEmpleados.setMaximumSize(new java.awt.Dimension(400, 70));
        btnMantenimientoEmpleados.setMinimumSize(new java.awt.Dimension(400, 70));
        btnMantenimientoEmpleados.setPreferredSize(new java.awt.Dimension(400, 70));
        btnMantenimientoEmpleados.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnMantenimientoEmpleadosActionPerformed(evt);
            }
        });
        jPanel1.add(btnMantenimientoEmpleados);

        btnMantenimientoCliente.setText("Mantenimiento de Clientes");
        btnMantenimientoCliente.setMaximumSize(new java.awt.Dimension(400, 70));
        btnMantenimientoCliente.setMinimumSize(new java.awt.Dimension(400, 70));
        btnMantenimientoCliente.setPreferredSize(new java.awt.Dimension(400, 70));
        btnMantenimientoCliente.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnMantenimientoClienteActionPerformed(evt);
            }
        });
        jPanel1.add(btnMantenimientoCliente);

        btnMantenimientoDestino.setText("Mantenimiento de Destino");
        btnMantenimientoDestino.setMaximumSize(new java.awt.Dimension(400, 70));
        btnMantenimientoDestino.setMinimumSize(new java.awt.Dimension(400, 70));
        btnMantenimientoDestino.setPreferredSize(new java.awt.Dimension(400, 70));
        btnMantenimientoDestino.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnMantenimientoDestinoActionPerformed(evt);
            }
        });
        jPanel1.add(btnMantenimientoDestino);

        btnMantenimientoTransporte.setText("Mantenimiento de Transporte");
        btnMantenimientoTransporte.setMaximumSize(new java.awt.Dimension(400, 70));
        btnMantenimientoTransporte.setMinimumSize(new java.awt.Dimension(400, 70));
        btnMantenimientoTransporte.setPreferredSize(new java.awt.Dimension(400, 70));
        btnMantenimientoTransporte.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnMantenimientoTransporteActionPerformed(evt);
            }
        });
        jPanel1.add(btnMantenimientoTransporte);

        btnMantenimientoUsuario.setText("Mantenimiento de Usuario");
        btnMantenimientoUsuario.setMaximumSize(new java.awt.Dimension(400, 70));
        btnMantenimientoUsuario.setMinimumSize(new java.awt.Dimension(400, 70));
        btnMantenimientoUsuario.setPreferredSize(new java.awt.Dimension(400, 70));
        btnMantenimientoUsuario.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnMantenimientoUsuarioActionPerformed(evt);
            }
        });
        jPanel1.add(btnMantenimientoUsuario);

        btnMantenimientoEncomienda.setText("Mantenimiento de Encomienda");
        btnMantenimientoEncomienda.setMaximumSize(new java.awt.Dimension(400, 70));
        btnMantenimientoEncomienda.setMinimumSize(new java.awt.Dimension(400, 70));
        btnMantenimientoEncomienda.setPreferredSize(new java.awt.Dimension(400, 70));
        btnMantenimientoEncomienda.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnMantenimientoEncomiendaActionPerformed(evt);
            }
        });
        jPanel1.add(btnMantenimientoEncomienda);

        btnMantenimientoMantenimiento.setText("Mantenimiento de Mantenimiento");
        btnMantenimientoMantenimiento.setMaximumSize(new java.awt.Dimension(400, 70));
        btnMantenimientoMantenimiento.setMinimumSize(new java.awt.Dimension(400, 70));
        btnMantenimientoMantenimiento.setPreferredSize(new java.awt.Dimension(400, 70));
        btnMantenimientoMantenimiento.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnMantenimientoMantenimientoActionPerformed(evt);
            }
        });
        jPanel1.add(btnMantenimientoMantenimiento);

        btnMantenimientoReserva.setText("Mantenimiento de Reserva");
        btnMantenimientoReserva.setMaximumSize(new java.awt.Dimension(400, 70));
        btnMantenimientoReserva.setMinimumSize(new java.awt.Dimension(400, 70));
        btnMantenimientoReserva.setPreferredSize(new java.awt.Dimension(400, 70));
        btnMantenimientoReserva.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnMantenimientoReservaActionPerformed(evt);
            }
        });
        jPanel1.add(btnMantenimientoReserva);

        btnMantenimientoViaje.setText("Mantenimiento de Viaje");
        btnMantenimientoViaje.setMaximumSize(new java.awt.Dimension(400, 70));
        btnMantenimientoViaje.setMinimumSize(new java.awt.Dimension(400, 70));
        btnMantenimientoViaje.setPreferredSize(new java.awt.Dimension(400, 70));
        btnMantenimientoViaje.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnMantenimientoViajeActionPerformed(evt);
            }
        });
        jPanel1.add(btnMantenimientoViaje);

        btnBackup.setText("Realizar Respaldo");
        btnBackup.setMaximumSize(new java.awt.Dimension(400, 70));
        btnBackup.setMinimumSize(new java.awt.Dimension(400, 70));
        btnBackup.setPreferredSize(new java.awt.Dimension(400, 70));
        btnBackup.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnBackupActionPerformed(evt);
            }
        });
        jPanel1.add(btnBackup);

        lblCerrarSesion.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Images/cerrar.png"))); // NOI18N
        lblCerrarSesion.setText(" Cerrar Sesión");
        lblCerrarSesion.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                lblCerrarSesionMouseClicked(evt);
            }
        });

        jLabel2.setText("¡Bienvenido!");

        lblFondo.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Images/world.png"))); // NOI18N

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                .addContainerGap(253, Short.MAX_VALUE)
                .addComponent(lblUsuario)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jLabel2)
                .addGap(87, 87, 87)
                .addComponent(lblCerrarSesion)
                .addContainerGap())
            .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                .addGroup(jPanel2Layout.createSequentialGroup()
                    .addGap(0, 0, Short.MAX_VALUE)
                    .addComponent(lblFondo)
                    .addGap(0, 0, Short.MAX_VALUE)))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(lblCerrarSesion)
                        .addComponent(jLabel2))
                    .addComponent(lblUsuario))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
            .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                .addGroup(jPanel2Layout.createSequentialGroup()
                    .addGap(0, 0, Short.MAX_VALUE)
                    .addComponent(lblFondo)
                    .addGap(0, 0, Short.MAX_VALUE)))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, 562, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void btnMantenimientoEmpleadosActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnMantenimientoEmpleadosActionPerformed
        this.dispose();
        JframeEmpleadosCRUD crudE = new JframeEmpleadosCRUD();
        crudE.setVisible(true);
    }//GEN-LAST:event_btnMantenimientoEmpleadosActionPerformed

    private void btnMantenimientoClienteActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnMantenimientoClienteActionPerformed
        this.dispose();
        JframeClientesCRUD crudC = new JframeClientesCRUD();
        crudC.setVisible(true);    }//GEN-LAST:event_btnMantenimientoClienteActionPerformed

    private void btnMantenimientoDestinoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnMantenimientoDestinoActionPerformed
        this.dispose();
        JframeDestinosCRUD crudD = new JframeDestinosCRUD();
        crudD.setVisible(true);
    }//GEN-LAST:event_btnMantenimientoDestinoActionPerformed

    private void btnMantenimientoTransporteActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnMantenimientoTransporteActionPerformed
        this.dispose();
        JframeTransportesCRUD crudT = new JframeTransportesCRUD();
        crudT.setVisible(true);
    }//GEN-LAST:event_btnMantenimientoTransporteActionPerformed

    private void btnMantenimientoUsuarioActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnMantenimientoUsuarioActionPerformed
        this.dispose();
        JframeUsuariosCRUD crudU = new JframeUsuariosCRUD();
        crudU.setVisible(true);
    }//GEN-LAST:event_btnMantenimientoUsuarioActionPerformed

    private void btnMantenimientoEncomiendaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnMantenimientoEncomiendaActionPerformed
        this.dispose();
        JframeEncomiendaCRUD crudE = new JframeEncomiendaCRUD();
        crudE.setVisible(true);
    }//GEN-LAST:event_btnMantenimientoEncomiendaActionPerformed

    private void btnMantenimientoMantenimientoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnMantenimientoMantenimientoActionPerformed
        this.dispose();
        JframeMantenimientosCRUD crudM = new JframeMantenimientosCRUD();
        crudM.setVisible(true);
    }//GEN-LAST:event_btnMantenimientoMantenimientoActionPerformed

    private void btnMantenimientoReservaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnMantenimientoReservaActionPerformed
        this.dispose();
        JframeReserva_ViajeCRUD crudR = new JframeReserva_ViajeCRUD();
        crudR.setVisible(true);
    }//GEN-LAST:event_btnMantenimientoReservaActionPerformed

    private void btnMantenimientoViajeActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnMantenimientoViajeActionPerformed
        this.dispose();
        JframeViajeCRUD crudV = new JframeViajeCRUD();
        crudV.setVisible(true);
    }//GEN-LAST:event_btnMantenimientoViajeActionPerformed

    private void btnBackupActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnBackupActionPerformed
        if (controlador.realizar_respaldo()) {
            JOptionPane.showMessageDialog(rootPane, "Respaldo realizado correctamente, encontraras el archivo en C:/Nuevo");
        } else {
            JOptionPane.showMessageDialog(rootPane, "Respaldo no realizado");
        }
    }//GEN-LAST:event_btnBackupActionPerformed

    private void lblCerrarSesionMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_lblCerrarSesionMouseClicked
        this.dispose();
        JframeLoginClient login = new JframeLoginClient();
        login.setVisible(true);
    }//GEN-LAST:event_lblCerrarSesionMouseClicked

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(JframeMenu.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(JframeMenu.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(JframeMenu.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(JframeMenu.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            @Override
            public void run() {
                new JframeMenu().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnBackup;
    private javax.swing.JButton btnMantenimientoCliente;
    private javax.swing.JButton btnMantenimientoDestino;
    private javax.swing.JButton btnMantenimientoEmpleados;
    private javax.swing.JButton btnMantenimientoEncomienda;
    private javax.swing.JButton btnMantenimientoMantenimiento;
    private javax.swing.JButton btnMantenimientoReserva;
    private javax.swing.JButton btnMantenimientoTransporte;
    private javax.swing.JButton btnMantenimientoUsuario;
    private javax.swing.JButton btnMantenimientoViaje;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JLabel lblCerrarSesion;
    private javax.swing.JLabel lblFondo;
    private javax.swing.JLabel lblUsuario;
    // End of variables declaration//GEN-END:variables
}
