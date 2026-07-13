package com.tap.model;

public class CustomerDetails {

    private int userId;
    private String username;
    private String email;
    private String address;

    private int totalOrders;
    private float totalSpent;

    public CustomerDetails() {}

    public CustomerDetails(int userId,
                           String username,
                           String email,
                           String address,
                           int totalOrders,
                           float totalSpent) {

        this.userId = userId;
        this.username = username;
        this.email = email;
        this.address = address;
        this.totalOrders = totalOrders;
        this.totalSpent = totalSpent;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }

    public float getTotalSpent() {
        return totalSpent;
    }

    public void setTotalSpent(float totalSpent) {
        this.totalSpent = totalSpent;
    }
}