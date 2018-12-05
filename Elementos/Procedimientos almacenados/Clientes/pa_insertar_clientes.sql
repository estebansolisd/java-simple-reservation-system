DROP PROCEDURE IF EXISTS pa_insertar_clientes
GO
CREATE PROCEDURE pa_insertar_clientes
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
	IF (SELECT count(*) from cliente where ind_cliente = @p_ind_cliente) > 1
	BEGIN
		SET @p_confirmado = 0;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 1;
		INSERT INTO cliente(ind_cliente,num_cedula,des_nombre, des_direccion, nom_pais, nom_distrito, nom_canton, num_telefono, des_email) VALUES(@p_ind_cliente, @p_num_cedula, @p_des_nombre, @p_des_direccion, @p_nom_pais, @p_nom_distrito, @p_nom_canton, @p_num_telefono, @p_des_email);
	END 
END