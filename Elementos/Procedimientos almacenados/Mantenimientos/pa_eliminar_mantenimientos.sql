DROP PROCEDURE IF EXISTS pa_eliminar_mantenimientos
GO
CREATE PROCEDURE pa_eliminar_mantenimientos
@p_ind_mantenimiento int,
@p_confirmado bit output
AS
BEGIN
	DELETE FROM mantenimiento WHERE ind_mantenimiento = @p_ind_mantenimiento;
	IF @@ROWCOUNT > 0 
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET @p_confirmado = 0;
	END
END