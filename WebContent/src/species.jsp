<%@page import="utils.Utils"%>
<%@ page import="models.Specie"  %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Espécies</title>
    <script src="https://cdn.jsdelivr.net/npm/feather-icons/dist/feather.min.js"></script>

    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
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

<body id="species">

	<%
	
		String html = "<a class='dropdown-item' href='#' data-toggle='modal' data-target='#modalLRForm'>Login</a>";
		
		String htmlAdmin = "";
				
		if(session.getAttribute("username") != null) {
			html = "<a class='dropdown-item' href='user.jsp'>Perfil</a><a class='dropdown-item' href='logout.jsp'>Sair</a>";
		}
		
		if(session.getAttribute("idAccessLevel") != null && session.getAttribute("idAccessLevel").equals(1)){
			htmlAdmin = "<li class='nav-item'><a class='nav-link waves-effect waves-light' href='admin.jsp'><i class='fas fa-cog'></i></a></li>";
		}
	
		Specie specie = new Specie(0, "", "", "", "", "", "", "", "", "", "", "");
		
		String cards = specie.listAllCards();
	
	%>

    <!-- <div class="mask"></div> -->

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
                <li class="nav-item active">
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
    <div class="view mb-3">
		<div class="banner-home" src="./assets/img/home1.jpg" class="img-fluid" alt="">
			<div class="mask rgba-black-strong flex-center justify-content-center pl-5 text-center">
                <div>
                    <h1 class="white-text text-bold fadein-center">Espécies</h1>
                    <h2 class="white-text fadein-center">Aqui você conhecer diversas espécies de plantas</h2>
                </div>
			</div>
		</div>
	</div>

    <div class="container col-md-12">
       <!-- <div class="row">
            <div class="col-xl-9 col-md-6 col-sm-0">    
                <hr class="line-search"/>
            </div>
            <div class="col-xl-3 col-md-6 col-sm-12">
                 <form class="form-inline md-form mr-auto mb-4">
                    <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
                      <button class="btn btn-outline-warning btn-rounded btn-sm my-0" type="submit">Search</button>
                </form> 
            </div>
        </div> -->
    </div>

    <div class="container col-md-12">

        <div class="card-group">
            
            <%= cards %>
            
        </div>
    </div>

	<!--Modal: Login / Register Form-->
	<div class="modal fade" id="modalLRForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true">
		<div class="modal-dialog cascading-modal" role="document">
			<!--Content-->
			<div class="modal-content">

				<!--Modal cascading tabs-->
				<div class="modal-c-tabs">

					<!-- Nav tabs -->
					<ul class="nav nav-tabs md-tabs tabs-2 white darken-3" role="tablist">
						<li class="nav-item">
							<a class="nav-link active" data-toggle="tab" href="#panel7" role="tab"><i
									class="fas fa-user mr-1"></i>
								Login</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#panel8" role="tab"><i
									class="fas fa-user-plus mr-1"></i>
								Register</a>
						</li>
					</ul>

					<!-- Tab panels -->
					<div class="tab-content">
						<!--Panel 7-->
						<div class="tab-pane fade in show active" id="panel7" role="tabpanel">
							<form method="POST" action="login.jsp" id="login">
								<input type="hidden" name="login-id" id="login-id" value="1" />
								<!--Body-->
								<div class="modal-body mb-1">
									<div class="md-form form-sm mb-5">
										<i class="fas fa-envelope prefix"></i>
										<input type="email" id="login-email" name="login-email"
											class="form-control form-control-sm validate">
										<label data-error="wrong" data-success="right" for="modalLRInput10">E-mail</label>
									</div>

									<div class="md-form form-sm mb-4">
										<i class="fas fa-lock prefix"></i>
										<input type="password" id="login-password" name="login-password"
											class="form-control form-control-sm validate">
										<label data-error="wrong" data-success="right" for="modalLRInput11">Senha</label>
									</div>
									<div class="text-center mt-2">
										<button class="btn btn-info" onclick="">Log in</button>
									</div>
								</div>
								<!--Footer-->
								<div class="modal-footer">
									<div class="options text-center text-md-right mt-1">
										<p>Esqueceu sua <a href="" data-toggle="modal" data-target="#forgotPassword" class="blue-text">Senha?</a></p>
									</div>
									<button type="button" class="btn btn-outline-info waves-effect ml-auto"
										data-dismiss="modal">Close</button>
								</div>
							</form>

						</div>
						<!--/.Panel 7-->

						<!--Panel 8-->
						<div class="tab-pane fade" id="panel8" role="tabpanel">
							<form method="POST" action="cadastrar.jsp" id="register">
								<input type="hidden" name="register-id" id="register-id" value="0" />
								<!--Body-->
								<div class="modal-body">
									<div class="md-form form-sm mb-5">
										<i class="fas fa-envelope prefix"></i>
										<input type="text" id="register-name" name="register-name"
											class="form-control form-control-sm validate">
										<label data-error="wrong" data-success="right" for="modalLRInput12">Nome</label>
									</div>
								
									<div class="md-form form-sm mb-5">
										<i class="fas fa-envelope prefix"></i>
										<input type="email" id="register-email" name="register-email"
											class="form-control form-control-sm validate">
										<label data-error="wrong" data-success="right" for="modalLRInput12">E-mail</label>
									</div>

									<div class="md-form form-sm mb-5">
										<i class="fas fa-lock prefix"></i>
										<input type="date" id="register-birthday" name="register-birthday"
											class="form-control form-control-sm validate">
										<label data-error="wrong" data-success="right" for="modalLRInput13">Data de Nascimento</label>
									</div>
									
									<div class="md-form form-sm mb-5">
										<i class="fas fa-lock prefix"></i>
										<input type="password" id="register-password" name="register-password"
											class="form-control form-control-sm validate">
										<label data-error="wrong" data-success="right" for="modalLRInput13">Senha</label>
									</div>

									<div class="text-center form-sm mt-2">
										<button class="btn btn-info">Cadastrar</button>
									</div>

								</div>

							</form>
							<!--Footer-->
							<div class="modal-footer">
								<button type="button" class="btn btn-outline-info waves-effect ml-auto"
									data-dismiss="modal">Close</button>
							</div>
						</div>
						<!--/.Panel 8-->
					</div>

				</div>
			</div>
			<!--/.Content-->
		</div>
	</div>
	<!--Modal: Login / Register Form-->
	
	<div class="modal fade" id="forgotPassword" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	  aria-hidden="true">
		<form method="POST" action="forgot.jsp" id="forgot">
		
			<input type="hidden" name="forgot-id" id="forgot-id" value="0" />
		
			<div class="modal-dialog" role="document">
		    	<div class="modal-content">
		      		<div class="modal-header text-center">
		        		<h4 class="modal-title w-100 font-weight-bold">Esqueci minha senha</h4>
		        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          	<span aria-hidden="true">&times;</span>
				        </button>
		      		</div>
		      		<div class="modal-body mx-3">
		      			<p>Um link será enviado por e-mail para o endereço eletrônico inserido abaixo.</p>
				      	<p>Só é possível redefinir sua senha pelo link enviado.</p>
				        <div class="md-form mb-5">
				          	<i class="fas fa-envelope prefix grey-text"></i>
				          	<input type="email" name="forgot-email" id="forgot-email" class="form-control validate">
				          	<label data-error="wrong" data-success="right" for="defaultForm-email">E-mail</label>
				        </div>
		      		</div>
		      		<div class="modal-footer d-flex justify-content-center">
		        		<button class="btn btn-default">Enviar</button>
		      		</div>
		    	</div>
		  	</div>
		</form>
	</div>

    <footer>
        © 2020 SLVXERY. All rights reserved.
	</footer>

    <script>

         feather.replace();

         let p = document.querySelector('.content');

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