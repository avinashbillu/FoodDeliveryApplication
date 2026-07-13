package com.tap.Servlet;

import java.io.IOException;
import java.util.List;

import com.tap.DAOImp.RestaurantDAOImpl;
import com.tap.model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/callRestaurantServlet")
public class RestaurantServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RestaurantDAOImpl restaurantPage= new RestaurantDAOImpl();
		List<Restaurant> allrestaurant=restaurantPage.getAllRestaurant();
		req.setAttribute("allrestaurant", allrestaurant);
		
		
		RequestDispatcher rd= req.getRequestDispatcher("RestaurantPage.jsp");
		rd.forward(req, resp);
	}
}
