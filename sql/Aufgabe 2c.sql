Drop Trigger IF EXISTS GetraenkemarktzuweisenInsert;
DELIMITER $$
CREATE Trigger Getraenkemarktzuweisen
After Insert on tbl_lieferer
for each row
Begin
		Declare lbID INT;
		Select Lieferbezirk_ID into lbID 
		from tbl_lieferbezirk
		where new.plz = plz;

		Insert into tbl_lieferer_lieferbezirk VALUES(lbID,new.Lieferer_ID,'Keine Lieferzeit angegeben',154);
    
END $$
DELIMITER ;




Drop Trigger IF EXISTS GetraenkemarktzuweisenUpdate;
DELIMITER $$
CREATE Trigger GetraenkemarktzuweisenUpdate
After Update on tbl_lieferer
for each row
Begin
	IF new.plz != old.plz
   	THEN
       	UPDATE tbl_lieferer_lieferbezirk
        SET Lieferbezirk_NR = (SELECT Lieferbezirk_ID from tbl_lieferbezirk where new.plz = plz)
        WHERE Lieferer_NR = new.Lieferer_ID;
    END IF;
END $$
DELIMITER ;