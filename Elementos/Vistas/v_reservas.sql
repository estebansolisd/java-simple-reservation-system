DROP VIEW IF EXISTS v_reservas;
GO
CREATE VIEW v_reservas
AS
(
	SELECT r.ind_re_viaje, c.des_nombre "Nombre Cliente", e.des_nombre as "Nombre Empleado", t.tip_transporte, d.des_destino, r.fec_inicio, r.fec_final, r.for_pago, r.num_plazas
	FROM empleados e inner join reserva_viaje r on e.ind_empleado = r.ind_empleado
	inner join destino d on d.ind_destino = r.ind_destino
	inner join cliente c on r.ind_cliente = c.ind_cliente
	inner join transporte t on t.ind_transporte = r.ind_transporte
);