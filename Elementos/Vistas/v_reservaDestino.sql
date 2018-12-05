DROP VIEW IF EXISTS v_reservaDestino
GO	
CREATE VIEW v_reservaDestino
AS
(
	SELECT ind_Destino, des_destino
	FROM Destino
);