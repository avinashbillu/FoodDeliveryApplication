package com.tap.model;

public class Category {

    private int categoryID;
    private int restaurantID;
    private String categoryName;
    private String description;
    private String imagePath;
    private boolean isActive;

    // Default Constructor
    public Category() {

    }

    // Parameterized Constructor
    public Category(int categoryID,
                    int restaurantID,
                    String categoryName,
                    String description,
                    String imagePath,
                    boolean isActive) {

        this.categoryID = categoryID;
        this.restaurantID = restaurantID;
        this.categoryName = categoryName;
        this.description = description;
        this.imagePath = imagePath;
        this.isActive = isActive;
    }

    // Getters & Setters

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public int getRestaurantID() {
        return restaurantID;
    }

    public void setRestaurantID(int restaurantID) {
        this.restaurantID = restaurantID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    @Override
    public String toString() {
        return "Category [categoryID=" + categoryID
                + ", restaurantID=" + restaurantID
                + ", categoryName=" + categoryName
                + ", description=" + description
                + ", imagePath=" + imagePath
                + ", isActive=" + isActive + "]";
    }
}