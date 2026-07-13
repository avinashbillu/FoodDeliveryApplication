package com.tap.DAOImp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.SearchDAO;
import com.tap.model.Restaurant;
import com.tap.utility.DBConnection;

public class SearchDAOImpl implements SearchDAO {

    // Search by Restaurant Name, Cuisine Type and Menu Item
	private static final String SEARCH_QUERY =

		    "SELECT DISTINCT r.* " +
		    "FROM restaurant r " +
		    "JOIN menu m ON r.RestaurantID = m.RestaurantID " +
		    "LEFT JOIN category c ON m.CategoryID = c.CategoryID " +
		    "WHERE LOWER(r.Name) LIKE ? " +
		    "OR LOWER(r.CuisineType) LIKE ? " +
		    "OR LOWER(m.ItemName) LIKE ? " +
		    "OR LOWER(c.CategoryName) LIKE ? " +
		    "ORDER BY r.Rating DESC";

    @Override
    public List<Restaurant> searchRestaurants(String keyword) {

        List<Restaurant> restaurants = new ArrayList<>();

        Connection con = DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    con.prepareStatement(SEARCH_QUERY);
          
 
            
            String search = "%" + keyword.trim().toLowerCase() + "%";

            
            pstmt.setString(1, search);
            pstmt.setString(2, search);
            pstmt.setString(3, search);
            pstmt.setString(4, search);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                Restaurant restaurant = new Restaurant();

                restaurant.setRestaurantID(
                        rs.getInt("RestaurantID"));

                restaurant.setName(
                        rs.getString("Name"));

                restaurant.setCuisineTypes(
                        rs.getString("CuisineType"));

                restaurant.setDeliveryTime(
                        rs.getInt("DeliveryTime"));

                restaurant.setAddress(
                        rs.getString("Address"));

                restaurant.setRating(
                        rs.getFloat("Rating"));

                restaurant.setIsActive(
                        rs.getBoolean("IsActive"));

                restaurant.setImagePath(
                        rs.getString("ImagePath"));

                restaurant.setOwnerID(
                        rs.getInt("OwnerID"));

                restaurants.add(restaurant);
              
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return restaurants;
    }
}	