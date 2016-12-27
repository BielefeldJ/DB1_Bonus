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
        String sql = "SELECT lb.Lieferbezirk_ID, lb.plz, COUNT(l.Lieferer_ID) AS AnzahlLieferer ,"
                            + "(SELECT Count(*)"
                                + "From tbl_liefererbestaetigung lfb, tbl_bestellung b, tbl_lieferer l1, tbl_lieferbezirk lb1 "
                                + "WHERE lfb.Bestellung_NR = b.Bestellung_ID and b.bestellstatus = 'abgeschlossen' and lfb.Lieferer_NR = l.Lieferer_ID and lb1.plz = l1.plz and l1.plz = l.plz) AS AnzahlBestellungen, "
                            + "(SELECT AVG(a.preis * bp.anzahl) "
                                + "FROM tbl_artikel a, tbl_bestellposition bp, tbl_bestellung b, tbl_liefererbestaetigung lb1 "
                                + "WHERE bp.Artikel_NR = a.Artikel_ID AND bp.Bestellung_NR = b.Bestellung_ID AND b.bestellstatus = 'abgeschlossen' AND lb1.Bestellung_NR = b.Bestellung_ID AND lb1.Lieferer_NR = l.Lieferer_ID) AS DurchschnittBestellsumme "
                        + "From tbl_lieferbezirk lb, tbl_lieferer l "
                        + "WHERE lb.plz = l.plz and l.plz = ? "
                        + "GROUP BY lb.Lieferbezirk_ID";

        String result = "Lieferbezirk ohne Lieferer";

        try (PreparedStatement stm = con.prepareStatement(sql);) // Erstellen der SQL Abfrage
        {
            stm.setString(1, String.valueOf(plz)); // Die Postleitzahl in die Select Answeisung einfügen
            ResultSet rs = stm.executeQuery(); // Select ausfüren

            while (rs.next()) // Liste aller Ergebnisse
            {
                System.out.println("test");
                result += rs.getString("Lieferbezirk_ID") + " " + rs.getString("plz") + " " + rs.getString("AnzahlLieferer") + " " + rs.getString("AnzahlBestellungen") + " " + rs.getString("DurchschnittBestellsumme") + "\n";
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
        try (PreparedStatement plzstm = con.prepareStatement("Select lb.plz FROM tbl_lieferbezirk lb");)
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
