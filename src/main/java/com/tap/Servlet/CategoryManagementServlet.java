package com.tap.Servlet;

import java.io.IOException;

import com.tap.DAOImp.CategoryImpl;
import com.tap.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CategoryManagementServlet")
public class CategoryManagementServlet extends HttpServlet {

    private CategoryImpl dao = new CategoryImpl();

    @Override
    protected void doGet(HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if(session == null ||
                session.getAttribute("restaurantId") == null) {

            resp.sendRedirect("RestaurantOwnerLogin.html");
            return;
        }

        String action = req.getParameter("action");

        if(action == null) {

            resp.sendRedirect("OwnerCategoriesServlet");
            return;
        }

        switch(action) {

        case "addPage":

            req.getRequestDispatcher("AddCategory.jsp")
                    .forward(req, resp);

            break;

        case "edit":

            int categoryId =
                    Integer.parseInt(req.getParameter("categoryId"));

            Category category =
                    dao.getCategory(categoryId);

            req.setAttribute("category", category);

            req.getRequestDispatcher("EditCategory.jsp")
                    .forward(req, resp);

            break;

        case "delete":

            dao.deleteCategory(
                    Integer.parseInt(req.getParameter("categoryId")));

            resp.sendRedirect("OwnerCategoriesServlet");

            break;

        case "toggle":

            int id =
                    Integer.parseInt(req.getParameter("categoryId"));

            Category c = dao.getCategory(id);

            dao.updateStatus(id,
                    !c.getIsActive());

            resp.sendRedirect("OwnerCategoriesServlet");

            break;

        default:

            resp.sendRedirect("OwnerCategoriesServlet");
        }

    }

    @Override
    protected void doPost(HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if(session == null ||
                session.getAttribute("restaurantId") == null) {

            resp.sendRedirect("RestaurantOwnerLogin.html");
            return;
        }

        String action = req.getParameter("action");

        int restaurantId =
                (Integer)session.getAttribute("restaurantId");

        if("add".equals(action)) {

            Category category = new Category();

            category.setRestaurantID(restaurantId);

            category.setCategoryName(
                    req.getParameter("categoryName"));

            category.setDescription(
                    req.getParameter("description"));

            category.setImagePath(
                    req.getParameter("imagePath"));

            category.setIsActive(
                    Boolean.parseBoolean(
                            req.getParameter("active")));

            dao.addCategory(category);

        }

        else if("update".equals(action)) {

            Category category = new Category();

            category.setCategoryID(
                    Integer.parseInt(
                            req.getParameter("categoryId")));

            category.setRestaurantID(restaurantId);

            category.setCategoryName(
                    req.getParameter("categoryName"));

            category.setDescription(
                    req.getParameter("description"));

            category.setImagePath(
                    req.getParameter("imagePath"));

            category.setIsActive(
                    Boolean.parseBoolean(
                            req.getParameter("active")));

            dao.updateCategory(category);

        }

        resp.sendRedirect("OwnerCategoriesServlet");

    }

}