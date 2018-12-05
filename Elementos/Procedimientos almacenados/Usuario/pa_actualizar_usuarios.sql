DROP PROCEDURE IF EXISTS pa_actualizar_usuarios
GO
CREATE PROCEDURE pa_actualizar_usuarios
@p_ind_usuario int,
@p_ind_empleado int,
@p_log_usuario varchar(15),
@p_des_clave varchar(50),
@p_ind_tipo varchar(30),
@p_confirmado bit output
AS
BEGIN
	UPDATE usuario SET ind_empleado = @p_ind_empleado ,log_usuario = @p_log_usuario, des_clave = @p_des_clave, ind_tipo  = @p_ind_tipo WHERE ind_usuario = @p_ind_usuario
		IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END