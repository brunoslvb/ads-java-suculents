<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="utils.RandomCode"%>
<%@ page import="utils.Utils"%>
<%@ page import="models.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	
		if(request.getParameter("login-id") != null){
			
			System.out.println("Logar");
			
			// String id = request.getParameter("login-id");
			String email = request.getParameter("login-email");
			String password = Utils.encodePassword(request.getParameter("login-password"));
	
			Usuario usuario = new Usuario(0, "", email, "", password, "", 1, "", "", "");
			
			int id = usuario.getWhere("email = '" + email + "' AND password = '"+ password +"'");
			
			if(id != 0){
				
				ResultSet userData = usuario.getByEmail(email);
				
				int idAccessLevel = 0;
				
				try {
					
					while (userData.next()) {
						
						idAccessLevel = userData.getInt("idAccessLevel");
						
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
				session.setAttribute ("username", email);
				session.setAttribute ("idAccessLevel", idAccessLevel);
								
				// response.getWriter().write("<div class='alert alert-success alert-dismissible fade show' role='alert'>Usuário logado com sucesso.<button type='button' class='close' id='alert' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button></div><script>setTimeout(() => {document.getElementById('alert').click(); window.location.href = 'home.jsp'}, 2000);</script>");
				response.getWriter().write("<script>alert('Usuário logado com sucesso.'); history.go(-1);</script>");
			} else {
				// response.getWriter().write("<div class='alert alert-danger alert-dismissible fade show' role='alert'>Usuário ou senha inválidos.<button type='button' class='close' id='alert' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button></div><script>setTimeout(() => {document.getElementById('alert').click(); window.location.href = 'home.jsp'}, 2000);</script>");
				response.getWriter().write("<script>alert('Usuário ou senha inválidos.'); history.go(-1);</script>");
			}
		
		}
	
	%>
</body>
</html>