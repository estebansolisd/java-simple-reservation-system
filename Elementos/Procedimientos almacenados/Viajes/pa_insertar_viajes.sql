DROP PROCEDURE IF EXISTS pa_insertar_viajes
GO
CREATE PROCEDURE pa_insertar_viajes
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
	IF (SELECT count(*) from viaje where ind_viaje = @p_ind_viaje) > 1
	BEGIN
		SET @p_confirmado = 0;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 1;
		INSERT INTO viaje(ind_viaje,ind_re_viaje,des_origen, des_destino, fec_salida, fec_llegada, mon_precio) VALUES(@p_ind_viaje, @p_ind_re_viaje, @p_des_origen, @p_des_destino, @p_fec_salida, @p_fec_llegada, @p_mon_precio);
	END 
END