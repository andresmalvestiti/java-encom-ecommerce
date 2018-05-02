package com.Encom.Controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.Encom.DTO.UserDTO;
import com.Encom.Services.UserService;


@WebServlet("/users")
public class Users extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	UserService userService = UserService.getInstance();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getSession(false)==null || request.getSession().getAttribute("userId")==null) {
			response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Access is denied due to invalid credentials.");
		} else if(request.getSession(false)!=null && (boolean)request.getSession().getAttribute("admin")==false) {
			response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to view this directory or page using the credentials that you supplied.");
		} else {
		
			if (request.getParameter("id") != null) {
				this.readUserById(request, response);
			}else if(request.getQueryString() == null){
				List<UserDTO> result = userService.getUsers();
				String nextJSP = "/admin-users.jsp";
	            forwardListUsers(request, response, result, nextJSP);
			}else {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid query.");
			}
		}
	}
	
	private void readUserById(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		try {
			int id = Integer.parseInt(req.getParameter("id"));	
			
			UserDTO user = new UserDTO();
			user.setId(id);
			
			user = userService.readUser(user);
			req.setAttribute("user", user);
			res.setStatus(HttpServletResponse.SC_OK);
			
			
		} catch (Exception ex) {
			res.sendError(HttpServletResponse.SC_NOT_FOUND, ex.getMessage());
			Logger.getLogger(Products.class.getName()).log(Level.SEVERE, null, ex);
		}
		String nextJSP = "/user-info.jsp";
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP); //aca no uso el forwardListProducts pq es un solo producto
		dispatcher.forward(req, res);
	}
	
	private void forwardListUsers(HttpServletRequest req, HttpServletResponse res, List<UserDTO> userList, String nextJSP)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher(nextJSP);
		req.setAttribute("userList", userList);
		dispatcher.forward(req, res);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");
		if(action!=null) {
			switch (action) {
	        case "add":
	            this.addUser(request, response);
	            break;
	        case "edit":
	            this.editUser(request, response);
	            break;    
			case "delete":
	            this.removeUser(request, response);
	            break;   
			}
		}
	}
	
	private void addUser(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String user = req.getParameter("user");
		String password = req.getParameter("password");
		boolean admin = (Integer.parseInt(req.getParameter("admin")) == 1) ? true : false;
		String name = req.getParameter("name");
		String surname = req.getParameter("surname");
		String dni = req.getParameter("dni");
		String email = req.getParameter("email");
		String form = req.getParameter("register");
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyy-MM-dd");
		Date parsed = null;
		java.sql.Date birthdate = null;
		try {
			parsed = (Date) formatter.parse(req.getParameter("birthdate"));
			birthdate = new java.sql.Date(parsed.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
        UserDTO u = new UserDTO();

		u.setUser(user);
		u.setPassword(password);
		u.setAdmin(admin);
		u.setName(name);
		u.setSurname(surname);
		u.setDni(dni);
		u.setBirthdate(birthdate);
		u.setEmail(email);

		int idUser;
		idUser = userService.createUser(u);
		if (idUser!=0) {
			req.setAttribute("message", "The user has been successfully added.");
            req.setAttribute("idUser", idUser);
            res.setStatus(HttpServletResponse.SC_OK);
		}
		
		if(form!=null) {
			RequestDispatcher dispatcher = req.getRequestDispatcher("./index.jsp");
			dispatcher.forward(req, res);
		} else {
			List<UserDTO> userList = userService.getUsers();
			String nextJSP = "/admin-users.jsp";
	        forwardListUsers(req, res, userList, nextJSP);
		}
		
	}

	private void editUser(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		if(req.getSession(false)==null || req.getSession().getAttribute("userId")==null) {
			res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Access is denied due to invalid credentials.");
		} else if(req.getSession(false)!=null && (boolean)req.getSession().getAttribute("admin")==false) {
			res.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to view this directory or page using the credentials that you supplied.");
		} else {
			int id = Integer.parseInt(req.getParameter("id"));
			String user = req.getParameter("user");
			boolean admin = (Integer.parseInt(req.getParameter("admin")) == 1) ? true : false;
			String name = req.getParameter("name");
			String surname = req.getParameter("surname");
			String dni = req.getParameter("dni");
			String email = req.getParameter("email");
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyy-MM-dd");
			Date parsed = null;
			java.sql.Date birthdate = null;
			try {
				parsed = (Date) formatter.parse(req.getParameter("birthdate"));
				birthdate = new java.sql.Date(parsed.getTime());
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			UserDTO u = new UserDTO();
			u.setId(id);
			u.setUser(user);
			u.setAdmin(admin);
			u.setName(name);
			u.setSurname(surname);
			u.setDni(dni);
			u.setBirthdate(birthdate);
			u.setEmail(email);
			
			boolean success = userService.updateUser(u);
	        String message = null;
	        if (success) {
	            message = "The user has been successfully updated.";
	        }
	        else {
	        	res.setStatus(500);
	        }
	        List<UserDTO> userList = userService.getUsers();
	        req.setAttribute("message", message);
	        res.setStatus(200);
	        String nextJSP = "/admin-users.jsp";
	        forwardListUsers(req, res, userList, nextJSP);
		}
	}
	
	private void removeUser(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		if(req.getSession(false)==null || req.getSession().getAttribute("userId")==null) {
			res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Access is denied due to invalid credentials.");
		} else if(req.getSession(false)!=null && (boolean)req.getSession().getAttribute("admin")==false) {
			res.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to view this directory or page using the credentials that you supplied.");
		} else {
			try {
				int id = Integer.parseInt(req.getParameter("id"));	
				UserDTO user = new UserDTO();
				user.setId(id);
				boolean confirm = userService.deleteUser(user);
				if (confirm) {
					String message = "The user has been successfully removed.";
		            req.setAttribute("message", message);
		            res.setStatus(200);
				}
				List<UserDTO> userList = userService.getUsers();
				String nextJSP = "/admin-users.jsp";
		        forwardListUsers(req, res, userList, nextJSP);
			} catch (Exception e) {
				System.out.println("e");
			}
		}
	}
	
}
