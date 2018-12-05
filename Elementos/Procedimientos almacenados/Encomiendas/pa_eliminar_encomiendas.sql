DROP PROCEDURE IF EXISTS pa_eliminar_encomiendas
GO
CREATE PROCEDURE pa_eliminar_encomiendas
@p_ind_encomienda int,
@p_confirmado bit output
AS
BEGIN
	DELETE FROM encomienda WHERE ind_encomienda = @p_ind_encomienda;

	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END