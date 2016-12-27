package de.fhdo.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Query
{

    public static String auslastungLieferer(Connection con, int plz)
    {
        // Select abfrage
        String sql = "SELECT lb.Lieferbezierk_ID, lb.plz, COUNT(l.Lieferer_ID) AS AnzahlLieferer, COUNT(lfb.Lieferbestaetigung_ID) AS AnzahlLieferungen, AVG(bp.anzahl) AS DurchschnittBestellsumme "
                + "FROM `tbl_lieferbezierk` lb, `tbl_lieferer` l, `tbl_liefererbestaetigung` lfb, `tbl_bestellung` b, `tbl_bestellposition` bp "
                + "WHERE lb.plz = l.plz AND l.plz = ? AND lfb.`Lieferer_NR` = l.Lieferer_ID AND lfb.`Bestellung_NR` = b.`Bestellung_ID` AND b.bestellstatus = 'abgeschlossen' and bp.`Bestellung_NR` = b.Bestellung_ID "
                + "GROUP BY lb.`Lieferbezierk_ID` ";
        
        String result = "";
        
        try (PreparedStatement stm = con.prepareStatement(sql);) // Erstellen der SQL Abfrage
        {
            stm.setString(1, String.valueOf(plz)); // Die Postleitzahl in die Select Answeisung einfügen
            ResultSet rs = stm.executeQuery(); // Select ausfüren
            if (!rs.next())
            {
                return "Kein Lieferer in der PLZ."; // Fals kein Ergebnis Zurück kommt
            }
            else
            {
                while (rs.next()) // Liste aller Ergebnisse
                {
                    result += rs.getString("Lieferbezierk_ID") + " " + rs.getString("plz") + " " + rs.getString("AnzahlLieferer") + " " + rs.getString("AnzahlLieferungen") + " " + rs.getString("DurchschnittBestellsumme") + "\n";
                }
            }
        }
        catch (SQLException ex)
        {
            Logger.getLogger(Query.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public static boolean checkPLZ(Connection con, int plz)
    {
        try (PreparedStatement plzstm = con.prepareStatement("Select lb.plz FROM tbl_lieferbezierk lb");)
        {
            ResultSet rs = plzstm.executeQuery();
            while (rs.next())
            {
                if (rs.getString("plz").equals(String.valueOf(plz)))
                {
                    return true;
                }
            }
        }
        catch (SQLException ex)
        {
            Logger.getLogger(Query.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
