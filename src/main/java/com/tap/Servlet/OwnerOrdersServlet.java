package com.tap.Servlet;

import java.io.IOException;
import java.util.List;

import com.tap.DAOImp.OrderTableImp;
import com.tap.model.OrderTable;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/OwnerOrdersServlet")
public class OwnerOrdersServlet extends HttpServlet {

	private OrderTableImp dao = new OrderTableImp();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);

		if (session == null) {

			resp.sendRedirect("RestaurantOwnerLogin.html");
			return;
		}

		Integer restaurantId = (Integer) session.getAttribute("restaurantId");

		if (restaurantId == null) {

			resp.sendRedirect("CreateRestaurant.jsp");
			return;
		}

		String action = req.getParameter("action");

		if (action != null && action.equals("status")) {

			int orderId = Integer.parseInt(req.getParameter("orderId"));

			String status = req.getParameter("status");

			dao.updateOrderStatus(orderId, status);

			resp.sendRedirect("OwnerOrdersServlet");

			return;
		}

		List<OrderTable> orders = dao.getOrdersByRestaurant(restaurantId);

		req.setAttribute("orders", orders);

		req.getRequestDispatcher("OwnerOrders.jsp").forward(req, resp);
	}

}