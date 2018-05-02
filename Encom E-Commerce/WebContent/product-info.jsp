<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.Encom.DTO.ProductDTO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="icon" href="images/encom-icon.png">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Product info</title>
<!-- Bootstrap core CSS-->
<link href="source/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Custom fonts for this template-->
<link href="source/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<!-- Page level plugin CSS-->
<link href="source/vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">
<!-- Custom styles for this template-->
<link href="source/css/sb-admin.css" rel="stylesheet">

<title>Admin Panel</title>
</head>

	<%
		ProductDTO product = (ProductDTO)request.getAttribute("product");
	%>
<script>
    function checkValidOption(){
        var category = document.getElementById('idCategory');
        var subcategory = document.getElementById('idSubcategory');
        category.onchange = function () { fieldcheck(); }
        subcategory.onchange = function () { fieldcheck(); }
        fieldcheck();
        
        function fieldcheck() {
            switch(category.value) {
            case '1':
            	subcategory.options[0].label = 'Intel';
            	subcategory.options[1].label = 'AMD';
                break;
            case '2':
            	subcategory.options[0].label = 'Discos Rigidos';
            	subcategory.options[1].label = 'Discos de Estado Solido';
                break;
            case '3':
            	subcategory.options[0].label = 'DDR3';
            	subcategory.options[1].label = 'DDR4';
                break;
            case '4':
            	subcategory.options[0].label = 'Genericas';
                subcategory.options[1].label = '+80';
                break;
            case '5':
            	subcategory.options[0].label = 'AM4';
            	subcategory.options[1].label = '1150';
                break;
            }
        }
    }
</script>
	<%
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
<body class="fixed-nav sticky-footer bg-dark" id="page-top">
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top"
		id="mainNav"> <a class="navbar-brand" href="./admin-home.jsp">Admin Panel</a>
	<button class="navbar-toggler navbar-toggler-right" type="button"
		data-toggle="collapse" data-target="#navbarResponsive"
		aria-controls="navbarResponsive" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarResponsive">
		<ul class="navbar-nav navbar-sidenav" id="exampleAccordion">
			<li class="nav-item" data-toggle="tooltip" data-placement="right"
				title="Link"><a class="nav-link" href="./products"> <i
					class="fa fa-gift" aria-hidden="true"></i> <span class="nav-link-text">Productos</span>
			</a></li>
			<li class="nav-item" data-toggle="tooltip" data-placement="right"
				title="Link"><a class="nav-link" href="./users"> <i
					class="fa fa-user" aria-hidden="true"></i> <span class="nav-link-text">Usuarios</span>
			</a></li>
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
				<li class="breadcrumb-item"><a href="./admin-home.jsp">Tablero</a></li>
				<li class="breadcrumb-item active">Productos</li>
			</ol>

			<!-- Example DataTables Card-->
			<div class="row">
				<div class="col-12">
					<h1 class="page-header">Modificar Producto</h1>
					<hr>
				</div>
			</div>

			<!-- /.row -->
			<div class="row justify-content-center">
				<div class="col-lg-6 col-md-10 col-sm-12">
					<div class="card">
						<div class="card-header font-weight-bold">Formulario</div>
						<div class="card-body">
						
						<%if(product==null){ %>
						<div class="alert alert-danger alert-dismissable">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
							<strong>Error!</strong> Did not specify product.
						</div>
						<% } else { %>
							<form role="form" method="POST" action="./products" encType="multipart/form-data" id="productForm" name="productForm">
								<div class="form-group">
									<input type="hidden" value="edit" name="action" id="action"> 
								</div>
								<div class="form-group">
									<label>ID</label> 
									<input type="hidden" value="<%=product.getId()%>" name="id" class="form-control">
									<input type="text" value="<%=product.getId()%>" name="idProducto" class="form-control" disabled>
								</div>
								<div class="form-group">
									<label>Nombre</label> 
									<input type="text" value="<%=product.getName()%>" name="name" class="form-control" required>
								</div>
									<div class="form-group">
									<label>Categoria</label>
									<select class="form-control" type="text" name="idCategory" id="idCategory" onchange="checkValidOption();" required>
								        <option value="1">Microprocesadores</option>
								        <option value="2">Almacenamiento</option>
								        <option value="3">Memorias</option>
								        <option value="4">Fuentes</option>
								        <option value="5">Motherboards</option>
								    </select>
								    </div>
								    <div class="form-group">
								    <label>Subcategoria</label>
								    <select class="form-control" type="text" name="idSubcategory" id="idSubcategory" onchange="checkValidOption();" required>
								        <option value="1">Intel</option>
								        <option value="2">AMD</option>
								    </select>
								    </div>
								
								<div class="form-group">
									<label>Precio</label> 
									<input name="price" value="<%=product.getPrice()%>" class="form-control" type="number" min="1" max="9999999" step="1"required>
									
								</div>
								<div class="form-group">
									<label>Descripcion</label>
									<textarea type="text" name="description" class="form-control" rows="3"><%=product.getDescription()%></textarea>
								</div>
								<div class="form-group">
									<label>Imagen</label> <input type="file" accept="image/jpg" name="imageName" value="<%=product.getImagePath()%>">
								</div>

								
								<button type="submit" class="btn btn-primary">Editar</button>
								<button type="reset" class="btn btn-default">Limpiar</button>
							</form>
						<% } %>
						</div>
					</div>
				</div>
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
		<a class="scroll-to-top rounded" href="#page-top"> <i
			class="fa fa-angle-up"></i>
		</a>
		<!-- Logout Modal-->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Ready to
							Leave?</h5>
						<button class="close" type="button" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body">Select "Logout" below if you are
						ready to end your current session.</div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button"
							data-dismiss="modal">Cancel</button>
						<a class="btn btn-primary" href="login.html">Logout</a>
					</div>
				</div>
			</div>
		</div>

	</div>

	<!-- Bootstrap core JavaScript-->
	<scriptl src="vendor/jquery/jquery.min.js">
	</script> <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script> <!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script> <!-- Page level plugin JavaScript-->
	<script src="vendor/datatables/jquery.dataTables.js"></script> <script
		src="vendor/datatables/dataTables.bootstrap4.js"></script> <!-- Custom scripts for all pages-->
	<script src="js/sb-admin.min.js"></script> <!-- Custom scripts for this page-->
	<script src="js/sb-admin-datatables.min.js"></script>
</body>
</html>