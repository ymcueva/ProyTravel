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

	var codigoProduccionGlobal;
	
 	$(document).ready(function(){
 		inicia();
 	});
 	
 	
	function inicia(){
		/*alert("11212"),
		$.ajax({
			url: '${pageContext.request.contextPath}/detalleProduccionDiariaPorVaca',
			cache: false,
			async: true,
			type: 'POST',
			contentType: "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				if (response.estado = "ok") {
					construirTablaProduccionDiariaPorVaca(response.dataJson.listaProduccionDiariaPorVaca)
				}
			},
			error: function(data, textStatus, errorThrown) {
			}
		});*/
	}
	
 	function construirTablaProduccionDiariaPorVaca( dataGrilla ){
		
 		var table = $('#tblProduccionDiariaPorVaca').dataTable({
            data: dataGrilla,
            ordering: false,
			bDestroy: true,
            searching: false,
            paging: true,
            bScrollAutoCss: true,
            bStateSave: false,
            bAutoWidth: false,
            info: false,
            bScrollCollapse: false,
            pagingType: "full_numbers",
            pageLength: 5,
            responsive: true,
            bLengthChange: false,
			
            fnDrawCallback: function(oSettings) {
                if (oSettings.fnRecordsTotal() == 0) {
                    $('#tblProduccionDiariaPorVaca_paginate').addClass('hiddenDiv');
                } else {
                    $('#tblProduccionDiariaPorVaca_paginate').removeClass('hiddenDiv');
                }
            },
			
            fnRowCallback: function (nRow, aData, iDisplayIndex) {
				$(nRow).attr('id', aData[5]);
				$(nRow).attr('align', 'center');
				$(nRow).attr('rowClasses','tableOddRow');
                return nRow;
            },
			language: {
                url: "/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/plug-ins/1.10.7/i18n/Spanish.json"
			},
			columns: [
				{data: "numeroFila"},
				{data: "codigoAnimal"},
				{data: "nombreAnimal"},
				{data: "cantidadProducida"}
			]
        });
 	}
	function salirDetalle(){
		$("#divReporteProduccionDiariaPorVaca").modal("hide");
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
										<table id ="tblProduccionDiariaPorVaca" class="table table-bordered responsive" style="width:100%">
											<thead>
												<tr>
													<th width="5%" class="text-center">N&deg;</td>
													<th width="20%" class="text-center">Código Animal</td>
													<th width="20%" class="text-center">Nombre Animal</td>
													<th width="15%" class="text-center">Cantidad Producida (Lt.)</td>
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
							<input type="button" class="btn btn-primary" value="Salir" id="btnSalir" onclick="salirDetalle()"></input>
							
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</div>
	
</body>

</html>