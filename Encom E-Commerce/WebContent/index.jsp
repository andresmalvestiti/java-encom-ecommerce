<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="images/encom-icon.png">

    <title>Encom</title>

    <!-- Bootstrap core CSS -->
    <link href="http://getbootstrap.com/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="source/css/index.css" rel="stylesheet">
    <link href="source/css/common.css" rel="stylesheet">
    <link href="source/css/footer-custom.css" rel="stylesheet">
    <script src="https://blackrockdigital.github.io/startbootstrap-thumbnail-gallery/vendor/jquery/jquery.min.js"></script>
  	<script src="https://blackrockdigital.github.io/startbootstrap-thumbnail-gallery/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  	<style>
	.bg-dark{
		background-color: #151515!important;
	}
	.fixed{
		height: 60px;
		margin: 0;
		padding: 0;
	  	width: auto;
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
  	<script>
        var x = 0;
        var increment = function() {
        x = x+1;
        document.getElementById('chart').innerHTML = x;
    }
    </script>
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
            <li class="nav-item active">
              <a class="nav-link" href="#">Home
                <span class="sr-only">(current)</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="about.jsp">About</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="./products?idCategory=1&idSubcategory=1">Productos</a>
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

    <main role="main">
    
        <section class="jumbotron text-center">
        <div class="container">
        <img alt="" src="images/encom-logo.png">
        <br>
          <p class="lead text-muted">Hardware de alta calidad y rendimiento para lograr gran performance de acuerdo a las necesidades de nuestros clientes.</p>
          <p>
            <a href="./products?idCategory=1&idSubcategory=1" class="btn btn-primary">Productos</a>
            <a href="about.jsp" class="btn btn-secondary">Contacto</a>
          </p>
        </div>
      </section>
      
      <div class="container">
      	<div id="banner" class="carousel slide" data-ride="carousel">

		  <!-- Indicators -->
		  <ul class="carousel-indicators">
		    <li data-target="#banner" data-slide-to="0" class="active"></li>
		    <li data-target="#banner" data-slide-to="1"></li>
		    <li data-target="#banner" data-slide-to="2"></li>
		    <li data-target="#banner" data-slide-to="3"></li>
		  </ul>
		  
		  <!-- The slideshow -->
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src="images/intel.jpg" class="rounded mx-auto d-block" alt="Intel" width="1100" height="500">
		    </div>
		    <div class="carousel-item">
		      <img src="images/amd.png" class="rounded mx-auto d-block" alt="AMD" width="1100" height="500">
		    </div>
		    <div class="carousel-item">
		      <img src="images/radeon.jpg" class="rounded mx-auto d-block" alt="Radeon" width="1100" height="500">
		    </div>
		    <div class="carousel-item">
		      <img src="images/xfx.jpg" class="rounded mx-auto d-block" alt="XFX" width="1100" height="500">
		    </div>
		    
		  </div>
		  
		  <!-- Left and right controls -->
		  <a class="carousel-control-prev" href="#banner" data-slide="prev">
		    <span class="carousel-control-prev-icon"></span>
		  </a>
		  <a class="carousel-control-next" href="#banner" data-slide="next">
		    <span class="carousel-control-next-icon"></span>
		  </a>
		</div>
      </div>
      
      
      
      <div class="album">
        <!-- Page Content -->
    <div class="container">
	<h1 class="my-4 text-center text-center">Productos destacados <i class="fa fa-gift" aria-hidden="true"></i></h1>
	<hr class="bg-primary">
      <div class="card-deck">
        <div class="card" style="width: 20rem;">
		  <img class="card-img-top" src="images/img-5389136804867417942.png" alt="Card image cap">
		  <div class="card-body">
		    <h4 class="card-title">Intel Core i7</h4>
		    <h5 class="card-subtitle mb-2 text-muted">$ 3500</h5>
		    <p class="card-text">Intel Core i7 es una familia de procesadores 4 y 6 núcleos de la arquitectura Intel x86-64. Gama alta de la familia Intel.</p>
		  </div>
		  <div class="card-footer bg-white border-light mx-auto">
	        <button <%=guest %> class="btn btn-primary" type="button" onclick="increment();"><i class="fa fa-shopping-cart" aria-hidden="true"></i> Agregar</button>
	       
	      </div>
		</div>
		<div class="card" style="width: 20rem;">
		  <img class="card-img-top" src="images/img-3134221912147904370.png" alt="Card image cap">
		  <div class="card-body">
		    <h4 class="card-title">SSD Kingston KC300</h4>
		    <h5 class="card-subtitle mb-2 text-muted">$ 3150</h5>
		    <p class="card-text">Modeo: 7MM KIT - Capacidad: 240GB.</p>
		  </div>
		  <div class="card-footer bg-white border-light mx-auto">
	        <button <%=guest %> class="btn btn-primary" type="button" onclick="increment();"><i class="fa fa-shopping-cart" aria-hidden="true"></i> Agregar</button>
	        
	      </div>
		</div>
		<div class="card" style="width: 20rem;">
		 <img class="card-img-top" src="images/img-8906251759755326384.png" alt="Card image cap">
		  <div class="card-body">
		    <h4 class="card-title">AMD Bulldozer Fx 8350</h4>
		    <h5 class="card-subtitle mb-2 text-muted">$ 4440</h5>
		    <p class="card-text">CPU CORES: 8 - THREADS: 8 - BASE CLOCK SPEED: 4 GHz - MAX TURBO CORE SPEED: 4.2 GHz.</p>
		  </div>
		  <div class="card-footer bg-white border-light mx-auto">
	        <button <%=guest %> class="btn btn-primary" type="button" onclick="increment();"><i class="fa fa-shopping-cart" aria-hidden="true"></i> Agregar</button>
	        
	      </div>
		</div>
	</div>
    </div>
    <!-- /.container -->
      </div>

    </main>

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
 
    
  </body>
</html>
