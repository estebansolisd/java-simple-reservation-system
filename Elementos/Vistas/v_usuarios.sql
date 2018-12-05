DROP VIEW IF EXISTS v_usuarios
GO
CREATE VIEW v_usuarios
AS
(
	SELECT ind_usuario, des_nombre, log_usuario, des_clave, ind_tipo  
	FROM empleados inner join usuario on  empleados.ind_empleado = usuario. ind_empleado
);