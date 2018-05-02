<%@ page isErrorPage="true"  import="java.io.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="icon" href="images/encom-icon.png">
<title>Error <%=response.getStatus() %></title>
<!-- Bootstrap core CSS -->
<link href="http://getbootstrap.com/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<style type="text/css">
	.center{
		margin-top: 15%;
	}
</style>
</head>
<body>
	<div class="container-fluid text-center">
		<div class="align-middle center">
			<h1 class="display-1">Error <%=response.getStatus()%></h1>
			
			<p class="lead">Message: <%=exception.getMessage()%></p>
			StackTrace:
			<br>
			<p>
			<%	StringWriter stringWriter = new StringWriter();
				PrintWriter printWriter = new PrintWriter(stringWriter);
				exception.printStackTrace(printWriter);
				out.println(stringWriter);
				printWriter.close();
				stringWriter.close();
			%></p>
		</div>		
	</div>
</body>
</html>
