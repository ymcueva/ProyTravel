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
		
 		inicia();
 				
		var listaOrden = ${listaOrden};
		
		construirTablaListaOrden(listaOrden);
		
 		$("#btnBuscarOrden").on('click', function(e){
 			e.preventDefault();
  			buscarOrden();
 		})
		
 	});
	
	
	function inicia(){
		$('#divFechaOrdenBusq').datetimepicker({
			language : 'es',
            autoClose : true,
 			minDate: '01/01/2000',
			
            format: 'DD/MM/YYYY',
            pickTime: false,
			useCurrent: false
        });
		
		$("#eliminarFecha").on("click", function(e){
			e.preventDefault();
			$("#txtFechaOrdenBusq").val("");
		});
		
	}
	
	function validarNumeroLetra(e){
		var key = window.Event ? e.which : e.keyCode;
		return ( (key==32 ) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) );
 	}
 	
	function buscarOrden(){
		
		var grabarFormParams = {
			'ordenBean' : formToObject( '#formConsuOrden' )
		};
		
		$.ajax({
			url: '${pageContext.request.contextPath}/listarOrden?btnBuscar=1',
			data: JSON.stringify(grabarFormParams),
			cache: false,
			async: true,
			type: 'POST',
			contentType: "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				
				var rpta = response.dataJson;
                // actualizando lista
                var listaOrden = [];
                if (rpta.listaOrden != null) {
                	listaOrden = rpta.listaOrden;
                }
				
				construirTablaListaOrden(listaOrden);
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
	}
	
 	function construirTablaListaOrden( dataGrilla ){
		
		var table = $('#tblListaOrden').dataTable({
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
			iDisplayLength: 20,
			responsive: true,
			bLengthChange: false,
			info: false,
			
			fnDrawCallback: function(oSettings) {
				if (oSettings.fnRecordsTotal() == 0) {
					$('#tblListaOrden_paginate').addClass('hiddenDiv');
				} else {
					$('#tblListaOrden_paginate').removeClass('hiddenDiv');
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
						
						var VerDetalle = "<span> <a href='javascript:;' onclick='verDetalleOrden(\""+row.idOrden+"\")' title='Ver Orden' ><span class='glyphicon glyphicon-eye-open'></span></a> </span>";
						return VerDetalle;
						
					}
					return '';
				}
			}],
	
			columns: [
				{data: "numeroFila"},
				{data: "numeroOrden"},
				{data: "fechaOrden"},
				{data: "descripcionOrden"},
				{data: "descripcionEstadoOrden"}
			]
		});
 	}
	
	function salir(){
		location.href= '${pageContext.request.contextPath}/principal';
	}
	
	function registrarOrden(){
		location.href= '${pageContext.request.contextPath}/cargarFormRegistrarOrden';
	}
	
	function verDetalleOrden(idOrden){
			
		$.ajax({
			url: '${pageContext.request.contextPath}/verDetalleOrden?idOrden='+idOrden,
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				
				var rpta = response.dataJson;
				$("#idOrdenDetalle").html(rpta.orden.idOrden)
				$("#divNumOrdenDetalle").html(rpta.orden.numeroOrden);
				
				$("#divFechaOrdenDetalle").html(rpta.orden.fechaOrden);
				$("#divFechaPartidaDetalle").html(rpta.orden.fechaPartida);
				$("#divFechaRetornoDetalle").html(rpta.orden.fechaRetorno);
				$("#divPresupuestoMaximoDetalle").html(rpta.orden.presupuestoMaximo);
				$("#divComentarioDetalle").html(rpta.orden.comentarioOrden);
				$("#divMotivoViaje").html(rpta.motivoViaje);
				$("#divServicioTuristico").html(rpta.servicioViaje);
				
				
				$("#divVerDetalleOrden").modal({
					backdrop: 'static',
					keyboard: false
				});
				
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
	}
	
	function limpiarFormularioInseminacion(){
		$('#formCotizacion').bootstrapValidator('resetForm', true);
		$("#selToro").val("");
		$("#txtFechaInseminacion").val("");
		$("#txtObservacion").val("");
	}
	
	function formToObject(formID) {
	    var formularioObject = {};
	    var formularioArray = $( formID ).serializeArray();
	    $.each(formularioArray, function(i, v) {
	        formularioObject[v.name] = v.value;
	    });
	    return formularioObject;
	}
	
	function cerraVerDetalle(){
		$('#divVerDetalleOrden').modal("hide");
	}
	
	function cerrarPopupOrden(){
		location.href= '${pageContext.request.contextPath}/listarOrden';
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
					<h3 class="panel-title"><center><strong>LISTADO DE ORDENES</strong></center></h3>
				</div>
				<div class="panel-body">
					
					<div class="col-sm-12" id="divSecBusquedaReserva">
						<div class="panel panel-primary">
							<div class="panel-heading">	<strong>Consulta de Ordenes</strong></div>
							
							<div class="panel-body">
												
								<div class="row">
									<div class="col-sm-12">
										<form id="formConsuOrden" class="form-horizontal" method="POST">

											<div class="form-group">
												<label class="col-sm-3 control-label alignDerecha">Nro. Orden:</label>
												<div class="col-sm-3">
													<input id="txtNumeroOrden" name="numeroOrden" type="text" maxlength="30" class="form-control">
												</div>
												
												<label class="col-sm-1 control-label alignDerecha">Estado:</label>
												<div class="col-sm-3">
													<select name="idEstadoOrden" id="selcodigoEstadoOrden" class="form-control tamanoMaximo"> 
														<option value="">--- Seleccione ---</option>
														<option value="6">Asignado</option>
														<option value="8">Revisado</option> 
														<option value="5">Finalizado</option> 
													</select>
												</div>
											</div>
												
											<div class="form-group">
												<label class="col-sm-3 control-label alignDerecha">Fecha Fin</label>
												<div class="col-sm-3">
													<div class="input-group date tamanoMaximo" id="divFechaOrdenBusq">
														<input id="txtFechaOrdenBusq" name="fechaOrden" type="text" maxlength="30" readonly="yes" class="form-control" />
														<span class="input-group-addon datepickerbutton">
															<span class="glyphicon glyphicon-calendar"></span>
														</span>
														<span class="input-group-addon" id="eliminarFecha">
															<span class="glyphicon glyphicon-remove"></span>
														</span>
													</div>
												</div>
												
											</div>
											
											<div class="form-group">
												
												<div class="col-sm-4">
												</div>
												<div class="col-sm-2">
													<input type="button" class="btn btn-primary btn-block" value="Buscar" id="btnBuscarOrden" onclick="buscarOrden()"></input>
												</div>
												
												<div class="col-sm-2" align="left">
													<input type="button" class="btn btn-primary btn-block" value="Nuevo" id="btnRegistrarOrden" onclick="registrarOrden()"></input>
												</div>
												<div class="col-sm-4">
												</div>
												
											</div>
											
								
										</form>
									</div>
								</div>
								
							</div>
						</div>
					</div>
					
					
					
					<div class="col-sm-12" id="divSecDatosReserva">
						<div class="panel panel-primary">
<!-- 							<div class="panel-heading">	<strong>Lista de Coti</strong></div> -->
							
							<div class="panel-body">
												
								<div id="dvSubSecReserva">
									<div class="col-sm-12" id="divTblListaOrden">
										
										<table id ="tblListaOrden" class="table table-bordered responsive" style="width:100%">
											<thead>
												<tr>
													<th width="5%" class="text-center">N&deg;</td>
													<th width="15%" class="text-center">N&deg; Orden</td>
													<th width="15%" class="text-center">Fecha Orden</td>
													<th width="20%" class="text-center">Descripci&oacute;n Orden</td>
													<th width="30%" class="text-center">Estado Orden</td>
													<th width="10%" class="text-center">Opcion</td>
												</tr>
											</thead>
										</table>
										
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

<div id="divRegistroInseminacion" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog">
		<div class="panel panel-primary">
			
		</div>
	</div>
</div>


<div id="mdlValidaCorreoCliente" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Cliente no tiene correo electr�nico:</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center">El cliente no tiene registrado un correo electr&oacute;nico<br />No se puede enviar la reserva.</p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">
						<input type="button" class="btn btn-primary" intermediateChanges="false" data-dismiss="" value="Aceptar"
							onclick="cerrarPopupReserva();"></input>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<div id="mdlEnviaReservaCliente" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Reserva Enviada:</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center" id="msjEnviaReserva"></p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">
						<input type="button" class="btn btn-primary" intermediateChanges="false" data-dismiss="" value="Aceptar"
							onclick="cerrarPopupReserva();"></input>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="divVerDetalleOrden" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog">
		<div class="panel panel-primary">
			<%@ include file="verDetalleOrden.jsp" %>
		</div>
	</div>
</div>

</body>

</html>
