DROP TRIGGER IF EXISTS GetraenkemarktzuweisenInsert;

DELIMITER &&
CREATE TRIGGER GetraenkemarktzuweisenInsert
AFTER INSERT ON tbl_lieferer
FOR EACH ROW

BEGIN
	-- Variablendeklaration
    DECLARE GetraenkemarktID INT;
    DECLARE done INT DEFAULT 0; 
    
    -- Deklariere Cursor für Getränkemärkte im Lieferbezirk
	DECLARE c CURSOR FOR SELECT Getraenkemarkt_ID
	FROM tbl_getraenkemarkt
	JOIN tbl_lieferbezirk USING(plz)
	WHERE tbl_getraenkemarkt.plz=new.plz;
    
    -- Deklariere Continue Handler zum beenden der LOOP
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;

	-- Cursor öffnen
    OPEN c;
    
    loop_getraenkemaerkte: LOOP
		-- Speichere Cursorinhalt in GetraenkemarktID
		FETCH c INTO GetraenkemarktID;
        
        -- Solange noch Getränkemärkte gefunden werden...
        IF done=0 THEN 
			-- ...Neue Zeile einfügen 
			INSERT INTO tbl_getraenkemarkt_has_lieferer(Lieferer_NR, Getraenkemarkt_NR)
			VALUES(new.Lieferer_ID, GetraenkemarktID);
        END IF;
        
		-- An Schleifenanfang gehen 
		IF done=0 THEN ITERATE loop_getraenkemaerkte; END IF;
       
		-- Schleife verlassen
		LEAVE loop_getraenkemaerkte;
        
	END LOOP;
    
    CLOSE c;     
    
END &&

DELIMITER ;