DROP PROCEDURE IF EXISTS pa_eliminar_destinos
GO
CREATE PROCEDURE pa_eliminar_destinos
@p_ind_destino int,
@p_confirmado bit output
AS
BEGIN
	DELETE FROM destino WHERE ind_destino = @p_ind_destino;
	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END