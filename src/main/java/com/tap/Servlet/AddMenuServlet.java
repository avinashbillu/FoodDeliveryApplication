package com.tap.Servlet;

import java.io.IOException;

import com.tap.DAOImp.MenuImpl;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AddMenuServlet")
public class AddMenuServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if(session==null){
            resp.sendRedirect("RestaurantOwnerLogin.html");
            return;
        }

        Integer restaurantId =
                (Integer)session.getAttribute("restaurantId");

        if(restaurantId==null){
            resp.sendRedirect("CreateRestaurant.jsp");
            return;
        }

        String itemName=req.getParameter("itemName");
        String description=req.getParameter("description");

        float price=
                Float.parseFloat(req.getParameter("price"));

        boolean available=
                Boolean.parseBoolean(req.getParameter("available"));

        String imagePath=req.getParameter("imagePath");

        Menu menu=new Menu();

        menu.setRestaurantID(restaurantId);
        menu.setItemName(itemName);
        menu.setDescription(description);
        menu.setPrice(price);
        menu.setIsAvailable(available);
        menu.setImagePath(imagePath);

        MenuImpl dao=new MenuImpl();

        dao.addMenuItem(menu);

        resp.sendRedirect("OwnerMenuServlet");
    }

}