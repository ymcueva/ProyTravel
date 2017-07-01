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

	$(document).ready(function(){
	$.ajaxSetup({
		scriptCharset: "utf-8",
		contentType: "application/json; charset=utf-8"
	});
	jQuery.support.cors = true;
	
		inicia();
	listaOrdenPlanificacion = ${listaOrdenPlanificacion};
		console.log("listar orden jquery");
		construirTablaListaOrden(listaOrdenPlanificacion);
	
	$("#btnBuscarOrdenPlan").on('click', function(e){
		e.preventDefault();
			buscarOrdPlan();
	})
	
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
			$("#txtFechaOrd").val("");
		})
	}

	function validarNumeroLetra(e){
		/*var key = window.Event ? e.which : e.keyCode;
		return ( (key==32 ) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) );*/
 	}
 	
	function buscarOrdPlan(){
		
		var grabarFormParams = {
			'ordenPlanificacionBean' : formToObject( '#formConsuOrden' )
		};
		//alert("params: " + JSON.stringify(grabarFormParams));
		
		$.ajax({
			url: '${pageContext.request.contextPath}/listarOrdenPlanificacion?btnBuscar=1',
			data: JSON.stringify(grabarFormParams),
			cache: false,
			async: true,
			type: 'POST',
			contentType: "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				
				var rpta = response.dataJson;
                // actualizando lista
                var listaOrdenPlanificacion = [];
                if (rpta.listaOrdenPlanificacion != null) {
                    listaOrdenPlanificacion = rpta.listaOrdenPlanificacion;
                }
				construirTablaListaOrden(listaOrdenPlanificacion);
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
	}
	
 	function construirTablaListaOrden( dataGrilla ){
		//alert(dataGrilla);
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
			iDisplayLength: 10,
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
						var VerDetalle = "<span> <a href='javascript:;' onclick='verDetalleOrden(\""+row.idOrden+"\")' title='Ver Orden Planificacion' ><span class='glyphicon glyphicon-eye-open'></span></a> </span>";
						return VerDetalle;
					}
					return '';
				}
			}], 
			columns: [
				{data: "numeroFila"},
				{data: "nuOrden"},
				{data: "feOrder"},
				{data: "nombreCliente"},
				{data: "nomStat"}
			]
		});
 	}
	
	function salir(){
		location.href= '${pageContext.request.contextPath}/principal';
	}
	
	function verDetalleOrden(idOrden){
		console.log("Detalle de la orden..." + idOrden);
		
		$("#divInfoDetalleCotizacion").css("display", "none");
		$("#divBotonCotizacionBuscar").css("display", "none");
		$("#divBotonCotizacionEnviar").css("display", "none");
		
		$("#divCodigo").html("");
		$("#divCliente").html("");
		$("#tituloCotizacion").html("");
		
		$("#divFecha").html("");
		$("#divTipo").html("");
		$("#divEstado").html("");
		
		$("#divDestinos").html("");					
		$("#divMotivos").html("");
		$("#divServicios").html("");
		
		$("#inpIdTipoCotizacion").val("");
		$("#inpIdCotizacion").val("");
		$("#inpIdEstado").val("");
		$("#idParams").val("");
		$.ajax({
			url: '${pageContext.request.contextPath}/verDetalleOrden?idOrden='+idOrden,
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				
				if (response.estado = "ok") {
					console.log(response.dataJson);
					console.log(response);
					
					$("#inpIdTipoCotizacion").val(response.dataJson.cotizacion.idTipoCotizacion);
					$("#inpIdCotizacion").val(response.dataJson.cotizacion.IdCotizacion);
					$("#inpIdEstado").val(response.dataJson.cotizacion.idEstado);									
					
					$("#divCodigo").html(response.dataJson.cotizacion.numeroCotizacion);
					$("#divCliente").html(response.dataJson.cotizacion.nombreCliente);
					$("#tituloCotizacion").html(response.dataJson.cotizacion.tipoCotizacion);
					
					$("#divFecha").html(response.dataJson.cotizacion.fechaCotizacion);
					$("#divTipo").html( response.dataJson.cotizacion.tipoCotizacion + " / " + response.dataJson.cotizacion.tipoPrograma);
					$("#divEstado").html(response.dataJson.cotizacion.estado);
					
					//$("#").val(response.dataJson.cotizacion.tipoAlojamiento);
					//$("#").val(response.dataJson.cotizacion.categoriaAlojamiento);
					//$("#").val(response.dataJson.cotizacion.habitaciones);
					
					$("#divDestinos").html(response.dataJson.cotizacion.destinos);					
					$("#divMotivos").html(response.dataJson.cotizacion.motivos);
					$("#divServicios").html(response.dataJson.cotizacion.servicios);
					
					if ( response.dataJson.cotizacion.idTipoCotizacion == 1 ) { //Paquete Turistico 1 / //Ticket Aereo 2
						if ( response.dataJson.cotizacion.idTipoCotizacion == 1 ) {										
							if ( response.dataJson.cotizacion.idEstado == 4 ) {	//Estado Pendiente
								$("#divBotonCotizacionBuscar").css("display", "inline");											
							} else if ( response.dataJson.cotizacion.idEstado == 6 ) { //Estado Asignado
								$("#divBotonCotizacionEnviar").css("display", "inline");
							}					
						}						
						$("#idParams").val("presupuesto="+response.dataJson.cotizacion.presupuestoMaximo + 
								"&idTipoAlojamiento="+response.dataJson.cotizacion.idTipoAlojamiento +
								"&idCategoriaAlojamiento="+response.dataJson.cotizacion.idCategoriaAlojamiento + 
								"&idTipoPrograma="+response.dataJson.cotizacion.idTipoPrograma +
						"&numeroCotizacion=" + response.dataJson.cotizacion.numeroCotizacion);
					}
					
					$("#divVerDetalleInseminacion").modal({
						backdrop: 'static',
						keyboard: false
					});
				}
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
	}
	

	
	function formToObject(formID) {
	    var formularioObject = {};
	    var formularioArray = $( formID ).serializeArray();
	    $.each(formularioArray, function(i, v) {
	        formularioObject[v.name] = v.value;
	    });
	    return formularioObject;
	}
	function limpiarForm() {
		document.getElementById("formConsuOrden").reset();
	}

	function salir() {
		location.href = '${pageContext.request.contextPath}/principal';
	}

	function registrarOrdenPlan() {
		location.href = '${pageContext.request.contextPath}/formRegistrarOrdenPlanificacion';
	}
</script>
</head>
<body>


	<div id="container" class="container" style="width: 100%">
		<div class="row col-sm-offset-0 col-sm-12">
			<div class="principal">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">Orden de Planificacion - Consulta
							Orden</h3>
					</div>
					<div class="panel-body">
						<div class="col-sm-12" id="divSecBusquedaOrden">
							<div class="panel panel-primary">
								<div class="panel-body">
									<div class="row">
										<div class="col-sm-12">
											<form id="formConsuOrden" class="form-horizontal"
												method="POST">
												<div class="form-group">
													<label class="col-sm-2 control-label alignIzquierda">Nro.
														Orden:</label>
													<div class="col-sm-2">
														<input id="txtnuOrden"
															onkeypress="return validarNumeroLetra(event)"
															name="numeroOrden" type="text" maxlength="30"
															class="form-control">
													</div>
													<label class="col-sm-1 control-label">Cliente:</label>
													<div class="col-sm-2">
														<select name="tipoBusqueda" id="selTipoBusqueda"
															class="form-control">
															<option value="">--- Seleccione ---</option>
															<option value="1">DNI</option>
															<option value="2">Nombre</option>
														</select>
													</div>

													<div class="col-sm-2">
														<input id="txtNomCli"
															onkeypress="return validarNumeroLetra(event)"
															name="nombreCliente" type="text" maxlength="30"
															class="form-control">
													</div>

												</div>
												<div class="form-group">
													<label class="col-sm-2 control-label alignDerecha">Estado
														Orden:</label>
													<div class="col-sm-2">
														<select name="codigoEstadoOrden"
															id="codigselEstadoOrden" class="form-control">
															<option value="">--- Seleccione ---</option>
															<option value="1">Pendiente</option>
															<option value="2">Finalizado</option>
															<option value="3">Asignado</option>
															<option value="4">Disponible</option>
														</select>
													</div>
													<label class="col-sm-2 control-label">Fecha Orden:</label>
													<div class="col-sm-3">
														<div class="input-group date" id="divFechaBusq">
															<input id="txtFechaOrd" name="fechaOrden"
																type="text" maxlength="30" readonly
																class="form-control txtFecha" />
															<span class="input-group-addon datepickerbutton">
															 <span class="glyphicon glyphicon-calendar"></span></span>
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
						<div class="panel-body">
							<div class="row">
								<div class="form-group">
									<div class="col-sm-2" align="center">
										<input type="button" class="btn btn-primary" value="Buscar"
											id="btnBuscarOrdenPlan" ></input>
									</div>
									<div class="col-sm-2" align="center">
										<input type="button" class="btn btn-primary" value="Limpiar"
											id="clean" onclick="limpiarForm()"></input>
									</div>
									<div class="col-sm-2" align="right">
										<input type="button" class="btn btn-primary" value="Nuevo"
											id="btnNuevaOrden" onclick="registrarOrdenPlan()"></input>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-12" id="divSecDatosOrden">
							<div class="panel panel-primary">
								<div class="panel-body">
									<div id="divSecDatosOrden">
										<div class="col-sm-12" id="divTblListaOrden">
											<table id="tblListaOrden"
												class="table table-bordered responsive" style="width: 100%">
												<thead>
													<tr>
														<th width="20%" class="text-center">Fecha Orden</th>
														<th width="50%" class="text-center">Cliente</th>
														<th width="20%" class="text-center">Estado</th>
														<th width="10%" class="text-center">Opcion</th>
													</tr>
												</thead>
												<%-- <tr>
														<td>${fecOrden}</td>
														<td>${clientes}</td>
														<td>${estados}</td>
														<td>${opciones}</td>
												</tr> --%>
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


	<div id="mdlConfirmaEliminacion" class="modal fade">
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
							<input type="button" class="btn btn-primary" data-dismiss=""
								value="Si" onclick="eliminarInseminacion();"
								id="btnEliminaRegistro"></input>
							<button type="button" id="btnEliminaNo" class="btn btn-primary"
								data-dismiss="modal">No</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>