<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="utils.Utils"%>
<%@ page import="models.Usuario"  %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Perfil do Usuário</title>
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
	
		// System.out.println(session.getAttribute("username"));
	
		
		if(request.getParameter("id") != null) {
			
			// String id = request.getParameter("forgot-id");
			String username = request.getParameter("username");
			String email = request.getParameter("email");
			String birthday = request.getParameter("birthday");
			
			String date = Utils.getDate();
			
			Usuario usuario = new Usuario(0, username, email, birthday, "", "", 2, "", "", date);
			
			// int id = usuario.getWhere("email = '" + email + "'");
										
			usuario.setDataToUpdate("email = '" + email + "'");
			
			usuario.setName(username);
			usuario.setEmail(email);
			usuario.setBirthday(birthday);
			usuario.setUpdatedAt(date);
			
			usuario.update();
		
			response.getWriter().write("<div class='alert alert-success alert-dismissible fade show' role='alert'>Informações atualizadas com sucesso.<button type='button' class='close' id='alert' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button></div><script>setTimeout(() => {document.getElementById('alert').click();}, 2000);</script>");
			
		}
		
		if(request.getParameter("idPassword") != null) {
			
			// String id = request.getParameter("forgot-id");
			String password = request.getParameter("password");
			String newPassword = request.getParameter("newPassword");
			String newPassword2 = request.getParameter("newPassword2");
			
			String email = session.getAttribute("username").toString();
			
			Usuario usuario = new Usuario(0, "", email, "", "", "", 2, "", "", "");

			usuario.setDataToUpdate("email = '" + email + "'");

			String currentPassword = usuario.getPassword();
			
			if(!currentPassword.equals(Utils.encodePassword(password))){
				
				response.getWriter().write("<div class='alert alert-danger alert-dismissible fade show' role='alert'>Senhas não são iguais. Tente novamente...<button type='button' class='close' id='alert' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button></div><script>setTimeout(() => {document.getElementById('alert').click();}, 2000);</script>");
				// return;
			} else if(!newPassword.equals(newPassword2)){
				
				response.getWriter().write("<div class='alert alert-danger alert-dismissible fade show' role='alert'>Senhas não são iguais. Tente novamente...<button type='button' class='close' id='alert' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button></div><script>setTimeout(() => {document.getElementById('alert').click();}, 2000);</script>");
				// return;
			} else {
			
				String date = Utils.getDate();										
				
				usuario.setPassword(Utils.encodePassword(newPassword));
				usuario.setUpdatedAt(date);
				
				usuario.update();
			
				response.getWriter().write("<div class='alert alert-success alert-dismissible fade show' role='alert'>Senha atualizada com sucesso.<button type='button' class='close' id='alert' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button></div><script>setTimeout(() => {document.getElementById('alert').click();}, 2000);</script>");
			}
		}
	
	
		String email = "";
			
		if(session.getAttribute("username") == null) {
			response.sendRedirect("home.jsp");
		} else {
			email = session.getAttribute("username").toString();
		}
		
		String html = "<a class='dropdown-item' href='#' data-toggle='modal' data-target='#modalLRForm'>Login</a>";
		
		String htmlAdmin = "";
		
		System.out.println(session.getAttribute("idAccessLevel"));
		
		if(session.getAttribute("username") != null) {
			html = "<a class='dropdown-item' href='user.jsp'>Perfil</a><a class='dropdown-item' href='logout.jsp'>Sair</a>";
		}
		
		if(session.getAttribute("idAccessLevel") != null && session.getAttribute("idAccessLevel").equals(1)){
			htmlAdmin = "<li class='nav-item'><a class='nav-link waves-effect waves-light' href='admin.jsp'><i class='fas fa-cog'></i></a></li>";
		}
		
		Usuario usuario = new Usuario(0, "", "", "", "", "", 0, "", "", "");
	
		ResultSet userData = usuario.getByEmail(email);
		
		String name = "";
		String birthday = "";
		
		try {
			
			while (userData.next()) {
				
				name = userData.getString("name");
				birthday = userData.getString("birthday");
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
	%>

    <!--Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark warning-color">
        <a class="navbar-brand logo" href="#">SLVXERY</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent-333"
            aria-controls="navbarSupportedContent-333" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent-333">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="home.jsp">Início</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="species.jsp">Espécies</a>
                </li>
            </ul>
            <ul class="navbar-nav ml-auto nav-flex-icons">
				<%= htmlAdmin %>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-333" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-user"></i>
					</a>
					<div class="dropdown-menu dropdown-menu-right dropdown-default"
						aria-labelledby="navbarDropdownMenuLink-333">
						<%= html %>
					</div>
				</li>
			</ul>
        </div>
    </nav>
    <!--/.Navbar -->

    <div class="container col-md-12 mt-5" id="user">


        
        <!-- <div class="avatar mx-auto d-flex justify-content-center mb-3">
            <img id="photo" src="./assets/img/bruno.jpeg" width="100px" class="rounded-circle" alt="Foto de perfil do usuário">
        </div> -->

        <h2 class="mb-4 d-flex justify-content-center">Bem vindo, <%= name %>!</h2>

        <form class="col-md-6 mx-auto" method="POST" action="">
        
        	<input type="hidden" id="id" name="id" value="0">
        
            <label class="font-weight-bold" for="username">Nome</label>
            <input class="form-control mb-3" type="text" id="username" name="username" value="<%= name %>" />
            
            <label class="font-weight-bold" for="email">E-mail</label>
            <input class="form-control mb-3" type="text" id="email" name="email" value="<%= email %>" />
            
            <label class="font-weight-bold" for="birthday">Data de Nascimento</label>
            <input class="form-control mb-3" type="date" id="birthday" name="birthday" value="<%= birthday %>"/>

            <!-- <div class="custom-file mt-2 mb-2">
                <input type="file" class="custom-file-input" id="customFileLang" lang="pt-br">
                <label class="custom-file-label" for="customFileLang">Selecionar nova imagem de perfil</label>
            </div> -->

            <button class="success" type="submit">Enviar</button>
            <button class="danger" type="reset">Cancelar</button>
        
        	<p class="mt-2" style="float: right"><a style="text-decoration: none" href="" data-toggle="modal" data-target="#changePassword" class="">Alterar senha</a></p>

        </form>
        	
        
       	<div class="modal fade" id="changePassword" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		  aria-hidden="true">
			<form method="POST" action="" id="change">
							
				<input type="hidden" id="idPassword" name="idPassword" value="0" />
			
				<div class="modal-dialog" role="document">
			    	<div class="modal-content">
			      		<div class="modal-header text-center">
			        		<h4 class="modal-title w-100 font-weight-bold">Alteração de senha</h4>
			        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          	<span aria-hidden="true">&times;</span>
					        </button>
			      		</div>
			      		<div class="modal-body mx-3">
					        <div class="md-form mb-5">
					          	<i class="fas fa-password prefix grey-text"></i>
					          	
					          	<input type="password" name="password" id="password" class="form-control validate" placeholder="Senha atual">
					          	<input type="password" name="newPassword" id="newPassword" class="form-control validate" placeholder="Nova senha">
					          	<input type="password" name="newPassword2" id="newPassword2" class="form-control validate" placeholder="Repita a nova senha">
					        </div>
			      		</div>
			      		<div class="modal-footer d-flex justify-content-center">
			        		<button class="btn btn-default">Alterar</button>
			      		</div>
			    	</div>
			  	</div>
			</form>
		</div>
        

    </div>

	<%
			

		
	%>


    <footer class="">
        © 2020 SLVXERY. All rights reserved.
    </footer>

    <script>

        feather.replace();

		// let p = document.querySelector('.content');

		// p.animate({"opacity": "1"}, 2000).finished.then((data) => {
		// 	p.style.opacity = 1;
		// });

		// p.animate({"left": "30vh"}, 700).finished.then((data) => {
		// 	console.log("Finished");
		// });

		// p.style.opacity = 1;


    </script>

    <!-- jQuery -->
    <script type="text/javascript" src="./assets/MDB/js/jquery.min.js"></script>
    <!-- Bootstrap tooltips -->
    <script type="text/javascript" src="./assets/MDB/js/popper.min.js"></script>
    <!-- Bootstrap core JavaScript -->
    <script type="text/javascript" src="./assets/MDB/js/bootstrap.min.js"></script>
    <!-- MDB core JavaScript -->
    <script type="text/javascript" src="./assets/MDB/js/mdb.min.js"></script>
</body>

</html>