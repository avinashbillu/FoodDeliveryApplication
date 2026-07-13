package com.tap.utility;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	private static String url="jdbc:mysql://localhost:3306/fooddeliveryapplication";
	private static String dbuser="root";
	private static String dbpassword="261104";
	public static Connection getConnection() {
		Connection con=null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			 con=DriverManager.getConnection(url,dbuser,dbpassword);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return con;
	}
}
