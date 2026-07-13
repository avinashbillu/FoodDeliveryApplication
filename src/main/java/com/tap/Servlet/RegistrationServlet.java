package com.tap.Servlet;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.tap.DAOImp.UserDAOImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/callRegistrationServlet")
public class RegistrationServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("username");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String address = req.getParameter("address");
		String role = req.getParameter("role");

		String pwd = BCrypt.hashpw(password, BCrypt.gensalt(8));

		
		
		User user = new User(name, pwd, email, address, role);
		UserDAOImpl userDAOImpl = new UserDAOImpl();
		int res = userDAOImpl.addUser(user);

		if (res == 1) {

			if (role.equals("RestaurantOwner")) {

				resp.sendRedirect("RestaurantOwnerLogin.html");

			} else {

				resp.sendRedirect("LoginPage.html");

			}

		} else {

			resp.sendRedirect("RegistrationPage.html");

		}

	}
}
