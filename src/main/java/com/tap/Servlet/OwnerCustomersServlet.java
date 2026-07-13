package com.tap.Servlet;

import java.io.IOException;
import java.util.List;

import com.tap.DAOImp.OrderTableImp;
import com.tap.model.CustomerDetails;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/OwnerCustomersServlet")
public class OwnerCustomersServlet extends HttpServlet {

    private OrderTableImp dao =
            new OrderTableImp();

    @Override
    protected void doGet(HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session =
                req.getSession(false);

        if(session==null){

            resp.sendRedirect(
                    "RestaurantOwnerLogin.html");

            return;
        }

        Integer restaurantId =
                (Integer)session.getAttribute("restaurantId");

        if(restaurantId==null){

            resp.sendRedirect("CreateRestaurant.jsp");

            return;
        }

        List<CustomerDetails> customers =
                dao.getRestaurantCustomers(restaurantId);

        req.setAttribute("customers", customers);

        req.getRequestDispatcher("OwnerCustomers.jsp")
                .forward(req, resp);

    }

}