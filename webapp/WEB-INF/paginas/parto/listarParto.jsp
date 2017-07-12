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

	var codigoPartoGeneral;
	var codigoAnimalGeneral;
 	$(document).ready(function(){
		$.ajaxSetup({
			scriptCharset: "utf-8",
			contentType: "application/json; charset=utf-8"
		});
		jQuery.support.cors = true;
		
 		inicia();
		listaParto = ${listaParto};

		construirTablaListaParto(listaParto);
		
		$("#btnBuscarParto").on('click', function(e){
			e.preventDefault();
			buscarParto();
		})
		
 	});
	
	
	function inicia(){
		$('#divFechaPartoBusq').datetimepicker({
			language : 'es',
            autoClose : true,
 			minDate: '01/01/2000',
 			maxDate: '<%=mapaDatos.get("fechaParto")%>',
            format: 'DD/MM/YYYY',
            pickTime: false,
			useCurrent: false
        });
		
		$("#eliminarFecha").on("click", function(e){
			e.preventDefault();
			$("#txtFechaPartoBusq").val("");
		})
	}
	
	function validarNumeroLetra(e){
		var key = window.Event ? e.which : e.keyCode;
		return ( (key==32 ) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) );
 	}
 	
	
	function buscarParto(){
		
		var grabarFormParams = {
			'partoBean' : formToObject( '#formConsuParto' )
		};
		
		$.ajax({
			url: '${pageContext.request.contextPath}/listarParto?btnBuscar=1',
			data: JSON.stringify(grabarFormParams),
			cache: false,
			async: true,
			type: 'POST',
			contentType: "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				var rpta = response.dataJson;
                // actualizando lista
                var listaParto = [];
                if (rpta.listaParto != null) {
                	listaParto = rpta.listaParto;
                }
                construirTablaListaParto(listaParto);
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
	}
	
 	function construirTablaListaParto( dataGrilla ){
		
		var table = $('#tblListaParto').dataTable({
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
					$('#tblListaParto_paginate').addClass('hiddenDiv');
				} else {
					$('#tblListaParto_paginate').removeClass('hiddenDiv');
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
						var VerDetalle = "<span> <a href='javascript:;' onclick='verDetalleParto(\""+row.codigoParto+"\")' title='Ver Parto' ><span class='glyphicon glyphicon-eye-open'></span></a> </span>";
						var Editar = "<span>&nbsp;</span><span> <a href='javascript:;' onclick='editarParto(\""+row.codigoParto+"\")' title='Editar Parto' ><span class='glyphicon glyphicon-pencil'></span></a> </span>";
						var Eliminar = "<span>&nbsp;</span><span> <a href='javascript:;' onclick='abrirConfirmarEliminacion(\""+row.codigoParto+"\", \""+row.codigoVaca+"\")' title='Eliminar Parto' ><span class='glyphicon glyphicon-remove-circle'></span></a> </span>";
						return VerDetalle + Editar + Eliminar;
					}
					return '';
				}
			}],
			columns: [
				{data: "numeroFila"},
				{data: "fechaParto"},
				{data: "nombreVaca"},
				{data: "diasParto"},
				{data: "estadoRegistroCria"}
			]
		});
 	}
	
	function salir(){
		location.href= '${pageContext.request.contextPath}/principal';
	}
	
	function listarVacasAParir(){
		location.href= '${pageContext.request.contextPath}/listarVacasAParir';
	}
	
	function editarParto(codigoParto){
		$("#divConfirmacionRegistroParto").modal("hide");
		
		$.ajax({
			url: '${pageContext.request.contextPath}/abrirEditarParto?codParto='+codigoParto,
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				
				if (response.estado = "ok") {
					
					$("#tituloParto").html(response.dataJson.titulo);
					$("#txtCodigoParto").val(response.dataJson.codigoParto);
					$("#btnRegistrar").html(response.dataJson.botonGrabar);
					
					$("#divCodigoVaca").html(response.dataJson.codigoVaca);
					$("#divNombreToro").html(response.dataJson.nombreToro);
					$("#divNumeroDiasPrenez").html(response.dataJson.numeroDiasPrenez);
					$("#divEdadMesesParto").html(response.dataJson.numeroMesesParto);
					
					$("#txtflagEdicion").val("1");
					$("#txtCodigoParto").val(response.dataJson.codigoParto);
					$("#txtFechaParto").val(response.dataJson.fechaParto);
					$("#txtNumeroCriasParto").val(response.dataJson.numeroCriasParto);
					$("#selTipoParto").val(response.dataJson.tipoParto);
					$("#txtObservacion").val(response.dataJson.observacion);
					
					$("#divRegistroParto").modal({
						backdrop: 'static',
						keyboard: false
					});
				}
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
	}
	
	function verDetalleParto(codigoParto){
		$.ajax({
			url: '${pageContext.request.contextPath}/verDetalleParto?codParto='+codigoParto,
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				
				if (response.estado = "ok") {
					var tipoParto = (response.dataJson.partoBean.tipoParto=1?"Natural":"Asistido");
					$("#tituloParto").html(response.dataJson.titulo);
					$("#divFechaPartoDeta").html(response.dataJson.partoBean.fechaParto);
					$("#divTipoParto").html(tipoParto);
					$("#divEstadoParto").html(response.dataJson.partoBean.estadoParto);
					$("#divNombreVaca").html(response.dataJson.partoBean.nombreVaca);
					$("#divNumeroCrias").html(response.dataJson.partoBean.numeroCriasParto);
					$("#divNumeroDiasPrenez").html(response.dataJson.partoBean.numeroDiasPrenez);
					$("#divDiasParto").html(response.dataJson.partoBean.diasParto);
					$("#divObservacion").html(response.dataJson.partoBean.observacion);
					$("#divUsuarioRegistro").html(response.dataJson.partoBean.usuarioRegistro);
					$("#divUsuarioModifica").html(response.dataJson.partoBean.usuarioModifica);
					
					$("#divVerDetalleParto").modal({
						backdrop: 'static',
						keyboard: false
					});
				}
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
	}
	
	
	function abrirConfirmarEliminacion(codigoParto, codigoAnimal){
		codigoPartoGeneral = codigoParto;
		codigoAnimalGeneral = codigoAnimal;
		$("#mdlConfirmaEliminacion").modal({
			backdrop: 'static',
			keyboard: false
		});
	}
	
	function eliminarParto(){
		
		$.ajax({
			url: '${pageContext.request.contextPath}/eliminarParto?codParto='+codigoPartoGeneral+'&codAnimal='+codigoAnimalGeneral,
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				if (response.estado = "ok") {
					location.href = '${pageContext.request.contextPath}/listarParto';
				}
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
		codigoPartoGeneral = "";
	}
	
	function limpiarFormularioParto(){
		$('#formParto').bootstrapValidator('resetForm', true);
		$("#selTipoParto").val("");
		$("#txtFechaParto").val("");
		$("#txtObservacion").val("");
		$("#txtNumeroCriasParto").val("");
	}
	
	function cerraVerDetalle(){
		$('#divVerDetalleParto').modal("hide");
	}
	
	function cerrarParto(){
		$('#divRegistroParto').modal("hide");
	}
	
	function formToObject(formID) {
	    var formularioObject = {};
	    var formularioArray = $( formID ).serializeArray();
	    $.each(formularioArray, function(i, v) {
	        formularioObject[v.name] = v.value;
	    });
	    return formularioObject;
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
					<h3 class="panel-title"><center><strong>LISTA DE PARTOS</strong></center></h3>
				</div>
				<div class="panel-body">

					
					
					<div class="col-sm-12" id="divSecBusquedaParto">
						<div class="panel panel-primary">
							<div class="panel-heading">	<strong>B&uacute;squeda de parto</strong></div>
							
							<div class="panel-body">
												
								<div class="row">
									<div class="col-sm-12">
										<form id="formConsuParto" class="form-horizontal" method="POST">

											<div class="form-group">
												<label class="col-sm-1 control-label alignDerecha">Fecha:</label>
												<div class="col-sm-3">
													<div class="input-group date tamanoMaximo" id="divFechaPartoBusq">
														<input id="txtFechaPartoBusq" name="fechaParto" type="text" maxlength="30" readonly="yes" class="form-control txtFecha" />
														<span class="input-group-addon datepickerbutton">
															<span class="glyphicon glyphicon-calendar"></span>
														</span>
														<span class="input-group-addon" id="eliminarFecha">
															<span class="glyphicon glyphicon-remove"></span>
														</span>
													</div>
												</div>
											
												
												<label class="col-sm-2 control-label alignDerecha">Nombre Vaca:</label>
												<div class="col-sm-4">
													<input id="txtNombreVaca" onkeypress="return validarNumeroLetra(event)" name="nombreVaca" type="text" maxlength="30" class="form-control">
												</div>
												
												<div class="col-sm-2">
													<button id="btnBuscarParto" class="btn btn-primary btn-block" title="Buscar">Buscar</button>
												</div>
											</div>
										</form>
									</div>
								</div>
								
							</div>
						</div>
					</div>
					
					
					<div class="col-sm-12" id="divSecDatosParto">
						<div class="panel panel-primary">
							<div class="panel-heading">	<strong>Lista de partos</strong></div>
							<div class="panel-body">
								<div id="dvSubSecParto">
									<div class="col-sm-12" id="divTblListaParto">
										<table id ="tblListaParto" class="table table-bordered responsive" style="width:100%">
											<thead>
												<tr>
													<th width="10%" class="text-center">N&deg;</th>
													<th width="20%" class="text-center">Fecha de Parto</th>
													<th width="20%" class="text-center">Nombre Vaca</th>
													<th width="20%" class="text-center">D&iacute;as de Parto</th>
													<th width="20%" class="text-center">Registro Cr&iacute;as</th>
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
						<input type="button" class="btn btn-primary" value="Registrar Parto" id="btnRegistrarParto" onclick="listarVacasAParir()"></input>
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
							onclick="eliminarParto();" id="btnEliminaRegistro"></input>
						<button type="button" id="btnEliminaNo" class="btn btn-primary" data-dismiss="modal">No</button>
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

<div id="divVerDetalleParto" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog">
		<div class="panel panel-primary">
			<%@ include file="verDetalleParto.jsp" %>
		</div>
	</div>
</div>

</body>

</html>