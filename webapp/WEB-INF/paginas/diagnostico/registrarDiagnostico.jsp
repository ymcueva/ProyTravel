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
	
	<style>
		.alignDerecha{
			text-align:right;
		}
		.alignIzquierda{
			text-align:left;
		}
		.alignCentro{
			text-align:center;
		}
		
		.txtFecha{
			background-color: #FFF !important;
		}
	</style>
	
<script>

	var codigoInseminacionGeneral;
	var codigoAnimalGeneral;
 	$(document).ready(function(){
		$.ajaxSetup({
			scriptCharset: "utf-8",
			contentType: "application/json; charset=utf-8"
		});
		jQuery.support.cors = true;
		
 		//inicia();
 		listaDiagnostico = ${listaDiagnostico};
 		
//  		construirTablaListaDiagnostico(listaDiagnostico);
		
		/*$("#btnBuscarInseminacion").on('click', function(e){
			e.preventDefault();
			buscarInseminacion();
		})*/
		
 	});
	
	
// 	function inicia(){
// 		$('#divFechaInseminacionBusq').datetimepicker({
// 			language : 'es',
//             autoClose : true,
//  			minDate: '01/01/2000',

//             format: 'DD/MM/YYYY',
//             pickTime: false,
// 			useCurrent: false
//         });
		
// 		$("#eliminarFecha").on("click", function(e){
// 			e.preventDefault();
// 			$("#txtFechaInseminacionBusq").val("");
// 		})
// 	}
	
// 	function validarNumeroLetra(e){
// 		var key = window.Event ? e.which : e.keyCode;
// 		return ( (key==32 ) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) );
//  	}
 	
// 	function buscarInseminacion(){
		
// 		var grabarFormParams = {
// 			'inseminacionBean' : formToObject( '#formConsuInsemi' )
// 		};
		
// 		$.ajax({
// 			url: '${pageContext.request.contextPath}/listarInseminacion?btnBuscar=1',
// 			data: JSON.stringify(grabarFormParams),
// 			cache: false,
// 			async: true,
// 			type: 'POST',
// 			contentType: "application/json; charset=utf-8",
// 			dataType: 'json',
// 			success: function(response) {
				
// 				var rpta = response.dataJson;
//                 // actualizando lista
//                 var listaInseminacion = [];
//                 if (rpta.listaInseminacion != null) {
//                     listaInseminacion = rpta.listaInseminacion;
//                 }
// 				construirTablaListaInseminacion(listaInseminacion);
// 			},
// 			error: function(data, textStatus, errorThrown) {
// 			}
// 		});
		
// 	}
	
	
//  	function construirTablaListaDiagnostico( dataGrilla ){
		
// 		var table = $('#tblListaDiagnostico').dataTable({
// 			data: dataGrilla,
// 			bDestroy: true,
// 			ordering: false,
// 			searching: false,
// 			paging: true,
// 			bScrollAutoCss: true,
// 			bStateSave: false,
// 			bAutoWidth: false,
// 			bScrollCollapse: false,
// 			pagingType: "full_numbers",
// 			iDisplayLength: 4,
// 			responsive: true,
// 			bLengthChange: false,
// 			info: false,
			
// 			fnDrawCallback: function(oSettings) {
// 				if (oSettings.fnRecordsTotal() == 0) {
// 					$('#tblListaDiagnostico_paginate').addClass('hiddenDiv');
// 				} else {
// 					$('#tblListaDiagnostico_paginate').removeClass('hiddenDiv');
// 				}
// 			},
			
// 			fnRowCallback: function (nRow, aData, iDisplayIndex) {
// 				$(nRow).attr('id', aData[5]);
// 				$(nRow).attr('align', 'center');
// 				$(nRow).attr('rowClasses','tableOddRow');
// 				return nRow;
// 			},
// 			language: {
// 				url: "/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/plug-ins/1.10.7/i18n/Spanish.json"
// 			},
			
// 			columnDefs: [{
// 				targets: 4,
// 				render: function(data, type, row){
// 					if (row !=null && typeof row != 'undefined') {
// 						var VerDetalle = "<span> <a href='javascript:;' onclick='verDetalleInseminacion(\""+row.codigoInseminacion+"\")' title='Ver Inseminaci&oacute;n' ><span class='glyphicon glyphicon-eye-open'></span></a> </span>";
// 						var Editar = "<span>&nbsp;</span><span> <a href='javascript:;' onclick='editarInseminacion(\""+row.codigoInseminacion+"\")' title='Editar Inseminaci&oacute;n' ><span class='glyphicon glyphicon-pencil'></span></a> </span>";
// 						var Eliminar = "<span>&nbsp;</span><span> <a href='javascript:;' onclick='abrirConfirmarEliminacion(\""+row.codigoInseminacion+"\", \""+row.codigoVaca+"\" )' title='Eliminar Inseminaci&oacute;n' ><span class='glyphicon glyphicon-remove-circle'></span></a> </span>";
// 						return VerDetalle + Editar + Eliminar;
// 					}
// 					return '';
// 				}
// 			}],
// 			columns: [
// 				{data: "numeroFila"},
// 				{data: "fechaDiagnostico"},
// 				{data: "nombreAnimal"},
// 				{data: "enfermedad"}
// 			]
// 		});
//  	}

	function abrirRegistrarSintoma(){
		
		$("#divRegistroSintoma").modal({
			backdrop: 'static',
			keyboard: false
		});
	}
	
	function abrirRegistrarAntedecente(){
		$("#divRegistroAntecedente").modal({
			backdrop: 'static',
			keyboard: false
		});
	}
	
	
	
	function salir(){
		location.href= '${pageContext.request.contextPath}/principal';
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
					<h3 class="panel-title"><center><strong>Registrar Diagn&oacute;stico de Enfermedad del Animal</strong></center></h3>
				</div>
				<div class="panel-body">

					
					
					<div class="col-sm-12" id="divSecBusquedaInseminacion">
						<div class="panel panel-primary">
<!-- 							<div class="panel-heading">	<strong>B&uacute;squeda de inseminaciones</strong></div> -->
							
							<div class="panel-body">
												
								<div class="row">
									<div class="col-sm-12">
										<form id="formConsuInsemi" class="form-horizontal" method="POST">

											<div class="form-group">
												<label class="col-sm-2 control-label alignDerecha">Codigo Animal:</label>
												<div class="col-sm-4">
													<input id="txtCodigoAnimal" onkeypress="return validarNumeroLetra(event)" name="nombreVaca" type="text" maxlength="30" class="form-control">
												</div>
												
												<label class="col-sm-2 control-label alignDerecha">Fecha diagnóstico:</label>
												<div class="col-sm-4">
													
													<div class="input-group date tamanoMaximo" id="divFechaInseminacionBusq">
														<input id="txtFechaInseminacionBusq" name="fechaInseminacion" type="text" maxlength="30" readonly="yes" class="form-control txtFecha" />
														<span class="input-group-addon datepickerbutton">
															<span class="glyphicon glyphicon-calendar"></span>
														</span>
														<span class="input-group-addon" id="eliminarFecha">
															<span class="glyphicon glyphicon-remove"></span>
														</span>
													</div>
												</div>
												
											</div>
										</form>
									</div>
								</div>
								
							</div>
						</div>
					</div>
					
					
					<div class="col-sm-12" align="right">
						<input type="button" class="btn btn-primary" value="Registrar Sintoma" id="btnRegistrarSintoma" onclick="abrirRegistrarSintoma()"></input>
					</div>
					
					<div class="col-sm-12" align="right">&nbsp;</div>
					
					<div class="col-sm-12" id="divSecDatosInseminacion">
						<div class="panel panel-primary">
							<div class="panel-heading">	<strong>Lista de Sintomas</strong></div>
							<div class="panel-body">
								<div id="dvSubSecSintomas">
									<div class="col-sm-12" id="divTblListaSintomas">
										<table id ="tblListaDiagnostico" class="table table-bordered responsive" style="width:100%">
											<thead>
												<tr>
													<th width="10%" class="text-center">N&deg;</th>
													<th width="20%" class="text-center">Sintomas</th>
													<th width="10%" class="text-center">Opciones</th>
												</tr>
											</thead>
										</table>
										
									</div>
								</div>
							</div>
						</div>
					</div>
					
					
					<div class="col-sm-12" align="right">
						<input type="button" class="btn btn-primary" value="Registrar Antecedente" id="btnRegistrarAntecedente" onclick="abrirRegistrarAntedecente()"></input>
						
					</div>
					
					<div class="col-sm-12" align="right">&nbsp;</div>
					
					<div class="col-sm-12" id="divSecDatosInseminacion">
						<div class="panel panel-primary">
							<div class="panel-heading">	<strong>Lista de Antecedentes</strong></div>
							<div class="panel-body">
								<div id="dvSubSecAntecedentes">
									<div class="col-sm-12" id="divTblListaantecedentes">
										<table id ="tblListaDiagnostico" class="table table-bordered responsive" style="width:100%">
											<thead>
												<tr>
													<th width="10%" class="text-center">N&deg;</th>
													<th width="20%" class="text-center">Antecedentes</th>
													<th width="10%" class="text-center">Opciones</th>
												</tr>
											</thead>
										</table>
										
									</div>
								</div>
							</div>
						</div>
					</div>
			
					
					<div class="col-sm-12" id="divSecDatosInseminacion">
							<div class="panel-body">
								<div class="row">
									<div class="col-sm-4" style="text-align:right; font-weight:bold">Enfermedad:</div>
									<div class="col-sm-8" id="divCodigoAnimal" >
									
										<select name="enfermedad" id="selEnfermedad">
											<option value="1">Metritis</option>
											<option value="2">otros</option>
										</select>
									</div>
								</div>
									
								<div class="row">
									<div class="col-sm-4" style="text-align:right; font-weight:bold">Observacion:</div>
									
									<div class="col-sm-8" id="divNombreAnimal">
										<textarea name="observacion" id="txtObservacion" onkeypress="return validarNumeroLetra(event)" rows="4" cols="50" value="s" /></textarea>
									</div>
									
								</div>
									
							</div>
						</div>
					</div>
					
					
				
					
					
					
				</div>
			</div>
		</div>
	</div>
</div>

<div id="divRegistroSintoma" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog">
		<div class="panel panel-primary">
			<%@ include file="registrarSintoma.jsp" %>
		</div>
	</div>
</div>

<div id="divRegistroAntedecente" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog">
		<div class="panel panel-primary">
			<%@ include file="registrarAntecedente.jsp" %>
		</div>
	</div>
</div>

<div id="mdlConfirmaEliminacion" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Confirmaci&oacute;n Eliminaci&oacute;n</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center">&iquest;Desea Eliminar?</p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">
						<input type="button" class="btn btn-primary" intermediateChanges="false" data-dismiss="" value="Si"
							onclick="eliminarInseminacion();" id="btnEliminaRegistro"></input>
						<button type="button" id="btnEliminaNo" class="btn btn-primary" data-dismiss="modal">No</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</body>

</html>