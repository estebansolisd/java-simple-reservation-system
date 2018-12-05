CREATE PROCEDURE pa_eliminar_empleados
@p_ind_empleado int,
@p_confirmado bit output
AS
BEGIN
	DELETE FROM empleados WHERE ind_empleado = @p_ind_empleado;

	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END