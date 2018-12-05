DROP PROCEDURE IF EXISTS pa_actualizar_destinos
GO
CREATE PROCEDURE pa_actualizar_destinos
@p_ind_destino int,
@p_des_destino varchar(50),
@p_des_observacion varchar(100),
@p_mon_precio int,
@p_confirmado bit output
AS
BEGIN
	UPDATE destino SET des_destino = @p_des_destino, des_observacion = @p_des_observacion, mon_precio = @p_mon_precio WHERE ind_destino = @p_ind_destino;

	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END


