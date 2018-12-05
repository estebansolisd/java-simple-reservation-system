DROP PROCEDURE IF EXISTS pa_eliminar_transportes
GO
CREATE PROCEDURE pa_eliminar_transportes
@p_ind_transporte int,
@p_confirmado bit output
AS
BEGIN
	DELETE FROM transporte WHERE ind_transporte = @p_ind_transporte;

	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END