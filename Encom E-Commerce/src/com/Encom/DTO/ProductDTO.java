package com.Encom.DTO;

import java.math.BigDecimal;

public class ProductDTO {

	private Integer id;
	private Integer idCategory;
	private Integer idSubcategory;
	private String name;
	private String description;
	private BigDecimal price;
	private String imagePath;

	public ProductDTO() {
	}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getIdCategory() {
		return idCategory;
	}

	public void setIdCategory(Integer idCategory) {
		this.idCategory = idCategory;
	}

	public Integer getIdSubcategory() {
		return idSubcategory;
	}

	public void setIdSubcategory(Integer idSubcategory) {
		this.idSubcategory = idSubcategory;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

}
