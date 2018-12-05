DROP VIEW IF EXISTS v_encomiendas
GO
CREATE VIEW v_encomiendas
AS
(
	SELECT ind_encomienda, tip_transporte, des_nombre, ced_recibe, nom_recibe, encomienda.des_origen, encomienda.des_destino, encomienda.fec_salida, encomienda.fec_llegada, encomienda.mon_precio
	FROM cliente inner join encomienda on cliente.ind_cliente = encomienda.ind_cliente
	inner join transporte on encomienda.ind_transporte = transporte.ind_transporte
);