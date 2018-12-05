DROP VIEW IF EXISTS v_reservaEmpleado
GO
CREATE VIEW v_reservaEmpleado
AS
(
	SELECT ind_empleado, des_nombre "nombreEmpleado"
	FROM empleados
);