<%@page import="pe.gob.sunat.framework.spring.util.conversion.SojoUtil"%>
<%@page import="java.util.ArrayList"%>
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
 	});
 		
	function salirDetalleProdTotalPorFecha(){
		$("#divReporteProduccionTotalPorFecha").modal("hide");
	}
	
</script>

</head>

<body>


<div id="container">
	<div>
		<div class="principal">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title"><center><strong>DETALLE DE PRODUCCI&Oacute;N DIARIA POR VACA</strong></center></h3>
				</div>
				<div class="panel-body">

					<div class="col-sm-12" id="divSecDatosPagRenta">
						<div class="panel panel-primary">
							<div class="panel-heading">	<strong>Producción diaria de leche</strong></div>
							
							<div class="panel-body">
												
								<div id="dvSubSecProduccion">
									
									<div class="col-sm-12">
										<table id ="tblProduccionTotalPorFecha" class="table table-bordered responsive" style="width:100%">
											<thead>
												<tr>
													<th width="5%" class="text-center">N&deg;</td>
													<th width="20%" class="text-center">Fecha Ordeño</td>
													<th width="20%" class="text-center">Cantidad Total Lt.</td>
													<th width="15%" class="text-center">Detalle Ordeño</td>
												</tr>
											</thead>
										</table>
										
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="col-sm-12" align="right">
						<div class="form-group">
							<input type="button" class="btn btn-primary" value="Salir" id="btnAgregaProduccion" onclick="salirDetalleProdTotalPorFecha()"></input>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</div>
	
</body>

</html>