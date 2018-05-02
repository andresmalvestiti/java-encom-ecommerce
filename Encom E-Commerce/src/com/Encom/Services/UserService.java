package com.Encom.Services;

import java.util.List;

import com.Encom.DAO.DAOFactory;
import com.Encom.DAO.UserDAO;
import com.Encom.DTO.UserDTO;
import com.Encom.Model.Credentials;

public class UserService {
	
	private static UserService userService = null;
	private DAOFactory mysqlDAOFactory;
	private UserDAO userDAO;
	
	public UserService() {
		mysqlDAOFactory = DAOFactory.getDAOFactory(1);
		userDAO = mysqlDAOFactory.getUserDAO();
	}
	
	public static UserService getInstance() {
		if (userService == null) {
			userService = new UserService();
		}
		return userService;
	}
	
	public UserDTO login(Credentials c) {
		
		UserDTO user = new UserDTO();
		user = userDAO.authenticate(c);
		return user;
	}
	
	public void logout() {
		
	}
	
	public int createUser(UserDTO user) {
		
		int id = userDAO.store(user);
		return id;
	}
	
	public UserDTO readUser(UserDTO u) throws Exception {

		UserDTO user;
		user = userDAO.findById(u);

		if (user != null) {
			return user;
		} else {
			throw new Exception("The Product id " + u.getId() + " not found");
		}
	}
	
	public boolean updateUser(UserDTO user) {
		
		boolean status;
		status = userDAO.update(user);
		return status;
	}
	
	public boolean deleteUser(UserDTO user) {
		
		boolean status;
		status = userDAO.delete(user);
		return status;
	}
	
	public List<UserDTO> getUsers() {
		List<UserDTO> userList;
		userList = userDAO.selectAll();
		return userList;
	}
}
