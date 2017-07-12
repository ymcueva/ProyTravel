<%@page import="pe.com.paxtravel.bean.ClienteBean"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% 
String mensaje = (String) request.getAttribute("msje");
//ArrayList = (String) request.getAttribute("data");
ArrayList<ClienteBean> lista = new ArrayList<ClienteBean>();
lista = (ArrayList<ClienteBean>) request.getAttribute("data");

System.out.println("mesaje: " + mensaje);
System.out.println("size: " + lista.size());
%>


<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Hola Mundo Spring</title>

</head>

<body>


	LISTANDO CLIENTES

	<br />


	<table border="1">
		<tr>
			<td>CODIGO</td>
			<td>PATERNO</td>
			<td>MATERNO</td>
			<td>NOMBRE</td>
			<td>DNI</td>
			<td>CIUDAD</td>
			<td>DIRECCION</td>
			<td>TELEFONO</td>
			<td>EMAIL</td>
		</tr>

		<c:forEach var="fila" items="${data}">
			<tr>
				<td>${fila.codigo}</td>
				<td>${fila.paterno}</td>
				<td>${fila.materno}</td>
				<td>${fila.nombre}</td>
				<td>${fila.dni}</td>
				<td>${fila.ciudad}</td>
				<td>${fila.direccion}</td>
				<td>${fila.telefono}</td>
				<td>${fila.email}</td>
			</tr>
		</c:forEach>

	</table>
</body>

</html>