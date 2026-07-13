package com.tap.DAO;

import java.util.List;

import com.tap.model.CustomerDetails;
import com.tap.model.OrderTable;

public interface OrderTableDAO {
	int addOrder(OrderTable ordertable);
	OrderTable getOrders(int orderID);
	void updateOrder(OrderTable ordertable);
	void deleteOrder(int orderID);
	List<OrderTable> getAllOrders();
	List<OrderTable> getOrdersByUserId(int userId);
	List<OrderTable> getOrdersByRestaurant(int restaurantId);
	void updateOrderStatus(int orderId, String status);
	List<CustomerDetails> getRestaurantCustomers(int restaurantId);
	List<OrderTable> getAllOrdersByUserId(int userId);
}
