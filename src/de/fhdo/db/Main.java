/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package de.fhdo.db;

import de.fhdo.db.mysqldata.bielefeld.DataBielefeldDB;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Scanner;

/**
 *
 * @author Admin
 */
public class Main
{

    public static void main(String args[])
    {
        String url = "jdbc:mysql://" + DataBielefeldDB.IP + ":" + DataBielefeldDB.PORT + "/venenumBonus";
        String user = DataBielefeldDB.USER, passwd = DataBielefeldDB.PASSWORD;

        /* Login Leo
        String url="jdbc:mysql://"+ DataRuehterDB.IP + ":"+DataRuehterDB.PORT +"/buchhandlung";
        String user=DataRuehterDB.USER, passwd = DataRuehterDB.PASSWORD;
         */
        Scanner sc = new Scanner(System.in);
        Query qry;

        try (Connection con = DriverManager.getConnection(url, user, passwd);)
        {
            qry = new Query(con);
            boolean run = true;
            int item;

            do
            {
                System.out.println("========================================");
                System.out.println("Wählen Sie aus, was Sie machen möchten: ");
                System.out.println("(1): Aufgabe 1a");
                System.out.println("(2): Aufgabe 2a");
                //System.out.println("(3): Aufgabe 2b");
                System.out.println("(4): Beenden");
                System.out.println("========================================");
                item = sc.nextInt();
                switch (item)
                {
                    case 1:
                        System.out.println("Geben Sie eine Postleitzahl ein: ");
                        int plz = sc.nextInt();
                        if (qry.checkPLZ(plz))
                        {
                            System.out.println(qry.auslastungLieferer(plz));
                        }
                        else
                        {
                            System.out.println("PLZ nicht im System gefunden.");
                        }
                        break;
                    case 2:
                        System.out.println("Geben Sie die Lieferer ID ein: ");
                        int LiefererID = sc.nextInt();
                        System.out.println("Geben Sie den aktuellen Bezirk ein: ");
                        String ondArea = sc.next();
                        System.out.println("Geben Sie den neuen Bezirk ein: ");
                        String newArea = sc.next();
                        System.out.println(qry.setNewArea(LiefererID, ondArea, newArea));
                        break;
                    case 4:
                        run = false;
                        break;
                    default:
                        System.out.println("Falsche eingabe..");
                        break;
                }
            } while (run);

        }
        catch (SQLException ex)
        {
            System.out.println("Keine Verbindung zum Server");
        }

    }
}
