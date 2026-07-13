package com.tap.DAOImp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.RestaurantDAO;
import com.tap.model.Restaurant;
import com.tap.utility.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO {

	private static final String add_query = "INSERT INTO restaurant (OwnerID, Name, CuisineType, DeliveryTime, Address, Rating, IsActive, ImagePath) VALUES (?,?,?,?,?,?,?,?)";
	private static final String get_query = "Select * from restaurant where restaurantId=?";
	private static final String update_query = "UPDATE restaurant SET OwnerID=?, Name=?, CuisineType=?, DeliveryTime=?, Address=?, Rating=?, IsActive=?, ImagePath=? WHERE RestaurantID=?";
	private static final String delete_query = "delete from restaurant where restaurantId=?";
	private static final String getAll_query = "select * from restaurant";
	private static final String GET_BY_OWNER = "SELECT * FROM restaurant WHERE OwnerID=?";

	@Override
	public void addRestaurant(Restaurant restaurant) {
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pstmt = con.prepareStatement(add_query);
			pstmt.setInt(1, restaurant.getOwnerID());
			pstmt.setString(2, restaurant.getName());
			pstmt.setString(3, restaurant.getCuisineTypes());
			pstmt.setInt(4, restaurant.getDeliveryTime());
			pstmt.setString(5, restaurant.getAddress());
			pstmt.setFloat(6, restaurant.getRating());
			pstmt.setBoolean(7, restaurant.getIsActive());
			pstmt.setString(8, restaurant.getImagePath());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Restaurant getRestaurant(int restaurantId) {
		Connection con = DBConnection.getConnection();
		Restaurant restaurant = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(get_query);
			pstmt.setInt(1, restaurantId);
			ResultSet result = pstmt.executeQuery();
			while (result.next()) {
				int restaurantId1 = result.getInt("restaurantId");
				String name = result.getString("name");
				String cuisineType = result.getString("cuisineType");
				int deliveryTime = result.getInt("deliveryTime");
				String address = result.getString("address");
				Float rating = result.getFloat("rating");
				boolean isActive = result.getBoolean("isActive");
				String imagePath = result.getString("imagePath");
				int ownerID = result.getInt("OwnerID");

				restaurant = new Restaurant(restaurantId1, ownerID, name, cuisineType, deliveryTime, address, rating,
						isActive, imagePath);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return restaurant;
	}

	@Override
	public void updateRestaurant(Restaurant restaurant) {
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pstmt = con.prepareStatement(update_query);
			pstmt.setInt(1, restaurant.getOwnerID());
			pstmt.setString(2, restaurant.getName());
			pstmt.setString(3, restaurant.getCuisineTypes());
			pstmt.setInt(4, restaurant.getDeliveryTime());
			pstmt.setString(5, restaurant.getAddress());
			pstmt.setFloat(6, restaurant.getRating());
			pstmt.setBoolean(7, restaurant.getIsActive());
			pstmt.setString(8, restaurant.getImagePath());
			pstmt.setInt(9, restaurant.getRestaurantID());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteRestaurant(int restaurantId) {
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pstmt = con.prepareStatement(delete_query);
			pstmt.setInt(1, restaurantId);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Restaurant> getAllRestaurant() {
		Connection con = DBConnection.getConnection();
		Restaurant restaurant = null;
		List<Restaurant> list = new ArrayList<Restaurant>();
		try {
			Statement stmt = con.createStatement();
			ResultSet result = stmt.executeQuery(getAll_query);
			while (result.next()) {
				int restaurantId1 = result.getInt("restaurantId");
				String name = result.getString("name");
				String cuisineType = result.getString("cuisineType");
				int deliveryTime = result.getInt("deliveryTime");
				String address = result.getString("address");
				Float rating = result.getFloat("rating");
				boolean isActive = result.getBoolean("isActive");
				String imagePath = result.getString("imagePath");
				int ownerID = result.getInt("OwnerID");

				restaurant = new Restaurant(restaurantId1, ownerID, name, cuisineType, deliveryTime, address, rating,
						isActive, imagePath);
				list.add(restaurant);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Restaurant getRestaurantByOwner(int ownerID) {

		Connection con = DBConnection.getConnection();

		Restaurant restaurant = null;

		try {

			PreparedStatement pstmt = con.prepareStatement(GET_BY_OWNER);

			pstmt.setInt(1, ownerID);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {

				restaurant = new Restaurant();

				restaurant.setRestaurantID(rs.getInt("RestaurantID"));

				restaurant.setOwnerID(rs.getInt("OwnerID"));

				restaurant.setName(rs.getString("Name"));

				restaurant.setCuisineTypes(rs.getString("CuisineType"));

				restaurant.setDeliveryTime(rs.getInt("DeliveryTime"));

				restaurant.setAddress(rs.getString("Address"));

				restaurant.setRating(rs.getFloat("Rating"));

				restaurant.setIsActive(rs.getBoolean("IsActive"));

				restaurant.setImagePath(rs.getString("ImagePath"));

			}

		} catch (Exception e) {

			e.printStackTrace();

		}

		return restaurant;

	}

}
