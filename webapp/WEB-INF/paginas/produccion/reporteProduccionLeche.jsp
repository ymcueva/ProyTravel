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

	var codigoInseminacionGeneral;
	var codigoAnimalGeneral;
	var fechaInicialGeneral;
	var fechaFinalGeneral;
 	$(document).ready(function(){
		$.ajaxSetup({
			scriptCharset: "utf-8",
			contentType: "application/json; charset=utf-8"
		});
		jQuery.support.cors = true;
		
 		iniciaReporte();
		
		$("#selTipoBusqueda").val("1");
 	});
	
	
	function iniciaReporte(){
		$('#divFechaInicialBusq').datetimepicker({
			language : 'es',
            autoClose : true,
 			minDate: '01/01/2000',
            format: 'DD/MM/YYYY',
            pickTime: false,
			useCurrent: false
        });
		
		$('#divFechaFinalBusq').datetimepicker({
			language : 'es',
            autoClose : true,
 			minDate: '01/01/2000',
            format: 'DD/MM/YYYY',
            pickTime: false,
			useCurrent: false
        });
		
		$("#selTipoBusqueda").on("change", function(e){
			e.preventDefault();
			var valor = $(this).val();
			if (valor==1) {
				$("#divFiltroFechas").attr("style", "display:inline");
			} else {
				$("#divFiltroFechas").attr("style", "display:none");
			}
		})
		
		$("#eliminarFechaInicial").on("click", function(){
			$("#txtFechaInicialBusq").val("");
		})
					
		$("#eliminarFechaFinal").on("click", function(){
			$("#txtFechaFinalBusq").val("");
		});
		
		$("#btnVerDetalle").on("click", function(){
			var valor = $("#selTipoBusqueda").val();
			var ruta = "";
			if (valor == 1) {
				var fIni = $("#txtFechaInicialBusq").val();
				var fFin = $("#txtFechaFinalBusq").val();
				ruta = '${pageContext.request.contextPath}/detalleReportePorFecha?fIni='+fIni+"&fFin="+fFin;
			} else if (valor == 2) {
				ruta = '${pageContext.request.contextPath}/detalleReporteProduccionDiaria';
			}
				
				
			$.ajax({
				url: ruta,
				cache: false,
				async: true,
				type: 'POST',
				contentType: "application/json; charset=utf-8",
				dataType: 'json',
				success: function(response) {
	
					if (response.estado = "ok") {
						
						if (valor == 1) {
							construirTablaProduccionDiariaPorFecha(response.dataJson.listaProduccionPorFecha)
							
							$("#divReporteProduccionTotalPorFecha").modal({
								backdrop: 'static',
								keyboard: false
							});
						}
						
						if (valor == 2) {
							$("#txtFechaOrdenoTotal").val(response.dataJson.listaDetalleProduccionDiaria[0]["fechaOrdeno"]);
							$("#divCantidadTotal").html(response.dataJson.listaDetalleProduccionDiaria[0]["cantidadTotalProduccion"]);
							$("#divOrdenador").html(response.dataJson.listaDetalleProduccionDiaria[0]["ordenador"]);
							$("#divVacaMasProd").html(response.dataJson.listaDetalleProduccionDiaria[0]["vacaMasProductiva"]);
							$("#divVacaMenosProd").html(response.dataJson.listaDetalleProduccionDiaria[0]["vacaMenosProductiva"]);
							
							$("#divReporteProduccionDiaria").modal({
								backdrop: 'static',
								keyboard: false
							});
						}
					}
				},
				error: function(data, textStatus, errorThrown) {
				}
			});
			
		});
		
		
	}
		
 	function construirTablaProduccionDiariaPorFecha( dataGrilla ){
		
 		var table = $('#tblProduccionTotalPorFecha').dataTable({
            data: dataGrilla,
            ordering: false,
			bDestroy: true,
            searching: false,
            paging: true,
            bScrollAutoCss: true,
            bStateSave: false,
            bAutoWidth: false,
            info: false,
            bScrollCollapse: false,
            pagingType: "full_numbers",
            pageLength: 5,
            responsive: true,
            bLengthChange: false,
			
            fnDrawCallback: function(oSettings) {
                if (oSettings.fnRecordsTotal() == 0) {
                    $('#tblProduccionTotalPorFecha_paginate').addClass('hiddenDiv');
                } else {
                    $('#tblProduccionTotalPorFecha_paginate').removeClass('hiddenDiv');
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
				targets: 3,
				render: function(data, type, row){
					if (row !=null && typeof row != 'undefined') {
						var VerDetalle = "<span> <a href='javascript:;' onclick='verProduccionDiariaPorFecha(\""+row.fechaOrdeno+"\")' title='Ver Detalle' >Ver Detalle</a> </span>";
						return VerDetalle;
					}
					return '';
				}
			}],
			
			columns: [
				{data: "numeroFila"},
				{data: "fechaOrdeno"},
				{data: "cantidadProducida"}
			]
        });
 	}
	
	function verProduccionDiariaPorFecha(fechaOrdeno){
		
		var params = "?fechaOrdeno="+fechaOrdeno;
		
		$.ajax({
			url: '${pageContext.request.contextPath}/detalleProduccionDiariaPorVaca'+params,
			cache: false,
			async: true,
			type: 'POST',
			contentType: "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {

				if (response.estado = "ok") {
					
					$("#divReporteProduccionTotalPorFecha").modal("hide");
					
					construirTablaProduccionDiariaPorVaca(response.dataJson.listaProduccionDiariaPorVaca)

					$("#divReporteProduccionDiariaPorVaca").modal({
						backdrop: 'static',
						keyboard: false
					});
				}
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
			
		
		
	}
	
	
 	function construirTablaProduccionDiariaPorVaca( dataGrilla ){
		
 		var table = $('#tblProduccionDiariaPorVaca').dataTable({
            data: dataGrilla,
            ordering: false,
            bDestroy: true,
            searching: false,
            paging: true,
            bScrollAutoCss: true,
            bStateSave: false,
            bAutoWidth: false,
            info: false,
            bScrollCollapse: false,
            pagingType: "full_numbers",
            pageLength: 5,
            responsive: true,
            bLengthChange: false,
			
            fnDrawCallback: function(oSettings) {
                if (oSettings.fnRecordsTotal() == 0) {
                    $('#tblProduccionDiariaPorVaca_paginate').addClass('hiddenDiv');
                } else {
                    $('#tblProduccionDiariaPorVaca_paginate').removeClass('hiddenDiv');
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
			columns: [
				{data: "numeroFila"},
				{data: "codigoAnimal"},
				{data: "nombreAnimal"},
				{data: "cantidadProducida"}
			]
        });
 	}
	
	function validarNumeroLetra(e){
		var key = window.Event ? e.which : e.keyCode;
		return ( (key==32 ) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) );
 	}
 	
	
	
	function salir(){
		location.href= '${pageContext.request.contextPath}/principal';
	}
	
	
	function salirDetalle(){
		$('#divReporteProduccionDiariaPorVaca').modal("hide");
	}
	
	function formToObject(formID) {
	    var formularioObject = {};
	    var formularioArray = $( formID ).serializeArray();
	    $.each(formularioArray, function(i, v) {
	        formularioObject[v.name] = v.value;
	    });
	    return formularioObject;
	}
		
	function retornar(){
		$("#divReporteProduccionDiariaPorVaca").modal("hide");
		$("#divReporteProduccionTotalPorFecha").modal({
			backdrop: 'static',
			keyboard: false
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
					<h3 class="panel-title"><center><strong>REPORTE DE PROUCCI&Oacute;N DE LECHE</strong></center></h3>
				</div>
				<div class="panel-body">
					
					<div class="col-sm-12" id="divSecBusquedaInseminacion">
						<div class="panel panel-primary">
							<div class="panel-heading">	<strong>Filtros deB&uacute;squeda</strong></div>
							
							<div class="panel-body">
												
								<div class="row">
									<div class="col-sm-12">
										<form id="formConsuInsemi" class="form-horizontal" method="post">

											<div class="form-group">
												<label class="col-sm-2 control-label alignDerecha">Tipo B&uacute;squeda:</label>
												<div class="col-sm-4">
													<select name="tipoBusqueda" id="selTipoBusqueda" class="form-control tamanoMaximo"> 
														<option value="0">Seleccione</option>
														<option value="1">Rango de fechas</option>
														<option value="2">Produci&oacute;n diaria por vaca</option>
													</select>
												</div>
											
												<div class="col-sm-6">&nbsp;</div>
											</div>
											<div class="form-group">
												<div id="divFiltroFechas">
													<label class="col-sm-2 control-label alignDerecha">Fecha Inicial:</label>
													<div class="col-sm-4">
														<div class="input-group date tamanoMaximo" id="divFechaInicialBusq">
															<input id="txtFechaInicialBusq" name="fechaInicial" type="text" maxlength="30" readonly="yes" class="form-control txtFecha" />
															<span class="input-group-addon datepickerbutton">
																<span class="glyphicon glyphicon-calendar"></span>
															</span>
															<span class="input-group-addon" id="eliminarFechaInicial">
																<span class="glyphicon glyphicon-remove"></span>
															</span>
														</div>
													</div>
													
													<label class="col-sm-2 control-label alignDerecha">Fecha Final:</label>
													<div class="col-sm-4">
														<div class="input-group date tamanoMaximo" id="divFechaFinalBusq">
															<input id="txtFechaFinalBusq" name="fechaFinal" type="text" maxlength="30" readonly="yes" class="form-control txtFecha" />
															<span class="input-group-addon datepickerbutton">
																<span class="glyphicon glyphicon-calendar"></span>
															</span>
															<span class="input-group-addon" id="eliminarFechaFinal">
																<span class="glyphicon glyphicon-remove"></span>
															</span>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group"></div>
											<div class="form-group">
												<div class="col-sm-4"></div>
												<div class="col-sm-4">
													<input type="button" id="btnVerDetalle" class="btn btn-primary btn-block" title="Buscar" value="Ver Detalle" />
												</div>
												<div class="col-sm-4"></div>
												
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

<div id="divReporteProduccionDiaria" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog">
		<div class="panel panel-primary">
			<%@ include file="reporteProduccionTotal.jsp" %>
		</div>
	</div>
</div>

<div id="divReporteProduccionDiariaPorVaca" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog" style="width: 1000px">
		<div class="panel panel-primary" >
							
							
				<div id="container">
					<div>
						<div class="principal">
							<div class="panel panel-primary">
								<div class="panel-heading">
									<h3 class="panel-title"><center><strong>DETALLE DE PRODUCCI&Oacute;N DIARIA POR VACA</strong></center></h3>
								</div>
								<div class="panel-body">

									<div class="col-sm-12" id="divSecDatosPagRenta">
										<div class="panel panel-primary">
											<div class="panel-heading">	<strong>Producci&oacute;n diaria de leche</strong></div>
											
											<div class="panel-body">
																
												<div id="dvSubSecProduccion">
													
													<div class="col-sm-12">
														<table id ="tblProduccionDiariaPorVaca" class="table table-bordered responsive" style="width:100%">
															<thead>
																<tr>
																	<th width="5%" class="text-center">N&deg;</td>
																	<th width="20%" class="text-center">C&oacute;digo Animal</td>
																	<th width="20%" class="text-center">Nombre Animal</td>
																	<th width="15%" class="text-center">Cantidad Producida (Lt.)</td>
																</tr>
															</thead>
														</table>
														
													</div>
												</div>
											</div>
										</div>
									</div>
									
									<div class="col-sm-12" align="right">
										<div class="form-group">
											<input type="button" class="btn btn-primary" value="Salir" id="btnAgregaProduccion" onclick="salirDetalle()"></input>
											<input type="button" class="btn btn-primary" value="Retornar" id="btnRetornar" onclick="retornar()"></input>
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

<div id="divReporteProduccionTotalPorFecha" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog" style="width: 1000px">
		<div class="panel panel-primary" >
			<%@ include file="reporteProduccionTotalPorFecha.jsp" %>
		</div>
	</div>
</div>

</body>

</html>