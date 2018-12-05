DROP PROCEDURE IF EXISTS pa_actualizar_clientes
GO
CREATE PROCEDURE pa_actualizar_clientes
@p_ind_cliente int,
@p_num_cedula varchar(14),
@p_des_nombre varchar(50),
@p_des_direccion varchar(50),
@p_nom_pais varchar(30),
@p_nom_distrito varchar(30),
@p_nom_canton varchar(30),
@p_num_telefono varchar(8),
@p_des_email varchar(50),
@p_confirmado bit output
AS
BEGIN
	UPDATE cliente SET num_cedula = @p_num_cedula, des_nombre = @p_des_nombre, des_direccion = @p_des_direccion, nom_pais = @p_nom_pais, nom_distrito = @p_nom_distrito, nom_canton = @p_nom_canton, num_telefono = @p_num_telefono, des_email = @p_des_email WHERE ind_cliente = @p_ind_cliente;

	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END