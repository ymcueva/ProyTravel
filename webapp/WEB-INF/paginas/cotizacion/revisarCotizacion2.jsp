<%@page import="pe.gob.sunat.framework.spring.util.conversion.SojoUtil"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="mapaDatos" scope="request" class="java.util.HashMap" />

<!DOCTYPE html>
<%
	
%>
<html lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">

<script src="/a/resources/js/jquery/1.11.2/jquery.min.js"></script>
<script src="/a/resources/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script
	src="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/media/js/jquery.dataTables.min.js"></script>
<script
	src="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/extensions/Responsive/js/dataTables.responsive.js"></script>
<script
	src="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/extensions/Scroller/js/dataTables.scroller.js"></script>

<!-- estilos -->
<link href="/a/resources/bootstrap/3.3.2/css/bootstrap.min.css"
	rel="stylesheet">

<link href="/a/resources/bootstrap/3.3.2/css/bootstrap-theme.min.css"
	rel="stylesheet" />
<link
	href="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/media/css/jquery.dataTables.css"
	rel="stylesheet" />
<link
	href="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/media/css/jquery.dataTables_themeroller.css"
	rel="stylesheet" />
<link
	href="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/extensions/Responsive/css/dataTables.responsive.css"
	rel="stylesheet" />
<link
	href="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/extensions/Scroller/css/dataTables.scroller.css"
	rel="stylesheet" />

<!-- datetimepicker -->
<script
	src="/a/resources/bootstrap/3.3.2/plugins/bootstrap-datetimepicker-3.1.3/js/moment-with-locales.js"></script>
<script
	src="/a/resources/bootstrap/3.3.2/plugins/bootstrap-datetimepicker-3.1.3/js/bootstrap-datetimepicker.min.js"></script>
<link
	href="/a/resources/bootstrap/3.3.2/plugins/bootstrap-datetimepicker-3.1.3/css/bootstrap-datetimepicker.min.css"
	rel="stylesheet">

<!-- bootstrap validator-->
<script
	src="/a/resources/js/bootstrapvalidator/js/bootstrapValidator.min.js"></script>

<style>
.alignDerecha {
	text-align: right;
}

.alignIzquierda {
	text-align: left;
}

.alignCentro {
	text-align: center;
}

.txtFecha {
	background-color: #FFF !important;
}
</style>

<script>
	var codigoInseminacionGeneral;
	var codigoAnimalGeneral;
	$(document).ready(function() {
		$.ajaxSetup({
			scriptCharset : "utf-8",
			contentType : "application/json; charset=utf-8"
		});
		jQuery.support.cors = true;
		
		$('.modal').modal('show');


	});

	function inicia() {
		$('#divFechaCotizacionBusq').datetimepicker({
			language : 'es',
			autoClose : true,
			minDate : '01/01/2000',

			format : 'DD/MM/YYYY',
			pickTime : false,
			useCurrent : false
		});

		$("#eliminarFecha").on("click", function(e) {
			e.preventDefault();
			$("#txtFechaCotizacionBusq").val("");
		})
	}



	function limpiarFormularioInseminacion() {
		$('#formCotizacion').bootstrapValidator('resetForm', true);
		$("#selToro").val("");
		$("#txtFechaInseminacion").val("");
		$("#txtObservacion").val("");
	}

	function formToObject(formID) {
		var formularioObject = {};
		var formularioArray = $(formID).serializeArray();
		$.each(formularioArray, function(i, v) {
			formularioObject[v.name] = v.value;
		});
		return formularioObject;
	}



</script>

</head>

<body>


	<div id="container" class="container" style="width: 100%">
		<div class="col-sm-12" id="divConsForm"
			style="margin: 0px 0px 0px 0px;">
			<div class="col-sm-7">&nbsp;</div>
			<div class="col-sm-3">
				<span style="color: #337ab7">Usuario: <%=session.getAttribute("codigoUsuario")%></span>
			</div>
			<div class="col-sm-2">
				<a href="logout">Cerrar Sesion</a>
			</div>
		</div>
		<div class="row col-sm-offset-0 col-sm-12">
			<div class="principal">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">
							<center>
								<strong>REVISAR COTIZACIÓN</strong>
							</center>
						</h3>
					</div>
					<div class="panel-body">

						<!-- START - REVISAR COTIZACION -->
						<div class="col-sm-8" id="divInfoCotizacion"
							style="font-size: 12px;">
							<div class="panel panel-primary">
								<div class="panel-heading">
									<strong>Información de Cotización</strong>
								</div>

								<div class="panel-body">
									<div class="row">
										<form class="form-horizontal">
											<div class="form-group">
												<label class="control-label col-sm-2">Nro.
													Cotización</label>
												<div class="col-sm-4">
													<label class="form-control">${cotizacionBean.numeroCotizacion}</label>
												</div>
												<label class="control-label col-sm-2">Fecha
													Cotización</label>
												<div class="col-sm-3">
													<label class="form-control">${cotizacionBean.fechaCotizacion}</label>
												</div>
											</div>
											<div class="form-group">
												<label class="control-label col-sm-2">Cliente</label>
												<div class="col-sm-4">
													<label class="form-control">${cotizacionBean.nombreCliente}</label>
												</div>
												<label class="control-label col-sm-2">Tipo / Num.
													Documento</label>
												<div class="col-sm-3">
													<label class="form-control">${cotizacionBean.tipoDocumento}
														/ ${cotizacionBean.documentoCliente}</label>
												</div>
											</div>

											<div class="col-sm-12" id="divInfoPaqueteTur">
												<div class="panel panel-primary">
													<div class="panel-heading">
														<strong>Información de Paquete Turístico</strong>
													</div>
													<div class="panel-body">
														<div class="row">
															<div class="form-group">
																<label class="control-label col-sm-2"> Fecha
																	Inicio</label>
																<div class="col-sm-5">
																	<label class="form-control">${cotizacionBean.paqueteTuristico.feInicio}
																	</label>
																</div>
																<label class="control-label col-sm-2">Fecha Fin</label>
																<div class="col-sm-2">
																	<label class="form-control">${cotizacionBean.paqueteTuristico.feFin}</label>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-sm-2">Nombre
																	Paquete</label>
																<div class="col-sm-5">
																	<label class="form-control">${cotizacionBean.paqueteTuristico.nombre}</label>
																</div>
																<label class="control-label col-sm-2">Cantidad
																	Pasajeros</label>
																<div class="col-sm-2">
																	<label class="form-control">${cotizacionBean.paqueteTuristico.cantidadPasajeros}</label>
																</div>
															</div>
															<div class="form-group">
																<label class="control-label col-sm-2">Precio
																	Total</label>
																<div class="col-sm-2">
																	<label class="form-control">${cotizacionBean.precioTotal}</label>
																</div>
															</div>
															<div class="form-group">
																<div class="col-sm-12" id="divDestinos">
																	<div class="panel">
																		<div class="panel-heading">
																			<strong>Lista de Destinos:</strong>
																		</div>
																		<div class="panel-body">
																			<div id="dvSubDestinos">
																				<div class="col-sm-12" id="divTblListaDestinos">
																					<table id="tblListaDestinos"
																						class="table table-bordered responsive"
																						style="width: 100%">
																						<thead>
																							<tr>
																								<th width="20%" class="text-center">Descripción
																								</th>
																								<th width="20%" class="text-center">Tour</th>
																								<th width="10%" class="text-center">Hotel</th>
																								<th width="10%" class="text-center">Aerolinea
																								</th>
																								<th width="10%" class="text-center">Proveedor
																								</th>
																							</tr>
																						</thead>
																						<!-- <tbody>
																							<tr role="row" class="odd" align="center"
																								rowclasses="tableOddRow">
																								<td>Alguna desc 1</td>
																								<td>20-05-2017</td>
																								<td>Proveedor 1</td>
																								<td>item1 item2 item3</td>
																							</tr>
																							<tr role="row" class="odd" align="center"
																								rowclasses="tableOddRow">
																								<td>Alguna desc 2</td>
																								<td>20-05-2017</td>
																								<td>Proveedor 2</td>
																								<td>item1 / item2 / item3</td>
																							</tr>
																						</tbody> -->
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
										</form>
									</div>
								</div>
							</div>
						</div>

						<div class="col-sm-4" id="divProcesarPago"
							style="font-size: 12px;">
							<div class="panel panel-primary">
								<div class="panel-heading">
									<strong>Procesar Pago</strong>
								</div>
								<div class="panel-body">
									<div class="row">
										<form class="form-horizontal" id="formProcesarPago">
											<input type="hidden" name="idCliente"
												value="${cotizacionBean.idCliente}"> <input
												type="hidden" name="imPrecio"
												value="${cotizacionBean.precioTotal}"> <input
												type="hidden" name="idCotiza"
												value="${cotizacionBean.idCotizacion}"> <input
												type="hidden" name="idPaquete"
												value="${cotizacionBean.paqueteTuristico.idPaquete}">
											<div class="form-group">
												<label class="control-label col-sm-9"
													id="resultadoProcesarPago"></label>
											</div>
											<div class="form-group">
												<label class="control-label col-sm-3">Tipo Tarjeta</label>
												<div class="col-sm-9">
													<div class="cc-selector-2">
														<input type="radio" name="tipoTarjeta" value="1" /> <label>VISA</label>
														<input type="radio" name="tipoTarjeta" value="2" /> <label>MASTERCARD</label>
													</div>
												</div>
											</div>
											<div class="form-group">
												<label class="control-label col-sm-3">Número</label>
												<div class="col-sm-7">
													<input id="txtNumeroTarjCred"
														onkeypress="return validarNumeroLetra(event)"
														name="numeroTarjeta" type="text" maxlength="16"
														class="form-control">
												</div>
											</div>
											<div class="form-group">
												<label class="control-label col-sm-3">Fecha de
													Caducidad</label>
												<div class="col-sm-7">
													<div class="input-group date tamanoMaximo"
														id="divFechaCotizacionBusq">
														<input id="txtFechaCaducidad" name="fechaCaducidad"
															type="text" maxlength="16" readonly="yes"
															class="form-control txtFecha" /> <span
															class="input-group-addon datepickerbutton"> <span
															class="glyphicon glyphicon-calendar"></span>
														</span> <span class="input-group-addon" id="eliminarFecha">
															<span class="glyphicon glyphicon-remove"></span>
														</span>
													</div>
												</div>
											</div>
											<div class="form-group">
												<label class="control-label col-sm-3">Código de
													Seguridad</label>
												<div class="col-sm-3">
													<input id="txtCodSeg"
														onkeypress="return validarNumeroLetra(event)"
														name="codigoSeguridad" type="text" maxlength="30"
														class="form-control">
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-10" style="text-align: center">
													<button id="btnProcesarPago" class="btn btn-primary"
														title="Aceptar">ACEPTAR</button>
												</div>
											</div>
										</form>
									</div>

								</div>
							</div>
							<div class="panel panel-primary">
								<div class="panel-heading">
									<strong>Rechazar Cotización</strong>
								</div>
								<div class="panel-body">
									<div class="row">
										<form class="form-horizontal" id="formRechazarCotizacion">
											<input type="hidden" name="idCotiza"
												value="${cotizacionBean.idCotizacion}"> <input
												type="hidden" name="idPaquete"
												value="${cotizacionBean.paqueteTuristico.idPaquete}">
											<div class="form-group">
												<label class="control-label col-sm-9"
													id="resultadoRechazarCotizacion"></label>
											</div>
											<div class="form-group">
												<label class="control-label col-sm-3">Observación</label>
												<div class="col-sm-9">
													<textarea rows="4" cols="5" maxlength="50"
														name="observacion"
														onkeypress="return validarNumeroLetra(event)"
														id="txtObservacion" class="form-control"></textarea>
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-10" style="text-align: center">
													<button id="btnRechazarCotizacion" class="btn btn-primary"
														title="Aceptar">ACEPTAR</button>
												</div>
											</div>
										</form>
									</div>

								</div>
							</div>
						</div>
						<!-- END - REVISAR COTZACION -->
					</div>
				</div>
			</div>
		</div>
	</div>

<div class="modal hide fade" id="myModal">
  <div class="modal-header">
    <a class="close" data-dismiss="modal">X</a>
    <h3>Modal header</h3>
  </div>
  <div class="modal-body">
    <p>One fine body</p>
  </div>
  <div class="modal-footer">
    <a href="#" class="btn">Close</a>
    <a href="#" class="btn btn-primary">Save changes</a>
  </div>
</div>



	<input type="hidden" id="inpIdTipoCotizacion" name="idTipoCotizacion" />
	<input type="hidden" id="inpIdCotizacion" name="idCotizacion" />
	<input type="hidden" id="inpIdEstado" name="idEstado" />
	<input type="hidden" id="inpIdParams" name="idParams" />
	<input type="hidden" id="inpIdPaquete" name="idPaquete" />

</body>

</html>