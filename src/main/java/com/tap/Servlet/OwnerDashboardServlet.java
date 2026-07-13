package com.tap.Servlet;

import java.io.IOException;

import com.tap.DAOImp.RestaurantDAOImpl;
import com.tap.model.Restaurant;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ownerDashboardServlet")
public class OwnerDashboardServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

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

		RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();

		Restaurant restaurant = restaurantDAO.getRestaurantByOwner(owner.getUserID());

		if (restaurant == null) {

			resp.sendRedirect("CreateRestaurant.jsp");
			return;

		}

		req.setAttribute("owner", owner);

		req.setAttribute("restaurant", restaurant);

		req.setAttribute("ownerName", owner.getUserName());

		req.setAttribute("ownerEmail", owner.getEmail());

		req.setAttribute("restaurantName", restaurant.getName());

		req.setAttribute("restaurantId", restaurant.getRestaurantID());

		req.getRequestDispatcher("OwnerDashboard.jsp").forward(req, resp);

	}

}