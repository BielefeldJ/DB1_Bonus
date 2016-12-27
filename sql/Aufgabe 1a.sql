SELECT lb.Lieferbezirk_ID, lb.plz, COUNT(l.Lieferer_ID) AS AnzahlLieferer , 
	(SELECT Count(*)
	From tbl_liefererbestaetigung lfb, tbl_bestellung b, tbl_lieferer l1, tbl_lieferbezirk lb1
	WHERE lfb.Bestellung_NR = b.Bestellung_ID and b.bestellstatus = 'abgeschlossen' and lfb.Lieferer_NR = l.Lieferer_ID and lb1.plz = l1.plz and l1.plz = l.plz) AS AnzahlBestellungen,
	(SELECT AVG(a.preis * bp.anzahl)
	FROM tbl_artikel a, tbl_bestellposition bp, tbl_bestellung b, tbl_liefererbestaetigung lb1
	WHERE bp.Artikel_NR = a.Artikel_ID AND bp.Bestellung_NR = b.Bestellung_ID AND b.bestellstatus = 'abgeschlossen' AND
	lb1.Bestellung_NR = b.Bestellung_ID AND lb1.Lieferer_NR = l.Lieferer_ID) AS DurchschnittBestellsumme
From tbl_lieferbezirk lb, tbl_lieferer l
WHERE lb.plz = l.plz and plz = 39001
GROUP BY lb.Lieferbezirk_ID