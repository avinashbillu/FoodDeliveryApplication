package com.tap.Servlet;

import java.io.IOException;
import java.util.List;

import com.tap.DAOImp.AddressDAOImpl;
import com.tap.model.Address;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();

		User user = (User) session.getAttribute("user");

		if (user == null) {

			resp.sendRedirect("LoginPage.html");

			return;

		}

		AddressDAOImpl dao = new AddressDAOImpl();

		List<Address> addresses = dao.getAddressesByUserId(user.getUserID());

		req.setAttribute("addresses", addresses);

		req.getRequestDispatcher("CheckoutPage.jsp").forward(req, resp);

	}

}
