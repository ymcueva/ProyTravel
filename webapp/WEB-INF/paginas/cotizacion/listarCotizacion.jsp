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
	var codigoInseminacionGeneral;
	var codigoAnimalGeneral;
	$(document).ready(function() {
		$.ajaxSetup({
			scriptCharset : "utf-8",
			contentType : "application/json; charset=utf-8"
		});
		jQuery.support.cors = true;

		inicia();
		listaCotizacion = ${listaCotizacion};

		construirTablaListaCotizacion(listaCotizacion);

		$("#btnBuscarCotizacion").on('click', function(e) {
			e.preventDefault();
			buscarCotizacion();
		})

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

	function validarNumeroLetra(e) {

	}

	/* function validarNumeroLetra(e){
		var key = window.Event ? e.which : e.keyCode;
		return ( (key==32 ) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) );
	} */

	function buscarCotizacion() {

		var grabarFormParams = {
			'cotizacionBean' : formToObject('#formConsuCotiza')
		};
		//alert("params: " + JSON.stringify(grabarFormParams));

		$
				.ajax({
					url : '${pageContext.request.contextPath}/listarCotizacion?btnBuscar=1',
					data : JSON.stringify(grabarFormParams),
					cache : false,
					async : true,
					type : 'POST',
					contentType : "application/json; charset=utf-8",
					dataType : 'json',
					success : function(response) {

						var rpta = response.dataJson;
						// actualizando lista
						var listaCotizacion = [];
						if (rpta.listaCotizacion != null) {
							listaCotizacion = rpta.listaCotizacion;
						}
						construirTablaListaCotizacion(listaCotizacion);
					},
					error : function(data, textStatus, errorThrown) {
					}
				});
	}

	function construirTablaListaCotizacion(dataGrilla) {
		//alert(dataGrilla);
		var table = $('#tblListaCotizacion')
				.dataTable(
						{
							data : dataGrilla,
							bDestroy : true,
							ordering : false,
							searching : false,
							paging : false,
							bScrollAutoCss : true,
							bStateSave : false,
							bAutoWidth : false,
							bScrollCollapse : false,
							pagingType : "full_numbers",
							iDisplayLength : 20,
							responsive : true,
							bLengthChange : false,
							info : false,

							fnDrawCallback : function(oSettings) {
								if (oSettings.fnRecordsTotal() == 0) {
									$('#tblListaCotizacion_paginate').addClass(
											'hiddenDiv');
								} else {
									$('#tblListaCotizacion_paginate')
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

							columnDefs : [ {
								targets : 5,
								render : function(data, type, row) {
									if (row != null
											&& typeof row != 'undefined') {
										var VerDetalle = "<span> <a href='javascript:;' onclick='verDetalleCotizacion(\""
												+ row.idCotizacion
												+ "\")' title='Ver Cotizaci&oacute;n' ><span class='glyphicon glyphicon-eye-open'></span></a> </span>";
										return VerDetalle;
									}
									return '';
								}
							} ],
							columns : [ {
								data : "numeroFila",
								"class" : "hidden"
							}, {
								data : "numeroCotizacion"
							}, {
								data : "fechaCotizacion"
							}, {
								data : "nombreCliente"
							}, {
								data : "nombreEstadoCotizacion"
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

							console
									.log("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ");

							console.log(response.dataJson);
							console.log(response);

							$("#inpIdTipoCotizacion")
									.val(
											response.dataJson.cotizacion.idTipoCotizacion);
							$("#inpIdCotizacion").val(
									response.dataJson.cotizacion.idCotizacion);
							$("#inpIdEstado").val(
									response.dataJson.cotizacion.idEstado);
							$("#inpIdCliente").val(
									response.dataJson.cotizacion.idCliente);

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

							console.log("motivos");
							var motivos = response.dataJson.cotizacion.motivos;
							console.log(motivos);

							if (motivos == "") {
								$("#divContenedorMotivos").css("display",
										"none");
							} else {
								$("#divMotivos").html(
										response.dataJson.cotizacion.motivos);
							}

							$("#divServicios").html(
									response.dataJson.cotizacion.servicios);

							console.log("Estado");
							console.log(response.dataJson.cotizacion.idEstado);

							if (response.dataJson.cotizacion.idEstado == 5) { //Estado Finalizado
								$("#divBotonCotizacionEnviar").css("display",
										"inline");
								console.log("Estado Finalizado");
							} else {
								if (response.dataJson.cotizacion.idTipoCotizacion == 1) { //Paquete Turistico 1 / //Ticket Aereo 2
									if (response.dataJson.cotizacion.idEstado == 4) { //Estado Pendiente
										$("#divBotonCotizacionBuscar").css(
												"display", "inline");
									} else if (response.dataJson.cotizacion.idEstado == 6) { //Estado Asignado
										$("#divBotonCotizacionEnviar").css(
												"display", "inline");
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
								;
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
		//$('#divVerDetalleInseminacion').modal("hide");
		location.reload(true);
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
									
									mensajeHTML = "<strong>No se encontro Paquete disponible.</strong><br />";
									
									console.log("Orden Num:");
									console.log(response.dataJson.nuOrden);
									
									mensajeHTML += "<strong>El sistema genero la Orden Nro. "+ response.dataJson.nuOrden +" para la creaci�n del Paquete Tur�stico.</strong>";
									
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
		var idCliente = $("#inpIdCliente").val();

		if (idCotizacion != '') {
			$
					.ajax({
						url : '${pageContext.request.contextPath}/enviarPaquete?idCotizacion='
								+ idCotizacion + '&idCliente=' + idCliente,
						cache : false,
						async : true,
						type : 'GET',
						contentType : "application/json; charset=utf-8",
						dataType : 'json',
						success : function(response) {
							console
									.log("************************************************************");
							if (response.estado = "ok") {
								$("#btnEnviarCotizacion")
										.css("display", "none");

								var mensaje = response.dataJson.mensaje;

								if (response.dataJson.envio == 1) {
									$("#divMsgResultadoEnviar")
											.html(
													"<strong>Su cotizacion fue enviada</strong>");
									$("#divBotonCotizacionAprobar").css(
											"display", "none");
								} else {
									$("#divMsgResultadoEnviar").html(
											"<strong style='color: red'>"
													+ mensaje + "</strong>");
								}

							}
						},
						error : function(data, textStatus, errorThrown) {

						},
					});
		}
		;

	}

	function aprobarCotizacion() {
		var idCotizacion = $("#inpIdCotizacion").val();

		//btnAprobarCotizacion 		aprobarCotizacion txtComentarioAprobacion
		//btnEnviarCotizacion enviarCotizacion 
		//divMsgResultadoEnviar
		//divBotonCotizacionAprobar

		if (idCotizacion != '') {
			var comentarioAprobacion = $("#txtComentarioAprobacion").val();

			console
					.log("************************************************************");
			console.log("idCotizacion");
			console.log(idCotizacion);
			console.log("Comentario de Aprobacion");
			console.log(comentarioAprobacion);

			$("#divMsgResultadoEnviar").html("");

			if (comentarioAprobacion != "") {
				$
						.ajax({
							url : '${pageContext.request.contextPath}/aprobarPaquete?idCotizacion='
									+ idCotizacion
									+ '&comentario='
									+ comentarioAprobacion,
							cache : false,
							async : true,
							type : 'GET',
							contentType : "application/json; charset=utf-8",
							dataType : 'json',
							success : function(response) {
								console
										.log("************************************************************");
								if (response.estado = "ok") {
									$("#btnEnviarCotizacion").css("display",
											"none");
									$("#divMsgResultadoEnviar")
											.html(
													"<strong>Su cotizacion fue aprobada</strong>");
									$("#divBotonCotizacionAprobar").css(
											"display", "none");
								}
								;
							},
							error : function(data, textStatus, errorThrown) {

							},
						});
			} else {
				$("#divMsgResultadoEnviar")
						.html(
								"<span style='color:red'>Para aprobar la cotizaci�n debe ingresar un comentario</span>");
				$("#txtComentarioAprobacion").focus();
			}
			;

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
								<strong>LISTADO DE COTIZACI&Oacute;N</strong>
							</center>
						</h3>
					</div>
					<div class="panel-body">



						<div class="col-sm-12" id="divSecBusquedaCotizacion">
							<div class="panel panel-primary">
								<div class="panel-heading">
									<strong>Cotizaciones - Consulta de Cotizaci&oacute;n</strong>
								</div>

								<div class="panel-body">

									<div class="row">
										<div class="col-sm-12">
											<form id="formConsuCotiza" class="form-horizontal"
												method="POST">

												<div class="form-group">
													<label class="col-sm-2 control-label alignDerecha">Nro.
														Cotizaci&oacute;n:</label>
													<div class="col-sm-3">
														<input id="txtNumeroCotizacion"
															onkeypress="return validarNumeroLetra(event)"
															name="numeroCotizacion" type="text" maxlength="30"
															class="form-control">
													</div>

													<label class="col-sm-1 control-label alignDerecha">Estado:</label>
													<div class="col-sm-4">
														<select name="codigoEstadoCotizacion"
															id="selcodigoEstadoCotizacion"
															class="form-control tamanoMaximo">
															<option value="">--- Seleccione ---</option>
															<option value="1">Por Pagar</option>
															<option value="2">Pagado</option>
															<option value="3">Cancelado</option>
															<option value="4">Pendiente</option>
															<option value="5">Finalizado</option>
														</select>
													</div>


												</div>

												<div class="form-group">
													<label class="col-sm-2 control-label alignDerecha">Fecha
														Cotizaci&oacute;n:</label>
													<div class="col-sm-3">
														<div class="input-group date tamanoMaximo"
															id="divFechaCotizacionBusq">
															<input id="txtFechaCotizacionBusq" name="fechaCotizacion"
																type="text" maxlength="30" readonly="yes"
																class="form-control txtFecha" /> <span
																class="input-group-addon datepickerbutton"> <span
																class="glyphicon glyphicon-calendar"></span>
															</span> <span class="input-group-addon" id="eliminarFecha">
																<span class="glyphicon glyphicon-remove"></span>
															</span>
														</div>
													</div>


													<label class="col-sm-1 control-label alignDerecha">Cliente:</label>
													<div class="col-sm-2">
														<select name="tipoBusqueda" id="selTipoBusqueda"
															class="form-control tamanoMaximo">
															<option value="">--- Seleccione ---</option>
															<option value="1">DNI</option>
															<option value="2">Nombre</option>
														</select>
													</div>

													<div class="col-sm-3">
														<input id="txtNombreCliente"
															onkeypress="return validarNumeroLetra(event)"
															name="nombreCliente" type="text" maxlength="30"
															class="form-control">
													</div>

												</div>

												<div class="form-group">
													<div class="col-sm-10" style="text-align: center">
														<button id="btnBuscarCotizacion" class="btn btn-primary"
															title="Buscar">Buscar</button>
														<button id="btnLimpiarCotizacion" class="btn btn-primary"
															title="Buscar">Limpiar</button>
													</div>

													<div class="col-sm-2" align="right">
														<input type="button" class="btn btn-primary" value="Nuevo"
															id="btnRegistrarCotizacion"
															onclick="registrarCotizacion()"></input>
													</div>
												</div>
											</form>
										</div>
									</div>

								</div>
							</div>
						</div>



						<div class="col-sm-12" id="divSecDatosCotizacion">
							<div class="panel panel-primary">
								<!-- 							<div class="panel-heading">	<strong>Lista de Coti</strong></div> -->

								<div class="panel-body">

									<div id="dvSubSecCotizacion">
										<div class="col-sm-12" id="divTblListaCotizacion">
											<table id="tblListaCotizacion"
												class="table table-bordered responsive" style="width: 100%">
												<thead>
													<tr>
														<th width="10%" class="text-center">N&deg;
														</td>
														<th width="20%" class="text-center">N&deg;
															Cotizaci&oacute;n
														</td>
														<th width="20%" class="text-center">Fecha
															Cotizaci&oacute;n
														</td>
														<th width="20%" class="text-center">Cliente
														</td>
														<th width="20%" class="text-center">Estado
														</td>
														<th width="10%" class="text-center">Opcion
														</td>
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
				<%@ include file="verDetalleCotizacion.jsp"%>
			</div>
		</div>
	</div>

	<input type="hidden" id="inpIdTipoCotizacion" name="idTipoCotizacion" />
	<input type="hidden" id="inpIdCotizacion" name="idCotizacion" />
	<input type="hidden" id="inpIdEstado" name="idEstado" />
	<input type="hidden" id="inpIdCliente" name="idCliente" />
	<input type="hidden" id="inpIdParams" name="idParams" />
	<input type="hidden" id="inpIdPaquete" name="idPaquete" />

</body>

</html>
