DROP VIEW IF EXISTS v_encomiendaCliente
GO
CREATE VIEW v_encomiendaCliente
AS
(
	SELECT ind_cliente as idCliente, des_nombre as nombreCliente
	FROM cliente
);