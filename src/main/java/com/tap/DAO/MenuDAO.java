package com.tap.DAO;

import java.util.List;

import com.tap.model.Menu;


public interface MenuDAO {
	void addMenuItem(Menu menu);
	Menu getMenuItem(int menuID);
	void updateMenuItem(Menu menu);
	void deleteMenuItem(int menuID);
	List<Menu> getAllMenu();
	List<Menu> getSpecificRestaurantMenu(int restaurantID );
	void updateAvailability(int menuID, boolean available);
	List<Menu> getMenuByCategory(int categoryId);
}
