package com.tap.Servlet;

import java.io.IOException;

import com.tap.DAOImp.MenuImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/callCartServlet")
public class CartServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		HttpSession session=req.getSession();
		Cart cart=(Cart)session.getAttribute("cart");
		int newRestaurantId =Integer.parseInt(req.getParameter("restaurantId"));
		
		Integer restaurantId=(Integer)session.getAttribute("restaurantId");
		
		
		
		
		if(cart==null || restaurantId!=newRestaurantId) {
			cart=new Cart();
			session.setAttribute("cart", cart);
			session.setAttribute("restaurantId", newRestaurantId);
		}
		
		
		
		
		String action=req.getParameter("action");
		
		if(action.equals("add")) {
			addItemToCart(req,cart);
		}
		else if(action.equals("update")) {
			updateItemToCart(req,cart);
		}
		else if(action.equals("delete")){
			deleteItemFromCart(req,cart);
		}
		
		resp.sendRedirect("CartPage.jsp");
	}
	
	private void addItemToCart(HttpServletRequest req, Cart cart) {
		int menuId=Integer.parseInt(req.getParameter("menuId"));
		int quantity=Integer.parseInt(req.getParameter("quantity"));
		
		MenuImpl menuImpl=new MenuImpl();
		Menu menu=menuImpl.getMenuItem(menuId);
		
		CartItem cartItem =
				new CartItem(
				menu.getMenuID(),
				menu.getRestaurantID(),
				menu.getItemName(),
				menu.getPrice(),
				quantity,
				menu.getImagePath()
				);
		cart.addItem(cartItem);
	}
	
	private void updateItemToCart(HttpServletRequest req, Cart cart) {
		
		int menuId=Integer.parseInt(req.getParameter("menuId"));
		int quantity=Integer.parseInt(req.getParameter("quantity"));
		cart.updateItem(menuId,quantity);
	}
	
	private void deleteItemFromCart(HttpServletRequest req, Cart cart) {
		
		int menuId=Integer.parseInt(req.getParameter("menuId"));
		cart.deleteItem(menuId);
	}
	
}
