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


/**
 *
 * @author Admin
 */
public class Main
{
    public static void main(String args[])
    {
        String url="jdbc:mysql://"+ DataBielefeldDB.IP + ":"+DataBielefeldDB.PORT +"/buchhandlung";
        String user=DataBielefeldDB.USER, passwd = DataBielefeldDB.PASSWORD;
        
        /* Login Leo
        String url="jdbc:mysql://"+ DataRuehterDB.IP + ":"+DataRuehterDB.PORT +"/buchhandlung";
        String user=DataRuehterDB.USER, passwd = DataRuehterDB.PASSWORD;
        */
                
        
        try(Connection con= DriverManager.getConnection(url,user,passwd);)
        {
            
        }
        catch (SQLException ex)
        {
            System.out.println("Keine Verbindung zum Server");
        }



        
    }
}
