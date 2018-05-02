package com.Encom.Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.Encom.DTO.UserDTO;
import com.Encom.Model.Credentials;
import com.Encom.Services.UserService;


@WebServlet("/authenticate")
public class Authenticate extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	UserService userService = UserService.getInstance();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getSession().getAttribute("userId")!=null) {
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("./login.jsp");
			request.setAttribute("message", "You have already logged in.");
			dispatcher.forward(request, response);

		}else if((request.getParameter("user")!=null) && (request.getParameter("password")!=null)) {
			
			Credentials c = new Credentials();
			c.setUser(request.getParameter("user"));
			c.setPassword(request.getParameter("password"));
			UserDTO currentUser = new UserDTO();
			currentUser = userService.login(c);
			if(currentUser.getUser()!=null) {
				HttpSession session = request.getSession();
				session.setAttribute("userId", currentUser.getId());
				session.setAttribute("userName", currentUser.getUser());
				session.setAttribute("admin", currentUser.isAdmin());
				session.setMaxInactiveInterval(900);	//timeout of 15 minutes
				response.setStatus(HttpServletResponse.SC_OK);
				RequestDispatcher dispatcher = request.getRequestDispatcher("./index.jsp");
				dispatcher.forward(request, response);

				
			} else {
				RequestDispatcher dispatcher = request.getRequestDispatcher("./login.jsp");
				request.setAttribute("message", "Invalid User or Password");
				dispatcher.forward(request, response);
				
			}
		}else {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST,"Invalid parameters.");
		}
	}
	
}
