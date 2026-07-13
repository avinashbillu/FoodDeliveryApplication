package com.tap.DAOImp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.MenuDAO;
import com.tap.model.Menu;
import com.tap.utility.DBConnection;

public class MenuImpl implements MenuDAO {

	private static String add_query =
			"INSERT INTO menu(RestaurantID,CategoryID,ItemName,Description,Price,IsAvailable,ImagePath) VALUES (?,?,?,?,?,?,?)";
	private static String get_query="select * from menu where menuID=?";
	private static String update_query =
			"UPDATE menu SET RestaurantID=?,CategoryID=?,ItemName=?,Description=?,Price=?,IsAvailable=?,ImagePath=? WHERE MenuID=?";
	private static String delete_query="delete from menu where menuID=?";
	private static String getAll_query="select * from menu";
	private static String getSepcific_query="select * from menu where RestaurantID=?";
	private static String query = "UPDATE menu SET IsAvailable=? WHERE MenuID=?";
	
	
	@Override
	public void addMenuItem(Menu menu) {
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pstmt=con.prepareStatement(add_query);
			pstmt.setInt(1, menu.getRestaurantID());
			pstmt.setInt(2, menu.getCategoryID());
			pstmt.setString(3, menu.getItemName());
			pstmt.setString(4, menu.getDescription());
			pstmt.setFloat(5, menu.getPrice());
			pstmt.setBoolean(6, menu.getIsAvailable());
			pstmt.setString(7, menu.getImagePath());
			pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Menu getMenuItem(int menuID) {

		Connection con=DBConnection.getConnection();
		Menu m=null;
		try {
			PreparedStatement pstmt=con.prepareStatement(get_query);
			pstmt.setInt(1, menuID);
			ResultSet result=pstmt.executeQuery();
			while(result.next()) {
				int RestaurantID=result.getInt("RestaurantID");
				int CategoryID=result.getInt("CategoryID");
				String ItemName=result.getString("ItemName");
				String Description=result.getString("Description");
				float Price=result.getFloat("Price");
				boolean IsAvailable=result.getBoolean("IsAvailable");
				String ImagePath=result.getString("ImagePath");
				m=new Menu(menuID, RestaurantID, ItemName, Description, Price, IsAvailable, ImagePath,CategoryID);
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return m;
	}

	@Override
	public void updateMenuItem(Menu menu) {
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pstmt=con.prepareStatement(update_query);
			pstmt.setInt(1, menu.getRestaurantID());
			pstmt.setInt(2, menu.getCategoryID());
			pstmt.setString(3, menu.getItemName());
			pstmt.setString(4, menu.getDescription());
			pstmt.setFloat(5, menu.getPrice());
			pstmt.setBoolean(6, menu.getIsAvailable());
			pstmt.setString(7, menu.getImagePath());
			pstmt.setInt(8, menu.getMenuID());
			pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void deleteMenuItem(int menuID) {
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pstmt=con.prepareStatement(delete_query);
			pstmt.setInt(1, menuID);
			pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public List<Menu> getAllMenu() {
		ArrayList<Menu> al=new ArrayList<>();
		Connection con=DBConnection.getConnection();
		Menu m=null;
		try {
			Statement stmt=con.createStatement();
			ResultSet result=stmt.executeQuery(getAll_query);
			while(result.next()) {
				int MenuID=result.getInt("MenuID");
				int RestaurantID=result.getInt("RestaurantID");
				int CategoryID=result.getInt("CategoryID");
				String ItemName=result.getString("ItemName");
				String Description=result.getString("Description");
				float Price=result.getFloat("Price");
				boolean IsAvailable=result.getBoolean("IsAvailable");
				String ImagePath=result.getString("ImagePath");
				m=new Menu(MenuID, RestaurantID, ItemName, Description, Price, IsAvailable, ImagePath,CategoryID);
				al.add(m);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return al;
	}
	
	@Override
	public List<Menu> getSpecificRestaurantMenu(int restaurantID) {
		ArrayList<Menu> al=new ArrayList<>();
		Connection con=DBConnection.getConnection();
		Menu m=null;
		try {
			PreparedStatement pstmt=con.prepareStatement(getSepcific_query);
			pstmt.setInt(1, restaurantID);
			ResultSet result=pstmt.executeQuery();
			while(result.next()) {
				int MenuID=result.getInt("MenuID");
				int RestaurantID=result.getInt("RestaurantID");
				int CategoryID=result.getInt("CategoryID");
				String ItemName=result.getString("ItemName");
				String Description=result.getString("Description");
				float Price=result.getFloat("Price");
				boolean IsAvailable=result.getBoolean("IsAvailable");
				String ImagePath=result.getString("ImagePath");
				m=new Menu(MenuID, RestaurantID, ItemName, Description, Price, IsAvailable, ImagePath,CategoryID);
				al.add(m);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return al;
	}
	
	public void updateAvailability(int menuID, boolean available) {

	    

	    Connection con = DBConnection.getConnection();

	    try {

	        PreparedStatement pstmt = con.prepareStatement(query);

	        pstmt.setBoolean(1, available);
	        pstmt.setInt(2, menuID);

	        pstmt.executeUpdate();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	public List<Menu> getMenuByCategory(int categoryId) {

	    List<Menu> list = new ArrayList<>();

	    Connection con = DBConnection.getConnection();

	    try {

	        PreparedStatement pstmt =
	                con.prepareStatement(
	                        "SELECT * FROM menu WHERE CategoryID=?");

	        pstmt.setInt(1, categoryId);

	        ResultSet rs = pstmt.executeQuery();

	        while(rs.next()){

	            Menu m = new Menu();

	            m.setMenuID(rs.getInt("MenuID"));
	            m.setRestaurantID(rs.getInt("RestaurantID"));
	            m.setCategoryID(rs.getInt("CategoryID"));
	            m.setItemName(rs.getString("ItemName"));
	            m.setDescription(rs.getString("Description"));
	            m.setPrice(rs.getFloat("Price"));
	            m.setIsAvailable(rs.getBoolean("IsAvailable"));
	            m.setImagePath(rs.getString("ImagePath"));

	            list.add(m);
	        }

	    } catch(Exception e){
	        e.printStackTrace();
	    }

	    return list;
	}
	
}
