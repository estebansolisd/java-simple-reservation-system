DROP PROCEDURE IF EXISTS pa_actualizar_mantenimientos
GO
CREATE PROCEDURE pa_actualizar_mantenimientos
@p_ind_mantenimiento int,
@p_ind_transporte int,
@p_fec_entrada date,
@p_fec_salidad date,
@p_des_mantenimiento varchar(100),
@p_can_mantenimiento int,
@p_val_mantenimiento int,
@p_confirmado bit output
AS
BEGIN
	UPDATE mantenimiento set ind_transporte = @p_ind_transporte, fec_entrada = @p_fec_entrada, fec_salidad = @p_fec_salidad, des_mantenimiento = @p_des_mantenimiento, can_mantenimiento = @p_can_mantenimiento, val_mantenimiento = @p_val_mantenimiento where ind_mantenimiento = @p_ind_mantenimiento;
	IF @@ROWCOUNT > 0 
	BEGIN
		set @p_confirmado = 1;
	END
	ELSE
	BEGIN
		set @p_confirmado = 0;
	END
END