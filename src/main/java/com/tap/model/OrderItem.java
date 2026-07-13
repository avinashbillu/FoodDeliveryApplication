package com.tap.model;

public class OrderItem {
	private int orderID;
	private int orderItemID;
	private int quantity;
	private float itemTotal;
	private int menuID;
	
	public OrderItem() {
		
	}

	public OrderItem(int orderID, int orderItemID, int quantity, float itemTotal, int menuID) {
		super();
		this.orderID = orderID;
		this.orderItemID = orderItemID;
		this.quantity = quantity;
		this.itemTotal = itemTotal;
		this.menuID = menuID;
	}

	public int getOrderID() {
		return orderID;
	}

	public void setOrderID(int orderID) {
		this.orderID = orderID;
	}

	public int getOrderItemID() {
		return orderItemID;
	}

	public void setOrderItemID(int orderItemID) {
		this.orderItemID = orderItemID;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public float getItemTotal() {
		return itemTotal;
	}

	public void setItemTotal(float itemTotal) {
		this.itemTotal = itemTotal;
	}

	public int getMenuID() {
		return menuID;
	}

	public void setMenuID(int menuID) {
		this.menuID = menuID;
	}

	@Override
	public String toString() {
		return "OrderItem [orderID=" + orderID + ", orderItemID=" + orderItemID + ", quantity=" + quantity
				+ ", itemTotal=" + itemTotal + ", menuID=" + menuID + "]";
	}
	
	
}
