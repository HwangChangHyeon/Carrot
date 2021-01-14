package RiotAPI;

import java.sql.*;
import java.util.HashMap;

public class Item {
	static String DRIVER = "org.mariadb.jdbc.Driver";
	static String DB =
	static String USER = 
	static String PW = 
	private HashMap<String, String> itemlist = new HashMap<String, String>();

     
	
	public HashMap<String, String> get_item(){
		return this.itemlist;
	}
	
	public void request_item(String item) throws SQLException, ClassNotFoundException {
		 Class.forName(DRIVER);
         Connection con = DriverManager.getConnection(DB, USER, PW);
         
         if( con == null ) {
             System.out.println("DB 연결 실패");
         }
         Statement stmt = null;
 		 stmt = con.createStatement();

         String sql;

         sql = "select * from item where item_id='"+item+"'";
         ResultSet rs = stmt.executeQuery(sql);
         while(rs.next()){
        	 this.itemlist.put("item",rs.getString("item_name"));
        	 this.itemlist.put("plain",rs.getString("item_plaintext"));
         }
         rs.close();
         stmt.close();
         con.close();
	}	
}
