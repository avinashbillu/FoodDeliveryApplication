package com.tap.Servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tap.DAOImp.MenuImpl;
import com.tap.DAOImp.OrderItemImp;
import com.tap.DAOImp.OrderTableImp;
import com.tap.DAOImp.RestaurantDAOImpl;
import com.tap.model.Menu;
import com.tap.model.OrderItem;
import com.tap.model.OrderTable;
import com.tap.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/TrackOrderServlet")
public class TrackOrderServlet extends HttpServlet {

    private OrderTableImp orderDAO = new OrderTableImp();

    private OrderItemImp orderItemDAO = new OrderItemImp();

    private RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();

    private MenuImpl menuDAO = new MenuImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int orderId =
                Integer.parseInt(request.getParameter("orderId"));
        
        
        
        OrderTable order = orderDAO.getOrders(orderId);

       
        
        Restaurant restaurant =
                restaurantDAO.getRestaurant(order.getRestaurantID());

        List<OrderItem> items =
                orderItemDAO.getItemsByOrderId(orderId);

        Map<Integer,Menu> menuMap = new HashMap<>();

        for(OrderItem item : items){

            Menu menu =
                    menuDAO.getMenuItem(item.getMenuID());

            menuMap.put(item.getMenuID(),menu);

        }

        request.setAttribute("order", order);

        request.setAttribute("restaurant", restaurant);

        request.setAttribute("items", items);

        request.setAttribute("menuMap",menuMap);

        request.getRequestDispatcher("TrackOrder.jsp")
               .forward(request,response);

    }

}