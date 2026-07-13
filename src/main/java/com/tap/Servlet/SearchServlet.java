package com.tap.Servlet;

import java.io.IOException;
import java.util.List;

import com.tap.DAOImp.SearchDAOImpl;
import com.tap.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {

    private SearchDAOImpl searchDAO;

    @Override
    public void init() throws ServletException {
        searchDAO = new SearchDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Get search keyword
        String keyword = request.getParameter("keyword");

        // If search box is empty
        if (keyword == null || keyword.trim().isEmpty()) {

            response.sendRedirect("callRestaurantServlet");
            return;
        }

        keyword = keyword.trim();

        // Search restaurants
        List<Restaurant> restaurants =
                searchDAO.searchRestaurants(keyword);

        // Send data to JSP
        request.setAttribute("allrestaurant", restaurants);
        request.setAttribute("searchKeyword", keyword);

        // Forward to your Restaurant page
        request.getRequestDispatcher("RestaurantPage.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}