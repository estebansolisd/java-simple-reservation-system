DROP PROCEDURE IF EXISTS pa_insertar_usuarios
GO
CREATE PROCEDURE pa_insertar_usuarios
@p_ind_usuario int,
@p_ind_empleado int,
@p_log_usuario varchar(15),
@p_des_clave varchar(50),
@p_ind_tipo varchar(30),
@p_confirmado bit output
AS
BEGIN
	IF (SELECT count(*) from usuario where ind_usuario = @p_ind_usuario) > 1
	BEGIN
		SET @p_confirmado = 0;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 1;
		INSERT INTO usuario(ind_usuario,ind_empleado,log_usuario, des_clave, ind_tipo) VALUES(@p_ind_usuario, @p_ind_empleado, @p_log_usuario, @p_des_clave, @p_ind_tipo);
	END 
END