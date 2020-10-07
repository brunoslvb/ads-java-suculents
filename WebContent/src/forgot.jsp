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
	
		if(request.getParameter("forgot-id") != null) {
			
			// String id = request.getParameter("forgot-id");
			String email = request.getParameter("forgot-email");
			
			String date = Utils.getDate();
			
			RandomCode random = new RandomCode();
			
			String token = random.generate(64);
			
			Usuario usuario = new Usuario(0, "", email, "", "", "", 2, token, "", date);
			
			int id = usuario.getWhere("email = '" + email + "'");
			
			if(id != 0) {
				
				String msg = "Olá.\n\nSegue link para redefinição de senha do sistema criado com JavaWeb:\n\nhttp://localhost:8080/JavaWeb/src/forgotPassword.jsp?token=" + token;
				
				String[] args = {"bruno.silva@edi-labs.com", email, "Redefinição de Senha - JavaWeb", msg};
				
				Utils.sendMail(args);
				
				usuario.setDataToUpdate("email = '" + email + "'");
				
				usuario.setToken(token);
				usuario.setUpdatedAt(date);
				
				usuario.update();
			
				// response.getWriter().write("<div class='alert alert-success alert-dismissible fade show' role='alert'>E-mail enviado com sucesso.<button type='button' class='close' id='alert' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button></div><script>setTimeout(() => {document.getElementById('alert').click();}, 2000);</script>");
				response.getWriter().write("<script>alert('E-mail enviado com sucesso.'); history.go(-1);</script>");
			} else {
			
				// response.getWriter().write("<div class='alert alert-danger alert-dismissible fade show' role='alert'>E-mail não cadastrado.<button type='button' class='close' id='alert' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button></div><script>setTimeout(() => {document.getElementById('alert').click();}, 2000);</script>");
				response.getWriter().write("<script>alert('E-mail não cadastrado.'); history.go(-1);</script>");
			}
			
		}
	
	%>
</body>
</html>