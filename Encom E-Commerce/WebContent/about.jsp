<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="icon" href="images/encom-icon.png">
<title>About</title>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
	<!-- Bootstrap core CSS -->
    <link href="http://getbootstrap.com/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="source/css/album.css" rel="stylesheet">
    <link href="source/css/footer-custom.css" rel="stylesheet">
    <link href="source/css/sticky-footer.css" rel="stylesheet">
    <link href="source/css/common.css" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://blackrockdigital.github.io/startbootstrap-thumbnail-gallery/vendor/jquery/jquery.min.js"></script>
  	<script src="https://blackrockdigital.github.io/startbootstrap-thumbnail-gallery/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  	<style>
  	.margin-top{
  	margin-top: 6em;
  	}
  	.margin-bottom{
  	margin-bottom: 173px;
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
	.bottom {
	margin-bottom: 50px;
	}
	.no-pd{
	padding: 0;
	}
  	</style>
  	
</head>
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
            <li class="nav-item active">
              <a class="nav-link" href="about.jsp">About</a>
              <span class="sr-only">(current)</span>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="./products?idCategory=1&idSubcategory=1">Productos</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#"><i class="fa fa-shopping-cart" aria-hidden="true"></i> <span class="badge badge-primary">0</span></a>
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
	

        <div class="container margin-top">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h1 class="section-heading">Servicios</h1>
                    <hr class="bg-encom">
                </div>
            </div>
            <div class="row text-center">
                <div class="col-md-4">
                    <span class="fa-stack fa-4x">
                        <i class="fa fa-circle fa-stack-2x text-encom"></i>
                        <i class="fa fa-shopping-cart fa-stack-1x fa-inverse"></i>
                    </span>
                    <h4 class="service-heading">E-Commerce</h4>
                    <p class="text-muted">Implementamos la innovadora herramienta E-Commerce, para que la experiencia de usuario sea 100% satisfactoria y gratificante.</p>
                </div>
                <div class="col-md-4">
                    <span class="fa-stack fa-4x">
                        <i class="fa fa-circle fa-stack-2x text-encom"></i>
                        <i class="fa fa-credit-card fa-stack-1x fa-inverse"></i>
                    </span>
                    <h4 class="service-heading">Formas de Pago</h4>
                    <p class="text-muted">Ofrecemos soporte a diversas y variadas formas de pago, desde tarjetas de credito VISA y MASTERCARD, a pago en efectivo y deposito bancario.</p>
                </div>
                <div class="col-md-4">
                    <span class="fa-stack fa-4x">
                        <i class="fa fa-circle fa-stack-2x text-encom"></i>
                        <i class="fa fa-cogs fa-stack-1x fa-inverse"></i>
                    </span>
                    <h4 class="service-heading">Soporte</h4>
                    <p class="text-muted">Service Desk disponible para el usuario. Nos encargamos de solucionar cualquier problema que se le presente al usuario.</p>
                </div>
            </div>
        </div>
        
      <div class="container-fluid section-gray pd-top pd-btm">
      	<div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h1 class="section-heading">Contacto</h1>
                    <hr class="bg-encom">
                </div>
            </div>
            <div class="row text-center">
                <div class="col-md-4">
                    <a class="contact" href="mailto:andres-malvestiti@hotmail.com?Subject=Encom%20E-commerce" target="_top"><span class="fa-stack fa-4x">
                        <i class="fa fa-paper-plane fa-stack-1x text-encom"></i>
                    </span>
                    <h4 class="service-heading">Email</h4>
                    </a>
                    <p>Click on me!</p>
                </div>
                <div class="col-md-4">
                    <span class="fa-stack fa-4x">
                        <i class="fa fa-phone fa-stack-1x text-encom"></i>
                    </span>
                    <h4 class="service-heading">Teléfono</h4>
                    <p class="text-muted">(+54) 3400 580629</p>
                </div>
                <div class="col-md-4">
                    <span class="fa-stack fa-4x">
                        <i class="fa fa-map-marker fa-stack-1x text-encom"></i>
                    </span>
                    <h4 class="service-heading">Ubicación</h4>
                    <p class="text-muted">Rosario (2000), Santa Fe.</p>
                </div>
            </div>
        </div>
      </div>
	  
	  <!-- Google Map -->
	<div class="container-fluid no-pd margin-bottom ">
		<iframe title="MapaGoogle"
			src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3347.868446653849!2d-60.64585033878075!3d-32.954482486117264!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x95b7ab11d0eb49c3%3A0x11f1d3d54f950dd0!2sUTN-FRRO%2C+Universidad+Tecnol%C3%B3gica+Nacional+-+Facultad+Regional+Rosario!5e0!3m2!1ses-419!2sar!4v1490369624629"
			width="100%" height="350" style="border: 0" allowfullscreen></iframe>
	</div>
	<!-- Google Map -->
   
    
     <footer class="footer text-white bg-dark">
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
      <div class="col-lg-3 col-md-12 col-sm-12 offset-sm-0">
      <p class="text-center">
          <a href="#" class="btn btn-outline-secondary"><i class="fa fa-arrow-up" aria-hidden="true"></i></a>
        </p>
      </div>
      </div>
 		<div class="footer-bottom">
            <p class="text-center"> Copyright © Encom 2017. All right reserved. </p>
        </div>
      </div>
        

    </footer>
    
</body>
</html>