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
	$(document).ready(function() {

		inicia();

	});
	function inicia() {
		$('#divFechaBusq').datetimepicker({
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
		});
	}

	function buscarOrdenesPlanificacion() {
		var params = "";
		var numCotiza = $("#txtcodcotiza").val();

		params = "?nucotiza=" + numCotiza;
		alert("params: " + params);
		$.ajax({
			url : '${pageContext.request.contextPath}/listarOrdenPlanificacion'
					+ params,
			//data: JSON.stringify(grabarFormParams),	           	
			cache : false,
			async : true,
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			dataType : 'json',
			success : function(response) {

				var rpta = response.dataJson;

				alert(response.estado)
				//alert(rpta.descripcion +rpta.observacion)
				$("#txtDescripcion").val(rpta.descripcion);
				$("#txtObservacion").val(rpta.observacion);
				return false;

			},
			error : function(data, textStatus, errorThrown) {
				alert(data);
				alert(textStatus);
				alert(errorThrown);
			}
		});
	}

	function formToObject(formID) {
		var formularioObject = {};
		var formularioArray = $(formID).serializeArray();
		$.each(formularioArray, function(i, v) {
			formularioObject[v.name] = v.value;
		});
		return formularioObject;
	}

	function aceptar() {
		location.href = '${pageContext.request.contextPath}/formRegistrarOrdenPlanificacion';
	}

	function registrarOrdPlanificacion() {
		var grabarFormParams = {
			'OrdenPlanificacionBean' : formToObject('#frmregOrdenPlanificacion')
		};

		var idOrden = $("#txtcodcotiza").val();
		//var nomPaquete = $("#txtpaqueteTuristico").val();

		alert(idOrden);
		//alert(nomPaquete);

		//var params = "?idOrden="+idOrden+"&nombre="+nomPaquete;

		var ruta = "";
		if ($("#txtflagEdicion").val() == 1) {
			ruta = '${pageContext.request.contextPath}/editarInseminacion';
		} else {
			ruta = '${pageContext.request.contextPath}/grabarTransaccionOrdPlanificacion';
		}

		alert(ruta);

		$
				.ajax({
					url : ruta,
					data : JSON.stringify(grabarFormParams),
					cache : false,
					async : true,
					type : 'POST',
					contentType : "application/json; charset=utf-8",
					dataType : 'json',
					success : function(response) {

						if (response.estado = "ok") {
							if ($("#txtflagEdicion").val() == 1) {
								$("#mensajeTransaccion")
										.html(
												"Se modific&oacute; satisfactoriamente la inseminaci&oacute;n de la vaca");
							}
							$("#divRegistroGrabadoCorrectamente").modal({
								backdrop : 'static',
								keyboard : false
							});
							return false;
						}

					},
					error : function(data, textStatus, errorThrown) {
					}
				});

	}
	function cargarConfirmacionRegistro(e, tipo) {
		e.preventDefault();

		if (tipo == 1) {

			//alert("paquee");
			$('#mdlConfirmaRegistro').modal({
				backdrop : 'static',
				keyboard : false
			});

		}

	}

	//Function Limpiar Formulario 
	function limpiarFormularioOrdPlanificacion() {
		$('#frmregOrdenPlanificacion').bootstrapValidator('resetForm', true);
		$("#txtPresupuestoMinimo").val("");
		$("#txtPresupuestoMaximo").val("");
		$("#txtDescripcion").val("");
	}

	$('#divFechaPartida').datetimepicker({
		language : 'es',
		autoClose : true,
		minDate : '01/01/2000',

		format : 'DD/MM/YYYY',
		pickTime : false,
		useCurrent : false
	});

	$('#divFechaPartidaTicket').datetimepicker({
		language : 'es',
		autoClose : true,
		minDate : '01/01/2000',

		format : 'DD/MM/YYYY',
		pickTime : false,
		useCurrent : false
	});

	$('#divFechaRetorno').datetimepicker({
		language : 'es',
		autoClose : true,
		minDate : '01/01/2000',

		format : 'DD/MM/YYYY',
		pickTime : false,
		useCurrent : false
	});

	function construirTablaCotizacion(dataGrilla) {

		// construyendo tabla destino
		var table = $('#tblDestinos')
				.dataTable(
						{
							data : dataGrilla,
							bDestroy : true,
							ordering : false,
							searching : false,
							paging : true,
							bScrollAutoCss : true,
							bStateSave : false,
							bAutoWidth : false,
							info : false,
							bScrollCollapse : false,
							pagingType : "full_numbers",
							pageLength : 5,
							responsive : true,
							bLengthChange : false,

							fnDrawCallback : function(oSettings) {
								if (oSettings.fnRecordsTotal() == 0) {
									$('#tblDestino_paginate').addClass(
											'hiddenDiv');
								} else {
									$('#tblDestino_paginate').removeClass(
											'hiddenDiv');
								}
							},

							fnRowCallback : function(nRow, aData, iDisplayIndex) {
								alert(aData[0]);
								$(nRow).attr('id', aData[0]);
								$(nRow).attr('align', 'center');
								$(nRow).attr('rowClasses', 'tableOddRow');
								return nRow;
							},
							language : {
								url : "/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/plug-ins/1.10.7/i18n/Spanish.json"
							},
							columns : [ {
								"class" : "botones"
							}, {
								"class" : ""
							}, {
								"class" : ""
							}, {
								"class" : ""
							}, {
								"class" : "hidden"
							} ]
						});

	}
</script>


<style>
fieldset {
	border: 1px solid #DDD;
	padding: 0 1.4em 1.4em 1.4em;
	width: auto;
}

legend {
	font-size: 1.2em;
	font-weight: bold;
	border-bottom: 0px;
	width: auto;
}
</style>

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
						<h3 class="panel-title">Orden de Planificacion - Registrar
							Orden</h3>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="panel-body">
								<div class="row">
									<div class="form-group">
										<label class="col-sm-2 control-label alignDerecha">Fecha
											Orden:</label>
										<div class="col-sm-3">
											<div class="input-group date tamanoMaximo"
												id="divFechaCotizacionBusq">
												<input id="txtFechaBusq" name="fechaIni" type="text"
													maxlength="30" readonly class="form-control txtFecha" /> <span
													class="input-group-addon datepickerbutton"> <span
													class="glyphicon glyphicon-calendar"></span>
												</span> <span class="input-group-addon" id="eliminarFecha">
													<span class="glyphicon glyphicon-remove"></span>
												</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="panel-body">
								<div class="row">
									<div class="form-group">
										<label class="col-sm-2 control-label alignDerecha">Descripcion:</label>
										<div class="col-sm-4">
											<input type="text" class="form-control" name="txtdescripcion"
												id="txtdescripcion" />
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<form id="frmregOrdenPlanificacion"
									name="frmregOrdenPlanificacion" role="form"
									class="form-horizontal" method="post">

									<div class="form-group">
										<input type="hidden" name="flagEdicion" id="txtflagEdicion" />
										<div class="col-sm-8" id="divCodigoAnimal"></div>
									</div>



									<div class="col-sm-12" id="divSecBusqOrdenPlanificacion">
										<div class="panel panel-primary">
											<div class="panel-heading">
												<strong>Datos de La Cotizacion</strong>
											</div>

											<div class="panel-body">
												<div class="row">
													<div class="col-sm-12">
														<div class="form-group">
															<label class="col-sm-2 control-label alignDerecha">Nro
																de Cotizacion:</label>
															<div class="col-sm-3">
																<input type="text" class="form-control tamanoMaximo"
																	name="codigoOrden" id="txtcodcotiza" />
															</div>

															<div class="col-sm-2">
																<!--	<button id="btnBuscarOrdenPlanificacion" class="btn btn-primary btn-block"  title="Buscar">Buscar</button> -->
																<button id="btnBuscarOrdenPlanificacion" type="button"
																	class="btn btn-primary centro"
																	onclick="buscarOrdenesPlanificacion()"
																	title="Buscar Orden">Buscar</button>
															</div>

															<label class="col-sm-2">Fecha Cotizacion:</label>
															<div class="col-sm-2">
																<input id="txtFechaOrden" name="fechaOrden" type="text"
																	maxlength="10" class="form-control" />
															</div>
														</div>
														<div class="form-group">
															<div class="col-sm-2"
																style="text-align: right; font-weight: bold">Cliente:</div>
															<div class="col-sm-9" id="divNombreAnimal">
																<input id="txtCliente" name="nombreCliente" type="text"
																	maxlength="80" class="form-control" />
															</div>
														</div>
														<div class="form-group">
															<div class="col-sm-2"
																style="text-align: right; font-weight: bold">Tipo
																Programa:</div>
															<div class="col-sm-2">
																<select name="tipoPrograma" id="selTipoPrograma"
																	class="form-control tamanoMaximo">
																	<option value="">---Seleccione---</option>
																	<option value="1">Pendiente</option>
																	<option value="2">Finalizado</option>
																</select>
															</div>
															<label class=" control-label col-sm-2">Fecha
																Partida:</label>

															<div class="col-sm-2">
																<div class="input-group date tamanoMaximo"
																	id="divFechaPartida">
																	<input name="fechaPartida" id="txtFechaPartida"
																		type="text" class="form-control tamanoMaximo txtFecha"></input>
																	<span class="input-group-addon"> <span
																		class="glyphicon glyphicon-calendar"></span>
																	</span>
																</div>
															</div>

															<label class=" control-label col-sm-2">Fecha
																Retorno:</label>
															<div class="col-sm-2">
																<div class="input-group date tamanoMaximo"
																	id="divFechaRetorno">
																	<input name="fechaRetorno" id="txtFechaRetorno"
																		type="text" class="form-control tamanoMaximo txtFecha"></input>
																	<span class="input-group-addon"> <span
																		class="glyphicon glyphicon-calendar"></span>
																	</span>
																</div>
															</div>
														</div>
														<div class="form-group">
															<div class="col-sm-2"
																style="text-align: right; font-weight: bold">Origen</div>
															<div class="col-sm-2">
																<select name="destinoOrigen" id="selOrigen"
																	class="form-control tamanoMaximo">
																	<option value="">---Seleccione---</option>
																	<option value="1">Pendiente</option>
																	<option value="2">Finalizado</option>
																</select>
															</div>
															<div class="col-sm-2"
																style="text-align: right; font-weight: bold">Motivo
																de Viaje</div>
															<div class="col-sm-1">
																<label class="control-label col-sm-1"><input
																	type="checkbox" value="1">Cultural </label>
															</div>
															<div class="col-sm-1">
																<label class="control-label col-sm-1"><input
																	type="checkbox" value="2">Deportes </label>
															</div>
															<div class="col-sm-1">
																<label class="control-label col-sm-1"><input
																	type="checkbox" value="3">Relajacion </label>
															</div>
															<div class="col-sm-1">
																<label class="control-label col-sm-1"><input
																	type="checkbox" value="4">Playa </label>
															</div>
														</div>
														<div class="form-group">
															<div class="col-sm-2"
																style="text-align: right; font-weight: bold">Cantidad
																Adultos</div>
															<div class="col-sm-1">
																<input type="number" min="1" name="txtnadult"
																	class="form-control">
															</div>
															<div class="col-sm-2"
																style="text-align: right; font-weight: bold">Cantidad
																Niños</div>
															<div class="col-sm-1">
																<input type="number" min="0" name="txtnchild"
																	class="form-control">
															</div>
														</div>

														<div class="form-group">
															<div class="col-sm-2"
																style="text-align: right; font-weight: bold">Destinos:
															</div>
															<div class="container">
																<table class="table table-bordered responsive">
																	<tr>
																		<th>Item</th>
																		<th>Destino</th>
																		<th>Cantidad Dias</th>
																		<th></th>
																	</tr>
																	<tr>
																		<td></td>
																		<td></td>
																		<td></td>
																		<td></td>
																	</tr>
																</table>
															</div>

														</div>

														<div class="form-group">
															<div class="col-sm-2"
																style="text-align: right; font-weight: bold">Tipo
																Alojamiento</div>

															<div class="col-sm-2">
																<select name="destinoOrigen" id="selOrigen"
																	class="form-control tamanoMaximo">
																	<option value="">---Seleccione---</option>
																	<option value="1">Pendiente</option>
																	<option value="2">Finalizado</option>
																</select>
															</div>
															<div class="col-sm-2"
																style="text-align: right; font-weight: bold">Categoria
																Alojamiento</div>
															<div class="col-sm-2">
																<select name="destinoOrigen" id="selOrigen"
																	class="form-control tamanoMaximo">
																	<option value="">---Seleccione---</option>
																	<option value="1">Pendiente</option>
																	<option value="2">Finalizado</option>
																</select>
															</div>
														</div>
														<div class="col-sm-12" id="divServiviosTuristicos">
															<div class="panel panel-primary">
																<div class="panel-heading">
																	<strong>Servicios Adicionales</strong>
																</div>
																<div class="panel-body">
																	<div class="row">
																		<div class="col-sm-12">
																			<div id="divSubServiciosTuristicos">
																				<div class="col-sm-12">
																					<div class="form-group">
																						<label
																							class=" control-label col-sm-2 col-md-offset-2">Seguro
																							Medico</label>
																						<div class="col-sm-1">
																							<input name="chkseguro" id="txtFechaRetorno"
																								type="checkbox" />
																						</div>
																						<label
																							class=" control-label col-sm-2 col-md-offset-2">Ticket
																							Aereo</label>
																						<div class="col-sm-1">
																							<input name="chkticket" id="txtFechaRetorno"
																								type="checkbox" />
																						</div>
																						<label
																							class=" control-label col-sm-2 col-md-offset-2">Tour</label>
																						<div class="col-sm-1">
																							<input name="chktour" id="txtFechaRetorno"
																								type="checkbox" />
																						</div>
																						<div class="form-group">
																							<label
																								class=" control-label col-sm-2 col-md-offset-2">Transporte
																								Local</label>
																							<div class="col-sm-1">
																								<input name="chktransporte" id="txtFechaRetorno"
																									type="checkbox" />
																							</div>
																							<label
																								class=" control-label col-sm-2 col-md-offset-2">Restaurante</label>
																							<div class="col-sm-1">
																								<input name="chkrestaurante"
																									id="txtFechaRetorno" type="checkbox" />
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
														<div class="form-group">
															<div class="col-sm-2"
																style="text-align: right; font-weight: bold">Presupuesto
																Minimo</div>
															<div class="col-sm-2">
																<input type="number" class="form-control"
																	name="txtpsmin">
															</div>
															<div class="col-sm-2"
																style="text-align: right; font-weight: bold">Presupuesto
																Maximo</div>
															<div class="col-sm-2">
																<input type="number" class="form-control"
																	name="txtpsmax">
															</div>
														</div>
														<div class="form-group">
															<div class="col-sm-2"
																style="text-align: right; font-weight: bold">Observaciones:</div>
															<div class="col-sm-2">
																<textarea name="txaobs" class="span6" rows="4"></textarea>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>


									<div class="form-group">
										<div class="col-sm-2"
											style="text-align: right; font-weight: bold">Asignar
											Ejecutivo de Ventas:</div>
										<div class="col-sm-2" id="divNombreAnimal">
											<select name="tipoPrograma" id="selTipoPrograma"
												class="form-control tamanoMaximo">
												<option value="">---Seleccione---</option>
												<option value="1">Pendiente</option>
												<option value="2">Finalizado</option>
											</select>
										</div>
										<div class="col-sm-1"
											style="text-align: right; font-weight: bold">Autorizar
											Reservas Historicas:</div>
										<div class="col-sm-1">
											<input id="nombre" name="nombre" type="checkbox"
												class="checkbox">
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-3"
											style="text-align: right; font-weight: bold">Observacion:</div>
										<textarea name="taobs" class="span6" rows="" cols="">
										</textarea>
									</div>

									<div class="row">&nbsp;</div>

									<!-- Botones de formulario -->

									<div class="container-fluid">
										<div class="row">
											<div class="col-sm-12" style="text-align: center">
												<div class="form-group">
													<div class="col-sm-3">
														<button id="btnRegistrar" class="btn btn-primary"
															onclick="cargarConfirmacionRegistro(event,1)"
															title="Continuar">Grabar</button>
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
			</div>
		</div>
	</div>


	<div id="divRegistroPaqTuristico" class="modal fade" role="dialog"
		style="text-center: center">
		<div class="modal-dialog">
			<div class="panel panel-primary"></div>
		</div>
	</div>

	<!-- DIALOGO PARA GRABAR SI O NO    -->
	<div id="mdlConfirmaRegistro" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="panel panel-info">
				<div class="panel-heading">
					<strong>Confirmaci&oacute;n Registro</strong>
				</div>
				<div class="panel-body">
					<div class="modal-body">
						<p class="text-center">&iquest;Desea Grabar?</p>
					</div>
					<div class="modal-footer">
						<div class="col-sm-12" align="center">
							<input type="button" class="btn btn-primary" data-dismiss=""
								value="Si" onclick="registrarOrdPlanificacion();"
								id="btnGrabaRegistro"></input>
							<button type="button" id="btnRegistroNo" class="btn btn-primary"
								data-dismiss="modal">No</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!--   MENSAJE GRABADO CORRECTAMENTE -->
	<div id="divRegistroGrabadoCorrectamente" class="modal fade"
		role="dialog">
		<div class="modal-dialog">
			<div class="panel panel-info">
				<div class="panel-heading">
					<strong>Registro Satisfactorio</strong>
				</div>
				<div class="panel-body">
					<div class="modal-body">
						<p class="text-center" id="mensajeTransaccion">Se registro
							satisfactoriamente la Cotizaci&oacute;n</p>
					</div>
					<div class="modal-footer">
						<div class="col-sm-12" align="center">
							<input type="button" id="btnRegistro" class="btn btn-primary"
								onclick="aceptar()" value="Aceptar" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- DiseÃ±o de ayuda de busqueda de ordenes  
	<div id="ModalBusqOrden" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Modal Header</h4>
				</div>
				<div class="modal-body">
					<p>Some text in the modal.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div>

		</div>
	</div>
	-->
</body>

</html>

