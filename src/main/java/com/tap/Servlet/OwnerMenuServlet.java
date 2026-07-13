package com.tap.Servlet;

import java.io.IOException;
import java.util.List;

import com.tap.DAOImp.MenuImpl;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/OwnerMenuServlet")
public class OwnerMenuServlet extends HttpServlet {

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

        MenuImpl dao = new MenuImpl();

        List<Menu> menuList =
                dao.getSpecificRestaurantMenu(restaurantId);

        req.setAttribute("menuList", menuList);

        req.getRequestDispatcher("OwnerMenu.jsp")
                .forward(req, resp);
    }
}
