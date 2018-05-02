package com.Encom.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import com.Encom.DTO.ProductDTO;

public class MysqlProductDAO implements ProductDAO {

	// Singleton
	private static MysqlProductDAO productDAO = null;

	private MysqlProductDAO() {
	}

	public static MysqlProductDAO getInstance() {
		if (productDAO == null) {
			productDAO = new MysqlProductDAO();
		}
		return productDAO;
	}

	@Override
	public Boolean store(ProductDTO product) {
		
		Connection connection = null;
		Statement stmt = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		
		int status = 0;
		try {
			connection = MysqlDAOFactory.createConnection();
			stmt = connection.createStatement();
			rs = stmt.executeQuery("SELECT MAX(idProducto) FROM producto");
			int id = 1;
			if (rs.next())
				id = rs.getInt(1) + 1;
			ps = connection.prepareStatement(
					"INSERT INTO producto (idProducto, subcategoria_idCat, subcategoria_idSubcat, nombre, descripcion, precio, img_path)"
							+ " VALUES (?, ?, ?, ?, ?, ?, ?)");
			ps.setInt(1, id);
			ps.setInt(2, product.getIdCategory());
			ps.setInt(3, product.getIdSubcategory());
			ps.setString(4, product.getName());
			ps.setString(5, product.getDescription());
			ps.setBigDecimal(6, product.getPrice());
			ps.setString(7, product.getImagePath());
			status = ps.executeUpdate();

		} catch (ClassNotFoundException | SQLException e) {
			 System.err.println("Caught Exception: " + e.getMessage());
		} finally {
			try { stmt.close(); } catch (Exception e) { /* ignored */ }
			try { rs.close(); } catch (Exception e) { /* ignored */ }
		    try { ps.close(); } catch (Exception e) { /* ignored */ }
		    try { connection.close(); } catch (Exception e) { /* ignored */ }
		}

		if (status == 1)
			return true;
		else
			return false;

	}

	@Override
	public Boolean delete(ProductDTO product) {

		Connection connection = null;
		PreparedStatement ps = null;
		
		Boolean state = false;
		try {
			connection = MysqlDAOFactory.createConnection();
			ps = connection.prepareStatement("DELETE FROM producto WHERE idProducto = ?");
			ps.setInt(1, product.getId());
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
	public ProductDTO findById(ProductDTO product) {

		ProductDTO p = new ProductDTO();
		Connection connection = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			connection = MysqlDAOFactory.createConnection();
			ps = connection.prepareStatement(
					"SELECT idProducto, subcategoria_idCat, subcategoria_idSubcat, nombre, descripcion, precio, img_path FROM producto WHERE idProducto = ?");
			ps.setInt(1, product.getId());
			rs = ps.executeQuery();

			while (rs.next()) {
				p.setId(rs.getInt(1));
				p.setIdCategory(rs.getInt(2));
				p.setIdSubcategory(rs.getInt(3));
				p.setName(rs.getString(4));
				p.setDescription(rs.getString(5));
				p.setPrice(rs.getBigDecimal(6));
				p.setImagePath(rs.getString(7));
			}

		} catch (ClassNotFoundException | SQLException e) {
			System.err.println("Caught Exception: " + e.getMessage());
		} finally {
			try { rs.close(); } catch (Exception e) { /* ignored */ }
		    try { ps.close(); } catch (Exception e) { /* ignored */ }
		    try { connection.close(); } catch (Exception e) { /* ignored */ }
		}

		return p;
	}

	@Override
	public Boolean update(ProductDTO product) {
		
		int status = 0;
		Connection connection = null;
		PreparedStatement ps = null;
		try {
			connection = MysqlDAOFactory.createConnection();
			ps = connection.prepareStatement(
					"UPDATE producto "
					+ "SET subcategoria_idCat = ?, "
					+ "subcategoria_idSubcat = ?, "
					+ "nombre = ?, "
					+ "descripcion = ?, "
					+ "precio = ?, "
					+ "img_path = ?"
					+ " WHERE idProducto = ?");
			
			ps.setInt(1, product.getIdCategory());
			ps.setInt(2, product.getIdSubcategory());
			ps.setString(3, product.getName());
			ps.setString(4, product.getDescription());
			ps.setBigDecimal(5, product.getPrice());
			ps.setString(6, product.getImagePath());
			ps.setInt(7, product.getId());
			status = ps.executeUpdate();

		} catch (ClassNotFoundException | SQLException e) {
			System.err.println("Caught Exception: " + e.getMessage());
		} finally {
			try { ps.close(); } catch (Exception e) { /* ignored */ }
		    try { connection.close(); } catch (Exception e) { /* ignored */ }
		}

		if (status == 1) {
			return true;
		}
		else {
			return false;
			}
	}

	@Override
	public List<ProductDTO> selectAll() {

		List<ProductDTO> products = new ArrayList<ProductDTO>();
		Connection connection = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			connection = MysqlDAOFactory.createConnection();
			ps = connection.prepareStatement("SELECT idProducto, subcategoria_idCat, subcategoria_idSubcat, nombre, descripcion, precio, img_path FROM producto");
			rs = ps.executeQuery();

			while (rs.next()) {
				ProductDTO p = new ProductDTO();
				p.setId(rs.getInt(1));
				p.setIdCategory(rs.getInt(2));
				p.setIdSubcategory(rs.getInt(3));
				p.setName(rs.getString(4));
				p.setDescription(rs.getString(5));
				p.setPrice(rs.getBigDecimal(6));
				p.setImagePath(rs.getString(7));
				products.add(p);
			}
		} catch (ClassNotFoundException | SQLException e) {
			System.err.println("Caught Exception: " + e.getMessage());
		} finally {
			try { rs.close(); } catch (Exception e) { /* ignored */ }
		    try { ps.close(); } catch (Exception e) { /* ignored */ }
		    try { connection.close(); } catch (Exception e) { /* ignored */ }
		}
		return products;
	}

	@Override
	public List<ProductDTO> selectProducts(ProductDTO product) {
		/*
		 * Busca productos por idCategoria y idSubcategoria Si existen productos,
		 * devuelve arraylist lleno, caso contrario devuelve arraylist vacio.
		 */
		List<ProductDTO> products = new ArrayList<ProductDTO>();
		Connection connection = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			connection = MysqlDAOFactory.createConnection();
			ps = connection.prepareStatement(
					"SELECT idProducto, nombre, descripcion, precio, img_path FROM producto WHERE subcategoria_idCat = ? AND subcategoria_idSubcat = ?");
			ps.setInt(1, product.getIdCategory());
			ps.setInt(2, product.getIdSubcategory());
			rs = ps.executeQuery();

			while (rs.next()) {
				ProductDTO p = new ProductDTO();
				p.setId(rs.getInt(1));
				p.setName(rs.getString(2));
				p.setDescription(rs.getString(3));
				p.setPrice(rs.getBigDecimal(4));
				p.setImagePath(rs.getString(5));
				products.add(p);
			}

		} catch (ClassNotFoundException | SQLException e) {
			System.err.println("Caught Exception: " + e.getMessage());
		} finally {
			try { rs.close(); } catch (Exception e) { /* ignored */ }
		    try { ps.close(); } catch (Exception e) { /* ignored */ }
		    try { connection.close(); } catch (Exception e) { /* ignored */ }
		}

		return products;
	}

}
