package com.tap.Servlet;

import java.io.IOException;
import java.util.List;

import com.tap.DAOImp.MenuImpl;
import com.tap.model.Menu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/menuServlet")
public class MenuServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MenuImpl menuPage = new MenuImpl();

		int restaurantID = Integer.parseInt(req.getParameter("restaurantID"));
		String restaurantName = req.getParameter("restaurantName");
		String cuisine = req.getParameter("cuisine");
		String rating = req.getParameter("rating");
		String deliveryTime = req.getParameter("deliveryTime");

		HttpSession session = req.getSession();

        //session.setAttribute("restaurantId", restaurantID);
        session.setAttribute("restaurantName", restaurantName);
        session.setAttribute("cuisine", cuisine);
        session.setAttribute("rating", rating);
        session.setAttribute("deliveryTime", deliveryTime);

		List<Menu> allMenuItems = menuPage.getSpecificRestaurantMenu(restaurantID);


		req.setAttribute("restaurantName", restaurantName);
		req.setAttribute("cuisine", cuisine);
		req.setAttribute("rating", rating);
		req.setAttribute("deliveryTime", deliveryTime);
		req.setAttribute("allMenuItems", allMenuItems);
		RequestDispatcher rd = req.getRequestDispatcher("MenuPage.jsp");
		rd.forward(req, resp);
	}
}
