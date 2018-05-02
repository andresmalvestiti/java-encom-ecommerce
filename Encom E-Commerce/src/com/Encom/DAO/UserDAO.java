package com.Encom.DAO;

import java.util.List;
import com.Encom.DTO.UserDTO;
import com.Encom.Model.Credentials;

public interface UserDAO {

	// CRUD Product and more stuff
		public UserDTO authenticate(Credentials credentials);
		public int store(UserDTO user);
		public Boolean delete(UserDTO user);
		public UserDTO findById(UserDTO user);
		public Boolean update(UserDTO user);
		public List<UserDTO> selectAll();
}
