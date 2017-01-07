package de.fhdo.db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;


public class Query
{
    private final Connection con;
    
    
    public Query(Connection con)
    {
        this.con = con ;
    }

    public String auslastungLieferer(int plz)
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

        String result = "";

        try (PreparedStatement stm = con.prepareStatement(sql);) // Erstellen der SQL Abfrage
        {
            stm.setString(1, String.valueOf(plz)); // Die Postleitzahl in die Select Answeisung einfügen
            ResultSet rs = stm.executeQuery(); // Select ausfüren

            while (rs.next()) // Liste aller Ergebnisse
            {
                //System.out.println("test");
                result += rs.getString("Lieferbezirk_ID") + " " + rs.getString("plz") + " " + rs.getString("AnzahlLieferer") + " " + rs.getString("AnzahlBestellungen") + " " + rs.getString("DurchschnittBestellsumme") + "\n"; //Jeden gefunden Datensatz in result schreiben
            }
            
            if(result.equals(""))
            {
                result = "Lieferbezirk ohne Lieferer"; 
            }

        }
        catch (SQLException ex)
        {
           //ex.printStackTrace();
        }

        return result;
    }

    
    
    public boolean checkPLZ(int plz)
    {
        try (PreparedStatement plzstm = con.prepareStatement("Select lb.plz FROM tbl_lieferbezirk lb");) //Erstellen der SQL Abfrage
        {
            ResultSet rs = plzstm.executeQuery(); //Select ausführen
            while (rs.next()) //Liste aller PLZ
            {
                if (rs.getString("plz").equals(String.valueOf(plz)))  //Die übergebene PLZ mit der PLZ aus der Datenbank vergleichen
                {
                    return true;
                }
            }
        }
        catch (SQLException ex)
        {
           //ex.printStackTrace();
        }
        return false;
    }
    
    public String setNewArea(int LiefererID, String oldArea, String newArea)
    {
        try( CallableStatement cst = con.prepareCall("{call setNewArea(?,?,?,?)}");) //Vorbereiten der Procedure setNewArea
        {
           cst.setString(1,String.valueOf(LiefererID)); //LieferID übergeben
           cst.setString(2, oldArea);   //oldArea übergeben
           cst.setString(3, newArea);   //newArea übergeben
           cst.registerOutParameter(4, Types.VARCHAR);  //rückgabe Parameter setzen
           cst.execute();   //Procedure ausführen
           return cst.getString(4); //Rückgabe der Procedure zurück geben
        }
        catch (SQLException ex)
        {
            //ex.printStackTrace();
        }
        return "Fehler beim ändern des Gebietes!";
    }
    
    public String insertNewDelivery(int LiefererID, String Vorname)
    {
        try(CallableStatement cst = con.prepareCall("{call insertLieferer(?,'Ultrageheimespw','Herr',?,'04.04.1996','Dingensstrasse','Dingenshausen','38999','01578554557','coolertyp@dingens.com','Cooler Tpy','001122554','Dingenskasse','500')}")) //Procedure insertNewDelivery vorbereiten
        {
            cst.setString(1, String.valueOf(LiefererID)); // LiefererID übergeben
            cst.setString(2, Vorname);  //Vorname übergeben
            cst.execute();  //Procedure ausführen
            return "Erfolgreich eingefügt";
        }
        catch (SQLException ex)
        {
            //ex.printStackTrace();
            return "Fehler beim einfügen";
        }
        
    }
}
