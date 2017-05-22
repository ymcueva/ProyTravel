<%@page import="pe.gob.sunat.framework.spring.util.conversion.SojoUtil"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="mapaDatos" scope="request" class="java.util.HashMap" />
<%
String fechaOrdeno = (String) mapaDatos.get("fechaOrdeno"); 
String flagTurno = (String) mapaDatos.get("flagTurno");
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

	var codigoProduccionGlobal;
	
 	$(document).ready(function(){

		
 		inicia();
 		var listaProduccion = ${listaProduccion};
 		
 		construirTablaProduccion(listaProduccion);
		
 	});
 	
 	function construirTablaProduccion( dataGrilla ){
 		var table = $('#tblProduccion').dataTable({
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
                    $('#tblProduccion_paginate').addClass('hiddenDiv');
                } else {
                    $('#tblProduccion_paginate').removeClass('hiddenDiv');
                }
            },
			
            columnDefs: [{
				targets: 6,
				render: function(data, type, row){
					if (row !=null && typeof row != 'undefined') {
						var eliminarProduccion = "<span> <a href='javascript:;' onclick='abrirConfirmarEliminacion(\""+row.codigoProduccion+"\")' title='Ver Inseminaci&oacute;n' ><span class='glyphicon glyphicon-remove-circle'></span></a> </span>";
						return eliminarProduccion;
					}
					return '';
				}
			}],
			
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
				{data: "fechaOrdeno"},
				{data: "turno"},
				{data: "codigoAnimal"},
				{data: "cantidadProducida"},
				{data: "usuario"}
			]
        });
 	}
 	
	function inicia(){
		$("#divFechaOrdenoProduccion").html("<%=fechaOrdeno.toString()%>");
		var flagTurno = "<%=flagTurno%>";
		if (flagTurno == 1) {
			$("#selTurno").val("1");
		} else if (flagTurno == 2) {
			$("#selTurno").val("2");
		} else if (flagTurno = 3) {
			$("#selTurno").val("3");
		}
	}
	
	function confirmarRegistro(){
		$('#mdlConfirmaRegistro').modal({
			backdrop: 'static',
			keyboard: false
		});
	}
	
	function cerrar(){
		$("#divProduccion").modal("hide");
	}
	
	function mostrarProduccion(){
		$("#divProduccion").modal({
			backdrop: 'static',
			keyboard: false
		});
	}
	
	function salirProduccion(){
		location.href= '${pageContext.request.contextPath}/';
	}
	
	function abrirConfirmarEliminacion(codigoProduccion){
		codigoProduccionGlobal = codigoProduccion;
		$("#mdlConfirmaEliminacion").modal({
			backdrop: 'static',
			keyboard: false
		});
	}
	
	function eliminarProduccion(){
		$.ajax({
			url: '${pageContext.request.contextPath}/eliminarProduccion?codProduccion='+codigoProduccionGlobal,
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				if (response.estado = "ok") {
					location.href = '${pageContext.request.contextPath}/listarProduccion';
				}
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
		codigoProduccionGlobal = "";
	}
</script>

</head>

<body>


<div id="container" class="container" style="width: 100%">
	<div class="row col-sm-offset-0 col-sm-12">
		<div class="principal">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title"><center><strong>PRODUCCIÓN DE LECHE</strong></center></h3>
				</div>
				<div class="panel-body">

					<div class="col-sm-12" id="divSecDatosPagRenta">
						<div class="panel panel-primary">
							<div class="panel-heading">	<strong>Producción diaria de leche</strong></div>
							
							<div class="panel-body">
												
								<div id="dvSubSecProduccion">
									<div class="col-sm-12" align="right">
										<div class="form-group">
											<input type="button" class="btn btn-primary" intermediateChanges="false" data-dismiss="modal" value="Agregar Produccion" id="btnAgregaProduccion" onclick="mostrarProduccion()"></input>
										</div>
									</div>
									
									
									<div class="col-sm-12">
										<table id ="tblProduccion" class="table table-bordered responsive" style="width:100%">
											<thead>
												<tr>
													<th width="5%" class="text-center">N&deg;</td>
													<th width="15%" class="text-center">Fecha/Hora Ordeño</td>
													<th width="15%" class="text-center">Turno</td>
													<th width="20%" class="text-center">Código Animal</td>
													<th width="20%" class="text-center">Cantidad Producida (Lt.)</td>
													<th width="20%" class="text-center">Ordeñador</td>
													<th width="20%" class="text-center">Eliminar</td>
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
							<input type="button" class="btn btn-primary" value="Salir" id="btnAgregaProduccion" onclick="salirProduccion()"></input>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</div>


<div id="mdlConfirmaEliminacion" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Confirmaci&oacute;n Eliminaci&oacute;n</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center">&iquest;Desea Eliminar la producci&oacute;n?</p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">
						<input type="button" class="btn btn-primary" intermediateChanges="false" data-dismiss="" value="Si"
							onclick="eliminarProduccion();" id="btnEliminaRegistro"></input>
						<button type="button" id="btnEliminaNo" class="btn btn-primary" data-dismiss="modal">No</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="divProduccion" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog">
		<div class="panel panel-primary">
			<%@ include file="registrarProduccion.jsp" %>
		</div>
	</div>
</div>

<div id="divProduccionFin" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog">
		<div class="panel panel-primary">
			<%@ include file="registrarProduccionFin.jsp" %>
		</div>
	</div>
</div>
	
</body>

</html>