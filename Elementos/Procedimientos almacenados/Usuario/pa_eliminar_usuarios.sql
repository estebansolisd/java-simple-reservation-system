DROP PROCEDURE IF EXISTS pa_eliminar_usuarios
GO
CREATE PROCEDURE pa_eliminar_usuarios
@p_ind_usuario int,
@p_confirmado bit output
AS
BEGIN
	DELETE FROM usuario WHERE ind_usuario = @p_ind_usuario;
	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END