DROP PROCEDURE IF EXISTS pa_insertar_mantenimientos
GO
CREATE PROCEDURE pa_insertar_mantenimientos
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
	IF (SELECT count(*) from mantenimiento where ind_mantenimiento = @p_ind_mantenimiento) > 1
	BEGIN
		SET @p_confirmado = 0;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 1;
		INSERT INTO mantenimiento(ind_mantenimiento,ind_transporte, fec_entrada, fec_salidad, des_mantenimiento, can_mantenimiento, val_mantenimiento) values(@p_ind_mantenimiento, @p_ind_transporte, @p_fec_entrada, @p_fec_salidad, @p_des_mantenimiento, @p_can_mantenimiento, @p_val_mantenimiento);
	END 
END