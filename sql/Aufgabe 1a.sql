SELECT lb.Lieferbezirk_ID, lb.plz, COUNT(l.Lieferer_ID) AS AnzahlLieferer, COUNT(lfb.Lieferbestaetigung_ID) AS AnzahlLieferungen, AVG(bp.anzahl) AS DurchschnittBestellsumme
FROM `tbl_lieferbezirk` lb, `tbl_lieferer` l, `tbl_liefererbestaetigung` lfb, `tbl_bestellung` b, `tbl_bestellposition` bp
 WHERE lb.plz = l.plz AND l.plz = ? AND lfb.`Lieferer_NR` = l.Lieferer_ID AND lfb.`Bestellung_NR` = b.`Bestellung_ID` AND b.bestellstatus = 'abgeschlossen' and bp.`Bestellung_NR` = b.Bestellung_ID
 GROUP BY lb.`Lieferbezirk_ID`