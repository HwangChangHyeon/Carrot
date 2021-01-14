package RiotAPI;

import java.sql.*;
import java.util.HashMap;

public class Spell {
	static String DRIVER = "org.mariadb.jdbc.Driver";
	static String DB =
	static String USER = 
	static String PW = 
	private HashMap<String, String> itemspell = new HashMap<String, String>();

     
	
	public HashMap<String, String> get_spell(){
		return this.itemspell;
	}
	
	public void request_spell(String spell) throws SQLException, ClassNotFoundException {
		 Class.forName(DRIVER);
         Connection con = DriverManager.getConnection(DB, USER, PW);
         
         if( con == null ) {
             System.out.println("DB 연결 실패");
         }
         Statement stmt = null;
 		 stmt = con.createStatement();

         String sql;

         sql = "select * from spell where spell_key='"+spell+"'";
         ResultSet rs = stmt.executeQuery(sql);
         while(rs.next()){
        	 this.itemspell.put("spell",rs.getString("spell_name"));
        	 this.itemspell.put("spell_des",rs.getString("spell_description"));
         }
         rs.close();
         stmt.close();
         con.close();
	}	
}
