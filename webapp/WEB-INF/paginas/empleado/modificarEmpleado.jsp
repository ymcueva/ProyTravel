<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<spring:url value="/resources/js/jquery/1.11.2/jquery.min.js" var="jquery" />
<script src="${jquery}"></script>
<script>

 
 function registrarEmpleado(){
	 $.ajax({
         url: '${pageContext.request.contextPath}/actualizarEmpleado',
       	 data: $('#frmActualizar').serialize(),
         cache: false,
         async: true,
         type: 'GET',
         contentType : "application/json; charset=utf-8",
         dataType: 'json',
         success: function(response) {
         	$(location).prop( 'href', '${pageContext.request.contextPath}/registrarPassword');
         },
         error: function(data, textStatus, errorThrown) {
        	 alert(eval("'"  + data + "'" )+ " - " + textStatus + " - " + errorThrown);
         }
     });
	 
 }

</script>

<title></title>

</head>

<body>

	${tituloPagina}
	<br />

	<form name="frmActualizar" id="frmActualizar" method="GET">
		<table>
			<tr>
				<td>CODIGO</td>
				<td>${codigoEmpleado}</td>
			</tr>
	
			<tr>
				<td>USUARIO</td>
				<td><input type="text" name="username" id="username" /></td>
			</tr>
			
			<tr>
				<td>PATERNO</td>
				<td>
				<input type="hidden" name="codigo" id="codigo" value="${codigoEmpleado}" />
				<input type="text" name="paterno" id="paterno" /></td>
			</tr>

			<tr>
				<td>MATERNO</td>
				<td><input type="text" name="materno" id="materno" /></td>
			</tr>

			<tr>
				<td>NOMBRE</td>
				<td><input type="text" name="nombre" id="nombre" /></td>
			</tr>

			<tr>
				<td colspan="2"><input type="button" name="txtGrabar" onclick="registrarEmpleado()"
					id="txtGrabar" value="Grabar..." /></td>
			</tr>

		</table>

	</form>
</body>

</html>