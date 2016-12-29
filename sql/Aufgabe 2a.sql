Drop PROCEDURE IF EXISTS setNewArea;
DELIMITER $$
CREATE PROCEDURE setNewArea(
	IN liefererID INT,
	IN fromArea char(5),
	IN toArea char(5),
	OUT msg varchar(50))
main:BEGIN
	DECLARE oldArea char(5);
	DECLARE checkMarkt char(5);
	SELECT l.plz INTO oldArea FROM tbl_lieferer l WHERE liefererID = l.Lieferer_ID;
	SELECT g.plz into checkMarkt from tbl_getraenkemarkt g where g.plz = toArea;
	IF checkMarkt IS NULL THEN
		SET msg= 'Kein Getränkemarkt gefunden!';
        LEAVE main;
	ELSE IF fromArea = oldArea THEN
			UPDATE tbl_lieferer
			SET tbl_lieferer.plz = toArea
			WHERE liefererID = tbl_lieferer.Lieferer_ID;
			SET msg = 'Änderung der PLZ erfolgreich';
		ELSE
			SET msg = 'Änderungen konnten nicht umgesetzt werden';
		END IF;
	END IF;
END $$
DELIMITER ;