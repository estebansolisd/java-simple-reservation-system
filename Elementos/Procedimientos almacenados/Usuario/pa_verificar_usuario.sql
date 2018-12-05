CREATE PROCEDURE pa_verificar_usuario
	@p_log_usuario varchar(15),
	@p_des_clave varchar(50),
	@p_confirmado bit output
as
begin
	if(select count(*) from usuario where log_usuario = @p_log_usuario and des_clave = @p_des_clave) <> 0 
	begin
		set @p_confirmado = 1;
	end
	else
	begin
		set @p_confirmado = 0;
	end
end