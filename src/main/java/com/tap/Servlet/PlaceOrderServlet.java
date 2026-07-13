package com.tap.Servlet;

import java.io.IOException;

import com.tap.DAOImp.OrderItemImp;
import com.tap.DAOImp.OrderTableImp;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.OrderItem;
import com.tap.model.OrderTable;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/placeOrderServlet")
public class PlaceOrderServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();

		User user = (User) session.getAttribute("user");

		Cart cart = (Cart) session.getAttribute("cart");

		if (user == null || cart == null || cart.getItems().isEmpty()) {

			resp.sendRedirect("CartPage.jsp");
			return;

		}

		String paymentMethod = req.getParameter("payment");
		String razorpayPaymentId = req.getParameter("razorpayPaymentId");

		String razorpayOrderId = req.getParameter("razorpayOrderId");

		String razorpaySignature = req.getParameter("razorpaySignature");


		float total = 0;

		int restaurantId = 0;

		for (CartItem item : cart.getItems().values()) {

			total += item.getPrice() * item.getQuantity();

			restaurantId = item.getRestaurantId();

		}

		float gst = total * 0.05f;

		float delivery = 39;

		float platform = 5;

		total = total + gst + delivery + platform;

		OrderTable order = new OrderTable();
		int addressID = Integer.parseInt(req.getParameter("addressID"));
		order.setUserID(user.getUserID());
		order.setAddressID(addressID);
		order.setRestaurantID(restaurantId);

		order.setToatalAmount(total);

		order.setStatus("Pending");

		order.setPaymentMethod(paymentMethod);
		

		OrderTableImp orderDAO = new OrderTableImp();

		int orderId = 0;
		if (paymentMethod.equals("Cash")) {
			System.out.println("Adding Order Items...");
			orderId = orderDAO.addOrder(order);
			System.out.println("Order Saved : " + orderId);

		} else if (paymentMethod.equals("Razorpay")) {

			if (razorpayPaymentId != null && !razorpayPaymentId.isEmpty()) {

				orderId = orderDAO.addOrder(order);

			} else {

				resp.sendRedirect("CheckoutPage.jsp?payment=failed");

				return;

			}

		}

		OrderItemImp itemDAO = new OrderItemImp();
		session.setAttribute("orderId", orderId);
		for (CartItem item : cart.getItems().values()) {

			OrderItem oi = new OrderItem();

			oi.setOrderID(orderId);

			oi.setMenuID(item.getMenuId());

			oi.setQuantity(item.getQuantity());

			oi.setItemTotal(item.getPrice() * item.getQuantity());

			itemDAO.addOrderItem(oi);

		}

		cart.clear();

		session.setAttribute("cart", cart);
		
		resp.sendRedirect("OrderSuccess.jsp");

	}

}