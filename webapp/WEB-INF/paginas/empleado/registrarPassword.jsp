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

<script type="text/javascript">
	function completarRegistroEmpleado(){
		$.ajax({
	         url: '${pageContext.request.contextPath}/completarRegistroEmpleado',
	       	 data: $('#frmPassword').serialize(),
	         cache: false,
	         async: true,
	         type: 'GET',
	         contentType : "application/json; charset=utf-8",
	         dataType: 'json',
	         success: function(response) {
	        	 alert("response:" + response.estadoRegistro);
	        	 
	        	 if (response.estadoRegistro==1){
	        		 alert("Registro ok");
 	              	 $(location).prop( 'href', '${pageContext.request.contextPath}/registrarOK');

	        	 } else {
	        		 alert("Error en regsitro");
	        	 }
	        	 
// 	         	$(location).prop( 'href', '${pageContext.request.contextPath}/abrirRegistroCorreo?');
	         },
	         error: function(data, textStatus, errorThrown) {
	         }
    });
	 
 }
</script>

<title>Hola Mundo Spring</title>

</head>

<body>

	${tituloPagina}
	<br />

	<form name="frmPassword" id="frmPassword" method="GET" >
		<table>
		<tr>
			<td>INGRESAR PASSWORD</td>
			<td>
				<input type="text" name="password" id="password"/>
			</td>
		</tr>
		
		<tr>
			<td colspan="2">
				<input type="button" name="btnRegistrar" id="btnRegistrar" value="COMPLETAR REGISTRO" onclick="completarRegistroEmpleado()" />
			</td>
		</tr>
		
		</table>
	</form>
</body>

</html>