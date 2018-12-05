DROP PROCEDURE IF EXISTS pa_insertar_destinos
GO
CREATE PROCEDURE pa_insertar_destinos
@p_ind_destino int,
@p_des_destino varchar(50),
@p_des_observacion varchar(100),
@p_mon_precio int,
@p_confirmado bit output
AS
BEGIN
	IF (SELECT count(*) from destino where ind_destino = @p_ind_destino) > 1
	BEGIN
		SET @p_confirmado = 0;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 1;
		INSERT INTO destino(ind_destino,des_destino,des_observacion, mon_precio) VALUES(@p_ind_destino, @p_des_destino, @p_des_observacion, @p_mon_precio);
	END 
END