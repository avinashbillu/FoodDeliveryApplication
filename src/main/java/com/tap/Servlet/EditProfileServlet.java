package com.tap.Servlet;

import java.io.IOException;

import com.tap.DAOImp.UserDAOImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {

    private UserDAOImpl userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {

            response.sendRedirect("LoginPage.html");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");

        // Always fetch latest data from DB
        User user = userDAO.getUser(sessionUser.getUserID());

        request.setAttribute("user", user);

        request.getRequestDispatcher("EditProfile.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {

            response.sendRedirect("LoginPage.html");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");

        // ---------- Read Form ----------

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone=request.getParameter("phone");
        String address = request.getParameter("address");
        if(username==null || username.trim().length()<3){

            request.setAttribute("error",
                    "Username must contain at least 3 characters.");

            doGet(request,response);
            return;
        }

        if(email==null || !email.contains("@")){

            request.setAttribute("error",
                    "Please enter a valid email.");

            doGet(request,response);
            return;
        }

        if(phone!=null &&
           !phone.isEmpty() &&
           !phone.matches("\\d{10}")){

            request.setAttribute("error",
                    "Phone number must contain exactly 10 digits.");

            doGet(request,response);
            return;
        }

        if(address==null || address.trim().isEmpty()){

            request.setAttribute("error",
                    "Address cannot be empty.");

            doGet(request,response);
            return;
        }
        // ---------- Get Existing User ----------

        User user = userDAO.getUser(sessionUser.getUserID());

        // ---------- Update Fields ----------

        user.setUserName(username);
        user.setEmail(email);
        user.setAddress(address);

        // ---------- Save ----------

        userDAO.updateUser(user);
        request.getSession().setAttribute(
                "success",
                "Profile updated successfully.");
        // ---------- Update Session ----------

        session.setAttribute("user", user);
        session.setAttribute("email", user.getEmail());

        response.sendRedirect("callProfileServlet");
    }
}