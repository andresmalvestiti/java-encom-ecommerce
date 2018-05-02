<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="com.Encom.DTO.ProductDTO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="images/encom-icon.png">

<title>Productos</title>

<!-- Bootstrap core CSS -->
<link href="http://getbootstrap.com/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="source/font-awesome-4.7.0/css/font-awesome.min.css">
<!-- Custom styles for this template -->
<link href="source/css/dashboard.css" rel="stylesheet">
<link href="source/css/common.css" rel="stylesheet">
<link href="source/css/footer-custom.css" rel="stylesheet">
<style type="text/css">
body {
  padding-top: 4.5rem;
}
.bg-dark{
		background-color: #151515!important;
}
.fixed{
	height: 60px;
	margin: 0;
	padding 0;
  	width: auto;
}
.padding-bottom{
padding-bottom: 2rem;
}
.footer {
  position: absolute;
  bottom: 0;
}
</style>
<script>
        var x = 0;
        var increment = function() {
        x = x+1;
        document.getElementById('chart').innerHTML = x;
    }
</script>
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
<body>

    <header>
      <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
      <div class="container-fluid">
        <a href="index.jsp"><img class="navbar-brand fixed" src="images/encom-brand.png" alt="encom-logo"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link" href="index.jsp">Home</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="about.jsp">About</a>
            </li>
            <li class="nav-item active">
              <a class="nav-link" href="./products?idCategory=1&idSubcategory=1">Productos</a>
              <span class="sr-only">(current)</span>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#"><i class="fa fa-shopping-cart" aria-hidden="true"></i> <span id="chart" class="badge badge-primary">0</span></a>
            </li>
            <%
            	if(admin){%>
            	<li class="nav-item">
            		 <a class="nav-link" href="./admin-home.jsp"><i class="fa fa-wrench" aria-hidden="true"></i> Admin Panel</a>
            	</li>
            	<% } 
            	if(userName!=null){%>
            	<li class="nav-item">
            		 <a class="nav-link"><i class="fa fa-user" aria-hidden="true"></i> Bienvenido <%=userName%></a>
            	</li>
            	<li class="nav-item">
            		 <a class="nav-link" href="./logout"><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</a>
            	</li>
            	<% } else{ %>
              	<li class="nav-item">
              		 <a class="nav-link" href="login.jsp"><i class="fa fa-sign-in" aria-hidden="true"></i> Login</a>
            	</li>
            <% } %>
          </ul>
        </div>
      </div>
    </nav>
    </header>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2  bg-light sidebar">
		<div id="accordion" role="tablist">
			<div class="nav-item">
				<div class="card-header bg-light" role="tab" id="headingOne">
					<a data-toggle="collapse" href="#collapseOne"
						aria-expanded="true" aria-controls="collapseOne">
						<i class="fa fa-microchip" aria-hidden="true"></i> Microprocesadores </a>
				</div>
				<div id="collapseOne" class="collapse" role="tabpanel"
					aria-labelledby="headingOne" data-parent="#accordion">
					<div class="card-body bg-white">
						<a class="nav-link"
							href="./products?idCategory=1&idSubcategory=1">Intel</a> <a
							class="nav-link"
							href="./products?idCategory=1&idSubcategory=2">AMD</a>
					</div>
				</div>
			</div>
			
			<div class="nav-item">
				<div class="card-header bg-light" role="tab" id="headingTwo">
					<a data-toggle="collapse" href="#collapseTwo"
						aria-expanded="false" aria-controls="collapseOne">
						<i class="fa fa-database" aria-hidden="true"></i> Almacenamiento </a>
				</div>
				<div id="collapseTwo" class="collapse" role="tabpanel"
					aria-labelledby="headingTwo" data-parent="#accordion">
					<div class="card-body bg-white">
						<a class="nav-link"
							href="./products?idCategory=2&idSubcategory=1">Discos Rígidos</a> <a
							class="nav-link"
							href="./products?idCategory=2&idSubcategory=2">Unidades de Estado Solido</a>
					</div>
				</div>
			</div>

			<div class="nav-item">
				<div class="card-header bg-light" role="tab" id="headingThree">
					<a data-toggle="collapse" href="#collapseThree"
						aria-expanded="false" aria-controls="collapseOne">
						<i class="fa fa-tachometer" aria-hidden="true"></i> Memorias </a>
				</div>
				<div id="collapseThree" class="collapse" role="tabpanel"
					aria-labelledby="headingThree" data-parent="#accordion">
					<div class="card-body bg-white">
						<a class="nav-link"
							href="./products?idCategory=3&idSubcategory=1">DDR3</a> <a
							class="nav-link"
							href="./products?idCategory=3&idSubcategory=2">DDR4</a>
					</div>
				</div>
			</div>

			<div class="nav-item">
				<div class="card-header bg-light" role="tab" id="headingFour">
					<a data-toggle="collapse" href="#collapseFour"
						aria-expanded="false" aria-controls="collapseOne">
						<i class="fa fa-bolt" aria-hidden="true"></i> Fuentes </a>
				</div>
				<div id="collapseFour" class="collapse" role="tabpanel"
					aria-labelledby="headingFour" data-parent="#accordion">
					<div class="card-body bg-white">
						<a class="nav-link"
							href="./products?idCategory=4&idSubcategory=1">Genéricas</a> <a
							class="nav-link"
							href="./products?idCategory=4&idSubcategory=2">+80</a>
					</div>
				</div>
			</div>
			
			<div class="nav-item">
				<div class="card-header bg-light" role="tab" id="headingFive">
					<a data-toggle="collapse" href="#collapseFive"
						aria-expanded="false" aria-controls="collapseOne">
						<i class="fa fa-desktop" aria-hidden="true"></i> Motherboards </a>
				</div>
				<div id="collapseFive" class="collapse" role="tabpanel"
					aria-labelledby="headingFive" data-parent="#accordion">
					<div class="card-body bg-white">
						<a class="nav-link"
							href="./products?idCategory=5&idSubcategory=1">AM4</a> <a
							class="nav-link"
							href="./products?idCategory=5&idSubcategory=2">1150</a>
					</div>
				</div>
			</div>
 			</div>
        </div>

        <div class="col-sm-9  col-md-10 pt-3">
	       <div class="page-header"><h1>Productos</h1></div>
			<nav aria-label="breadcrumb" role="navigation">
			  <ol class="breadcrumb">
			    <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
			    <li class="breadcrumb-item active" aria-current="page">Productos</li>
			  </ol>
			</nav>
          <div class="row bg-light padding-bottom">
          <%  if(products!=null){ 
			
        	Iterator<ProductDTO> iterator = products.iterator();
      		while (iterator.hasNext()) {
      			ProductDTO p = iterator.next();
			%>
	        <div class="col-lg-3 col-md-4 col-sm-6 portfolio-item">
	          <div class="card h-100">
	            <a href="#"><img class="card-img-top" src="./data/<%=p.getImagePath()%>" alt=""/></a>
	            <div class="card-body">
	              <h4 class="card-title"><%=p.getName()%></h4>
	              <h5 class="card-subtitle mb-2">$ <%=p.getPrice()%></h5>
				    <p class="card-text"><%=p.getDescription()%></p>
	            </div>
	            <div class="card-footer bg-white border-light mx-auto">
			        <button <%=guest %> class="btn btn-primary" type="button" onclick="increment();"><i class="fa fa-shopping-cart" aria-hidden="true"></i> Agregar</button>
			        
			      </div>
	           </div>
	        </div>
	        <% }} else{
				%>
				<div class="alert alert-danger col-lg-3 col-md-4 col-sm-6 portfolio-item mx-auto text-center" role="alert">
				  Seleccione una categoria!
				</div>
				<%
			}%>
      <!-- /.row -->

          
        </div>
      </div>
    </div>
    </div>
    <footer class="text-white bg-dark">
      <div class="container-fluid">
      <div class="row justify-content-md-center">
      <div class="col-lg-3 col-md-5 col-sm-12 offset-lg-1 offset-md-1 offset-sm-0">
      	<adress>
      		<p><strong><i class="fa fa-graduation-cap" aria-hidden="true"></i> UTN - FRRo</strong></p>
      		<p><i class="fa fa-map-marker" aria-hidden="true"></i> Rosario (2000), Santa Fe</p>
      		<abbr title="Phone"><p><i class="fa fa-phone" aria-hidden="true"></i> (3400) 580629</p></abbr>
      	</adress>
      	<adress>
      	<strong><p>Andrés M.</p></strong>
      	<a href="mailto:#">andres-malvestiti@hotmail.com</a>
      	</adress>
      </div>
      <div class="col-lg-4 col-md-5 col-sm-12 offset-lg-1 offset-md-1 offset-sm-0">
      <h4 class="">Find me</h4>
      <br>
       <ul class="social-network social-circle">
          <li><a href="https://www.linkedin.com/in/andr%C3%A9s-malvestiti-36a1b812a" target="_blank" class="icoLinkedin social" title="Linkedin"><i class="fa fa-linkedin"></i></a></li>
       	  <li><a href="https://github.com/andresm96" target="_blank" class="icoGithub social" title="Github"><i class="fa fa-github"></i></a></li>
          <li><a href="https://www.facebook.com/andres.malvestiti.7" target="_blank" class="icoFacebook social" title="Facebook"><i class="fa fa-facebook"></i></a></li>
          <li><a href="https://plus.google.com/u/0/107971581068308490406" target="_blank" class="icoGoogle social" title="Google +"><i class="fa fa-google-plus"></i></a></li>  
      </ul>
      </div>
      <div class="col-lg-3 col-md-12 col-sm-12  offset-sm-0">
      <p class="text-center">
          <a href="#" class="btn btn-outline-secondary"><i class="fa fa-arrow-up" aria-hidden="true"></i></a>
        </p>
      </div>
      </div>
 		<div class="footer-bottom">
            <p class="text-center bottom"> Copyright © Encom 2017. All right reserved. </p>
        </div>
      </div>
        

    </footer>
     <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="http://getbootstrap.com/assets/js/vendor/popper.min.js"></script>
    <script src="http://getbootstrap.com/dist/js/bootstrap.min.js"></script>
    
</body>
</html>