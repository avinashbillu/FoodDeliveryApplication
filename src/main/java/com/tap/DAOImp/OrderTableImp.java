package com.tap.DAOImp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.OrderTableDAO;
import com.tap.model.CustomerDetails;
import com.tap.model.OrderTable;
import com.tap.utility.DBConnection;

public class OrderTableImp implements OrderTableDAO {

	private static final String add_query = "INSERT INTO ordertable (UserID, OrderDate, TotalAmount, Status, PaymentMethod, RestaurantID,addressID) VALUES (?,?,?,?,?,?,?)";
	private static final String get_query = "select * from ordertable where orderID=?";
	private static final String update_query = "update ordertable set userId=?, restaurantId=? ,orderDate=?, totalAmount=?, status=?, paymentMethod=?, addressID=? where orderID=?";
	private static final String delete_query = "delete from ordertable where orderID=?";
	private static final String getAll_query = "select * from ordertable";
	private static final String getUserOrders_query = "select * from ordertable WHERE UserID=? ORDER BY OrderDate DESC Limit 2";
	private static final String getRestaurantOrders_query = "SELECT * FROM ordertable WHERE RestaurantID=? ORDER BY OrderDate DESC";

	private static final String updateStatus_query = "UPDATE ordertable SET Status=? WHERE OrderID=?";
	private static final String GET_RESTAURANT_CUSTOMERS =
			"SELECT u.UserID,u.Username,u.Email,u.Address," +
			"COUNT(o.OrderID) AS TotalOrders," +
			"SUM(o.TotalAmount) AS TotalSpent " +
			"FROM users u " +
			"JOIN ordertable o ON u.UserID=o.UserID " +
			"WHERE o.RestaurantID=? " +
			"GROUP BY u.UserID,u.Username,u.Email,u.Address " +
			"ORDER BY TotalSpent DESC";
	
	private static final String getAllUserOrders_query =
			"SELECT * FROM ordertable WHERE UserID=? ORDER BY OrderDate DESC";
	
	@Override
	public int addOrder(OrderTable ordertable) {
		Connection con = DBConnection.getConnection();
		int orderId = 0;
		try {
			PreparedStatement pstmt = con.prepareStatement(add_query, Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, ordertable.getUserID());
			pstmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
			pstmt.setFloat(3, ordertable.getToatalAmount());
			pstmt.setString(4, ordertable.getStatus());
			pstmt.setString(5, ordertable.getPaymentMethod());
			pstmt.setInt(6, ordertable.getRestaurantID());
			pstmt.setInt(7, ordertable.getAddressID());
			pstmt.executeUpdate();

			ResultSet rs = pstmt.getGeneratedKeys();

			if (rs.next()) {

				orderId = rs.getInt(1);

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return orderId;
	}

	@Override
	public OrderTable getOrders(int orderID) {
		Connection con = DBConnection.getConnection();
		OrderTable ordertable = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(get_query);
			pstmt.setInt(1, orderID);
			ResultSet result = pstmt.executeQuery();
			while (result.next()) {
				int userID = result.getInt("userID");
				int orderID2 = result.getInt("orderID");
				Timestamp orderDate = result.getTimestamp("orderDate");
				float toatalAmount = result.getFloat("TotalAmount");
				String status = result.getString("status");
				String paymentMethod = result.getString("paymentMethod");
				int restaurantID = result.getInt("restaurantID");
				int addressID=result.getInt("addressID");
				ordertable = new OrderTable(userID, orderID2, orderDate, toatalAmount, status, paymentMethod,
						restaurantID,addressID);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ordertable;
	}

	@Override
	public void updateOrder(OrderTable ordertable) {
		Connection con = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = con.prepareStatement(update_query);

			pstmt.setInt(1, ordertable.getUserID());
			pstmt.setInt(2, ordertable.getRestaurantID());
			pstmt.setTimestamp(3, ordertable.getOrderDate());
			pstmt.setFloat(4, ordertable.getToatalAmount());
			pstmt.setString(5, ordertable.getStatus());
			pstmt.setString(6, ordertable.getPaymentMethod());
			pstmt.setInt(8, ordertable.getOrderID());
			pstmt.setInt(7,ordertable.getAddressID());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public void deleteOrder(int orderID) {
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pstmt = con.prepareStatement(delete_query);
			pstmt.setInt(1, orderID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public List<OrderTable> getAllOrders() {
		List<OrderTable> al = new ArrayList<>();
		Connection con = DBConnection.getConnection();
		OrderTable ordertable = null;
		try {
			Statement stmt = con.createStatement();
			ResultSet result = stmt.executeQuery(getAll_query);
			while (result.next()) {
				int userID = result.getInt("userID");
				int orderID2 = result.getInt("orderID");
				Timestamp orderDate = result.getTimestamp("orderDate");
				float toatalAmount = result.getFloat("toatalAmount");
				String status = result.getString("status");
				String paymentMethod = result.getString("paymentMethod");
				int restaurantID = result.getInt("restaurantID");
				int addressID=result.getInt("addressId");
				ordertable = new OrderTable(userID, orderID2, orderDate, toatalAmount, status, paymentMethod,
						restaurantID,addressID);
				al.add(ordertable);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return al;
	}

	@Override
	public List<OrderTable> getOrdersByUserId(int userId) {

		List<OrderTable> orders = new ArrayList<>();

		Connection con = DBConnection.getConnection();

		try {

			PreparedStatement pstmt = con.prepareStatement(getUserOrders_query);

			pstmt.setInt(1, userId);

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {

				OrderTable order = new OrderTable();

				order.setOrderID(rs.getInt("OrderID"));
				order.setUserID(rs.getInt("UserID"));
				order.setOrderDate(rs.getTimestamp("OrderDate"));
				order.setToatalAmount(rs.getFloat("TotalAmount"));
				order.setStatus(rs.getString("Status"));
				order.setPaymentMethod(rs.getString("PaymentMethod"));
				order.setRestaurantID(rs.getInt("RestaurantID"));
				order.setAddressID(rs.getInt("AddressID"));
				orders.add(order);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return orders;
	}

	@Override
	public List<OrderTable> getOrdersByRestaurant(int restaurantId) {

		List<OrderTable> orders = new ArrayList<>();

		Connection con = DBConnection.getConnection();

		try {

			PreparedStatement pstmt = con.prepareStatement(getRestaurantOrders_query);

			pstmt.setInt(1, restaurantId);

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {

				OrderTable order = new OrderTable();

				order.setOrderID(rs.getInt("OrderID"));
				order.setUserID(rs.getInt("UserID"));
				order.setOrderDate(rs.getTimestamp("OrderDate"));
				order.setToatalAmount(rs.getFloat("TotalAmount"));
				order.setStatus(rs.getString("Status"));
				order.setPaymentMethod(rs.getString("PaymentMethod"));
				order.setRestaurantID(rs.getInt("RestaurantID"));
				order.setAddressID(rs.getInt("AddressID"));
				orders.add(order);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return orders;
	}

	@Override
	public void updateOrderStatus(int orderId, String status) {

		Connection con = DBConnection.getConnection();

		try {

			PreparedStatement pstmt = con.prepareStatement(updateStatus_query);

			pstmt.setString(1, status);
			pstmt.setInt(2, orderId);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public List<CustomerDetails> getRestaurantCustomers(int restaurantId) {

	    List<CustomerDetails> customers = new ArrayList<>();

	    Connection con = DBConnection.getConnection();

	    try {

	        PreparedStatement pstmt =
	                con.prepareStatement(GET_RESTAURANT_CUSTOMERS);

	        pstmt.setInt(1, restaurantId);

	        ResultSet rs = pstmt.executeQuery();

	        while(rs.next()){

	            CustomerDetails customer =
	                    new CustomerDetails();

	            customer.setUserId(rs.getInt("UserID"));
	            customer.setUsername(rs.getString("Username"));
	            customer.setEmail(rs.getString("Email"));
	            customer.setAddress(rs.getString("Address"));
	            customer.setTotalOrders(rs.getInt("TotalOrders"));
	            customer.setTotalSpent(rs.getFloat("TotalSpent"));

	            customers.add(customer);

	        }

	    }
	    catch(Exception e){
	        e.printStackTrace();
	    }

	    return customers;
	}
	
	@Override
	public List<OrderTable> getAllOrdersByUserId(int userId) {

	    List<OrderTable> orders = new ArrayList<>();

	    Connection con = DBConnection.getConnection();

	    try {

	        PreparedStatement pstmt =
	                con.prepareStatement(getAllUserOrders_query);

	        pstmt.setInt(1, userId);

	        ResultSet rs = pstmt.executeQuery();

	        while(rs.next()){

	            OrderTable order = new OrderTable();

	            order.setOrderID(rs.getInt("OrderID"));
	            order.setUserID(rs.getInt("UserID"));
	            order.setOrderDate(rs.getTimestamp("OrderDate"));
	            order.setToatalAmount(rs.getFloat("TotalAmount"));
	            order.setStatus(rs.getString("Status"));
	            order.setPaymentMethod(rs.getString("PaymentMethod"));
	            order.setRestaurantID(rs.getInt("RestaurantID"));
	            order.setAddressID(rs.getInt("AddressID"));
	            orders.add(order);

	        }

	    }
	    catch(Exception e){
	        e.printStackTrace();
	    }

	    return orders;
	}
	

}
