package com.Encom.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import com.Encom.DTO.UserDTO;
import com.Encom.Model.Credentials;


public class MysqlUserDAO implements UserDAO {

	// Singleton
	private static MysqlUserDAO userDAO = null;

	private MysqlUserDAO() {
	}

	public static MysqlUserDAO getInstance() {
		if (userDAO == null) {
			userDAO = new MysqlUserDAO();
		}
		return userDAO;
	}
	
	@Override
	public int store(UserDTO user) {
		
		Connection connection = null;
		Statement stmt = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		
		int id = 0;
		try {
			connection = MysqlDAOFactory.createConnection();
			stmt = connection.createStatement();
			rs = stmt.executeQuery("SELECT MAX(idCliente) FROM cliente");
			id = 1;
			if (rs.next())
				id = rs.getInt(1) + 1;
			ps = connection.prepareStatement(
					"INSERT INTO cliente (idCliente, usuario, contrasenia, tipo_usuario, nombre, apellido, dni, fec_nac, email)"
							+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
			ps.setInt(1, id);
			ps.setString(2, user.getUser());
			ps.setString(3, user.getPassword());
			ps.setBoolean(4, user.isAdmin());
			ps.setString(5, user.getName());
			ps.setString(6, user.getSurname());
			ps.setString(7, user.getDni());
			ps.setDate(8, user.getBirthdate());
			ps.setString(9, user.getEmail());
			ps.executeUpdate();

		} catch (ClassNotFoundException | SQLException e) {
			System.err.println("Caught Exception: " + e.getMessage());
		} finally {
			try { stmt.close(); } catch (Exception e) { /* ignored */ }
			try { rs.close(); } catch (Exception e) { /* ignored */ }
		    try { ps.close(); } catch (Exception e) { /* ignored */ }
		    try { connection.close(); } catch (Exception e) { /* ignored */ }
		}
		return id;
	}

	@Override
	public Boolean delete(UserDTO user) {
		
		Connection connection = null;
		PreparedStatement ps = null;
		
		Boolean state = false;
		try {
			connection = MysqlDAOFactory.createConnection();
			ps = connection.prepareStatement("DELETE FROM cliente WHERE idCliente = ?");
			ps.setInt(1, user.getId());
			int error = ps.executeUpdate();
			if (error != 0) {
				state = true;
			}
		} catch (ClassNotFoundException | SQLException e) {
			System.err.println("Caught Exception: " + e.getMessage());
		} finally {
			try { ps.close(); } catch (Exception e) { /* ignored */ }
		    try { connection.close(); } catch (Exception e) { /* ignored */ }
		}
		return state;
	}

	@Override
	public UserDTO findById(UserDTO user) {
		
		UserDTO u = new UserDTO();
		Connection connection = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			connection = MysqlDAOFactory.createConnection();
			ps = connection.prepareStatement(
					"SELECT idCliente, usuario, tipo_usuario, nombre, apellido, dni, fec_nac, email FROM cliente WHERE idCliente = ?");
			ps.setInt(1, user.getId());
			rs = ps.executeQuery();

			while (rs.next()) {
				u.setId(rs.getInt(1));
				u.setUser(rs.getString(2));
				u.setAdmin(rs.getBoolean(3));
				u.setName(rs.getString(4));
				u.setSurname(rs.getString(5));
				u.setDni(rs.getString(6));
				u.setBirthdate(rs.getDate(7));
				u.setEmail(rs.getString(8));
			}
		} catch (ClassNotFoundException | SQLException e) {
			System.err.println("Caught Exception: " + e.getMessage());
		} finally {
			try { rs.close(); } catch (Exception e) { /* ignored */ }
		    try { ps.close(); } catch (Exception e) { /* ignored */ }
		    try { connection.close(); } catch (Exception e) { /* ignored */ }
		}
		return u;
	}

	@Override
	public Boolean update(UserDTO user) {
		System.out.println("entro");
		int status = 0;
		Connection connection = null;
		PreparedStatement ps = null;
		try {
			connection = MysqlDAOFactory.createConnection();
			ps = connection.prepareStatement(
					"UPDATE cliente "
					+ "SET tipo_usuario = ?, "
					+ "nombre = ?, "
					+ "apellido = ?, "
					+ "dni = ?, "
					+ "fec_nac = ?, "
					+ "email = ? "
					+ "WHERE idCliente = ?");

			ps.setBoolean(1, user.isAdmin());
			ps.setString(2, user.getName());
			ps.setString(3, user.getSurname());
			ps.setString(4, user.getDni());
			ps.setDate(5, user.getBirthdate());
			ps.setString(6, user.getEmail());
			ps.setInt(7, user.getId());
			status = ps.executeUpdate();
			
		} catch (ClassNotFoundException | SQLException e) {
			System.err.println("Caught Exception: " + e.getMessage());
		} finally {
			try { ps.close(); } catch (Exception e) { /* ignored */ }
		    try { connection.close(); } catch (Exception e) { /* ignored */ }
		}

		if (status == 1) {
			return true;
		
		}else {
			return false;
		}
	}

	@Override
	public List<UserDTO> selectAll() {
		
		List<UserDTO> users = new ArrayList<UserDTO>();
		Connection connection = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			connection = MysqlDAOFactory.createConnection();
			ps = connection.prepareStatement("SELECT idCliente, usuario, tipo_usuario, nombre, apellido, dni, fec_nac, email FROM cliente");
			rs = ps.executeQuery();

			while (rs.next()) {
				UserDTO u = new UserDTO();
				u.setId(rs.getInt(1));
				u.setUser(rs.getString(2));
				u.setAdmin(rs.getBoolean(3));
				u.setName(rs.getString(4));
				u.setSurname(rs.getString(5));
				u.setDni(rs.getString(6));
				u.setBirthdate(rs.getDate(7));
				u.setEmail(rs.getString(8));
				users.add(u);
			}
		} catch (ClassNotFoundException | SQLException e) {
			System.err.println("Caught Exception: " + e.getMessage());
		} finally {
			try { rs.close(); } catch (Exception e) { /* ignored */ }
		    try { ps.close(); } catch (Exception e) { /* ignored */ }
		    try { connection.close(); } catch (Exception e) { /* ignored */ }
		}
		return users;
	}

	@Override
	public UserDTO authenticate(Credentials credentials) {
		
		UserDTO u = new UserDTO();
		Connection connection = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			connection = MysqlDAOFactory.createConnection();
			ps = connection.prepareStatement(
					"SELECT idCliente, usuario, tipo_usuario FROM cliente WHERE usuario = ? AND contrasenia = ?");
			ps.setString(1, credentials.getUser());
			ps.setString(2, credentials.getPassword());
			rs = ps.executeQuery();

			if (rs.next()) {
				u.setId(rs.getInt(1));
				u.setUser(rs.getString(2));
				u.setAdmin(rs.getBoolean(3));
			}
		} catch (ClassNotFoundException | SQLException e) {
			System.err.println("Caught Exception: " + e.getMessage());
		} finally {
			try { rs.close(); } catch (Exception e) { /* ignored */ }
		    try { ps.close(); } catch (Exception e) { /* ignored */ }
		    try { connection.close(); } catch (Exception e) { /* ignored */ }
		}
		return u;
	}
	
}
