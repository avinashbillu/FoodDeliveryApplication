package com.tap.DAOImp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.CategoryDAO;
import com.tap.model.Category;
import com.tap.utility.DBConnection;

public class CategoryImpl implements CategoryDAO {

    private static final String add_query =
            "INSERT INTO category(RestaurantID,CategoryName,Description,ImagePath,IsActive) VALUES(?,?,?,?,?)";

    private static final String get_query =
            "SELECT * FROM category WHERE CategoryID=?";

    private static final String update_query =
            "UPDATE category SET RestaurantID=?,CategoryName=?,Description=?,ImagePath=?,IsActive=? WHERE CategoryID=?";

    private static final String delete_query =
            "DELETE FROM category WHERE CategoryID=?";

    private static final String getAll_query =
            "SELECT * FROM category";

    private static final String getRestaurant_query =
            "SELECT * FROM category WHERE RestaurantID=? ORDER BY CategoryName";

    private static final String status_query =
            "UPDATE category SET IsActive=? WHERE CategoryID=?";



    @Override
    public void addCategory(Category category) {

        Connection con = DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    con.prepareStatement(add_query);

            pstmt.setInt(1, category.getRestaurantID());
            pstmt.setString(2, category.getCategoryName());
            pstmt.setString(3, category.getDescription());
            pstmt.setString(4, category.getImagePath());
            pstmt.setBoolean(5, category.getIsActive());

            pstmt.executeUpdate();

        }
        catch(Exception e) {

            e.printStackTrace();

        }

    }



    @Override
    public Category getCategory(int categoryID) {

        Connection con = DBConnection.getConnection();

        Category category = null;

        try {

            PreparedStatement pstmt =
                    con.prepareStatement(get_query);

            pstmt.setInt(1, categoryID);

            ResultSet rs = pstmt.executeQuery();

            while(rs.next()) {

                category = new Category();

                category.setCategoryID(rs.getInt("CategoryID"));
                category.setRestaurantID(rs.getInt("RestaurantID"));
                category.setCategoryName(rs.getString("CategoryName"));
                category.setDescription(rs.getString("Description"));
                category.setImagePath(rs.getString("ImagePath"));
                category.setIsActive(rs.getBoolean("IsActive"));

            }

        }
        catch(Exception e) {

            e.printStackTrace();

        }

        return category;

    }



    @Override
    public void updateCategory(Category category) {

        Connection con = DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    con.prepareStatement(update_query);

            pstmt.setInt(1, category.getRestaurantID());
            pstmt.setString(2, category.getCategoryName());
            pstmt.setString(3, category.getDescription());
            pstmt.setString(4, category.getImagePath());
            pstmt.setBoolean(5, category.getIsActive());
            pstmt.setInt(6, category.getCategoryID());

            pstmt.executeUpdate();

        }
        catch(Exception e) {

            e.printStackTrace();

        }

    }



    @Override
    public void deleteCategory(int categoryID) {

        Connection con = DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    con.prepareStatement(delete_query);

            pstmt.setInt(1, categoryID);

            pstmt.executeUpdate();

        }
        catch(Exception e) {

            e.printStackTrace();

        }

    }



    @Override
    public List<Category> getAllCategories() {

        List<Category> list = new ArrayList<>();

        Connection con = DBConnection.getConnection();

        try {

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery(getAll_query);

            while(rs.next()) {

                Category category = new Category();

                category.setCategoryID(rs.getInt("CategoryID"));
                category.setRestaurantID(rs.getInt("RestaurantID"));
                category.setCategoryName(rs.getString("CategoryName"));
                category.setDescription(rs.getString("Description"));
                category.setImagePath(rs.getString("ImagePath"));
                category.setIsActive(rs.getBoolean("IsActive"));

                list.add(category);

            }

        }
        catch(Exception e) {

            e.printStackTrace();

        }

        return list;

    }



    @Override
    public List<Category> getRestaurantCategories(int restaurantID) {

        List<Category> list = new ArrayList<>();

        Connection con = DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    con.prepareStatement(getRestaurant_query);

            pstmt.setInt(1, restaurantID);

            ResultSet rs = pstmt.executeQuery();

            while(rs.next()) {

                Category category = new Category();

                category.setCategoryID(rs.getInt("CategoryID"));
                category.setRestaurantID(rs.getInt("RestaurantID"));
                category.setCategoryName(rs.getString("CategoryName"));
                category.setDescription(rs.getString("Description"));
                category.setImagePath(rs.getString("ImagePath"));
                category.setIsActive(rs.getBoolean("IsActive"));

                list.add(category);

            }

        }
        catch(Exception e) {

            e.printStackTrace();

        }

        return list;

    }



    @Override
    public void updateStatus(int categoryID, boolean status) {

        Connection con = DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    con.prepareStatement(status_query);

            pstmt.setBoolean(1, status);
            pstmt.setInt(2, categoryID);

            pstmt.executeUpdate();

        }
        catch(Exception e) {

            e.printStackTrace();

        }

    }

}