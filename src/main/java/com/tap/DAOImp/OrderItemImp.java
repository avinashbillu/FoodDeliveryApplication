package com.tap.DAOImp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.OrderItemDAO;
import com.tap.model.OrderItem;
import com.tap.utility.DBConnection;

public class OrderItemImp  implements OrderItemDAO{

	private static String add_query="insert into orderItem(orderID,Quantity,ItemTotal,MenuID) values(?,?,?,?)";
	private static String get_query="select * from orderItem where orderItemID=?";
	private static String update_query="update orderItem set orderID=?,Quantity=?,itemTotal=?,menuID=? where orderItemID=?";
	private static String delete_query="delete from orderItem where orderItemID=?";
	private static String getAll_query="select * from orderItem";
	private static final String getItems_query =
			"SELECT * FROM orderitem WHERE OrderID=?";
	
	@Override
	public void addOrderItem(OrderItem orderItem) {
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pstmt=con.prepareStatement(add_query);
			pstmt.setInt(1, orderItem.getOrderID());
			pstmt.setInt(2, orderItem.getQuantity());
			pstmt.setFloat(3, orderItem.getItemTotal());
			pstmt.setInt(4, orderItem.getMenuID());
			pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public OrderItem getOrderItem(int orderItemID) {
		Connection con=DBConnection.getConnection();
		OrderItem ot=null;
		try {
			PreparedStatement pstmt=con.prepareStatement(get_query);
			pstmt.setInt(1, orderItemID);
			ResultSet result=pstmt.executeQuery();
			while(result.next()) {
				int orderitemid=result.getInt("OrderItemID");
				int orderid=result.getInt("OrderID");
				int quantity=result.getInt("Quantity");
				float itemtoatl=result.getFloat("ItemTotal");
				int menuid=result.getInt("MenuID");
				ot=new OrderItem(orderid, orderitemid, quantity, itemtoatl, menuid);
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return ot;
	}

	@Override
	public void updateOrderItem(OrderItem orderItem) {
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pstmt=con.prepareStatement(update_query);
			pstmt.setInt(1, orderItem.getOrderID());
			pstmt.setInt(2, orderItem.getQuantity());
			pstmt.setFloat(3, orderItem.getItemTotal());
			pstmt.setInt(4, orderItem.getMenuID());
			pstmt.setInt(5, orderItem.getOrderItemID());
			pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteOrderItem(int orderItemID) {
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pstmt=con.prepareStatement(delete_query);
			pstmt.setInt(1, orderItemID);
			pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public List<OrderItem> getAllOrderItems() {
		ArrayList<OrderItem> al=new ArrayList<>();
		Connection con=DBConnection.getConnection();
		OrderItem ot=null;
		try {
			Statement stmt=con.createStatement();
			ResultSet result=stmt.executeQuery(getAll_query);
			while(result.next()) {
				int orderitemid=result.getInt("OrderItemID");
				int orderid=result.getInt("OrderID");
				int quantity=result.getInt("Quantity");
				float itemtoatl=result.getFloat("ItemTotal");
				int menuid=result.getInt("MenuID");
				ot=new OrderItem(orderid, orderitemid, quantity, itemtoatl, menuid);
				al.add(ot);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return al;
	}

	@Override
	public List<OrderItem> getItemsByOrderId(int orderId) {

	    List<OrderItem> items = new ArrayList<>();

	    Connection con = DBConnection.getConnection();

	    try {

	        PreparedStatement pstmt =
	                con.prepareStatement(getItems_query);

	        pstmt.setInt(1, orderId);

	        ResultSet rs = pstmt.executeQuery();

	        while(rs.next()){

	            OrderItem item = new OrderItem();

	            item.setOrderItemID(rs.getInt("OrderItemID"));
	            item.setOrderID(rs.getInt("OrderID"));
	            item.setQuantity(rs.getInt("Quantity"));
	            item.setItemTotal(rs.getFloat("ItemTotal"));
	            item.setMenuID(rs.getInt("MenuID"));

	            items.add(item);
	        }

	    }
	    catch(Exception e){
	        e.printStackTrace();
	    }

	    return items;
	}

}
