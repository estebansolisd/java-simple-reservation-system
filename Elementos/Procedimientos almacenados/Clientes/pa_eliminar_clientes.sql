DROP PROCEDURE IF EXISTS pa_eliminar_clientes
GO
CREATE PROCEDURE pa_eliminar_clientes
@p_ind_cliente int,
@p_confirmado bit output
AS
BEGIN
	DELETE FROM cliente WHERE ind_cliente = @p_ind_cliente;

	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END