package com.tap.Servlet;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.tap.DAOImp.RestaurantDAOImpl;
import com.tap.DAOImp.UserDAOImpl;
import com.tap.model.Restaurant;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/RestaurantOwnerLoginServlet")
public class RestaurantOwnerLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDAOImpl userDAO = new UserDAOImpl();
        User user = userDAO.getUserByEmail(email);

        if (user == null) {
            resp.sendRedirect("RestaurantOwnerLogin.html");
            return;
        }

        if (!"RestaurantOwner".equals(user.getRole())) {
            resp.sendRedirect("RestaurantOwnerLogin.html");
            return;
        }

        if (!BCrypt.checkpw(password, user.getPassword())) {
            resp.sendRedirect("RestaurantOwnerLogin.html");
            return;
        }

        HttpSession session = req.getSession();

        session.setAttribute("owner", user);
        session.setAttribute("ownerName", user.getUserName());
        session.setAttribute("ownerEmail", user.getEmail());

        RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();

        Restaurant restaurant = restaurantDAO.getRestaurantByOwner(user.getUserID());

        if (restaurant != null) {

            session.setAttribute("restaurant", restaurant);
            session.setAttribute("restaurantId", restaurant.getRestaurantID());
            session.setAttribute("restaurantName", restaurant.getName());

            resp.sendRedirect("ownerDashboardServlet");

        } else {

            resp.sendRedirect("CreateRestaurant.jsp");

        }

    }

}