DROP PROCEDURE IF EXISTS pa_actualizar_transportes
GO
CREATE PROCEDURE pa_actualizar_transportes
@p_ind_transporte int,
@p_tip_transporte varchar(50),
@p_des_origen varchar(50),
@p_des_destino varchar(50),
@p_fec_salida date,
@p_hor_salida time(7),
@p_fec_llegada date,
@p_hor_llegada time(7),
@p_num_plazas int,
@p_mon_precio int,
@p_confirmado bit output
AS
BEGIN
	UPDATE transporte SET tip_transporte = @p_tip_transporte, des_origen = @p_des_origen, des_destino = @p_des_destino, fec_salida = @p_fec_salida, hor_salida = @p_hor_salida, fec_llegada = @p_fec_llegada, hor_llegada = @p_hor_llegada, num_plazas = @p_num_plazas, mon_precio = @p_mon_precio WHERE ind_transporte = @p_ind_transporte;

	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END