package com.tap.model;

public class Restaurant {

	private int restaurantID;
	private String name;
	private String cuisineTypes;
	private int deliveryTime;
	private String address;
	private float rating;
	private boolean isActive;
	private String imagePath;
	private int ownerID;

	public Restaurant() {

	}

	public Restaurant(int restaurantID, int ownerID, String name, String cuisineType, int deliveryTime, String address,
			float rating, boolean isActive, String imagePath) {

		this.restaurantID = restaurantID;
		this.ownerID = ownerID;
		this.name = name;
		this.cuisineTypes = cuisineType;
		this.deliveryTime = deliveryTime;
		this.address = address;
		this.rating = rating;
		this.isActive = isActive;
		this.imagePath = imagePath;
	}

	public int getRestaurantID() {
		return restaurantID;
	}

	public void setRestaurantID(int restaurantID) {
		this.restaurantID = restaurantID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCuisineTypes() {
		return cuisineTypes;
	}

	public void setCuisineTypes(String cuisineTypes) {
		this.cuisineTypes = cuisineTypes;
	}

	public int getDeliveryTime() {
		return deliveryTime;
	}

	public void setDeliveryTime(int deliveryTime) {
		this.deliveryTime = deliveryTime;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public float getRating() {
		return rating;
	}

	public void setRating(float rating) {
		this.rating = rating;
	}

	public boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(boolean isActive) {
		this.isActive = isActive;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	
	public int getOwnerID() {
	    return ownerID;
	}
	
	public void setOwnerID(int ownerID) {
	    this.ownerID = ownerID;
	}
	
	@Override
	public String toString() {
		return "Restaurant [restaurantID=" + restaurantID + ", name=" + name + ", cuisineTypes=" + cuisineTypes
				+ ", deliveryTime=" + deliveryTime + ", address=" + address + ", rating=" + rating + ", isActive="
				+ isActive + ", imagePath=" + imagePath + ", ownerID=" + ownerID + "]";
	}

}
