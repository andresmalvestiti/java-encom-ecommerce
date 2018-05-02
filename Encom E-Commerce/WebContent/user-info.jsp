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
<title>User info</title>
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
				<li class="breadcrumb-item"><a href="./admin-home.jsp">Tablero</a></li>
				<li class="breadcrumb-item active">Usuarios</li>
			</ol>

			<!-- Example DataTables Card-->
			<div class="row">
				<div class="col-12">
					<h1 class="page-header">Modificar Usuario</h1>
					<hr>
				</div>
			</div>

			<!-- /.row -->
			<div class="row justify-content-center">
				<div class="col-lg-6 col-md-10 col-sm-12">
					<div class="card">
						<div class="card-header font-weight-bold">Formulario</div>
						<div class="card-body">

						<%if(user==null){ %>
							<div class="alert alert-danger alert-dismissable">
								<a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
								<strong>Error!</strong> Did not specify user.
							</div>
						<% } else { %>
							<form role="form" method="POST" action="./users" id="userForm" name="userForm">
								<div class="form-group">
									<input type="hidden" value="edit" name="action" id="action"> 
								</div>
								<div class="form-group">
									<label>ID</label> 
									<input type="hidden" value="<%=user.getId()%>" name="id" class="form-control">
									<input type="text" value="<%=user.getId()%>" name="idUser" class="form-control" disabled>
								</div>
								<div class="form-group">
									<label>User</label> 
									<input type="text" value="<%=user.getUser()%>" name="user" class="form-control" disabled>
								</div>
								<div class="form-group">
									<label>Tipo Usuario</label>
									<%	
										String adminUser="";
										String client="";
										if(user.isAdmin()){
										adminUser="checked";
										client="";
										} else{
											client = "checked";
											adminUser="";
										}%>
									<div class="radio">
									  <label><input type="radio" name="admin" value="0" checked="<%=client%>">Default</label>
									</div>
									<div class="radio">
									  <label><input type="radio" name="admin" value="1" checked="<%=adminUser%>">Admin</label>
									</div>
								</div>
								<div class="form-group">
									<label>Nombre</label> 
									<input type="text" value="<%=user.getName()%>" name="name" class="form-control" required>
								</div>
								<div class="form-group">
									<label>Apellido</label> 
									<input type="text" value="<%=user.getSurname()%>" name="surname" class="form-control" required>
								</div>
								<div class="form-group">
									<label>DNI</label> 
									<input type="text" value="<%=user.getDni()%>" name="dni" class="form-control" required>
								</div>
								<div class="form-group row">
								  <label for="example-date-input" class="col-2 col-form-label">Fecha de nacimiento</label>
								  <div class="col-10">
								    <input class="form-control" type="date" value="<%=formatter.format(user.getBirthdate())%>"  min="1900-01-01" max="1999-01-01" name="birthdate" id="birthdate" required>
								  </div>
								</div>
								<div class="form-group">
									<label>Email</label> 
									<input type="email" value="<%=user.getEmail()%>" name="email" class="form-control" required>
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