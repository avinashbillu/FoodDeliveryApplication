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
import jakarta.servlet.http.HttpSession;

@WebServlet("/callLoginServlet")
public class LoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email=req.getParameter("email");
		String password=req.getParameter("password");
		
		HttpSession session=req.getSession();
		
		UserDAOImpl userDAOImpl=new UserDAOImpl();
		User user=userDAOImpl.getUserByEmail(email);
		String pwd=user.getPassword();
		
		if(user != null && BCrypt.checkpw(password, pwd)) {
			session.setAttribute("email", email);
			session.setAttribute("username", user.getUserName());
			session.setAttribute("user", user);
			resp.sendRedirect("callRestaurantServlet");
		}
		else {
			resp.sendRedirect("LoginPage.html");
		}
	}
}
