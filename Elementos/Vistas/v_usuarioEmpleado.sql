DROP VIEW IF EXISTS v_usuarioEmpleado
GO
CREATE VIEW v_usuarioEmpleado
AS
(
	SELECT ind_empleado, des_nombre
	FROM empleados
);