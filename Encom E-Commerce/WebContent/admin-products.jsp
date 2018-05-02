<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="com.Encom.DTO.ProductDTO"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="images/encom-icon.png">
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>Products</title>
  <!-- Bootstrap core CSS-->
  <link href="source/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom fonts for this template-->
  <link href="source/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <!-- Page level plugin CSS-->
  <link href="source/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
  <!-- Custom styles for this template-->
  <link href="source/css/sb-admin.css" rel="stylesheet">

<title>Admin Panel</title>
<%
	
	ArrayList<ProductDTO> products = new ArrayList<ProductDTO>();
	products = (ArrayList<ProductDTO>) request.getAttribute("productList");
	
  	HttpSession sesion = request.getSession();
	String guest="hidden";
	boolean admin = false;
	String userName = null;
	if(sesion.getAttribute("userId")!=null){
		guest="";
		userName = (String)session.getAttribute("userName");
	}
	if(sesion.getAttribute("admin") != null){
	    admin = (Boolean) request.getSession().getAttribute("admin");
	}
%>
</head>

<body class="fixed-nav sticky-footer bg-dark" id="page-top">
  <!-- Navigation-->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
    <a class="navbar-brand" href="./admin-home.jsp">Admin Panel</a>
    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
      <ul class="navbar-nav navbar-sidenav" id="exampleAccordion">
        <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Link">
          <a class="nav-link" href="./productServlet">
            <i class="fa fa-gift"></i>
            <span class="nav-link-text">Productos</span>
          </a>
        </li>
        <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Link">
          <a class="nav-link" href="./users">
            <i class="fa fa-user"></i>
            <span class="nav-link-text">Usuarios</span>
          </a>
        </li>
      </ul>       

      <ul class="navbar-nav ml-auto">
      		<li class="nav-item">
            	<a class="nav-link" href="./index.jsp"><i class="fa" aria-hidden="true"></i> Home</a>
            </li>
        	<%  if((!admin)){
        		response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to view this directory or page using the credentials that you supplied.");
            	} else if(userName!=null){%>
            	<li class="nav-item">
            		 <a class="nav-link"><i class="fa fa-user" aria-hidden="true"></i> Bienvenido <%=userName%></a>
            	</li>
            	<li class="nav-item">
            		 <a class="nav-link" href="./logout"><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</a>
            	</li>
            	<% } %>
      </ul>
    </div>
  </nav>
    <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="./admin-home.jsp">Tablero</a>
        </li>
        <li class="breadcrumb-item active">Productos</li>
      </ol>
      <!-- Example DataTables Card-->
      <div class="card mb-3">
        <div class="card-header">
          <i class="fa fa-table"></i> Productos</div>
        <div class="card-body">
       
         <% 
         	String message = (String)request.getAttribute("message");
         	if(request.getAttribute("message")!=null && response.getStatus()==200){ %>
         		<div class="alert alert-success alert-dismissable">
					<a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
					<strong>Success!</strong> <%=message %>
				</div>
		   <% } else if(request.getAttribute("message")!=null){%>
				<div class="alert alert-danger alert-dismissable">
					<a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
					<strong>Error!</strong> <%=message %>
				</div>
		   <% } %>
        <form action="./products" method="POST" id="productForm" role="form" >              
          <input type="hidden" id="id" name="id">
          <input type="hidden" id="action" name="action">
          
          <div class="table table-responsive">
            <table class="table table-bordered" id="" width="100%" cellspacing="0">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Categoria</th>
                  <th>Subcategoria</th>
                  <th>Nombre</th>
                  <th>Precio</th>
                  <th>Acciones</th>
                </tr>
              </thead>
              <tfoot>
                <tr>
                  <th>ID</th>
                  <th>Categoria</th>
                  <th>Subcategoria</th>
                  <th>Nombre</th>
                  <th>Precio</th>
                  <th>Acciones</th>
                </tr>
              </tfoot>
              <tbody>
               <%  if(products!=null){ 
			
		        	Iterator<ProductDTO> iterator = products.iterator();
		      		while (iterator.hasNext()) {
		      			ProductDTO p = iterator.next();
				%>
                <tr>
                  <td><%=p.getId()%></td>
                  <td><%=p.getIdCategory()%></td>
                  <td><%=p.getIdSubcategory() %></td>
                  <td><%=p.getName() %></td>
                  <td><%=p.getPrice() %></td>
                  <td class="text-center">
                  <a href="./products?id=<%=p.getId()%>" class="text-primary">
		          	<span class="fa fa-eye"></span>Ver
		          </a> | 
		          <%int id=p.getId(); %>
               	  <a href="#" class="text-danger" id="remove" 
                  	onclick="document.getElementById('action').value = 'delete';
               		document.getElementById('id').value = '<%=id%>'; 
               		document.getElementById('productForm').submit();"> 
                    <span class="fa fa-trash-o"/></span>Eliminar
                 </a>
                  	
                  </td>
                </tr>
                <%  }
		      	  }
               	  else{
				%>
				<tr>No hay productos cargados.</tr>
				<% } %>
              </tbody>
            </table>
          </div>
          </form>
          <div class="row">
          	<div class="col-md-11">
          	</div>
          	<div class="col-md-1">
          	<a href="create-product.jsp" class="btn btn-success"><span class="fa fa-plus"></span> Agregar</a>
          	</div>
          </div>
        </div>
        <div class="card-footer small text-muted">Productos</div>
      </div>
    </div>
    <!-- /.container-fluid-->
    <!-- /.content-wrapper-->
    <footer class="sticky-footer">
      <div class="container">
        <div class="text-center">
          <small>Copyright © Encom 2017</small>
        </div>
      </div>
    </footer>
    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fa fa-angle-up"></i>
    </a>
    <!-- Logout Modal-->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
          <div class="modal-footer">
            <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
            <a class="btn btn-primary" href="login.html">Logout</a>
          </div>
        </div>
      </div>
    </div>
    
  </div>

  	<!-- Bootstrap core JavaScript-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    <!-- Page level plugin JavaScript-->
    <script src="vendor/datatables/jquery.dataTables.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.js"></script>
    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin.min.js"></script>
    <!-- Custom scripts for this page-->
    <script src="js/sb-admin-datatables.min.js"></script>
    
</body>
</html>