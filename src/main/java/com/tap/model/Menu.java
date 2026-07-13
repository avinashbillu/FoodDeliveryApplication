package com.tap.model;

public class Menu {
	private int menuID;
	private int restaurantID;
	private String itemName;
	private String description;
	private float price;
	private boolean isAvailable;
	private String imagePath;
	private int categoryID;
	
	public Menu() {
		
	}

	public Menu(int menuID, int restaurantID, String itemName, String description, float price, boolean isAvailable,
			String imagePath,int categoryID) {
		super();
		this.menuID = menuID;
		this.restaurantID = restaurantID;
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.isAvailable = isAvailable;
		this.imagePath = imagePath;
		this.categoryID=categoryID;
	}

	public int getMenuID() {
		return menuID;
	}

	public void setMenuID(int menuID) {
		this.menuID = menuID;
	}

	public int getRestaurantID() {
		return restaurantID;
	}

	public void setRestaurantID(int restaurantID) {
		this.restaurantID = restaurantID;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public boolean getIsAvailable() {
		return isAvailable;
	}

	public void setIsAvailable(boolean isAvailable) {
		this.isAvailable = isAvailable;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	
	
	
	public int getCategoryID() {
		return categoryID;
	}

	public void setCategoryID(int categoryID) {
		this.categoryID = categoryID;
	}

	@Override
	public String toString() {
		return "Menu [menuID=" + menuID + ", restaurantID=" + restaurantID + ", itemName=" + itemName + ", description="
				+ description + ", price=" + price + ", isAvailable=" + isAvailable + ", imagePath=" + imagePath
				+ ", categoryID=" + categoryID + "]";
	}

	
	
}
