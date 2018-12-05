DROP PROCEDURE IF EXISTS pa_insertar_encomiendas
GO
CREATE PROCEDURE pa_insertar_encomiendas
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
	IF (SELECT count(*) from transporte where ind_transporte = @p_ind_transporte) > 1
	BEGIN
		SET @p_confirmado = 0;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 1;
		INSERT INTO encomienda(ind_encomienda,ind_transporte, ind_cliente, ced_recibe, nom_recibe, des_origen, des_destino, fec_salida, fec_llegada, mon_precio) VALUES(@p_ind_encomienda, @p_ind_transporte, @p_ind_cliente, @p_ced_recibe, @p_nom_recibe, @p_des_origen, @p_des_destino, @p_fec_salida, @p_fec_llegada, @p_mon_precio);		
	END 
END