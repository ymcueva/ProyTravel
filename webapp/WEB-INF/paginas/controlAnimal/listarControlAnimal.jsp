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

	var codigoControlAnimalGeneral;
	var codigoAnimalGeneral;
 	$(document).ready(function(){
		$.ajaxSetup({
			scriptCharset: "utf-8",
			contentType: "application/json; charset=utf-8"
		});
		jQuery.support.cors = true;
		
 		inicia();
		listaControlAnimal = ${listaControlAnimal};
 		
 		construirTablaListaControlAnimal(listaControlAnimal);
		
		$("#btnBuscarControlAnimal").on('click', function(e){
			e.preventDefault();
			buscarControlAnimal();
		})
		
 	});
	
	
	function inicia(){
		$('#divFechaControlAnimalBusq').datetimepicker({
			language : 'es',
            autoClose : true,
 			minDate: '01/01/2000',
			maxDate: '<%=mapaDatos.get("fechaActual")%>',
            format: 'DD/MM/YYYY',
            pickTime: false,
			useCurrent: false
        });
		
		$("#eliminarFecha").on("click", function(e){
			e.preventDefault();
			$("#txtFechaControlAnimalBusq").val("");
		})
	}
	
	function validarNumeroLetra(e){
		var key = window.Event ? e.which : e.keyCode;
		return ( (key==32 ) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) );
 	}
 	
	function buscarControlAnimal(){
		
		var grabarFormParams = {
			'controlAnimalBean' : formToObject( '#formConsuControl' )
		};
		
		$.ajax({
			url: '${pageContext.request.contextPath}/listarControlEvolutivoAnimal?btnBuscar=1',
			data: JSON.stringify(grabarFormParams),
			cache: false,
			async: true,
			type: 'POST',
			contentType: "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				
				var rpta = response.dataJson;
                // actualizando lista
                var listaControlAnimal = [];
                if (rpta.listaControlAnimal != null) {
                	listaControlAnimal = rpta.listaControlAnimal;
                }
				construirTablaListaControlAnimal(listaControlAnimal);
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
		
	}
	
	
 	function construirTablaListaControlAnimal( dataGrilla ){
		
		var table = $('#tblListaControlAnimal').dataTable({
			data: dataGrilla,
			bDestroy: true,
			ordering: false,
			searching: false,
			paging: true,
			bScrollAutoCss: true,
			bStateSave: false,
			bAutoWidth: false,
			bScrollCollapse: false,
			pagingType: "full_numbers",
			iDisplayLength: 5,
			responsive: true,
			bLengthChange: false,
			info: false,
			
			fnDrawCallback: function(oSettings) {
				if (oSettings.fnRecordsTotal() == 0) {
					$('#tblListaControlAnimal_paginate').addClass('hiddenDiv');
				} else {
					$('#tblListaControlAnimal_paginate').removeClass('hiddenDiv');
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
				targets: 5,
				render: function(data, type, row){
					if (row !=null && typeof row != 'undefined') {
						var VerDetalle = "<span> <a href='javascript:;' onclick='verDetalleControlAnimal(\""+row.codigoControlAnimal+"\")' title='Ver Control Animal' ><span class='glyphicon glyphicon-eye-open'></span></a> </span>";
						var Editar = "<span>&nbsp;</span><span> <a href='javascript:;' onclick='editarControlAnimal(\""+row.codigoControlAnimal+"\")' title='Editar Control Animal' ><span class='glyphicon glyphicon-pencil'></span></a> </span>";
						var Eliminar = "<span>&nbsp;</span><span> <a href='javascript:;' onclick='abrirConfirmarEliminacion(\""+row.codigoControlAnimal+"\")' title='Eliminar Control Animal' ><span class='glyphicon glyphicon-remove-circle'></span></a> </span>";
						return VerDetalle + Editar + Eliminar;
					}
					return '';
				}
			}],
			columns: [
				{data: "numeroFila"},
				{data: "codigoAnimal"},
				{data: "nombreAnimal"},
				{data: "fechaControl"},
				{data: "edad"}
			]
		});
 	}
 	
	function salir(){
		location.href= '${pageContext.request.contextPath}/principal';
	}
	
	function listarControlAnimal(){
		location.href= '${pageContext.request.contextPath}/listarControlEvolutivoAnimal';
	}
	
	function editarControlAnimal(codigoControlAnimal){
		$.ajax({
			url: '${pageContext.request.contextPath}/abrirEditarControlAnimal?codControlAnimal='+codigoControlAnimal,
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				
				if (response.estado = "ok") {
 					$("#titulo").html(response.dataJson.titulo);
 					$("#btnRegistrar").html(response.dataJson.botonGrabar);
					$("#divCodigoAnimalEdicion").html(response.dataJson.codigoAnimal);
 					$("#divEdadEdicion").html(response.dataJson.edad);
 					$("#txtFechaControl").val(response.dataJson.fechaControl);
 					$("#txtPerimetroToraxico").val(response.dataJson.perimetroToraxico);
 					$("#txtPeso").val(response.dataJson.peso);
 					$("#txtAltura").val(response.dataJson.altura);
					$("#selFlagDiagnostico").val(response.dataJson.flagDiagnostico);
					$("#txtObservacion").val(response.dataJson.observacion);
 					$("#txtflagEdicion").val("1");
 					$("#txtCodigoControlAnimal").val(response.dataJson.codigoControlAnimal);
					
					$("#divRegistroControlAnimal").modal({
						backdrop: 'static',
						keyboard: false
					});
				}
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
	}
	
	function verDetalleControlAnimal(codigoControlAnimal){
		$.ajax({
			url: '${pageContext.request.contextPath}/verDetalleControlAnimal?codControlAnimal='+codigoControlAnimal,
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				
				if (response.estado = "ok") {
					var diagnostico = (response.dataJson.controlAnimalBean.flagDiagnostico==1?"Si":"No");
					$("#titulo").html(response.dataJson.tituloControlAnimal);
					$("#divCodigoAnimal").html(response.dataJson.controlAnimalBean.codigoAnimal);
					$("#divEdad").html(response.dataJson.controlAnimalBean.edad);
					$("#divTipoPerimetro").html(response.dataJson.controlAnimalBean.perimetroToraxico);
					$("#divPeso").html(response.dataJson.controlAnimalBean.peso);
					$("#divAltura").html(response.dataJson.controlAnimalBean.altura);
					$("#divFechaControlAnimal").html(response.dataJson.controlAnimalBean.fechaControl);
					$("#divDiagnostico").html(diagnostico);
					$("#divObservacion").html(response.dataJson.controlAnimalBean.observacion);
					$("#divUsuario").html(response.dataJson.controlAnimalBean.usuarioRegistro);
					
					$("#divVerDetalleControlAnimal").modal({
						backdrop: 'static',
						keyboard: false
					});
				}
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
	}
	
	
	function abrirConfirmarEliminacion(codigoControlAnimal){
		codigoControlAnimalGeneral = codigoControlAnimal;
		$("#mdlConfirmaEliminacion").modal({
			backdrop: 'static',
			keyboard: false
		});
	}
	
	function eliminarControlAnimal(){
		$.ajax({
			url: '${pageContext.request.contextPath}/eliminarControlAnimal?codControlAnimal='+codigoControlAnimalGeneral,
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				if (response.estado = "ok") {
					location.href = '${pageContext.request.contextPath}/listarControlAnimal';
				}
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
		codigoControlAnimalGeneral = "";
	}
	
	function limpiarFormularioControlAnimal(){
		$('#formControlAnimal').bootstrapValidator('resetForm', true);
		//$("#selToro").val("");
		$("#txtFechaControl").val("");
		$("#txtObservacion").val("");
	}
	
	function cerraControlAnimal(){
		$('#divRegistroControlAnimal').modal("hide");
	}
	
	function cerraVerDetalle(){
		$('#divVerDetalleControlAnimal').modal("hide");
	}
	
	function formToObject(formID) {
	    var formularioObject = {};
	    var formularioArray = $( formID ).serializeArray();
	    $.each(formularioArray, function(i, v) {
	        formularioObject[v.name] = v.value;
	    });
	    return formularioObject;
	}
	
	
	function registrarControlAnimal(){
		$.ajax({
			url: '${pageContext.request.contextPath}/abrirRegistrarControlAnimal?codControlAnimal='+codigoControlAnimalGeneral,
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				if (response.estado = "ok") {
					$("#titulo").html(response.dataJson.titulo);
					$("#txtFechaControl").val(response.dataJson.fechaActual);
					$("#divRegistroControlAnimal").modal({
						backdrop: 'static',
						keyboard: false
					});
				}
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
		
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
					<h3 class="panel-title"><center><strong>LISTADO DE CONTROL DE ANIMAL</strong></center></h3>
				</div>
				<div class="panel-body">

					
					
					<div class="col-sm-12" id="divSecBusquedaInseminacion">
						<div class="panel panel-primary">
							<div class="panel-heading">	<strong>B&uacute;squeda de animal</strong></div>
							
							<div class="panel-body">
												
								<div class="row">
									<div class="col-sm-12">
										<form id="formConsuControl" class="form-horizontal" method="POST">

											<div class="form-group">
												<label class="col-sm-1 control-label alignDerecha">C&oacute;digo Animal:</label>
												<div class="col-sm-3">
													<div class="input-group date tamanoMaximo" id="divFechaInseminacionBusq">
														<input name="codigoAnimal" id="txtCodigoAnimal" onkeypress="return validarNumeroLetra(event)" type="text" maxlength="30" class="form-control">
													</div>
												</div>
												
												<label class="col-sm-2 control-label alignDerecha">Nombre Animal:</label>
												<div class="col-sm-4">
													<input name="nombreAnimal" id="txtNombreAnimal" onkeypress="return validarNumeroLetra(event)" type="text" maxlength="30" class="form-control">
												</div>
												
												<div class="col-sm-2">
													<button id="btnBuscarControlAnimal" class="btn btn-primary btn-block" title="Buscar">Buscar</button>
												</div>
											</div>
										</form>
									</div>
								</div>
								
							</div>
						</div>
					</div>
					
					
					<div class="col-sm-12" id="divSecDatosControlAnimal">
						<div class="panel panel-primary">
							<div class="panel-heading">	<strong>Lista de Control de Animal</strong></div>
							
							<div class="panel-body">
												
								<div id="dvSubSecInseminacion">
									<div class="col-sm-12" id="divTblListaControlAnimal">
										<table id ="tblListaControlAnimal" class="table table-bordered responsive" style="width:100%">
											<thead>
												<tr>
													<th width="10%" class="text-center">N&deg;</td>
													<th width="20%" class="text-center">C&oacute;digo Animal</td>
													<th width="20%" class="text-center">Nombre Animal</td>
													<th width="20%" class="text-center">Fecha Control</td>
													<th width="20%" class="text-center">Edad</td>
													<th width="10%" class="text-center">Opciones</td>
												</tr>
											</thead>
										</table>
										
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="col-sm-12" align="right">
						<input type="button" class="btn btn-primary" value="Registrar Control Evolutivo" id="btnRegistrarControlAnimal" onclick="registrarControlAnimal()"></input>
						<input type="button" class="btn btn-primary" value="Salir" id="btnSalir" onclick="salir()"></input>
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
				<div class="modal-body"> <p class="text-center">&iquest;Desea Eliminar?</p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">
						<input type="button" class="btn btn-primary" intermediateChanges="false" data-dismiss="" value="Si"
							onclick="eliminarControlAnimal();" id="btnEliminaRegistro"></input>
						<button type="button" id="btnEliminaNo" class="btn btn-primary" data-dismiss="modal">No</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="divRegistroControlAnimal" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog">
		<div class="panel panel-primary">
			<%@ include file="registrarControlAnimal.jsp" %>
		</div>
	</div>
</div>

<div id="divVerDetalleControlAnimal" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog">
		<div class="panel panel-primary">
			<%@ include file="verDetalleControlAnimal.jsp" %>
		</div>
	</div>
</div>

</body>

</html>