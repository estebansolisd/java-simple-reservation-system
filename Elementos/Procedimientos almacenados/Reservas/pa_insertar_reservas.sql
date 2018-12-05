DROP PROCEDURE IF EXISTS pa_insertar_reservas
GO
CREATE PROCEDURE pa_insertar_reservas
@p_ind_re_viaje int,
@p_ind_cliente int,
@p_ind_empleado int,
@p_ind_transporte int,
@p_ind_destino int,
@p_fec_inicio date,
@p_fec_final date,
@p_for_pago varchar(50),
@p_num_plazas int,
@p_confirmado bit output
AS
BEGIN
	IF(SELECT COUNT(*) FROM reserva_viaje WHERE ind_re_viaje = @p_ind_re_viaje) > 0
	BEGIN
		SET @p_confirmado = 0;
	END
	ELSE
	BEGIN
		INSERT INTO reserva_viaje(ind_re_viaje, ind_cliente, ind_empleado, ind_transporte, ind_destino, fec_inicio, fec_final, for_pago, num_plazas)
		VALUES(@p_ind_re_viaje,@p_ind_cliente, @p_ind_empleado, @p_ind_transporte, @p_ind_destino, @p_fec_inicio, @p_fec_final, @p_for_pago, @p_num_plazas);
		SET @p_confirmado = 1;
	END
END