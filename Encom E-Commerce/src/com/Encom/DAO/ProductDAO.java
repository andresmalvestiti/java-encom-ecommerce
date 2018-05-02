package com.Encom.DAO;

import java.util.List;
import com.Encom.DTO.ProductDTO;

public interface ProductDAO {
	
	// CRUD Product and more stuff
	
	public Boolean store(ProductDTO product);
	public Boolean delete(ProductDTO product);
	public ProductDTO findById(ProductDTO product);
	public Boolean update(ProductDTO product);
	public List<ProductDTO> selectAll();
	public List<ProductDTO> selectProducts(ProductDTO product);
}
