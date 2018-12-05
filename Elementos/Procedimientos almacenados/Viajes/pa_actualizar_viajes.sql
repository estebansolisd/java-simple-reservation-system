DROP PROCEDURE IF EXISTS pa_actualizar_viajes
GO
CREATE PROCEDURE pa_actualizar_viajes
@p_ind_viaje int,
@p_ind_re_viaje int,
@p_des_origen varchar(50),
@p_des_destino varchar(50),
@p_fec_salida date,
@p_fec_llegada date,
@p_mon_precio int,
@p_confirmado bit output
AS
BEGIN
	UPDATE viaje SET ind_re_viaje = @p_ind_re_viaje, des_origen = @p_des_origen, des_destino = @p_des_destino, fec_salida = @p_fec_salida, fec_llegada = @p_fec_llegada, mon_precio = @p_mon_precio WHERE ind_viaje = @p_ind_viaje;

	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END




