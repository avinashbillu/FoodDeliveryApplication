package com.tap.model;

import java.sql.Timestamp;

public class OrderTable {
	private int userID;
	private int orderID;
	private Timestamp orderDate;
	private float toatalAmount;
	private String status;
	private String paymentMethod;
	private int restaurantID;
	private int addressID;
	
	public OrderTable() {
		
	}
	

	public OrderTable(int userID, int orderID, Timestamp orderDate, float toatalAmount, String status,
			String paymentMethod, int restaurantID, int addressID) {
		super();
		this.userID = userID;
		this.orderID = orderID;
		this.orderDate = orderDate;
		this.toatalAmount = toatalAmount;
		this.status = status;
		this.paymentMethod = paymentMethod;
		this.restaurantID = restaurantID;
		this.addressID = addressID;
	}


	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public int getOrderID() {
		return orderID;
	}

	public void setOrderID(int orderID) {
		this.orderID = orderID;
	}

	public Timestamp getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
	}

	public float getToatalAmount() {
		return toatalAmount;
	}

	public void setToatalAmount(float toatalAmount) {
		this.toatalAmount = toatalAmount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public int getRestaurantID() {
		return restaurantID;
	}

	public void setRestaurantID(int restaurantID) {
		this.restaurantID = restaurantID;
	}

	
	
	public int getAddressID() {
		return addressID;
	}


	public void setAddressID(int addressID) {
		this.addressID = addressID;
	}


	@Override
	public String toString() {
		return "OrderTable [userID=" + userID + ", orderID=" + orderID + ", orderDate=" + orderDate + ", toatalAmount="
				+ toatalAmount + ", status=" + status + ", paymentMethod=" + paymentMethod + ", restaurantID="
				+ restaurantID + ", addressID=" + addressID + "]";
	}


	
	
	
}
