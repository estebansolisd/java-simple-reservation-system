/*
***********¡¡¡¡¡¡¡¡¡IMPORTANTE:Antes de empezar use la BD [MASTER]!!!!!!*************
*/


--Borramos la base de datos si existe.
USE master
GO
DROP DATABASE IF EXISTS agencia_viajes
GO

--Iniciar CMD desde BD.
EXEC sp_configure 'show advanced options', 1;    
RECONFIGURE;   
EXEC sp_configure 'xp_cmdshell', 1;    
RECONFIGURE;


/*
*Eliminamos si existe. De igual manera 
si no lo encuentra arroja "El sistema no puede encontrar el archivo especificado" pero no es ningún
problema.
*/
DECLARE @eliminar NVARCHAR(MAX) =  'xp_cmdshell ''rmdir "C:\Nuevo"''';
EXEC (@eliminar)

--La creamos.    
DECLARE @crear NVARCHAR(MAX) =  'xp_cmdshell ''mkdir "C:\Nuevo"''';
EXEC (@crear)
--Si el resultado es NULL, fue correcta la creación.



--IMPORTANTE: Esta sentencia puede fallar si no posee el espacio suficiente para almacenar 100MB.
--Desde aqui comenzamos a crear nuestra base de datos. Especificando el LOG y el DATA.
CREATE DATABASE agencia_viajes  
ON   
( NAME = agencia_viajes_dat,  
    FILENAME = 'C:\Nuevo\agencia_viajes_dat.mdf',  
    SIZE = 100mb,  
    MAXSIZE = unlimited,  
    FILEGROWTH = 10% )  
LOG ON  
( NAME = agencia_viajes_log,  
    FILENAME = 'C:\Nuevo\agencia_viajes_log.ldf',  
    SIZE = 100MB,  
    MAXSIZE = unlimited,  
    FILEGROWTH = 20% ) ;  
GO
USE agencia_viajes
GO

--De aqui en adelante se crean las tablas.
CREATE TABLE empleados(
	ind_empleado int NOT NULL primary key,
	num_cedula varchar(14) NOT NULL,
	des_nombre varchar(50) NOT NULL,
	tip_cargo varchar(50) NOT NULL,
	des_direccion varchar(100) NOT NULL,
	nom_pais varchar(40) NOT NULL,
	nom_distrito varchar(40) NOT NULL,
	nom_canton varchar(40) NOT NULL,
	num_telefono varchar(8) NOT NULL,
	des_email varchar(50) NOT NULL
);
GO

CREATE TABLE cliente(
	ind_cliente int NOT NULL primary key,
	num_cedula varchar(14) NOT NULL,
	des_nombre varchar(50) NOT NULL,
	des_direccion varchar(50) NOT NULL,
	nom_pais varchar(30) NOT NULL,
	nom_distrito varchar(30) NOT NULL,
	nom_canton varchar(30) NOT NULL,
	num_telefono varchar(8) NOT NULL,
	des_email varchar(50) NOT NULL
);
GO

CREATE TABLE destino(
	ind_destino int NOT NULL primary key,
	des_destino varchar(50) NOT NULL,
	des_observacion varchar(100) NOT NULL,
	mon_precio int NOT NULL
);
GO

CREATE TABLE transporte(
	ind_transporte int NOT NULL primary key,
	tip_transporte varchar(50) NOT NULL,
	des_origen varchar(50) NOT NULL,
	des_destino varchar(50) NOT NULL,
	fec_salida date NOT NULL,
	hor_salida time(7) NOT NULL,
	fec_llegada date NOT NULL,
	hor_llegada time(7) NOT NULL,
	num_plazas int NOT NULL,
	mon_precio int NOT NULL
);
GO

CREATE TABLE usuario(
	ind_usuario int NOT NULL primary key,
	ind_empleado int NOT NULL foreign key references empleados(ind_empleado),
	log_usuario varchar(15) NOT NULL,
	des_clave varchar(50) NOT NULL,
	ind_tipo varchar(30) NOT NULL
);
GO

CREATE TABLE bitacora(
	ind_bitacora int NULL,
	log_usuario varchar(15) NULL,
	tip_movimiento varchar(50) NULL,
	des_datos varchar(30) NULL,
	num_consecutivo varchar(30) NULL,
	fec_bitacora varchar(30) NULL
);
GO


CREATE TABLE encomienda(
	ind_encomienda int NOT NULL primary key,
	ind_transporte int NOT NULL foreign key references transporte(ind_transporte),
	ind_cliente int NOT NULL foreign key references cliente(ind_cliente),
	ced_recibe int NOT NULL,
	nom_recibe varchar(50) NOT NULL,
	des_origen varchar(50) NOT NULL,
	des_destino varchar(50) NOT NULL,
	fec_salida date NULL,
	fec_llegada date NULL,
	mon_precio int NOT NULL
);
GO

CREATE TABLE mantenimiento(
	ind_mantenimiento int NOT NULL primary key,
	ind_transporte int NOT NULL foreign key references transporte(ind_transporte),
	fec_entrada date NULL,
	fec_salidad date NULL,
	des_mantenimiento varchar(100) NOT NULL,
	can_mantenimiento int NOT NULL,
	val_mantenimiento int NOT NULL
);
GO

CREATE TABLE reserva_viaje(
	ind_re_viaje int NOT NULL primary key,
	ind_cliente int NOT NULL foreign key references cliente(ind_cliente),
	ind_empleado int NOT NULL foreign key references empleados(ind_empleado),
	ind_transporte int NOT NULL foreign key references transporte(ind_transporte),
	ind_destino int NOT NULL foreign key references destino(ind_destino),
	fec_inicio date NULL,
	fec_final date NULL,
	for_pago varchar(50) NOT NULL,
	num_plazas int NOT NULL
);
GO

CREATE TABLE viaje(
	ind_viaje int NOT NULL primary key,
	ind_re_viaje int NOT NULL foreign key references reserva_viaje(ind_re_viaje),
	des_origen varchar(50) NOT NULL,
	des_destino varchar(50) NOT NULL,
	fec_salida date NULL,
	fec_llegada date NULL,
	mon_precio int NULL
);
GO


--PROCEDIMIENTOS ALMACENADOS.
--Sección de empleados
--INSERTAR
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
GO

--ACTUALIZAR
CREATE PROCEDURE pa_actualizar_empleados
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
	UPDATE empleados SET num_cedula = @p_num_cedula, des_nombre = @p_des_nombre, tip_cargo = @p_tip_cargo, des_direccion = @p_des_direccion, nom_pais = @p_nom_pais, nom_distrito = @p_nom_distrito, nom_canton = @p_nom_canton, num_telefono = @p_num_telefono, des_email = @p_des_email WHERE ind_empleado = @p_ind_empleado;

	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END
GO

--ELIMINAR
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
GO

--Sección de clientes
--INSERTAR
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
GO

--ACTUALIZAR
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
GO

--ELIMINAR
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
GO

--Sección destino
--INSERTAR
CREATE PROCEDURE pa_insertar_destinos
@p_ind_destino int,
@p_des_destino varchar(50),
@p_des_observacion varchar(100),
@p_mon_precio int,
@p_confirmado bit output
AS
BEGIN
	IF (SELECT count(*) from destino where ind_destino = @p_ind_destino) > 1
	BEGIN
		SET @p_confirmado = 0;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 1;
		INSERT INTO destino(ind_destino,des_destino,des_observacion, mon_precio) VALUES(@p_ind_destino, @p_des_destino, @p_des_observacion, @p_mon_precio);
	END 
END
GO

--Actualizar
CREATE PROCEDURE pa_actualizar_destinos
@p_ind_destino int,
@p_des_destino varchar(50),
@p_des_observacion varchar(100),
@p_mon_precio int,
@p_confirmado bit output
AS
BEGIN
	UPDATE destino SET des_destino = @p_des_destino, des_observacion = @p_des_observacion, mon_precio = @p_mon_precio WHERE ind_destino = @p_ind_destino;

	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END
GO

--Eliminar
CREATE PROCEDURE pa_eliminar_destinos
@p_ind_destino int,
@p_confirmado bit output
AS
BEGIN
	DELETE FROM destino WHERE ind_destino = @p_ind_destino;
	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END
GO
--Sección de transporte
--Insertar
CREATE PROCEDURE pa_insertar_transportes
@p_ind_transporte int,
@p_tip_transporte varchar(50),
@p_des_origen varchar(50),
@p_des_destino varchar(50),
@p_fec_salida date,
@p_hor_salida time(7),
@p_fec_llegada date,
@p_hor_llegada time(7),
@p_num_plazas int,
@p_mon_precio int,
@p_confirmado bit output
AS
BEGIN
	IF (SELECT count(*) from transporte where ind_transporte = @p_ind_transporte) > 1
	BEGIN
		SET @p_confirmado = 0;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 1;
		INSERT INTO transporte(ind_transporte,tip_transporte,des_origen, des_destino, fec_salida, hor_salida, fec_llegada, hor_llegada, num_plazas, mon_precio) VALUES(@p_ind_transporte, @p_tip_transporte, @p_des_origen, @p_des_destino, @p_fec_salida, @p_hor_salida, @p_fec_llegada, @p_hor_llegada, @p_num_plazas, @p_mon_precio);
	END 
END
GO
--Actualizar
CREATE PROCEDURE pa_actualizar_transportes
@p_ind_transporte int,
@p_tip_transporte varchar(50),
@p_des_origen varchar(50),
@p_des_destino varchar(50),
@p_fec_salida date,
@p_hor_salida time(7),
@p_fec_llegada date,
@p_hor_llegada time(7),
@p_num_plazas int,
@p_mon_precio int,
@p_confirmado bit output
AS
BEGIN
	UPDATE transporte SET tip_transporte = @p_tip_transporte, des_origen = @p_des_origen, des_destino = @p_des_destino, fec_salida = @p_fec_salida, hor_salida = @p_hor_salida, fec_llegada = @p_fec_llegada, hor_llegada = @p_hor_llegada, num_plazas = @p_num_plazas, mon_precio = @p_mon_precio WHERE ind_transporte = @p_ind_transporte;

	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END
GO

--Eliminar
CREATE PROCEDURE pa_eliminar_transportes
@p_ind_transporte int,
@p_confirmado bit output
AS
BEGIN
	DELETE FROM transporte WHERE ind_transporte = @p_ind_transporte;

	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END
GO

--Sección de usuarios
--Insertar
CREATE PROCEDURE pa_insertar_usuarios
@p_ind_usuario int,
@p_ind_empleado int,
@p_log_usuario varchar(15),
@p_des_clave varchar(50),
@p_ind_tipo varchar(30),
@p_confirmado bit output
AS
BEGIN
	IF (SELECT count(*) from usuario where ind_usuario = @p_ind_usuario) > 1
	BEGIN
		SET @p_confirmado = 0;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 1;
		INSERT INTO usuario(ind_usuario,ind_empleado,log_usuario, des_clave, ind_tipo) VALUES(@p_ind_usuario, @p_ind_empleado, @p_log_usuario, @p_des_clave, @p_ind_tipo);
	END 
END
GO
--Actualizar
CREATE PROCEDURE pa_actualizar_usuarios
@p_ind_usuario int,
@p_ind_empleado int,
@p_log_usuario varchar(15),
@p_des_clave varchar(50),
@p_ind_tipo varchar(30),
@p_confirmado bit output
AS
BEGIN
	UPDATE usuario SET ind_empleado = @p_ind_empleado ,log_usuario = @p_log_usuario, des_clave = @p_des_clave, ind_tipo  = @p_ind_tipo WHERE ind_usuario = @p_ind_usuario
		IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END
GO

--Eliminar
CREATE PROCEDURE pa_eliminar_usuarios
@p_ind_usuario int,
@p_confirmado bit output
AS
BEGIN
	DELETE FROM usuario WHERE ind_usuario = @p_ind_usuario;
	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END
GO
--verificar
CREATE PROCEDURE pa_verificar_usuario
	@p_log_usuario varchar(15),
	@p_des_clave varchar(50),
	@p_confirmado bit output
as
begin
	if(select count(*) from usuario where log_usuario = @p_log_usuario and des_clave = @p_des_clave) <> 0 
	begin
		set @p_confirmado = 1;
		DECLARE @tip_movimiento varchar(50) = (SELECT 'INICIO DE SESIÓN');
		DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
		DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
		DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
		DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
		DECLARE @log_usuario varchar(15) = (SELECT @p_log_usuario);
		--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

		INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
		VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
	end
	else
	begin
		set @p_confirmado = 0;
	end
end
GO
--Sección de bitacora


--fin de Sección de bitacora



--Sección de encomienda
--Insertar
CREATE PROCEDURE pa_insertar_encomiendas
@p_ind_encomienda int,
@p_ind_transporte int,
@p_ind_cliente int,
@p_ced_recibe int,
@p_nom_recibe varchar(50),
@p_des_origen varchar(50),
@p_des_destino varchar(50),
@p_fec_salida date,
@p_fec_llegada date,
@p_mon_precio int,
@p_confirmado bit output
AS
BEGIN
	IF (SELECT count(*) from transporte where ind_transporte = @p_ind_transporte) > 1
	BEGIN
		SET @p_confirmado = 0;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 1;
		INSERT INTO encomienda(ind_encomienda,ind_transporte, ind_cliente, ced_recibe, nom_recibe, des_origen, des_destino, fec_salida, fec_llegada, mon_precio) VALUES(@p_ind_encomienda, @p_ind_transporte, @p_ind_cliente, @p_ced_recibe, @p_nom_recibe, @p_des_origen, @p_des_destino, @p_fec_salida, @p_fec_llegada, @p_mon_precio);		
	END 
END
GO
--Actualizar
CREATE PROCEDURE pa_actualizar_encomiendas
@p_ind_encomienda int,
@p_ind_transporte int,
@p_ind_cliente int,
@p_ced_recibe int,
@p_nom_recibe varchar(50),
@p_des_origen varchar(50),
@p_des_destino varchar(50),
@p_fec_salida date,
@p_fec_llegada date,
@p_mon_precio int,
@p_confirmado bit output
AS
BEGIN
	UPDATE encomienda set ind_transporte = @p_ind_transporte, ind_cliente = @p_ind_cliente, ced_recibe = @p_ced_recibe, nom_recibe = @p_nom_recibe, des_origen = @p_des_origen, des_destino = @p_des_destino, fec_salida = @p_fec_salida, fec_llegada = @p_fec_llegada, mon_precio = @p_mon_precio where ind_encomienda = @p_ind_encomienda 
	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END
END
GO

--Eliminar
CREATE PROCEDURE pa_eliminar_encomiendas
@p_ind_encomienda int,
@p_confirmado bit output
AS
BEGIN
	DELETE FROM encomienda WHERE ind_encomienda = @p_ind_encomienda;

	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END
GO
--Sección de mantenimientos
--Insertar
CREATE PROCEDURE pa_insertar_mantenimientos
@p_ind_mantenimiento int,
@p_ind_transporte int,
@p_fec_entrada date,
@p_fec_salidad date,
@p_des_mantenimiento varchar(100),
@p_can_mantenimiento int,
@p_val_mantenimiento int,
@p_confirmado bit output
AS
BEGIN
	IF (SELECT count(*) from mantenimiento where ind_mantenimiento = @p_ind_mantenimiento) > 1
	BEGIN
		SET @p_confirmado = 0;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 1;
		INSERT INTO mantenimiento(ind_mantenimiento,ind_transporte, fec_entrada, fec_salidad, des_mantenimiento, can_mantenimiento, val_mantenimiento) values(@p_ind_mantenimiento, @p_ind_transporte, @p_fec_entrada, @p_fec_salidad, @p_des_mantenimiento, @p_can_mantenimiento, @p_val_mantenimiento);
	END 
END
GO
--Actualizar
CREATE PROCEDURE pa_actualizar_mantenimientos
@p_ind_mantenimiento int,
@p_ind_transporte int,
@p_fec_entrada date,
@p_fec_salidad date,
@p_des_mantenimiento varchar(100),
@p_can_mantenimiento int,
@p_val_mantenimiento int,
@p_confirmado bit output
AS
BEGIN
	UPDATE mantenimiento set ind_transporte = @p_ind_transporte, fec_entrada = @p_fec_entrada, fec_salidad = @p_fec_salidad, des_mantenimiento = @p_des_mantenimiento, can_mantenimiento = @p_can_mantenimiento, val_mantenimiento = @p_val_mantenimiento where ind_mantenimiento = @p_ind_mantenimiento;
	IF @@ROWCOUNT > 0 
	BEGIN
		set @p_confirmado = 1;
	END
	ELSE
	BEGIN
		set @p_confirmado = 0;
	END
END
GO
--Eliminar
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
GO
--Sección de reserva_viaje
--Insertar
CREATE PROCEDURE pa_insertar_reservas
@p_ind_re_viaje int,
@p_ind_cliente int,
@p_ind_empleado int,
@p_ind_transporte int,
@p_ind_destino int,
@p_fec_inicio date,
@p_fec_final date,
@p_for_pago varchar(50),
@p_num_plazas int,
@p_confirmado bit output
AS
BEGIN
	IF(SELECT COUNT(*) FROM reserva_viaje WHERE ind_re_viaje = @p_ind_re_viaje) > 0
	BEGIN
		SET @p_confirmado = 0;
	END
	ELSE
	BEGIN
		INSERT INTO reserva_viaje(ind_re_viaje, ind_cliente, ind_empleado, ind_transporte, ind_destino, fec_inicio, fec_final, for_pago, num_plazas)
		VALUES(@p_ind_re_viaje,@p_ind_cliente, @p_ind_empleado, @p_ind_transporte, @p_ind_destino, @p_fec_inicio, @p_fec_final, @p_for_pago, @p_num_plazas);
		SET @p_confirmado = 1;
	END
END
GO

--Actualizar
CREATE PROCEDURE pa_actualizar_reservas
@p_ind_re_viaje int,
@p_ind_cliente int,
@p_ind_empleado int,
@p_ind_transporte int,
@p_ind_destino int,
@p_fec_inicio date,
@p_fec_final date,
@p_for_pago varchar(50),
@p_num_plazas int,
@p_confirmado bit output
AS
BEGIN
	UPDATE reserva_viaje set ind_cliente = @p_ind_cliente, ind_empleado = @p_ind_empleado, ind_transporte = @p_ind_transporte,
	ind_destino = @p_ind_destino, fec_inicio = @p_fec_inicio, fec_final = @p_fec_final, for_pago = @p_for_pago,
	num_plazas = @p_num_plazas
	WHERE ind_re_viaje = @p_ind_re_viaje
	
	IF @@ROWCOUNT > 0
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET @p_confirmado = 0;
	END
END
GO

--Eliminar
CREATE PROCEDURE pa_eliminar_reservas
@p_ind_re_viaje int,
@p_confirmado bit output
AS
BEGIN
	DELETE FROM reserva_viaje WHERE ind_re_viaje = @p_ind_re_viaje;
	
	IF @@ROWCOUNT > 0
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET @p_confirmado = 0;
	END
END
GO
--Sección de viaje
--Insertar
CREATE PROCEDURE pa_insertar_viajes
@p_ind_viaje int,
@p_ind_re_viaje int,
@p_des_origen varchar(50),
@p_des_destino varchar(50),
@p_fec_salida date,
@p_fec_llegada date,
@p_mon_precio int,
@p_confirmado bit output
AS
BEGIN
	IF (SELECT count(*) from viaje where ind_viaje = @p_ind_viaje) > 1
	BEGIN
		SET @p_confirmado = 0;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 1;
		INSERT INTO viaje(ind_viaje,ind_re_viaje,des_origen, des_destino, fec_salida, fec_llegada, mon_precio) VALUES(@p_ind_viaje, @p_ind_re_viaje, @p_des_origen, @p_des_destino, @p_fec_salida, @p_fec_llegada, @p_mon_precio);
	END 
END
GO

--Actualizar
CREATE PROCEDURE pa_actualizar_viajes
@p_ind_viaje int,
@p_ind_re_viaje int,
@p_des_origen varchar(50),
@p_des_destino varchar(50),
@p_fec_salida date,
@p_fec_llegada date,
@p_mon_precio int,
@p_confirmado bit output
AS
BEGIN
	UPDATE viaje SET ind_re_viaje = @p_ind_re_viaje, des_origen = @p_des_origen, des_destino = @p_des_destino, fec_salida = @p_fec_salida, fec_llegada = @p_fec_llegada, mon_precio = @p_mon_precio WHERE ind_viaje = @p_ind_viaje;

	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END
GO

--Eliminar
CREATE PROCEDURE pa_eliminar_viajes
@p_ind_vije int,
@p_confirmado bit output
AS
BEGIN
	DELETE FROM viaje WHERE ind_viaje = @p_ind_vije;

	IF @@ROWCOUNT > 0	
	BEGIN
		SET @p_confirmado = 1;
	END
	ELSE
	BEGIN
		SET  @p_confirmado = 0;
	END 
END
GO

----VISTAS-------

--Empleados
CREATE VIEW v_empleados AS
(
	SELECT * FROM empleados
);
GO

--Clientes

CREATE VIEW v_clientes
AS
(
	SELECT * FROM cliente
);
GO

--Destino
CREATE VIEW v_destinos
AS
(
	SELECT * FROM destino
);
GO

--Transporte
CREATE VIEW v_transportes
AS
(
	SELECT * FROM transporte
);
GO

--Usuario
CREATE VIEW v_usuarios
AS
(
	SELECT ind_usuario, des_nombre, log_usuario, des_clave, ind_tipo  
	FROM empleados inner join usuario on  empleados.ind_empleado = usuario. ind_empleado
);
GO


CREATE VIEW v_usuarioEmpleado
AS
(
	SELECT ind_empleado, des_nombre
	FROM empleados
);
GO

--Encomienda
CREATE VIEW v_encomiendas
AS
(
	SELECT ind_encomienda, tip_transporte, des_nombre, ced_recibe, nom_recibe, encomienda.des_origen, encomienda.des_destino, encomienda.fec_salida, encomienda.fec_llegada, encomienda.mon_precio
	FROM cliente inner join encomienda on cliente.ind_cliente = encomienda.ind_cliente
	inner join transporte on encomienda.ind_transporte = transporte.ind_transporte
);
GO


CREATE VIEW v_encomiendaCliente
AS
(
	SELECT ind_cliente as idCliente, des_nombre as nombreCliente
	FROM cliente
);
GO

CREATE VIEW v_encomiendaTransporte
AS
(
	SELECT ind_transporte as idTransporte, tip_transporte as tipoTransporte
	FROM transporte
);
GO

--Mantenimiento
CREATE VIEW v_mantenimientos
AS
(
	SELECT ind_mantenimiento, transporte.tip_transporte, fec_entrada, fec_salidad, des_mantenimiento, can_mantenimiento, val_mantenimiento
	FROM mantenimiento INNER JOIN transporte ON mantenimiento.ind_transporte = transporte.ind_transporte
);
GO

--Reserva_viaje
CREATE VIEW v_reservas
AS
(
	SELECT r.ind_re_viaje, c.des_nombre "Nombre Cliente", e.des_nombre as "Nombre Empleado", t.tip_transporte, d.des_destino, r.fec_inicio, r.fec_final, r.for_pago, r.num_plazas
	FROM empleados e inner join reserva_viaje r on e.ind_empleado = r.ind_empleado
	inner join destino d on d.ind_destino = r.ind_destino
	inner join cliente c on r.ind_cliente = c.ind_cliente
	inner join transporte t on t.ind_transporte = r.ind_transporte
);
GO

CREATE VIEW v_reservaEmpleado
AS
(
	SELECT ind_empleado, des_nombre "nombreEmpleado"
	FROM empleados
);
GO
	
CREATE VIEW v_reservaDestino
AS
(
	SELECT ind_Destino, des_destino
	FROM Destino
);
GO

--Viajes 
CREATE VIEW v_viajes
AS
(
	SELECT * FROM viaje
);
GO

CREATE VIEW v_viajeReserva
AS
(
	SELECT ind_re_viaje from reserva_viaje
);
GO

--Triggers

--Cliente-bitacora
--**Insertar
CREATE TRIGGER tr_auditoria_cliente_insertar
ON cliente
AFTER INSERT
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'INSERTAR EN CLIENTE');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--**Actualizar.
CREATE TRIGGER tr_auditoria_cliente_actualizar
ON cliente
AFTER UPDATE
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'ACTUALIZAR EN CLIENTE');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--**Eliminar.
CREATE TRIGGER tr_auditoria_cliente_eliminar
ON cliente
AFTER DELETE
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'ELIMINAR EN CLIENTE');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--Empleados-bitacora
--**Insertar
CREATE TRIGGER tr_auditoria_empleados_insertar
ON empleados
AFTER INSERT
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'INSERTAR EN EMPLEADO');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--**Actualizar
CREATE TRIGGER tr_auditoria_empleados_actualizar
ON empleados
AFTER UPDATE
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'ACTUALIZAR EN EMPLEADOS');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--**Eliminar
CREATE TRIGGER tr_auditoria_empleados_eliminar
ON empleados
AFTER DELETE
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'ELIMINAR EN EMPLEADOS');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--DESTINO-BITACORA
--**Insertar
CREATE TRIGGER tr_auditoria_destino_insertar
ON destino
AFTER INSERT
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'INSERTAR EN DESTINO');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--**Actualizar
CREATE TRIGGER tr_auditoria_destino_actualizar
ON destino
AFTER UPDATE
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'ACTUALIZAR EN DESTINO');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--**Eliminar
CREATE TRIGGER tr_auditoria_destino_eliminar
ON destino
AFTER DELETE
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'ELIMINAR EN DESTINO');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--Encomienda-Bitacora
--**Insertar
CREATE TRIGGER tr_auditoria_encomienda_insertar
ON encomienda
AFTER INSERT
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'INSERTAR EN ENCOMIENDA');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--**Actualizar
CREATE TRIGGER tr_auditoria_encomienda_actualizar
ON encomienda
AFTER update
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'ACTUALIZAR EN ENCOMIENDA');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--**Eliminar
CREATE TRIGGER tr_auditoria_encomienda_eliminar
ON encomienda
AFTER DELETE
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'ELIMINAR EN ENCOMIENDA');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--Mantenimiento-Bitacora
--**Insertar
CREATE TRIGGER tr_auditoria_mantenimiento_insertar
ON mantenimiento
AFTER INSERT
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'INSERTAR EN MANTENIMIENTO');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--**Actualizar
CREATE TRIGGER tr_auditoria_mantenimiento_actualizar
ON mantenimiento
AFTER UPDATE
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'ACTUALIZAR EN MANTENIMIENTO');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--**Eliminar
CREATE TRIGGER tr_auditoria_mantenimiento_eliminar
ON mantenimiento
AFTER DELETE
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'ELIMINAR EN MANTENIMIENTO');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--RESERVA-BITACORA
--**Insertar
CREATE TRIGGER tr_auditoria_reserva_insertar
ON reserva_viaje
AFTER INSERT
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'INSERTAR EN RESERVA_VIAJE');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--**Actualizar
CREATE TRIGGER tr_auditoria_reserva_actualizar
ON reserva_viaje
AFTER update
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'ACTUALIZAR EN RESERVA_VIAJE');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--**Eliminar
CREATE TRIGGER tr_auditoria_reserva_eliminar
ON reserva_viaje
AFTER DELETE
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'ELIMINAR EN RESERVA_VIAJE');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--TRANSPORTE-BITACORA
--**Insertar
CREATE TRIGGER tr_auditoria_transporte_insertar
ON transporte
AFTER INSERT
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'INSERTAR EN TRANSPORTE');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--**Actualizar
CREATE TRIGGER tr_auditoria_transporte_actualizar
ON transporte
AFTER UPDATE
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'ACTUALIZAR EN TRANSPORTE');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--**Eliminar
CREATE TRIGGER tr_auditoria_transporte_eliminar
ON transporte
AFTER DELETE
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'ELIMINAR EN TRANSPORTE');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--USUARIO-BITACORA
--**Insertar
CREATE TRIGGER tr_auditoria_usuario_insertar
ON usuario
AFTER INSERT
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'INSERTAR EN USUARIO');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--**Actualizar
CREATE TRIGGER tr_auditoria_usuario_actualizar
ON usuario
AFTER UPDATE
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'ACTUALIZAR EN USUARIO');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--**Eliminar
CREATE TRIGGER tr_auditoria_usuario_eliminar
ON usuario
AFTER DELETE
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'ELIMINAR EN USUARIO');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--Viaje-Bitacora
--**Insertar
CREATE TRIGGER tr_auditoria_viaje_insertar
ON viaje
AFTER INSERT
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'INSERTAR EN VIAJE');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--**Actualizar
CREATE TRIGGER tr_auditoria_viaje_actualizar
ON viaje
AFTER update
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'ACTUALIZAR EN VIAJE');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO

--**ELIMINAR
CREATE TRIGGER tr_auditoria_viaje_eliminar
ON viaje
AFTER DELETE
AS
--PARAMETROS
--DECLARACIONES
DECLARE @tip_movimiento varchar(50) = (SELECT 'ELIMINAR EN VIAJE');
DECLARE @movimiento varchar(max) = (SELECT top 1 dest.text FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC);
DECLARE @ind_bitacora INT = (SELECT ISNULL(MAX(ind_bitacora),0) + 1  from bitacora);
DECLARE @consecutivo varchar(30) = (SELECT 'reg' + cast(ISNULL(max(ind_bitacora),0) + 1  as varchar) from bitacora);
DECLARE @des_datos VARCHAR(30) = (SELECT top 1 LEFT(dest.text,30) FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @fec_bitacora varchar(30) = (SELECT top 1 CAST(deqs.last_execution_time as VARCHAR(30))  FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC)
DECLARE @log_usuario varchar(15) = (SELECT top 1 log_usuario from bitacora order by log_usuario desc);
--SELECT deqs.last_execution_time AS [Time], LEFT(dest.text,15) as Tiempo, dest.* FROM sys.dm_exec_query_stats AS deqs CROSS APPLY sys.dm_exec_sql_text(deqs.sql_handle) AS dest WHERE dest.dbid = DB_ID('agencia_viajes') ORDER BY deqs.last_execution_time DESC

INSERT INTO bitacora(ind_bitacora, log_usuario, tip_movimiento, des_datos, num_consecutivo, fec_bitacora)
VALUES(@ind_bitacora, @log_usuario, @tip_movimiento, @des_datos, @consecutivo, @fec_bitacora);
GO


--Logins BD
/**USUARIO CON TODOS LOS PERMISOS.**/
USE master
IF EXISTS(SELECT * FROM sys.syslogins WHERE name = N'bryan')
BEGIN
	DROP LOGIN bryan
END
GO
CREATE LOGIN bryan WITH PASSWORD=N'123', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
EXEC master..sp_addsrvrolemember @loginame = N'bryan', @rolename = N'sysadmin'
GO

/*USUARIO SOLO CON PERMISO DE SELECT e INSERT EN BITACORA**/
use master
IF EXISTS(SELECT * FROM sys.syslogins WHERE name = N'jose')
BEGIN
	DROP LOGIN jose
END
GO
GO
CREATE LOGIN jose
    WITH PASSWORD = '123';
USE agencia_viajes;
go
CREATE USER josebd FOR LOGIN jose;
GO
GRANT SELECT TO josebd;
GRANT EXECUTE ON OBJECT::pa_verificar_usuario TO josebd;
GRANT INSERT ON OBJECT::bitacora TO josebd 
USE master
GO
GRANT VIEW SERVER STATE TO jose
go
USE agencia_viajes;
GO
--Creación de Procedimiento Almacenado para crear respaldos.
CREATE PROCEDURE pa_respaldo
@p_confirmado bit output
AS
BEGIN
	BACKUP DATABASE agencia_viajes
	TO DISK = 'C:\Nuevo\agencia_viajes.bak'
	with format
	IF (SELECT TOP 1 database_name FROM msdb.dbo.backupset WHERE backup_start_date BETWEEN DATEADD(hh, -24, GETDATE()) AND GETDATE() AND Type = 'D' ORDER BY backup_set_id DESC) <> ''
	BEGIN
		set @p_confirmado = 1;
	END
	ELSE
	BEGIN
		set @p_confirmado = 0;
	END
END
GO

--Datos.
--Las tablas de Empleados y Usuario son fundamentales, ya que con ellas podemos realizar el inicio de sessión.
INSERT empleados (ind_empleado, num_cedula, des_nombre, tip_cargo, des_direccion, nom_pais, nom_distrito, nom_canton, num_telefono, des_email) VALUES (1, '5000000', 'bryan', 'jefe', 'liberia', 'Costa Rica', 'Liberia', 'Liberia', '88888888', 'bryan@gmail.com')
INSERT usuario (ind_usuario, ind_empleado, log_usuario, des_clave, ind_tipo) VALUES (1, 1, 'bryan', '123', 'admin')
INSERT usuario (ind_usuario, ind_empleado, log_usuario, des_clave, ind_tipo) VALUES (2, 1, 'bryan2', '1234', 'admin')
INSERT cliente (ind_cliente, num_cedula, des_nombre, des_direccion, nom_pais, nom_distrito, nom_canton, num_telefono, des_email) VALUES (1, '502550255', 'cristopher', 'belen', 'costa rica', 'carrillo', 'carrillo', '12345678', 'cris@gmail.com')
INSERT destino (ind_destino, des_destino, des_observacion, mon_precio) VALUES (1, 'Liberia', 'viaje sencillo', 3000)
INSERT transporte (ind_transporte, tip_transporte, des_origen, des_destino, fec_salida, hor_salida, fec_llegada, hor_llegada, num_plazas, mon_precio) VALUES (1, 'encomienda', 'nicoya', 'liberia', CAST('2018-12-02' AS Date), CAST('08:00:00' AS Time), CAST('2018-12-05' AS Date), CAST('10:00:00' AS Time), 50, 150000)
INSERT reserva_viaje (ind_re_viaje, ind_cliente, ind_empleado, ind_transporte, ind_destino, fec_inicio, fec_final, for_pago, num_plazas) VALUES (1, 1, 1, 1, 1, CAST('2018-12-02' AS Date), CAST('2018-12-05' AS Date), 'efectivo', 150)
INSERT encomienda (ind_encomienda, ind_transporte, ind_cliente, ced_recibe, nom_recibe, des_origen, des_destino, fec_salida, fec_llegada, mon_precio) VALUES (1, 1, 1, 502220222, 'jose zuñiga', 'nicoya', 'liberia', CAST('2018-12-02' AS Date), CAST('2018-12-05' AS Date), 150000)
INSERT mantenimiento (ind_mantenimiento, ind_transporte, fec_entrada, fec_salidad, des_mantenimiento, can_mantenimiento, val_mantenimiento) VALUES (1, 1, CAST('2018-12-02' AS Date), CAST('2018-12-05' AS Date), 'reparación de vehiculos', 1, 1000)
INSERT viaje (ind_viaje, ind_re_viaje, des_origen, des_destino, fec_salida, fec_llegada, mon_precio) VALUES (1, 1, 'nicoya', 'liberia', CAST('2018-12-02' AS Date), CAST('2018-12-05' AS Date), 150000)



