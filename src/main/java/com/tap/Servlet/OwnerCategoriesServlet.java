package com.tap.Servlet;

import java.io.IOException;
import java.util.List;

import com.tap.DAOImp.CategoryImpl;
import com.tap.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/OwnerCategoriesServlet")
public class OwnerCategoriesServlet extends HttpServlet {

    private CategoryImpl dao = new CategoryImpl();

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if(session == null){
            resp.sendRedirect("RestaurantOwnerLogin.html");
            return;
        }

        Integer restaurantId =
                (Integer)session.getAttribute("restaurantId");

        if(restaurantId == null){
            resp.sendRedirect("CreateRestaurant.jsp");
            return;
        }

        List<Category> categories =
                dao.getRestaurantCategories(restaurantId);

        req.setAttribute("categories", categories);

        req.getRequestDispatcher("OwnerCategories.jsp")
                .forward(req, resp);
    }
}