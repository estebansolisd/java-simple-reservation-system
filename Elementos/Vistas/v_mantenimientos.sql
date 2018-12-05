DROP VIEW IF EXISTS v_mantenimientos
GO
CREATE VIEW v_mantenimientos
AS
(
	SELECT ind_mantenimiento, transporte.tip_transporte, fec_entrada, fec_salidad, des_mantenimiento, can_mantenimiento, val_mantenimiento
	FROM mantenimiento INNER JOIN transporte ON mantenimiento.ind_transporte = transporte.ind_transporte
);