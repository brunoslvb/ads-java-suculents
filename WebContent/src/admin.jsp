<%@ page import="models.Specie"%>
<%@ page import="utils.Utils"%>
<%@ page import="models.Usuario"  %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <title>Administração</title>
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <script src="https://cdn.jsdelivr.net/npm/feather-icons/dist/feather.min.js"></script>

		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">

        <link rel="stylesheet" href="./assets/css/style.css" />

    </head>

    <body>
    
    	<%

	    	if(session.getAttribute("username") == null) {
				response.sendRedirect("home.jsp");
			}
    	
    	
    		if(request.getParameter("id") != null){
    			
    			int id = Integer.parseInt(request.getParameter("id"));
    			
    			Usuario usuario = new Usuario(id, "", "", "", "", "", 0, "", "", "");

    			usuario.delete(id);
    			
    			response.sendRedirect("admin.jsp");
    			
    		}
    	 	
			if(request.getParameter("user-id") != null) {
				
				System.out.println("Cadastrar");
				
				String id = request.getParameter("user-id");
				String name = request.getParameter("user-name");
				String email = request.getParameter("user-email");
				String birthday = request.getParameter("user-birthday");
				String password = Utils.encodePassword(request.getParameter("user-password"));
				String idAccessLevel = request.getParameter("user-accessLevel");
				
				String date = Utils.getDate();
				
				Usuario usuario = new Usuario(Integer.parseInt(id), name, email, birthday, password, "", Integer.parseInt(idAccessLevel), "", date, date);
				
				int flag = usuario.getWhere("email = '" + email + "'");
				
				System.out.println(flag);
				
				if(flag != 0){
					response.getWriter().write("<script>alert('Usuário já cadastrado na base de dados.')</script>");
				} else {
				
					usuario.save();
				
					String msg = "Olá, "+ name +".\n\nSegue dados para acesso ao sistema criado com JavaWeb:\n\nUsuário: "+ email +"\nSenha: "+ request.getParameter("user-password") + "\n\nLink para acesso: http://localhost:8080/JavaWeb/src/home.jsp";
					
					String[] args = {"bruno.silva@edi-labs.com", email, "Criação de usuário - JavaWeb", msg};
					
					Utils.sendMail(args);
					
					response.getWriter().write("<script>alert('Usuário cadastrado com sucesso.')</script>");
				}
			
			}
    	
			Usuario usuario = new Usuario(0, "", "", "", "", "", 0, "", "", "");
			
    		String usuarios = usuario.listAll();

		%>
    
        <div id="admin">
            <nav>
                <ul>
                    <li><p>Administração</p></li>
                    <li class="right"><a href="home.jsp"><i data-feather="log-out"></i></a></li>
                </ul>
            </nav>

            <div id="sidenav" class="sidenav">
                <a id="users" class="active" href="#users">Usuários</a>
                <a id="species" href="species-admin.jsp">Espécies</a>
            </div>

            <div class="main">
                <div class="content">

                    <div id="users-panel">
                        <div class="header">
                            <h2 class="title">Informações - Usuários</h2>
                        </div>
                        <div>
                            <table>
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Nome</th>
                                        <th>E-mail</th>
                                        <th>Nascimento</th>
                                        <th>ID de Acesso</th>
                                        <th>Data de Criação</th>
                                        <th>Última atualização</th>
                                        <th>Ações</th>
                                    </tr>
                                </thead>
                                <tbody>
                                
                                    <%= usuarios %>
                                
                                </tbody>
                            </table>
                            <span class="pagination">
                                <a class="active" href="">1</a>
                                <a class="" href="">2</a>
                                <a class="" href="">3</a>
                                <a class="" href="">4</a>
                            </span>
                        </div>

                        <div id="form-user" class="form">
                            <h3>Formulário</h3>
                            <form class="" method="POST" action="">
                            		
                            	<input type="hidden" id="user-id" name="user-id" value="0"/>
                            	
                                <label for="user-name">Nome Completo
                                    <input type="text" id="user-name" name="user-name" required/>
                                </label>
                                
                                <label for="user-email">E-mail
                                    <input type="text" id="user-email" name="user-email" required />
                                </label>

                                <label for="user-password">Senha
                                    <input type="password" id="user-password" name="user-password" required />
                                </label>

                                <label for="user-birthday">Data de Nascimento
                                    <input type="date" id="user-birthday" name="user-birthday" required />
                                </label>

                                <label for="user-accessLevel">Identificador de acesso
                                    <select name="user-accessLevel" id="user-accessLevel">
                                        <option value="0" disabled selected>Selecione...</option>
                                        <option value="1">Administrador</option>
                                        <option value="2">Usuário</option>
                                    </select>
                                </label>

                                <button class="success" type="submit">Enviar</button>
                                <button class="danger" type="reset">Cancelar</button>
                            </form>
                        </div>
                    </div>
            	</div>
            </div>
        </div>
        
        <script>
        
            feather.replace();

          </script>
    </body>

</html>