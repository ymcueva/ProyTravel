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

		inicia();
		listaDestinos = ${listaDestinos};

		construirTablaListaDestinos(listaDestinos);

		$("#btnProcesarPago").on('click', function(e) {
			e.preventDefault();
			procesarPago();
		})

		$("#btnRechazarCotizacion").on('click', function(e) {
			e.preventDefault();
			rechazarCotizacion();
		})

	});

	function inicia() {
		$('#divFechaCotizacionBusq').datetimepicker({
            format: 'MM/YYYY',        
            viewMode: "months",
            pickTime: false,
            useCurrent: true
		});

		$("#eliminarFecha").on("click", function(e) {
			e.preventDefault();
			$("#txtFechaCotizacionBusq").val("");
		})
	}

	function validarNumeroLetra(e) {

	}

	/* function validarNumeroLetra(e){
		var key = window.Event ? e.which : e.keyCode;
		return ( (key==32 ) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) );
	} */

	function procesarPago() {

		var grabarFormParams = {
			'procesarPagoBean' : formToObject('#formProcesarPago')
		};
		//alert("params: " + JSON.stringify(grabarFormParams));

		$.ajax({
			url : '${pageContext.request.contextPath}/procesarPagoCotizacion',
			data : JSON.stringify(grabarFormParams),
			cache : false,
			async : true,
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			dataType : 'json',
			success : function(response) {
				var rpta = response.dataJson;
				var rptaRes = rpta.resultadoProcesarPago;
				var result = rpta.resultado;
				console.log("respuesta procesar pago: " + rptaRes);
				console.log("result: " + result);
				if(result == 'ok'){
					window.location.replace(rpta.url);
				}else{
					$("#resultadoProcesarPago").html(rptaRes);	
				}
				
			},
			error : function(data, textStatus, errorThrown) {
			}
		});
	}

	function rechazarCotizacion() {

		var grabarFormParams = {
			'rechazarCotizacionBean' : formToObject('#formRechazarCotizacion')
		};
		//alert("params: " + JSON.stringify(grabarFormParams));

		$.ajax({
			url : '${pageContext.request.contextPath}/rechazarCotizacion',
			data : JSON.stringify(grabarFormParams),
			cache : false,
			async : true,
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			dataType : 'json',
			success : function(response) {
				var rpta = response.dataJson; // OK
				var rptaRes = rpta.resultadoRechazarCotizacion;
				var result = rpta.resultado;
				console.log("rpta resultado: " + rptaRes);
				if(result == 'ok'){
					window.location.replace(rpta.url);
				}else{
					$("#resultadoRechazarCotizacion").html(rptaRes);
				}
			},
			error : function(data, textStatus, errorThrown) {
			}
		});
	}

	function construirTablaListaDestinos(dataGrilla) {
		//alert(dataGrilla);
		var table = $('#tblListaDestinos')
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
							bScrollCollapse : false,
							pagingType : "full_numbers",
							iDisplayLength : 10,
							responsive : true,
							bLengthChange : false,
							info : false,

							fnDrawCallback : function(oSettings) {
								if (oSettings.fnRecordsTotal() == 0) {
									$('#tblListaDestinos_paginate').addClass(
											'hiddenDiv');
								} else {
									$('#tblListaDestinos_paginate')
											.removeClass('hiddenDiv');
								}
							},

							fnRowCallback : function(nRow, aData, iDisplayIndex) {
								$(nRow).attr('id', aData[5]);
								$(nRow).attr('align', 'center');
								$(nRow).attr('rowClasses', 'tableOddRow');
								return nRow;
							},
							language : {
								url : "/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/plug-ins/1.10.7/i18n/Spanish.json"
							},
							columns : [ {
								data : "descripcionCiudad"
							}, {
								data : "nomTour"
							}, {
								data : "nomHotel"
							}, {
								data : "nomAerolinea"
							}, {
								data : "nombreProveedor"
							} ]
						});
	}

	function salir() {
		location.href = '${pageContext.request.contextPath}/principal';
	}

	function registrarCotizacion() {
		location.href = '${pageContext.request.contextPath}/cargarFormRegistrarCotizacion';
	}

	function verDetalleCotizacion(idCotizacion) {

		console.log("Detalle de la cotizacion..." + idCotizacion);

		$("#divInfoDetalleCotizacion").css("display", "none");
		$("#divBotonCotizacionBuscar").css("display", "none");
		$("#divBotonCotizacionEnviar").css("display", "none");

		$("#divCodigo").html("");
		$("#divCliente").html("");
		$("#tituloCotizacion").html("");

		$("#divFecha").html("");
		$("#divTipo").html("");
		$("#divEstado").html("");

		//$("#").val(response.dataJson.cotizacion.tipoAlojamiento);
		//$("#").val(response.dataJson.cotizacion.categoriaAlojamiento);
		//$("#").val(response.dataJson.cotizacion.habitaciones);

		$("#divDestinos").html("");
		$("#divMotivos").html("");
		$("#divServicios").html("");

		$("#inpIdTipoCotizacion").val("");
		$("#inpIdCotizacion").val("");
		$("#inpIdEstado").val("");
		$("#idParams").val("");

		$("#divContenedorServicios").css("display", "none");
		$("#divContenedorMotivos").css("display", "none");

		$
				.ajax({
					url : '${pageContext.request.contextPath}/verDetalleCotizacion?idCotizacion='
							+ idCotizacion,
					cache : false,
					async : true,
					type : 'GET',
					contentType : "application/json; charset=utf-8",
					dataType : 'json',
					success : function(response) {

						if (response.estado = "ok") {

							console.log(response.dataJson);
							console.log(response);

							$("#inpIdTipoCotizacion")
									.val(
											response.dataJson.cotizacion.idTipoCotizacion);
							$("#inpIdCotizacion").val(
									response.dataJson.cotizacion.idCotizacion);
							$("#inpIdEstado").val(
									response.dataJson.cotizacion.idEstado);

							$("#divCodigo")
									.html(
											response.dataJson.cotizacion.numeroCotizacion);
							$("#divCliente").html(
									response.dataJson.cotizacion.nombreCliente);
							$("#tituloCotizacion")
									.html(
											response.dataJson.cotizacion.tipoCotizacion);

							$("#divFecha")
									.html(
											response.dataJson.cotizacion.fechaCotizacion);

							var tipoCotizacion = "";
							if (response.dataJson.cotizacion.idTipoCotizacion == 1) {
								tipoCotizacion = " / "
										+ response.dataJson.cotizacion.tipoPrograma;
								$("#divContenedorServicios").css("display",
										"inline");
								$("#divContenedorMotivos").css("display",
										"inline");
							}

							$("#divTipo")
									.html(
											"<strong>"
													+ response.dataJson.cotizacion.tipoCotizacion
													+ tipoCotizacion
													+ "</strong>");
							$("#divEstado").html(
									response.dataJson.cotizacion.estado);

							//$("#").val(response.dataJson.cotizacion.tipoAlojamiento);
							//$("#").val(response.dataJson.cotizacion.categoriaAlojamiento);
							//$("#").val(response.dataJson.cotizacion.habitaciones);

							$("#divDestinos").html(
									response.dataJson.cotizacion.destinos);
							$("#divMotivos").html(
									response.dataJson.cotizacion.motivos);
							$("#divServicios").html(
									response.dataJson.cotizacion.servicios);

							if (response.dataJson.cotizacion.idTipoCotizacion == 1) { //Paquete Turistico 1 / //Ticket Aereo 2
								if (response.dataJson.cotizacion.idTipoCotizacion == 1) {
									if (response.dataJson.cotizacion.idEstado == 4) { //Estado Pendiente
										$("#divBotonCotizacionBuscar").css(
												"display", "inline");
									} else if (response.dataJson.cotizacion.idEstado == 6) { //Estado Asignado
										$("#divBotonCotizacionEnviar").css(
												"display", "inline");
									}
								}
								$("#idParams")
										.val(
												"presupuesto="
														+ response.dataJson.cotizacion.presupuestoMaximo
														+ "&idTipoAlojamiento="
														+ response.dataJson.cotizacion.idTipoAlojamiento
														+ "&idCategoriaAlojamiento="
														+ response.dataJson.cotizacion.idCategoriaAlojamiento
														+ "&idTipoPrograma="
														+ response.dataJson.cotizacion.idTipoPrograma
														+ "&numeroCotizacion="
														+ response.dataJson.cotizacion.numeroCotizacion);
							}

							$("#divVerDetalleInseminacion").modal({
								backdrop : 'static',
								keyboard : false
							});

						}

					},
					error : function(data, textStatus, errorThrown) {

					},
				});

		/*
		$.ajax({
			url: '${pageContext.request.contextPath}/verDetalleCotizacion?numCotizacion='+numeroCotizacion,
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				
				if (response.estado = "ok") {
					var tipoInseminacion = (response.dataJson.inseminacionBean.tipoInseminacion=1?"Inseminaci&oacute;n":"Natural");
					
					$("#tituloInseminacion").html(response.dataJson.titulo);
					$("#divCodigoInseminacion").html(response.dataJson.inseminacionBean.codigoVaca);
					$("#divFechaCotizacionDeta").html(response.dataJson.inseminacionBean.fechaInseminacion);
					$("#divTipoInseminacion").html(tipoInseminacion);
					$("#divCodigoVaca").html(response.dataJson.inseminacionBean.codigoVaca);
					$("#divNombreVaca").html(response.dataJson.inseminacionBean.nombreVaca);
					$("#divCodigoToro").html(response.dataJson.inseminacionBean.codigoToro);
					$("#divDiasInseminado").html(response.dataJson.inseminacionBean.diasInseminado);
					$("#divObservacion").html(response.dataJson.inseminacionBean.observacion);
					$("#divUsuario").html("ocalderon");
					
					$("#divVerDetalleInseminacion").modal({
						backdrop: 'static',
						keyboard: false
					});
				}
			},
			error: function(data, textStatus, errorThrown) {
			}
		}); */
	}

	function limpiarFormularioInseminacion() {
		$('#formCotizacion').bootstrapValidator('resetForm', true);
		$("#selToro").val("");
		$("#txtFechaInseminacion").val("");
		$("#txtObservacion").val("");
	}

	function cerraInseminacion() {
		$('#divRegistroInseminacion').modal("hide");
	}

	function cerraVerDetalle() {
		$('#divVerDetalleInseminacion').modal("hide");
	}

	function formToObject(formID) {
		var formularioObject = {};
		var formularioArray = $(formID).serializeArray();
		$.each(formularioArray, function(i, v) {
			formularioObject[v.name] = v.value;
		});
		return formularioObject;
	}

	function buscarPaquete() {
		var idTipoCotizacion = $("#inpIdTipoCotizacion").val();
		var idCotizacion = $("#inpIdCotizacion").val();
		var idparams = $("#idParams").val();

		if (idTipoCotizacion == 1) {

			console.log("**************************************");
			console.log("paquete");

			console.log("idTipoCotizacion: " + idTipoCotizacion);
			console.log("idCotizacion: " + idCotizacion);
			console.log("idparams: " + idparams);

			$("#divMsgResultado").html("");

			$
					.ajax({
						url : '${pageContext.request.contextPath}/buscarPaquete?idCotizacion='
								+ idCotizacion + "&" + idparams,
						cache : false,
						async : true,
						type : 'GET',
						contentType : "application/json; charset=utf-8",
						dataType : 'json',
						success : function(response) {

							var mensajeHTML = "";

							console
									.log("************************************************************");
							console.log("response");
							console.log(response);
							console.log(response.dataJson.listaPaquetes);
							console.log(response.dataJson.cantidadPaquetes);
							console.log(response.dataJson.destinos);

							if (response.estado = "ok") {

								console.log("cantidad paquetes");
								console
										.log(parseInt(response.dataJson.cantidadPaquetes));

								if (parseInt(response.dataJson.cantidadPaquetes) > 0) {
									var nomPaquete = "";
									var idPaquete = 0;
									var precio = 0;

									if (response.dataJson.destinos[0]) {
										nomPaquete = response.dataJson.destinos[0].nomPaquete;
										idPaquete = response.dataJson.destinos[0].idPaquete;
										precio = response.dataJson.destinos[0].imPrecio;
										console.log("Paquete");
										console.log(nomPaquete);
										console.log(idPaquete);
										console.log(precio);
									}

									console.log("destinos");
									console
											.log(response.dataJson.destinos[0].destinos);
									mensajeHTML += "<center><strong>Paquete: "
											+ nomPaquete + " (USD. " + precio
											+ ")</strong></center>";

									$("#inpIdPaquete").val(idPaquete);
									console.log("inpIdPaquete");
									console.log($("#inpIdPaquete").val());

									$
											.each(
													response.dataJson.destinos,
													function(i, row) {
														console
																.log("destinos each");
														console
																.log(row.destinos);
														console.log(row.hotel);
														console.log(row.tour);
														console
																.log(row.aerolinea);

														mensajeHTML += "<strong>"
																+ (i + 1)
																+ " "
																+ row.destinos
																+ "</strong>: <i>";

														if (row.hotel) {
															mensajeHTML += row.hotel;
														}
														if (row.tour) {
															mensajeHTML += row.tour;
														}
														if (row.aerolinea) {
															mensajeHTML += row.aerolinea;
														}
														mensajeHTML += "</i><br />";

													});
								} else {
									mensajeHTML = "<strong>No se encontraron Paquetes disponibles.</strong>";
									$("#btnGuardarPaquete").css("display",
											"none");
								}

								$("#divInfoDetalleCotizacion").css("display",
										"block");
								$("#divMsgResultado").html(mensajeHTML);

							}
							;

						},
						error : function(data, textStatus, errorThrown) {

						},
					});

		} else {
			console.log("ticket");
		}
	}

	function guardarPaquete() {

		console
				.log("*****************************************************************");
		console.log("guardar paquete");

		var idPaquete = $("#inpIdPaquete").val();
		var idCotizacion = $("#inpIdCotizacion").val();

		console.log("idPaquete");
		console.log(idPaquete);

		console.log("idCotizacion");
		console.log(idCotizacion);

		$("#divMsgResultadoRegistro").html("");
		$("#divBotonCotizacionEnviar").css("display", "none");
		if (idPaquete != '') {
			$
					.ajax({
						url : '${pageContext.request.contextPath}/grabarPaquete?idCotizacion='
								+ idCotizacion + "&idPaquete=" + idPaquete,
						cache : false,
						async : true,
						type : 'GET',
						contentType : "application/json; charset=utf-8",
						dataType : 'json',
						success : function(response) {

							console
									.log("************************************************************");
							console.log(response);

							if (response.estado = "ok") {
								$("#btnBuscar").css("display", "none");
								$("#btnGuardarPaquete").css("display", "none");
								$("#divBotonCotizacionEnviar").css("display",
										"block");
								$("#divMsgResultadoRegistro")
										.html(
												"<strong>Su cotizacion fue actualizada</strong>");
							}

						},
						error : function(data, textStatus, errorThrown) {

						},
					});
		}
		;
	}

	function enviarCotizacion() {
		var idCotizacion = $("#inpIdCotizacion").val();
		if (idCotizacion != '') {
			$
					.ajax({
						url : '${pageContext.request.contextPath}/enviarPaquete?idCotizacion='
								+ idCotizacion,
						cache : false,
						async : true,
						type : 'GET',
						contentType : "application/json; charset=utf-8",
						dataType : 'json',
						success : function(response) {
							var mensajeHTML = "";
							console
									.log("************************************************************");
							if (response.estado = "ok") {
								$("#btnEnviarCotizacion")
										.css("display", "none");
								$("#divMsgResultadoEnviar")
										.html(
												"<strong>Su cotizacion fue enviada</strong>");
							}
						},
						error : function(data, textStatus, errorThrown) {

						},
					});
		}
		;
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
														name="codigoSeguridad" type="text" maxlength="4"
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


	<div id="mdlConfirmaEliminacion" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="panel panel-info">
				<div class="panel-heading">
					<strong>Confirmaci&oacute;n Eliminaci&oacute;n</strong>
				</div>
				<div class="panel-body">
					<div class="modal-body">
						<p class="text-center">&iquest;Desea Eliminar?</p>
					</div>
					<div class="modal-footer">
						<div class="col-sm-12" align="center">
							<input type="button" class="btn btn-primary"
								intermediateChanges="false" data-dismiss="" value="Si"
								onclick="eliminarInseminacion();" id="btnEliminaRegistro"></input>
							<button type="button" id="btnEliminaNo" class="btn btn-primary"
								data-dismiss="modal">No</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="divRegistroInseminacion" class="modal fade" role="dialog"
		style="text-center: center">
		<div class="modal-dialog">
			<div class="panel panel-primary"></div>
		</div>
	</div>

	<div id="divVerDetalleInseminacion" class="modal fade" role="dialog"
		style="text-center: center">
		<div class="modal-dialog">
			<div class="panel panel-primary">
			</div>
		</div>
	</div>

	<input type="hidden" id="inpIdTipoCotizacion" name="idTipoCotizacion" />
	<input type="hidden" id="inpIdCotizacion" name="idCotizacion" />
	<input type="hidden" id="inpIdEstado" name="idEstado" />
	<input type="hidden" id="inpIdParams" name="idParams" />
	<input type="hidden" id="inpIdPaquete" name="idPaquete" />

</body>

</html>