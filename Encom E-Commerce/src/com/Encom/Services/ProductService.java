package com.Encom.Services;

import java.util.List;
import com.Encom.DAO.DAOFactory;
import com.Encom.DAO.ProductDAO;
import com.Encom.DTO.ProductDTO;

public class ProductService {

	private static ProductService productService = null;
	private DAOFactory mysqlDAOFactory;
	private ProductDAO productDAO;

	private ProductService() {
		mysqlDAOFactory = DAOFactory.getDAOFactory(1);
		productDAO = mysqlDAOFactory.getProductDAO();
	}

	public static ProductService getInstance() {
		if (productService == null) {
			productService = new ProductService();
		}
		return productService;
	}

	public boolean createProduct(ProductDTO p) {
		
		boolean status;
		status = productDAO.store(p);
		return status;
	}

	public boolean updateProduct(ProductDTO p) {
		
		boolean status;
		status = productDAO.update(p);
		return status;
		
	}

	public ProductDTO readProduct(ProductDTO p) throws Exception {

		ProductDTO product;
		product = productDAO.findById(p);

		if (product != null) {
			return product;
		} else {
			throw new Exception("The Product id " + p.getId() + " not found");
		}
	}
	
	public List<ProductDTO> selectProducts(ProductDTO p) {
		
		List<ProductDTO> productList;
		productList = productDAO.selectProducts(p);
		return productList;
	}
	
	public List<ProductDTO> getAllProducts() {
		
		List<ProductDTO> productList;
		productList = productDAO.selectAll();
		return productList;
	}

	public boolean deleteProduct(ProductDTO p) {

		boolean status;
		status = productDAO.delete(p);
		return status;
	}

}
