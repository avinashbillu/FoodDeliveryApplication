package com.tap.DAO;

import java.util.List;
import com.tap.model.Category;

public interface CategoryDAO {

    
    void addCategory(Category category);
    Category getCategory(int categoryID);
    void updateCategory(Category category);
    void deleteCategory(int categoryID);
    List<Category> getAllCategories();
    List<Category> getRestaurantCategories(int restaurantID);
    void updateStatus(int categoryID, boolean status);

}