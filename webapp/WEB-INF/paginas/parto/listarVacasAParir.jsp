<%@page import="pe.gob.sunat.framework.spring.util.conversion.SojoUtil"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="mapaDatos" scope="request" class="java.util.HashMap" />

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
 		inicia();
 		var listaVacasAParir = ${listaVacasAParir};
 		construirTablaVacasAParir(listaVacasAParir);
		
 	});
 	
 	function construirTablaVacasAParir( dataGrilla ){
 		var table = $('#tblVacasAParir').dataTable({
            data: dataGrilla,
			bDestroy: true,
            ordering: false,
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
                    $('#tblVacasAParir_paginate').addClass('hiddenDiv');
                } else {
                    $('#tblVacasAParir_paginate').removeClass('hiddenDiv');
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
			columnDefs: [{
            	targets: 6,
            	render: function(data, type, row){
            		if (row !=null && typeof row != 'undefined') {
						var registrarParto = "<span> <a href='javascript:;' onclick='abrirRegistrarParto(\""+row.codigoAnimal+"\",\""+row.codigoToro+"\",\""+row.nombreToro+"\",\""+row.numeroDiasPrenez+"\",\""+row.numeroMesesParto+"\")' title='Registrar Parto' >Reg. Parto</a> </span>";
						var registrarAborto = "&nbsp;<span> <a href='javascript:;' onclick='abrirRegistrarAborto(\""+row.codigoAnimal+"\",\""+row.nombreToro.replace("\n"," sdsds")+"\",\""+row.numeroDiasPrenez+"\",\""+row.numeroMesesParto+"\")' title='Registrar Aborto' >Reg. Aborto</a> </span>";
            			return registrarParto + registrarAborto;
            		}
            		return '';
            	}
            }],
            
			columns: [
				{data: "numeroFila"},
				{data: "codigoAnimal"},
				{data: "nombreAnimal"},
				{data: "nombreToro"},
				{data: "fechaInseminacion"},
				{data: "numeroDiasPrenez"},
			]
        });
 	}
	
	function abrirRegistrarParto(codigoAnimal, codigoToro, nombreToro, numeroDiasPrenez, edadMesesParto){
		$.ajax({
			url: '${pageContext.request.contextPath}/abrirRegistrarParto',
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
	    		
				if (response.estado = "ok") {
					$("#tituloParto").html(response.dataJson.titulo);
					$("#divCodigoVaca").html(codigoAnimal);
					$("#divNombreToro").html(nombreToro);
					$("#divNumeroDiasPrenez").html(numeroDiasPrenez);
					$("#divEdadMesesParto").html(edadMesesParto);
					
					$("#txtFechaParto").val(response.dataJson.fechaActual);
					
					$("#txtCodigoAnimal").val(codigoAnimal);
					$("#txtCodigoToro").val(codigoToro);
					
					$("#txtNumeroDiasPrenez").val(numeroDiasPrenez);
					//$("#txtflagEdicion").val("2");
					
					$("#divRegistroParto").modal({
						backdrop: "static", 
						keyboard: false
					});
				}
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
	}
	
	
	function abrirRegistrarAborto(codigoAnimal, nombreToro, numeroDiasPrenez, edadMesesAborto){
		$.ajax({
			url: '${pageContext.request.contextPath}/abrirRegistrarAborto',
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
	    		
				if (response.estado = "ok") {
					$("#tituloAborto").html(response.dataJson.titulo);
					$("#divCodigoVacaAborto").html(codigoAnimal);
					$("#divNombreToroAborto").html(nombreToro);
					$("#divNumeroDiasPrenezAborto").html(numeroDiasPrenez);
					$("#divEdadMesesAborto").html(edadMesesAborto);
					
					$("#txtFechaAborto").val(response.dataJson.fechaActual);
					$("#txtCodigoAnimalAborto").val(codigoAnimal);
					$("#txtNumeroDiasPrenezAborto").val(numeroDiasPrenez);
					
					//$("#txtflagEdicion").val("2");
					
					$("#divRegistroAborto").modal({
						backdrop: "static", 
						keyboard: false
					});
				}
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
	}
	
	
	function inicia(){
		
	}
	
	
	function retornarAListarParir(){
		location.href= '${pageContext.request.contextPath}/listarParto';
	}
	
	function limpiarFormularioParto(){
		$('#formParto').bootstrapValidator('resetForm', true);
		$("#selTipoParto").val("");
		$("#txtFechaParto").val("");
		$("#txtObservacion").val("");
		$("#txtNumeroCriasParto").val("");
	}
	
	function cerrarParto(){
		$('#divRegistroParto').modal("hide");
	}
	
	function cerrarAnimal(){
		$('#divRegistroAnimal').modal("hide");
	}
	
	function cancelarRegistroCria(){
		location.href = '${pageContext.request.contextPath}/listarParto';
	}
</script>

</head>

<body>


<div id="container" class="container" style="width: 100%">
	<div class="col-sm-12" id="divConsForm" style="margin:0px 0px 0px 0px;">
		<div class="col-sm-7">&nbsp;</div>
		<div class="col-sm-3">
			<span style="color:#337ab7">Usuario: <%=session.getAttribute("codigoUsuario")%></span>
		</div>
		<div class="col-sm-2">
			<a href="logout">Cerrar Sesion</a>
		</div>
	</div>
	<div class="row col-sm-offset-0 col-sm-12">
		<div class="principal">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title"><center><strong>LISTADO DE VACAS A PARIR</strong></center></h3>
				</div>
				<div class="panel-body">
				
					<div class="col-sm-12" id="divSecListaVacasAParir">
						<div class="panel panel-primary">
							<div class="panel-heading">	<strong>Lista de Vacas a parir</strong></div>
							
							<div class="panel-body">
												
								<div id="dvSubSecParir">
									<div class="col-sm-12">
										<table id ="tblVacasAParir" class="table table-bordered responsive" style="width:100%">
											<thead>
												<tr>
													<th width="5%" class="text-center">N&deg;</td>
													<th width="15%" class="text-center">C&oacute;digo Vaca</td>
													<th width="15%" class="text-center">Nombre Vaca</td>
													<th width="15%" class="text-center">Nombre Toro</td>
													<th width="15%" class="text-center">Fecha Inseminaci&oacute;n</td>
													<th width="15%" class="text-center">D&iacute;as Preñez</td>
													<th width="15%" class="text-center">Opciones</td>
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
							<input type="button" class="btn btn-primary" value="Retornar" id="btnRetornarParir" onclick="retornarAListarParir()"></input>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</div>

<div id="divRegistroParto" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog">
		<div class="panel panel-primary">
			<%@ include file="registrarParto.jsp" %>
		</div>
	</div>
</div>

<div id="divRegistroAborto" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog">
		<div class="panel panel-primary">
			<%@ include file="registrarAborto.jsp" %>
		</div>
	</div>
</div>


<div id="divRegistroAnimal" class="modal fade" role="dialog" style="width;700px; text-center:center">
	<div class="modal-dialog" style="width:900px;">
		<div class="panel panel-primary">
			<%@ include file="registrarAnimal.jsp" %>
		</div>
	</div>
</div>


<div id="mdlConfirmaRegistroCrias" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Confirmaci&oacute;n Registro Cr&iacute;as</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center">&iquest;Desea Registrar las Cr&iacute;as?</p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">
						<input type="button" class="btn btn-primary" intermediateChanges="false" data-dismiss="" value="Si"
							onclick="aceptaAbrirRegistrarCria();" id="btnRegistroCria"></input>
						<button type="button" id="btnEliminaNo" onclick="cancelarRegistroCria()" class="btn btn-primary" data-dismiss="modal">No</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</body>

</html>