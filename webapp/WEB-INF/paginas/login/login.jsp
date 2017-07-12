<%

if(session.getAttribute("codigoUsuario") == null){
	System.out.println("ES NULO INDEX");
} else {
	System.out.println("NO ES NULO INDEX");
}
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">

    <script src="/a/resources/js/jquery/1.11.2/jquery.min.js"></script>
    <script src="/a/resources/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/media/js/jquery.dataTables.min.js"></script>
	<script src="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/extensions/Responsive/js/dataTables.responsive.js"></script>
	<script src="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/extensions/Scroller/js/dataTables.scroller.js"></script>
	
	<!-- estilos -->	
	<link href="/a/resources/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
	
	<link href="/a/resources/bootstrap/3.3.2/css/bootstrap-theme.min.css" rel="stylesheet"/>
	<link href="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/media/css/jquery.dataTables.css" rel="stylesheet"/>
	<link href="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/media/css/jquery.dataTables_themeroller.css" rel="stylesheet"/>
	<link href="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/extensions/Responsive/css/dataTables.responsive.css" rel="stylesheet"/>
	<link href="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/extensions/Scroller/css/dataTables.scroller.css" rel="stylesheet"/>
	
	<!-- datetimepicker -->
	<script src="/a/resources/bootstrap/3.3.2/plugins/bootstrap-datetimepicker-3.1.3/js/moment-with-locales.js"></script>
	<script src="/a/resources/bootstrap/3.3.2/plugins/bootstrap-datetimepicker-3.1.3/js/bootstrap-datetimepicker.min.js"></script>
	<link href="/a/resources/bootstrap/3.3.2/plugins/bootstrap-datetimepicker-3.1.3/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
	
	<!-- bootstrap validator-->
	<script src="/a/resources/js/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
	
<script>
	
 	$(document).ready(function(){
		$("#txtUsuario").focus();
 	});
	
	function accederAplicacion(){
		$("#formLogin").submit();
	}
 	
</script>

</head>

<body>


<div id="container" class="container" style="width: 100%">
	<div class="row col-sm-offset-0 col-sm-12">
		<div class="principal">
			
			<div class="panel panel-primary">
									
				<div class="panel-heading" >
					<h3 class="panel-title" align="center">ACCESO A LA APLICACI&Oacute;N</h3>
				</div>
				
				<div class="panel-body">
					<div class="row">
						<div class="col-sm-12">
				
							<form id="formLogin" action="login" role="form" class="form-horizontal" method="post">
								
								<div class="form-group">
									<div class="col-sm-5" style="text-align:right; font-weight:bold">Usuario:</div>
									<div class="col-sm-2" >
										<input name="codigoUsuario" id="txtUsuario" type="text" class="form-control" ></input>
									</div>
									<div class="col-sm-5" >&nbsp;</div>
								</div>
								
								<div class="form-group">
									<div class="col-sm-5" style="text-align:right; font-weight:bold">Password:</div>
									<div class="col-sm-2" >
										<input name="claveUsuario" id="txtPassword" type="password" class="form-control" ></input>
									</div>
									<div class="col-sm-5" >&nbsp;</div>
								</div>
								
								<div class="form-group">
									<div class="col-sm-5">&nbsp;</div>
									<div class="col-sm-2" >
										<input type="submit" class="btn btn-primary" value="Ingresar" />
									</div>
									<div class="col-sm-5" >&nbsp;</div>
								</div>
							</form>
						</div>
					</div>
				</div>
					
			</div>
		</div>
	</div>
</div>

</body>

</html>