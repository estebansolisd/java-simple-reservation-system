DROP PROCEDURE IF EXISTS pa_actualizar_encomiendas
GO
CREATE PROCEDURE pa_actualizar_encomiendas
@p_ind_encomienda int,
@p_ind_transporte int,
@p_ind_cliente int,
@p_ced_recibe int,
@p_nom_recibe varchar(50),
@p_des_origen varchar(50),
@p_des_destino varchar(50),
@p_fec_salida date,
@p_fec_llegada date,
@p_mon_precio int,
@p_confirmado bit output
AS
BEGIN
	UPDATE encomienda set ind_transporte = @p_ind_transporte, ind_cliente = @p_ind_cliente, ced_recibe = @p_ced_recibe, nom_recibe = @p_nom_recibe, des_origen = @p_des_origen, des_destino = @p_des_destino, fec_salida = @p_fec_salida, fec_llegada = @p_fec_llegada, mon_precio = @p_mon_precio where ind_encomienda = @p_ind_encomienda 
	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END
END