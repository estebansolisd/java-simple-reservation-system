DROP PROCEDURE IF EXISTS pa_actualizar_reservas
GO
CREATE PROCEDURE pa_actualizar_reservas
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
	UPDATE reserva_viaje set ind_cliente = @p_ind_cliente, ind_empleado = @p_ind_empleado, ind_transporte = @p_ind_transporte,
	ind_destino = @p_ind_destino, fec_inicio = @p_fec_inicio, fec_final = @p_fec_final, for_pago = @p_for_pago,
	num_plazas = @p_num_plazas
	WHERE ind_re_viaje = @p_ind_re_viaje
	
	IF @@ROWCOUNT > 0
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET @p_confirmado = 0;
	END
END