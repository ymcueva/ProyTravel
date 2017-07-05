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
 				
		console.log("Ingresooooooooooo");
		
		var listaReserva = ${listaReserva};
		
		construirTablaListaReserva(listaReserva);
		
 		$("#btnBuscarReserva").on('click', function(e){
 			e.preventDefault();
  			buscarReserva();
 		})
		
 	});
	
	
	function inicia(){
		$('#divFechaCotizacionBusq').datetimepicker({
			language : 'es',
            autoClose : true,
 			minDate: '01/01/2000',
			
            format: 'DD/MM/YYYY',
            pickTime: false,
			useCurrent: false
        });
		
		$('#divFechaFinBusq').datetimepicker({
			language : 'es',
            autoClose : true,
 			minDate: '01/01/2000',
			
            format: 'DD/MM/YYYY',
            pickTime: false,
			useCurrent: false
        });
		
		$("#eliminarFecha").on("click", function(e){
			e.preventDefault();
			$("#txtFechaCotizacionBusq").val("");
		});
		
		$("#eliminarFechaFin").on("click", function(e){
			e.preventDefault();
			$("#txtFechaFinBusq").val("");
		});
	}
	
	function validarNumeroLetra(e){
		var key = window.Event ? e.which : e.keyCode;
		return ( (key==32 ) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) );
 	}
 	
	function buscarReserva(){
		
		var grabarFormParams = {
			'reservaBean' : formToObject( '#formConsuReserva' )
		};
		
		$.ajax({
			url: '${pageContext.request.contextPath}/listarReserva?btnBuscar=1',
			data: JSON.stringify(grabarFormParams),
			cache: false,
			async: true,
			type: 'POST',
			contentType: "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				
				var rpta = response.dataJson;
                // actualizando lista
                var listaReserva = [];
                if (rpta.listaReserva != null) {
                	listaReserva = rpta.listaReserva;
                }
				construirTablaListaReserva(listaReserva);
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
	}
	
 	function construirTablaListaReserva( dataGrilla ){
		
		var table = $('#tblListaReserva').dataTable({
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
			iDisplayLength: 10,
			responsive: true,
			bLengthChange: false,
			info: false,
			
			fnDrawCallback: function(oSettings) {
				if (oSettings.fnRecordsTotal() == 0) {
					$('#tblListaReserva_paginate').addClass('hiddenDiv');
				} else {
					$('#tblListaReserva_paginate').removeClass('hiddenDiv');
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
						var VerDetalle = "<span> <a href='javascript:;' onclick='verDetalleReserva(\""+row.idReserva+"\",\""+row.idEstadoReserva+"\")' title='Ver Reserva' ><span class='glyphicon glyphicon-eye-open'></span></a> </span>";
						return VerDetalle;
					}
					return '';
				}
			}],
	
			columns: [
				{data: "numeroFila"},
				{data: "numeroReserva"},
				{data: "numeroCotizacion"},
				{data: "fechaReserva"},
				{data: "cliente"},
				{data: "nombreEstadoReserva"}
			]
		});
 	}
	
 	function mostrarPaquete(idpaquete,idorden,nuorden,modifica){
 		var params = "?idpaquete=" + idpaquete;
 		params+= "&idorden=" + idorden;
 		params+= "&nuOrden=" + nuorden;
 		params+="&modifica=" + modifica;
 		location.href = '${pageContext.request.contextPath}/cargarFormRegistrarPaqueteTuristico' + params;
 			 	
 	}
 	
	function salir(){
		location.href= '${pageContext.request.contextPath}/principal';
	}
	
	function registrarReserva(){
		location.href= '${pageContext.request.contextPath}/cargarFormRegistrarReserva';
	}
	
	function verDetalleReserva(idReserva, idEstadoReserva){
			
		$.ajax({
			url: '${pageContext.request.contextPath}/verDetalleReserva?idReserva='+idReserva+"&idEstadoReserva="+idEstadoReserva,
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				
				var rpta = response.dataJson;
				$("#idReservaDetalle").html(rpta.reserva.idReserva)
				$("#divNumReservaDetalle").html(rpta.reserva.numeroReserva);
				
				$("#divNumCotizaDetalle").html(rpta.reserva.numeroCotizacion);
				$("#divFechaCotizaDetalle").html(rpta.reserva.fechaCotizacion);
				$("#divClienteDetalle").html(rpta.reserva.cliente);
				$("#divPrecioDetalle").html(rpta.reserva.precioCotizacion);
								
				if(idEstadoReserva == 12) {
					$("#unBotonDetalle").hide();
					$("#dosBotonesDetalle").show();
				} else {
					$("#dosBotonesDetalle").hide();
					$("#unBotonDetalle").show();
				}
				
				$("#divVerDetalleReserva").modal({
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
	
	
	
	function cerraVerDetalle(){
		$('#divVerDetalleInseminacion').modal("hide");
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
		$('#divVerDetalleReserva').modal("hide");
	}
	
	function enviarReservaCliente(){
			
		var idReserva = $("#idReservaDetalle").html();
		var numReserva = $("#divNumReservaDetalle").html();
		
			
		$.ajax({
			url: '${pageContext.request.contextPath}/enviarReservaCliente?idReserva='+idReserva+"&numReserva="+numReserva,
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				
				var rpta = response.dataJson;
				
				if (rpta.flagValidaCorreo == 1) {
					
					$("#divVerDetalleReserva").modal("hide");
					
					$("#mdlValidaCorreoCliente").modal({
						backdrop: 'static',
						keyboard: false
					});
					
				} else {
					$("#divNumeroReserva").html(rpta.numReserva);
					
					$("#divVerDetalleReserva").modal("hide");
					
					var mensaje = "Se actualizó la reserva [" + rpta.numReserva + "] al estado Emitido.";
					$("#msjEnviaReserva").html(mensaje);
					
					
					$("#mdlEnviaReservaCliente").modal({
						backdrop: 'static',
						keyboard: false
					});
				}
					
				
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
	}
	
	function cerrarPopupReserva(){
		location.href= '${pageContext.request.contextPath}/listarReserva';
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
					<h3 class="panel-title"><center><strong>LISTADO DE RESERVAS</strong></center></h3>
				</div>
				<div class="panel-body">
					
					<div class="col-sm-12" id="divSecBusquedaReserva">
						<div class="panel panel-primary">
							<div class="panel-heading">	<strong>Consulta de Reservas</strong></div>
							
							<div class="panel-body">
												
								<div class="row">
									<div class="col-sm-12">
										<form id="formConsuReserva" class="form-horizontal" method="POST">

											<div class="form-group">
												<label class="col-sm-3 control-label alignDerecha">Nro. Reserva:</label>
												<div class="col-sm-3">
													<input id="txtNumero" name="numeroReserva" type="text" maxlength="30" class="form-control">
												</div>
												
												<label class="col-sm-3 control-label alignDerecha">Nro. Cotizaci&oacute;n:</label>
												<div class="col-sm-3">
													<input id="txtNumero" name="numeroCotizacion" type="text" maxlength="30" class="form-control">
												</div>
											</div>
												
											<div class="form-group">
												<label class="col-sm-3 control-label alignDerecha">Cliente:</label>
												<div class="col-sm-3">
													<select name="tipoBusqueda" id="selTipoBusqueda" class="form-control tamanoMaximo"> 
														<option value="">--- Seleccione ---</option>
														<option value="1">DNI</option>
														<option value="2">Nombre</option>
													</select>
												</div>
												
												<div class="col-sm-6">
													<input name="cliente" id="txtNombreCliente"  type="text" maxlength="30" class="form-control" />
												</div>
												
											</div>
											
											<div class="form-group">
												<label class="col-sm-2 control-label alignDerecha">Fecha Inicio</label>
												<div class="col-sm-2">
													<div class="input-group date tamanoMaximo" id="divFechaCotizacionBusq">
														<input id="txtFechaCotizacionBusq" name="fechaInicio" type="text" maxlength="30" readonly="yes" class="form-control txtFecha" />
														<span class="input-group-addon datepickerbutton">
															<span class="glyphicon glyphicon-calendar"></span>
														</span>
														<span class="input-group-addon" id="eliminarFecha">
															<span class="glyphicon glyphicon-remove"></span>
														</span>
													</div>
												</div>
												
												<label class="col-sm-2 control-label alignDerecha">Fecha Fin</label>
												<div class="col-sm-2">
													<div class="input-group date tamanoMaximo" id="divFechaFinBusq">
														<input id="txtFechaFinBusq" name="fechaFin" type="text" maxlength="30" readonly="yes" class="form-control txtFecha" />
														<span class="input-group-addon datepickerbutton">
															<span class="glyphicon glyphicon-calendar"></span>
														</span>
														<span class="input-group-addon" id="eliminarFechaFin">
															<span class="glyphicon glyphicon-remove"></span>
														</span>
													</div>
												</div>
												
												<label class="col-sm-2 control-label alignDerecha">Estado:</label>
												<div class="col-sm-2">
													<select name="idEstadoReserva" id="selcodigoEstadoCotizacion" class="form-control tamanoMaximo"> 
														<option value="">--- Seleccione ---</option>
														<option value="12">Confirmado</option>
														<option value="13">Emitido</option> 
													</select>
												</div>
												
												
												
											</div>
											
											<div class="form-group">
												<div class="col-sm-10" style="text-align:center">
													<button id="btnBuscarReserva" class="btn btn-primary" title="Buscar">Buscar</button>
													<button id="btnLimpiarReserva" class="btn btn-primary" title="Limpiar">Limpiar</button>
												</div>
												
												<div class="col-sm-2" align="right">
													<input type="button" class="btn btn-primary" value="Nuevo" id="btnRegistrarReserva" onclick="registrarReserva()"></input>
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
									<div class="col-sm-12" id="divTblListaReserva">
										
										<table id ="tblListaReserva" class="table table-bordered responsive" style="width:100%">
											<thead>
												<tr>
													<th width="5%" class="text-center">N&deg;</td>
													<th width="15%" class="text-center">N&deg; Reserva</td>
													<th width="15%" class="text-center">N&deg; Cotizaci&oacute;n</td>
													<th width="20%" class="text-center">Fecha Reserva</td>
													<th width="30%" class="text-center">Cliente</td>
													<th width="20%" class="text-center">Estado</td>
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
			<div class="panel-heading"> <strong>Cliente no tiene correo electrónico:</strong></div>
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

<div id="divVerDetalleReserva" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog">
		<div class="panel panel-primary">
			<%@ include file="verDetalleReserva.jsp" %>
		</div>
	</div>
</div>

</body>

</html>