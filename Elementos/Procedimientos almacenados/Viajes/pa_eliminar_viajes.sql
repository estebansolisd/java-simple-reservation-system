DROP PROCEDURE IF EXISTS pa_eliminar_viajes
GO
CREATE PROCEDURE pa_eliminar_viajes
@p_ind_vije int,
@p_confirmado bit output
AS
BEGIN
	DELETE FROM viaje WHERE ind_viaje = @p_ind_vije;

	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN_
		SET  @p_confirmado = 0;
	END 
END