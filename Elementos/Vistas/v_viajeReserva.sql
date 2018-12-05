DROP VIEW IF EXISTS v_viajeReserva
GO
CREATE VIEW v_viajeReserva
AS
(
	SELECT ind_re_viaje from reserva_viaje
);