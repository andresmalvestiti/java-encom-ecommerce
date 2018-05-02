package com.Encom.Controller;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import com.Encom.DTO.ProductDTO;
import com.Encom.Services.ProductService;

@WebServlet("/products")
public class Products extends HttpServlet {
	private static final long serialVersionUID = 1L;

	ProductService productService = ProductService.getInstance();
	
	private static final String DATA_DIRECTORY = "data";
    private static final int MAX_MEMORY_SIZE = 1024 * 1024 * 2;
    private static final int MAX_REQUEST_SIZE = 1024 * 1024;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	
		
			
			if (request.getParameter("id") != null) {
				
				this.readProductById(request, response);
				
			} else if ((request.getParameter("idCategory") != null) && (request.getParameter("idSubcategory")) != null) {
				
				this.selectProducts(request, response);
				
			}else if(request.getQueryString() == null){
				
				this.getAllProducts(request, response);
				
			}else {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid query.");
			}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		if(request.getSession(false)==null || request.getSession().getAttribute("userId")==null) {
			response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Access is denied due to invalid credentials.");
		} else if(request.getSession(false)!=null && (boolean)request.getSession().getAttribute("admin")==false) {
			response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to view this directory or page using the credentials that you supplied.");
		} else {
			String action;
			boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	        if (isMultipart) {
	        	Map<String, String> formFields = new HashMap<String, String>();
	        	formFields = this.contentHandler(request, response);
	        	action = formFields.get("action");
	        	
	        	for(Map.Entry<String, String> entry : formFields.entrySet()) {
	        	    String key = entry.getKey();
	        	    String value = entry.getValue(); 
					request.setAttribute(key, value);
				}
	        }
			else {
				action = request.getParameter("action");
			}
			
			if(action!=null) {
				switch (action) {
		        case "add":
		            this.addProduct(request, response);
		            break;
		        case "edit":
		            this.editProduct(request, response);
		            break;    
				case "delete":
		            this.removeProduct(request, response);
		            break;   
				}
			}
		}
		
	}
	
	private void readProductById(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		if(req.getSession(false)==null || req.getSession().getAttribute("userId")==null) {
			
			res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Access is denied due to invalid credentials.");
			
		} else if(req.getSession(false)!=null && (boolean)req.getSession().getAttribute("admin")==false) {
			
			res.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to view this directory or page using the credentials that you supplied.");
		
		} else {
			try {
				int id = Integer.parseInt(req.getParameter("id"));	
				
				ProductDTO product = new ProductDTO();
				product.setId(id);
				
				product = productService.readProduct(product);
				req.setAttribute("product", product);
				res.setStatus(HttpServletResponse.SC_OK);
				
				
			} catch (Exception ex) {
				res.sendError(HttpServletResponse.SC_NOT_FOUND, ex.getMessage());
				Logger.getLogger(Products.class.getName()).log(Level.SEVERE, null, ex);
			}
			String nextJSP = "/product-info.jsp";
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP); //aca no uso el forwardListProducts pq es un solo producto
			dispatcher.forward(req, res);
		}
	}
	private void selectProducts(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		int idCategory = Integer.parseInt(req.getParameter("idCategory"));
		int idSubcategory = Integer.parseInt(req.getParameter("idSubcategory"));

		ProductDTO product = new ProductDTO();
		product.setIdCategory(idCategory);
		product.setIdSubcategory(idSubcategory);
		
		List<ProductDTO> result;
		result = productService.selectProducts(product);
		res.setStatus(HttpServletResponse.SC_OK);
		String nextJSP = "/product-list.jsp";
		forwardListProducts(req, res, result, nextJSP);
	}
	private void getAllProducts(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		if(req.getSession(false)==null || req.getSession().getAttribute("userId")==null) {
			
			res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Access is denied due to invalid credentials.");
			
		} else if(req.getSession(false)!=null && (boolean)req.getSession().getAttribute("admin")==false) {
			
			res.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to view this directory or page using the credentials that you supplied.");
		
		} else {
			List<ProductDTO> result = productService.getAllProducts();
			String nextJSP = "/admin-products.jsp";
            forwardListProducts(req, res, result, nextJSP);
		}
	}
	private void forwardListProducts(HttpServletRequest req, HttpServletResponse res, List<ProductDTO> productList, String nextJSP)
			throws ServletException, IOException {
		
		RequestDispatcher dispatcher = req.getRequestDispatcher(nextJSP);
		req.setAttribute("productList", productList);
		dispatcher.forward(req, res);
	}

	private void addProduct(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
        String imagePath="no-image.jpg";

    	String name = (String) req.getAttribute("name");
		int idCategory = Integer.parseInt((String) req.getAttribute("idCategory"));
		int idSubcategory = Integer.parseInt((String) req.getAttribute("idSubcategory"));
		BigDecimal price = new BigDecimal((String) req.getAttribute("price"));
		String description = ((req.getAttribute("description") == null) ? "N/A" : (String) req.getAttribute("description"));
		imagePath = (String) req.getAttribute("imageName");
        
        ProductDTO product = new ProductDTO();
		product.setIdCategory(idCategory);
		product.setIdSubcategory(idSubcategory);
		product.setName(name);
		product.setDescription(description);
		product.setPrice(price);
		product.setImagePath(imagePath);
		
		Boolean success;
		success = productService.createProduct(product);
		if (success) {
            req.setAttribute("message", "The product has been successfully added.");
            res.setStatus(HttpServletResponse.SC_OK);
		}
		else {
			req.setAttribute("message", "The product already exist or could not be added.");
		}

		List<ProductDTO> productList = productService.getAllProducts();
		String nextJSP = "/admin-products.jsp";
        forwardListProducts(req, res, productList, nextJSP);
	}
	
	private void editProduct(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		int id = Integer.parseInt((String)req.getAttribute("id"));
		int idCategory = Integer.parseInt((String) req.getAttribute("idCategory"));
		int idSubcategory = Integer.parseInt((String) req.getAttribute("idSubcategory"));
		String name = (String) req.getAttribute("name");
		String description= (String) req.getAttribute("description");
		BigDecimal price= new BigDecimal((String)req.getAttribute("price"));
		String imagePath= (String) req.getAttribute("imageName");
		
		ProductDTO product = new ProductDTO();
		product.setId(id);
		product.setIdCategory(idCategory);
		product.setIdSubcategory(idSubcategory);
		product.setName(name);
		product.setDescription(description);
		product.setPrice(price);
		product.setImagePath(imagePath);
		
		boolean success = productService.updateProduct(product);

        if (success) {
            req.setAttribute("id", id);
            req.setAttribute("message", "The product has been successfully updated.");
            res.setStatus(HttpServletResponse.SC_OK);
            
        }
        else {
        	req.setAttribute("message", "The product does not exist or could not be updated.");
        }
        List<ProductDTO> productList = productService.getAllProducts();
        String nextJSP = "/admin-products.jsp";
        forwardListProducts(req, res, productList, nextJSP);
	}

	private void removeProduct(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		try {
			int id = Integer.parseInt(req.getParameter("id"));	
			ProductDTO product = new ProductDTO();
			product.setId(id);
			
			boolean confirm = productService.deleteProduct(product);
			if (confirm) {
	            req.setAttribute("message", "The product has been successfully removed.");
	            res.setStatus(HttpServletResponse.SC_OK);
			}
			else {
				req.setAttribute("message", "The product does not exist or could not be removed.");
			}
			List<ProductDTO> productList = productService.getAllProducts();
			String nextJSP = "/admin-products.jsp";
	        forwardListProducts(req, res, productList, nextJSP);
		} catch (Exception e) {
			System.err.println("e");
		}
		
	}

	private Map<String, String> contentHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		/*// Check that we have a file upload request
        boolean isMultipart = ServletFileUpload.isMultipartContent(req);

        if (!isMultipart) {
            return;
        }*/

        // Create a factory for disk-based file items
        DiskFileItemFactory factory = new DiskFileItemFactory();

        // Sets the size threshold beyond which files are written directly to
        // disk.
        factory.setSizeThreshold(MAX_MEMORY_SIZE);

        // Sets the directory used to temporarily store files that are larger
        // than the configured size threshold. We use temporary directory for
        // java
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        // constructs the folder where uploaded file will be stored
        String uploadFolder = getServletContext().getRealPath("")
                + File.separator + DATA_DIRECTORY;

        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);

        // Set overall request size constraint
        upload.setSizeMax(MAX_REQUEST_SIZE);

        try {
            // Parse the request
            List items = upload.parseRequest(req);
            Map<String, String> formFields = new HashMap<String, String>();
            Iterator iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();

                if (!item.isFormField()) {
                	if(item.getSize()!=0) {
	                	String fileName = new File(item.getName()).getName();
	                    formFields.put("imageName", fileName);
	                    String filePath = uploadFolder + File.separator + fileName;
	                    File uploadedFile = new File(filePath);
	                    System.out.println(filePath);
	                    // saves the file to upload directory
	                    item.write(uploadedFile);
                	}
                	else {
                		formFields.put("imageName", "no-image.jpg");
                	}
                }
                else {
                	String name = item.getFieldName();
                    String value = item.getString();
                    formFields.put(name, value);
                }
            }

            // displays done.jsp page after upload finished
            return formFields;

        } catch (FileUploadException ex) {
            throw new ServletException(ex);
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
	}
	
}
