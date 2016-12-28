Drop PROCEDURE IF EXISTS setNewArea;
DELIMITER $$
CREATE PROCEDURE setNewArea(
	IN liefererID INT,
	IN fromArea char(5),
	IN toArea char(5),
	OUT msg varchar(50))
BEGIN
	DECLARE oldArea char(5);
	DECLARE checkMarkt char(5);
	SELECT l.plz INTO oldArea FROM tbl_lieferer l WHERE liefererID = l.Lieferer_ID;
	SELECT g.plz into checkMarkt from getraenkemarkt g where g.plz = toArea;
	IF checkMarkt IS NULL THEN
		Call Kein_Getraenkemarkt_gefunden();
	ELSE IF fromArea = oldArea THEN
			UPDATE lieferer
			SET lieferer.plz = toArea
			WHERE liefererID = lieferer.Lieferer_ID;
			SET msg = 'Änderung der PLZ erfolgreich';
		ELSE
			SET msg = 'Änderungen konnten nicht umgesetzt werden';
		END IF;
	END IF;
END $$
DELIMITER ;