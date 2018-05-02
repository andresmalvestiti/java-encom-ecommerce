<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.Encom.DTO.UserDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
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
<title>Admin Panel</title>
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
		UserDTO user = (UserDTO)request.getAttribute("user");
		SimpleDateFormat formatter = new SimpleDateFormat("yyy-MM-dd");
		
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
				<li class="breadcrumb-item active">Tablero</li>
			</ol>

			<!-- Example DataTables Card-->
			<div class="row">
				<div class="col-12">
					<h1 class="page-header">Admin Panel</h1>
					<hr>
				</div>
			</div>

			<!-- /.row -->
			<div class="row justify-content-center">
				<div class="col-lg-6 col-md-10 col-sm-12">
					<div class="card">
						<div class="card-header font-weight-bold">Descripción</div>
						<div class="card-body">
						
						<h5>Usuarios autorizados:</h5>
						Administradores
						<hr>
						<h5>Topics:</h5>
						Alta Productos
						<br>
						Baja Productos
						<br>
						Modificación de Productos
						<br>
						<hr>
						Alta Usuarios
						<br>
						Baja Usuarios
						<br>
						Modificación de Usuarios
						<br>
						</div>
						<div class="card-footer">
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
