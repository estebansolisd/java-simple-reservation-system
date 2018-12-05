DROP VIEW IF EXISTS v_encomiendaTransporte
GO
CREATE VIEW v_encomiendaTransporte
AS
(
	SELECT ind_transporte as idTransporte, tip_transporte as tipoTransporte
	FROM transporte
);