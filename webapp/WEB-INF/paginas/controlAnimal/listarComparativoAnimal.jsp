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

	var codigoControlAnimalGeneral;
	var codigoAnimalGeneral;
 	$(document).ready(function(){
		$.ajaxSetup({
			scriptCharset: "utf-8",
			contentType: "application/json; charset=utf-8"
		});
		jQuery.support.cors = true;
		
 		inicia();
 		listaComparativoAnimal = ${listaComparativoAnimal};
 		
 		construirTablaListaComparativoAnimal(listaComparativoAnimal);
		
// 		$("#btnBuscarControlAnimal").on('click', function(e){
// 			e.preventDefault();
// 			buscarControlAnimal();
// 		});
 	});
	
	function inicia(){
// 		$('#divFechaControlAnimalBusq').datetimepicker({
// 			language : 'es',
//             autoClose : true,
//  			minDate: '01/01/2000',

//             format: 'DD/MM/YYYY',
//             pickTime: false,
// 			useCurrent: false
//         });
		
// 		$("#eliminarFecha").on("click", function(e){
// 			e.preventDefault();
// 			$("#txtFechaControlAnimalBusq").val("");
// 		})
	}
	
	function validarNumeroLetra(e){
		var key = window.Event ? e.which : e.keyCode;
		return ( (key==32 ) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) );
 	}
 	
// 	function buscarControlAnimal(){
		
// 		var grabarFormParams = {
// 			'controlAnimalBean' : formToObject( '#formConsuControl' )
// 		};
		
// 		$.ajax({
// 			url: '${pageContext.request.contextPath}/listarControlEvolutivoAnimal?btnBuscar=1',
// 			data: JSON.stringify(grabarFormParams),
// 			cache: false,
// 			async: true,
// 			type: 'POST',
// 			contentType: "application/json; charset=utf-8",
// 			dataType: 'json',
// 			success: function(response) {
				
// 				var rpta = response.dataJson;
//                 // actualizando lista
//                 var listaControlAnimal = [];
//                 if (rpta.listaControlAnimal != null) {
//                 	listaControlAnimal = rpta.listaControlAnimal;
//                 }
// 				construirTablaListaControlAnimal(listaControlAnimal);
// 			},
// 			error: function(data, textStatus, errorThrown) {
// 			}
// 		});
		
// 	}
	
 	function construirTablaListaComparativoAnimal( dataGrilla ){
		
		var table = $('#tblListaComparativoAnimal').dataTable({
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
					$('#tblListaComparativoAnimal_paginate').addClass('hiddenDiv');
				} else {
					$('#tblListaComparativoAnimal_paginate').removeClass('hiddenDiv');
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
						var detalleComparativo = "<span> <a href='javascript:;' onclick='verDetalleComparativoXAnimal(\""+row.codigoAnimal+"\")' title='Ver Detalle Comparativo por Animal' ><span class='glyphicon glyphicon-zoom-in'></span></a> </span>";
						return detalleComparativo;
					}
					return '';
				}
			}],
			columns: [
				{data: "numeroFila"},
				{data: "codigoAnimal"},
				{data: "nombreAnimal"}
			]
		});
 	}
	
	
	function construirTablaListaDetalleComparativoAnimal( dataGrilla ){
		
		var table = $('#tblListaDetalleComparativoAnimal').dataTable({
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
					$('#tblListaDetalleComparativoAnimal_paginate').addClass('hiddenDiv');
				} else {
					$('#tblListaDetalleComparativoAnimal_paginate').removeClass('hiddenDiv');
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
				targets: 7,
				render: function(data, type, row){
					if (row !=null && typeof row != 'undefined') {
						var detalleComparativo = "<span> <a href='javascript:;' onclick='verReporteAnalisisComparativoPorEdad(\""+row.codigoAnimal+"\", \""+row.nombreAnimal+"\",  \""+row.fechaControl+"\", \""+row.edad+"\")' title='Ver Detalle Comparativo por Animal' >Ver An&aacute;lisis Comparativo</a> </span>";
						return detalleComparativo;
					}
					return '';
				}
			}],
			columns: [
				{data: "numeroFila"},
				{data: "codigoAnimal"},
				{data: "nombreAnimal"},
				{data: "edad"},
				{data: "perimetroToraxico"},
				{data: "peso"},
				{data: "altura"},
                {data: "fechaControl"}
			]
		});
 	}
 	
	function salir(){
		location.href= '${pageContext.request.contextPath}/principal';
	}
	
	function listarControlAnimal(){
		location.href= '${pageContext.request.contextPath}/listarControlEvolutivoAnimal';
	}
	
	function verDetalleComparativoXAnimal(codigoAnimal){
		$.ajax({
			url: '${pageContext.request.contextPath}/verDetalleComparativoXAnimal?codAnimal='+codigoAnimal,
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				
				if (response.estado = "ok") {
					
					var data = response.dataJson.listaDetalleComparativoAnimal;
 		
					construirTablaListaDetalleComparativoAnimal(data);
					
					$("#divVerDetalleControlAnimal").modal({
						backdrop: 'static',
						keyboard: false
					});
				}
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
	}
	
	function cerraDetalleControl(){
		$('#divVerDetalleControlAnimal').modal("hide");
	}
	
	function cerrarReporte(){
		$('#divVerReporteAnalisisComparativoPorEdad').modal("hide");
	}
	
	function verReporteAnalisisComparativoPorEdad(codigoAnimalAnalisis, nombreAnimalAnalisis, fechaControAnalisis, edadAnalisis){
    
		$('#divVerDetalleControlAnimal').modal("hide");
		var params = "?codAnimal="+codigoAnimalAnalisis+"&edadAnimal="+edadAnalisis+"&nomAnimal="+nombreAnimalAnalisis+"&fecControl="+fechaControAnalisis;
		$.ajax({
			url: '${pageContext.request.contextPath}/verReporteAnalisisComparativoPorEdad' + params,
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				
				if (response.estado = "ok") {
					
					var dataEstandar  = response.dataJson.listaEstandarAnimal;
					var dataControl   = response.dataJson.listaControlAnimal;
					
					$("#divTipoPerimetroEstandar").html(dataEstandar[0]["perimetroToraxico"]);
					$("#divPesoEstandar").html(dataEstandar[0]["peso"]);
					$("#divAlturaEstandar").html(dataEstandar[0]["altura"]);

					$("#divTipoPerimetroControl").html(dataControl[0]["perimetroToraxico"]);
					$("#divPesoControl").html(dataControl[0]["peso"]);
					$("#divAlturaControl").html(dataControl[0]["altura"]);

					$("#divTipoPerimetroResultado").html(response.dataJson.perimetroResultado);
					$("#divPesoResultado").html(response.dataJson.pesoResultado);
					$("#divAlturaResultado").html(response.dataJson.alturaResultado);
					
					
					$("#divCodigoGeneral").html(response.dataJson.codigoAnimal);
					$("#divNombreGeneral").html(response.dataJson.nombreAnimal);
					$("#divEdadGeneral").html(response.dataJson.edad);
					$("#divFechaGeneral").html(response.dataJson.fechaControl);
					
					$("#divVerReporteAnalisisComparativoPorEdad").modal({
						backdrop: 'static',
						keyboard: false
					});
				}
			},
			error: function(data, textStatus, errorThrown) {
			}
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
					<h3 class="panel-title"><center><strong>LISTA ANIMALES PARA AN&Aacute;LISIS COMPARATIVO</strong></center></h3>
				</div>
				<div class="panel-body">
					
					<div class="col-sm-12" id="divSecBusquedaInseminacion">
						<div class="panel panel-primary">
							<div class="panel-heading">	<strong>B&uacute;squeda de animal</strong></div>
							
							<div class="panel-body">
												
								<div class="row">
									<div class="col-sm-12">
										<form id="formConsuControl" class="form-horizontal" method="POST">

											<div class="form-group">
												<label class="col-sm-1 control-label alignDerecha">C&oacute;digo Animal:</label>
												<div class="col-sm-3">
													<div class="input-group date tamanoMaximo" id="divFechaInseminacionBusq">
														<input name="codigoAnimal" id="txtCodigoAnimal" onkeypress="return validarNumeroLetra(event)" type="text" maxlength="30" class="form-control">
													</div>
												</div>
												
												<label class="col-sm-2 control-label alignDerecha">Nombre Animal:</label>
												<div class="col-sm-4">
													<input name="nombreAnimal" id="txtNombreAnimal" onkeypress="return validarNumeroLetra(event)" type="text" maxlength="30" class="form-control">
												</div>
												
												<div class="col-sm-2">
													<button id="btnBuscarControlAnimal" class="btn btn-primary btn-block" title="Buscar">Buscar</button>
												</div>
											</div>
										</form>
									</div>
								</div>
								
							</div>
						</div>
					</div>
					
					
					<div class="col-sm-12" id="divSecDatosControlAnimal">
						<div class="panel panel-primary">
							<div class="panel-heading">	<strong>Lista de Control de Animal</strong></div>
							
							<div class="panel-body">
												
								<div id="dvSubSecInseminacion">
									<div class="col-sm-12" id="divTblListaControlAnimal">
										<table id ="tblListaComparativoAnimal" class="table table-bordered responsive" style="width:100%">
											<thead>
												<tr>
													<th width="10%" class="text-center">N&deg;</td>
													<th width="20%" class="text-center">C&oacute;digo Animal</td>
													<th width="20%" class="text-center">Nombre Animal</td>
													
													<th width="10%" class="text-center">An&aacute;lisis Comparativo </td>
												</tr>
											</thead>
										</table>
										
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="col-sm-12" align="right">
						
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
							onclick="eliminarControlAnimal();" id="btnEliminaRegistro"></input>
						<button type="button" id="btnEliminaNo" class="btn btn-primary" data-dismiss="modal">No</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="divVerDetalleControlAnimal" class="modal fade" role="dialog"  style="text-center:center">
	<div class="modal-dialog" style="width:1000px;">
		<div class="panel panel-primary">
			<%@ include file="detalleComparativoAnimal.jsp" %>
		</div>
	</div>
</div>

<div id="divVerReporteAnalisisComparativoPorEdad" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog" style="width:800px;">
		<div class="panel panel-primary">
			<%@ include file="reporteAnalisisComparativoPorEdad.jsp" %>
		</div>
	</div>
</div>

</body>

</html>