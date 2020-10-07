<%@page import="utils.RandomCode"%>
<%@ page import="utils.Utils"%>
<%@ page import="models.Usuario"  %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Início</title>
	<script src="https://cdn.jsdelivr.net/npm/feather-icons/dist/feather.min.js"></script>

	<meta name="viewport"
		content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">

	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
	<!-- Google Fonts Roboto -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
	<!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="./assets/MDB/css/bootstrap.min.css">
	<!-- Material Design Bootstrap -->
	<link rel="stylesheet" href="./assets/MDB/css/mdb.min.css">

	<link rel="stylesheet" href="./assets/css/style.css" />

</head>

<body>

	<%
	
		if(request.getParameter("token") != null){
			
			Usuario usuario = new Usuario(0, "", "", "", "", "", 2, "", "", "");
			
			String token = request.getParameter("token");
			
			int id = usuario.getWhere("token = '" + token + "'");
			
			if(id == 0){
			
				response.getWriter().write("<script>alert('Token inválido!');window.location.replace('home.jsp');</script>");
				return;
			}
			
		} else {
			
			response.getWriter().write("<script>alert('Token inválido!');window.location.replace('home.jsp');</script>");
			return;
			
		}
	
		if(request.getParameter("forgot-id") != null){
			
			String password = request.getParameter("password");
			String passwordConfirmed = request.getParameter("password-confirmed");
			String token = request.getParameter("token");
			
			String date = Utils.getDate();
			
			if(!password.equals(passwordConfirmed)){
				response.getWriter().write("<div class='alert alert-warning alert-dismissible fade show' role='alert'>As senhas não são iguais.<button type='button' class='close' id='alert' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button></div><script>setTimeout(() => {document.getElementById('alert').click();}, 2000);</script>");
				return;
			}
						
			Usuario usuario = new Usuario(0, "", "", "", "", "", 2, "", "", "");
			
			usuario.setDataToUpdate("token = '" + token + "'");
			
			usuario.setPassword(Utils.encodePassword(password));
			usuario.setToken("");
			usuario.setUpdatedAt(date);
			
			usuario.update();
			
			response.getWriter().write("<div class='alert alert-success alert-dismissible fade show' role='alert'>Senha alterada com sucesso.<button type='button' class='close' id='alert' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button></div><script>setTimeout(() => {window.location.replace('home.jsp')}, 2000);</script>");
			return;
		}
	
	%>

	<div class="container col-md-4 mx-auto">
	
		<!-- Default form login -->
		<form class="text-center border border-light p-5 mt-5" action="" method="POST">
		
		    <p class="h4 mb-4">Redefinição de senha</p>
		
			<input type="hidden" name="forgot-id" id="forgot-id" value="0" />
		
		    <!-- Password -->
		    <input type="password" name="password" id="password" class="form-control mb-4" placeholder="Nova Senha">
		
		    <!-- Password Confirm -->
		    <input type="password" name="password-confirmed" id="password-confirmed" class="form-control mb-4" placeholder="Confirmar Nova Senha">
		
		    <!-- Sign in button -->
		    <button class="btn btn-black btn-block my-4" type="submit">Redefinir</button>

		</form>
		<!-- Default form login -->
	
	</div>

</body>
</html>