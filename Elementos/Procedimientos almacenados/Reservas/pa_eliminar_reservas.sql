DROP PROCEDURE IF EXISTS pa_eliminar_reservas
GO
CREATE PROCEDURE pa_eliminar_reservas
@p_ind_re_viaje int,
@p_confirmado bit output
AS
BEGIN
	DELETE FROM reserva_viaje WHERE ind_re_viaje = @p_ind_re_viaje;
	
	IF @@ROWCOUNT > 0
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET @p_confirmado = 0;
	END
END