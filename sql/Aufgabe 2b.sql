Drop PROCEDURE IF EXISTS insertLieferer;
DELIMITER $$
CREATE PROCEDURE insertLieferer(
    IN newID int,
    IN Passwort varchar(45),
	IN anrede varchar(45),
	IN Vorname varchar(45),
	IN Datum varchar(45),
	IN Strasse varchar(45),
	IN ort varchar(45),
	IN plz varchar(45),
	IN tel varchar(45),
	IN mail varchar(45),
	IN beschreibung varchar(45),
	IN blz varchar(45),
	IN Bankname varchar(45),
	IN wert double)
BEGIN            
	Declare lieferbezirkTOP INT;
    
	Select lb.Lieferbezirk_ID into lieferbezirkTOP
	From tbl_getraenkemarkt g, tbl_lieferbezirk lb
	where g.name = 'Top' and g.plz = lb.plz;

	Insert INTO tbl_lieferer VALUES(newID, Passwort, anrede, Vorname, "Bielefeld", Datum, Strasse, ort, plz, tel, mail, beschreibung, "7097263", blz, Bankname);	
	Insert INTO tbl_lieferer_lieferbezirk VALUES(lieferbezirkTOP, newID, "12:00 bis 13:35", wert);
END $$
DELIMITER ;