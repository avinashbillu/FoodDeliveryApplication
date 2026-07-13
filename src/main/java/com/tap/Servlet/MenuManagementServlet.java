package com.tap.Servlet;

import java.io.IOException;
import com.tap.DAOImp.MenuImpl;
import com.tap.model.Menu;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/MenuManagementServlet")
public class MenuManagementServlet extends HttpServlet {

    private final MenuImpl dao = new MenuImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("restaurantId") == null) {
            resp.sendRedirect("RestaurantOwnerLogin.html");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) {
            resp.sendRedirect("OwnerMenuServlet");
            return;
        }

        switch (action) {
            case "addPage":
                req.getRequestDispatcher("AddMenu.jsp").forward(req, resp);
                break;

            case "edit":
                Menu menu = dao.getMenuItem(Integer.parseInt(req.getParameter("menuId")));
                req.setAttribute("menu", menu);
                req.getRequestDispatcher("EditMenu.jsp").forward(req, resp);
                break;

            case "delete":
                dao.deleteMenuItem(Integer.parseInt(req.getParameter("menuId")));
                resp.sendRedirect("OwnerMenuServlet");
                break;

            case "toggle":
                int id = Integer.parseInt(req.getParameter("menuId"));
                Menu m = dao.getMenuItem(id);
                dao.updateAvailability(id, !m.getIsAvailable());
                resp.sendRedirect("OwnerMenuServlet");
                break;

            default:
                resp.sendRedirect("OwnerMenuServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("restaurantId") == null) {
            resp.sendRedirect("RestaurantOwnerLogin.html");
            return;
        }

        String action = req.getParameter("action");
        int restaurantId = (Integer) session.getAttribute("restaurantId");

        if ("add".equals(action)) {

            Menu menu = new Menu();
            menu.setRestaurantID(restaurantId);
            menu.setItemName(req.getParameter("itemName"));
            menu.setDescription(req.getParameter("description"));
            menu.setPrice(Float.parseFloat(req.getParameter("price")));
            menu.setIsAvailable(Boolean.parseBoolean(req.getParameter("available")));
            menu.setImagePath(req.getParameter("imagePath"));

            dao.addMenuItem(menu);

        } else if ("update".equals(action)) {

            Menu menu = new Menu();
            menu.setMenuID(Integer.parseInt(req.getParameter("menuId")));
            menu.setRestaurantID(restaurantId);
            menu.setItemName(req.getParameter("itemName"));
            menu.setDescription(req.getParameter("description"));
            menu.setPrice(Float.parseFloat(req.getParameter("price")));
            menu.setIsAvailable(Boolean.parseBoolean(req.getParameter("available")));
            menu.setImagePath(req.getParameter("imagePath"));

            dao.updateMenuItem(menu);
        }

        resp.sendRedirect("OwnerMenuServlet");
    }
}
