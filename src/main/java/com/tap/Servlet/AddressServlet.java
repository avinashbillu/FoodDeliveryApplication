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

@WebServlet("/AddressServlet")
public class AddressServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private AddressDAOImpl addressDAO = new AddressDAOImpl();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {

			response.sendRedirect("LoginPage.html");
			return;
		}

		String action = request.getParameter("action");

		if (action == null) {
			action = "view";
		}

		switch (action) {

		case "delete":
			deleteAddress(request, response);
			break;

		case "default":
			setDefaultAddress(request, response);
			break;

		case "view":
		default:
			viewAddresses(request, response);
			break;
		}

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if ("add".equals(action)) {

			addAddress(request, response);

		} else if ("update".equals(action)) {

			updateAddress(request, response);

		} else {

			response.sendRedirect("AddressServlet");

		}

	}

	private void viewAddresses(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		User user = (User) session.getAttribute("user");

		List<Address> addresses = addressDAO.getAddressesByUserId(user.getUserID());

		request.setAttribute("addresses", addresses);

		request.getRequestDispatcher("Address.jsp").forward(request, response);

	}

	private void addAddress(HttpServletRequest request, HttpServletResponse response) throws IOException {

		HttpSession session = request.getSession(false);

		User user = (User) session.getAttribute("user");

		Address address = new Address();

		address.setUserID(user.getUserID());

		address.setFullName(request.getParameter("fullName"));
		address.setPhone(request.getParameter("phone"));
		address.setHouseNo(request.getParameter("houseNo"));
		address.setArea(request.getParameter("area"));
		address.setLandmark(request.getParameter("landmark"));
		address.setCity(request.getParameter("city"));
		address.setState(request.getParameter("state"));
		address.setPincode(request.getParameter("pincode"));
		address.setAddressType(request.getParameter("addressType"));

		String isDefault = request.getParameter("isDefault");

		address.setIsDefault(isDefault != null);

		addressDAO.addAddress(address);

		if(address.getIsDefault()){

		    addressDAO.setDefaultAddress(
		            address.getAddressID(),
		            user.getUserID());

		}
		
		response.sendRedirect("AddressServlet");

	}


	private void updateAddress(HttpServletRequest request, HttpServletResponse response) throws IOException {

		HttpSession session = request.getSession(false);

		User user = (User) session.getAttribute("user");

		Address address = new Address();

		address.setAddressID(Integer.parseInt(request.getParameter("addressId")));

		address.setUserID(user.getUserID());

		address.setFullName(request.getParameter("fullName"));
		address.setPhone(request.getParameter("phone"));
		address.setHouseNo(request.getParameter("houseNo"));
		address.setArea(request.getParameter("area"));
		address.setLandmark(request.getParameter("landmark"));
		address.setCity(request.getParameter("city"));
		address.setState(request.getParameter("state"));
		address.setPincode(request.getParameter("pincode"));
		address.setAddressType(request.getParameter("addressType"));

		String isDefault = request.getParameter("isDefault");

		address.setIsDefault(isDefault != null);

		addressDAO.updateAddress(address);
		
		if(address.getIsDefault()){

		    addressDAO.setDefaultAddress(
		            address.getAddressID(),
		            user.getUserID());

		}
		
		response.sendRedirect("AddressServlet");

	}

	private void deleteAddress(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int addressId = Integer.parseInt(request.getParameter("id"));

		addressDAO.deleteAddress(addressId);

		response.sendRedirect("AddressServlet");

	}

	private void setDefaultAddress(HttpServletRequest request, HttpServletResponse response) throws IOException {

		HttpSession session = request.getSession(false);

		User user = (User) session.getAttribute("user");

		int addressId = Integer.parseInt(request.getParameter("id"));

		addressDAO.clearDefaultAddress(user.getUserID());

		addressDAO.setDefaultAddress(addressId, user.getUserID());

		response.sendRedirect("AddressServlet");

	}

}