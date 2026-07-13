package com.tap.Servlet;

import com.tap.DAOImp.AddressDAOImpl;
import com.tap.model.Address;
import java.util.List;
import com.tap.DAOImp.OrderTableImp;
import com.tap.model.OrderTable;
import java.io.IOException;

import com.tap.DAOImp.UserDAOImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/callProfileServlet")
public class ProfileServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req,
	        HttpServletResponse resp)
	        throws ServletException, IOException {

	    HttpSession session = req.getSession(false);

	    if(session == null || session.getAttribute("email") == null || session.getAttribute("user") == null) {
	        resp.sendRedirect("LoginPage.html");
	        return;
	    }
	    resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	    resp.setHeader("Pragma", "no-cache");
	    resp.setDateHeader("Expires", 0);
	    
	    String email = (String) session.getAttribute("email");

	    UserDAOImpl dao = new UserDAOImpl();

	    User user = dao.getUserByEmail(email);
	    AddressDAOImpl addressDAO = new AddressDAOImpl();

	    Address defaultAddress =
	            addressDAO.getDefaultAddress(user.getUserID());

	    req.setAttribute("defaultAddress", defaultAddress);
	    OrderTableImp orderDAO = new OrderTableImp();

	    List<OrderTable> orders =orderDAO.getOrdersByUserId(user.getUserID());

	    req.setAttribute("orders", orders);
	    req.setAttribute("user", user);

	    req.getRequestDispatcher("Profile.jsp")
	       .forward(req, resp);
	}
}