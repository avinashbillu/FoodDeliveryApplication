package com.tap.Servlet;

import java.io.IOException;
import java.util.List;

import com.tap.DAOImp.MenuImpl;
import com.tap.DAOImp.OrderItemImp;
import com.tap.DAOImp.OrderTableImp;
import com.tap.DAOImp.RestaurantDAOImpl;
import com.tap.model.OrderTable;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/MyOrdersServlet")
public class MyOrdersServlet extends HttpServlet {

    private OrderTableImp orderDAO = new OrderTableImp();
    private OrderItemImp orderItemDAO = new OrderItemImp();
    private MenuImpl menuDAO = new MenuImpl();

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {

            resp.sendRedirect("LoginPage.html");
            return;
        }

        User user = (User) session.getAttribute("user");
        RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
        // Fetch all orders of the logged-in customer
        List<OrderTable> orders =
                orderDAO.getAllOrdersByUserId(user.getUserID());

        // Send data to JSP
        req.setAttribute("orders", orders);

        // Send DAO objects so JSP can fetch items & menu details
        req.setAttribute("orderItemDAO", orderItemDAO);
        req.setAttribute("menuDAO", menuDAO);
        req.setAttribute("restaurantDAO", restaurantDAO);
        req.getRequestDispatcher("MyOrders.jsp")
           .forward(req, resp);
    }
}