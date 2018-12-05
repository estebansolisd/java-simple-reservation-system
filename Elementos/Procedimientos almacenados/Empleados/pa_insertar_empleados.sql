DROP PROCEDURE IF EXISTS pa_insertar_empleados
GO
CREATE PROCEDURE pa_insertar_empleados
@p_ind_empleado int,
@p_num_cedula varchar(14),
@p_des_nombre varchar(50),
@p_tip_cargo varchar(50),
@p_des_direccion varchar(100),
@p_nom_pais varchar(40),
@p_nom_distrito varchar(40),
@p_nom_canton varchar(40),
@p_num_telefono varchar(8),
@p_des_email varchar(50),
@p_confirmado bit output
AS
BEGIN
	IF (SELECT count(*) from empleados where ind_empleado = @p_ind_empleado) > 1
	BEGIN
		SET @p_confirmado = 0;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 1;
		INSERT INTO empleados(ind_empleado,num_cedula,des_nombre, tip_cargo, des_direccion, nom_pais, nom_distrito, nom_canton, num_telefono, des_email) VALUES(@p_ind_empleado, @p_num_cedula, @p_des_nombre, @p_tip_cargo, @p_des_direccion, @p_nom_pais, @p_nom_distrito, @p_nom_canton, @p_num_telefono, @p_des_email);
	END 
END