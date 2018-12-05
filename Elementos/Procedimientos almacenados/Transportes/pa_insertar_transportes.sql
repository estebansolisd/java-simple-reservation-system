DROP PROCEDURE IF EXISTS pa_insertar_transportes
GO
CREATE PROCEDURE pa_insertar_transportes
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
	IF (SELECT count(*) from transporte where ind_transporte = @p_ind_transporte) > 1
	BEGIN
		SET @p_confirmado = 0;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 1;
		INSERT INTO transporte(ind_transporte,tip_transporte,des_origen, des_destino, fec_salida, hor_salida, fec_llegada, hor_llegada, num_plazas, mon_precio) VALUES(@p_ind_transporte, @p_tip_transporte, @p_des_origen, @p_des_destino, @p_fec_salida, @p_hor_salida, @p_fec_llegada, @p_hor_llegada, @p_num_plazas, @p_mon_precio);
	END 
END