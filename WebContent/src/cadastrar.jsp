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
	
		if(request.getParameter("register-id") != null) {
			
			System.out.println("Cadastrar");
			
			// String id = request.getParameter("register-id");
			String name = request.getParameter("register-name");
			String email = request.getParameter("register-email");
			String birthday = request.getParameter("register-birthday");
			String password = Utils.encodePassword(request.getParameter("register-password"));
			
			String date = Utils.getDate();
			
			Usuario usuario = new Usuario(0, name, email, birthday, password, "", 2, "", date, date);
			
			int id = usuario.getWhere("email = '" + email + "'");
			
			usuario.setIdUsuario(id);
						
			if(id != 0){
				
				// response.getWriter().write("<div class='alert alert-warning alert-dismissible fade show' role='alert'>Usuário já cadastrado na base de dados.<button type='button' class='close' id='alert' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button></div><script>setTimeout(() => {document.getElementById('alert').click();}, 2000);</script>");
				response.getWriter().write("<script>alert('Usuário já cadastrado na base de dados.'); history.go(-1);</script>");
			} else {
			
				usuario.save();
			
				// response.getWriter().write("<div class='alert alert-success alert-dismissible fade show' role='alert'>Usuário cadastrado com sucesso.<button type='button' class='close' id='alert' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button></div><script>setTimeout(() => {document.getElementById('alert').click();}, 2000);</script>");
				response.getWriter().write("<script>alert('Usuário cadastrado com sucesso.'); history.go(-1);</script>");
			}
		
		}
	
	%>
</body>
</html>