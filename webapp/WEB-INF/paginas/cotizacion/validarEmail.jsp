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
		// listaDestinos = ${listaDestinos};

		//construirTablaListaDestinos(listaDestinos);
		
		$("#btnValidarEmail").on('click', function(e) {
			e.preventDefault();
			validarEmail();
		})

	});
	
	function validarEmail() {

		var grabarFormParams = {
			'validarEmailBean' : formToObject('#formValidarEmail')
		};

		$.ajax({
			url : '${pageContext.request.contextPath}/validarEmail2',
			data : JSON.stringify(grabarFormParams),
			cache : false,
			async : true,
			type : 'POST',
			contentType : "application/json; charset=utf-8",
			dataType : 'json',
			success : function(response) {
				var rpta = response.dataJson; // OK
				var rptaRes = rpta.resultadoProcesarPago;
				console.log("respuesta procesar pago: " + rptaRes);
				$("#resultadoProcesarPago").html(rptaRes);
			},
			error : function(data, textStatus, errorThrown) {
			}
		});
	}

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
								data : "fePartida"
							}, {
								data : "nomAerolinea"
							}, {
								data : "ciudadOrigen"
							}, {
								data : "ciudadDestino"
							}, {
								data : "imPrecio"
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
								<strong>VALIDAR EMAIL</strong>
							</center>
						</h3>
					</div>
					<div class="panel-body">

						<div class="col-sm-12" id="divInfoCotizacion"
							style="font-size: 12px;">
							<div class="panel panel-primary">

								<div class="panel-body">
									<div class="row">
										<form class="form-horizontal" id="formValidarEmail">
											<input type="hidden" name="idCliente"
												value="${cotizacionBean.idCliente}"> 
											<input type="hidden" name="idCotizacion"
												value="${cotizacionBean.idCotizacion}">
											<div class="form-group">
												<label class="control-label col-sm-5">Email</label>
												<div class="col-sm-3">
													<input id="txtEmail"
														onkeypress="return validarNumeroLetra(event)"
														name="email" type="text" maxlength="30"
														class="form-control">
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-10" style="text-align: center">
													<button id="btnValidarEmail" class="btn btn-primary"
														title="Aceptar">ACEPTAR</button>
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
		</div>
	</div>

	<input type="hidden" id="inpIdTipoCotizacion" name="idTipoCotizacion" />
	<input type="hidden" id="inpIdCotizacion" name="idCotizacion" />
	<input type="hidden" id="inpIdEstado" name="idEstado" />
	<input type="hidden" id="inpIdParams" name="idParams" />
	<input type="hidden" id="inpIdPaquete" name="idPaquete" />

</body>

</html>