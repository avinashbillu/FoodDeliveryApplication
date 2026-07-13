package com.tap.DAO;

import java.util.List;

import com.tap.model.Restaurant;

public interface SearchDAO {

    /**
     * Search restaurants by:
     * 1. Restaurant Name
     * 2. Cuisine Type
     * 3. Menu Item Name
     *
     * Example:
     * "Biryani"
     * "Pizza"
     * "Chicken"
     * "Burger"
     * "Chinese"
     */
    List<Restaurant> searchRestaurants(String keyword);

}