package com.tap.Servlet;

import java.io.IOException;

import com.tap.DAOImp.RestaurantDAOImpl;
import com.tap.model.Restaurant;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/CreateRestaurantServlet")
public class CreateRestaurantServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null) {

			resp.sendRedirect("RestaurantOwnerLogin.html");
			return;

		}

		User owner = (User) session.getAttribute("owner");

		if (owner == null) {

			resp.sendRedirect("RestaurantOwnerLogin.html");
			return;

		}

		// Read form data
		String name = req.getParameter("name");

		String cuisineType = req.getParameter("cuisineType");

		int deliveryTime = Integer.parseInt(req.getParameter("deliveryTime"));

		String address = req.getParameter("address");

		String imagePath = req.getParameter("imagePath");

		boolean isActive = Boolean.parseBoolean(req.getParameter("isActive"));

		// Create Restaurant Object
		Restaurant restaurant = new Restaurant();

		restaurant.setOwnerID(owner.getUserID());

		restaurant.setName(name);

		restaurant.setCuisineTypes(cuisineType);

		restaurant.setDeliveryTime(deliveryTime);

		restaurant.setAddress(address);

		restaurant.setRating(0.0f);

		restaurant.setIsActive(isActive);

		restaurant.setImagePath(imagePath);

		// Save into DB
		RestaurantDAOImpl dao = new RestaurantDAOImpl();

		dao.addRestaurant(restaurant);

		// Get newly created restaurant
		Restaurant newRestaurant = dao.getRestaurantByOwner(owner.getUserID());

		session.setAttribute("restaurant", newRestaurant);
		session.setAttribute("restaurantId", newRestaurant.getRestaurantID());
		session.setAttribute("restaurantName", newRestaurant.getName());

		resp.sendRedirect("ownerDashboardServlet");

	}

}