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
	
<script>

 	$(document).ready(function(){
		
 		inicia();
 		var listaVacasAInseminar = ${listaVacasAInseminar};
 		
 		construirTablaVacasAInseminar(listaVacasAInseminar);
		
 	});
 	
 	function construirTablaVacasAInseminar( dataGrilla ){
 		var table = $('#tblVacasAInseminar').dataTable({
            data: dataGrilla,
			bDestroy: true,
            ordering: false,
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
                    $('#tblVacasAInseminar_paginate').addClass('hiddenDiv');
                } else {
                    $('#tblVacasAInseminar_paginate').removeClass('hiddenDiv');
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
            			return "<span> <a href='javascript:;' onclick='abrirRegistrarInseminacion(\""+row.codigoAnimal+"\", \""+row.nombreAnimal+"\")' title='Registrar Inseminaci&oacute;n' ><span class='glyphicon glyphicon-plus-sign'></span></a> </span>";
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
 	
	function abrirRegistrarInseminacion(codigoAnimal, nombreAnimal){
		
		
		$.ajax({
			url: '${pageContext.request.contextPath}/abrirRegistrarInseminacion',
			//data: $('#formProduccion').serialize(),
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				
				
				/*var jsonToros = response.dataJson.listaToro;
	        	document.getElementById("selToro").options[0] = new Option("---");
	    		document.getElementById("selToro").options[0].value = "";
	    		
	    		alert(jsonToros.length);
				for (var i = 0; i < jsonToros.length; i++) {
					document.getElementById("selToro").options[i+1] = new Option(jsonToros[i].descripcion);
	       	        document.getElementById("selToro").options[i+1].value = jsonToros[i].codigo;
	    		}*/
	    		
				if (response.estado = "ok") {
					$("#tituloInseminacion").html(response.dataJson.titulo);
					$("#divCodigoAnimal").html(codigoAnimal);
					$("#divNombreAnimal").html(nombreAnimal);
					$("#txtCodigoAnimal").val(codigoAnimal);
					$("#txtFechaInseminacion").val(response.dataJson.fechaActual);
					
					$("#txtflagEdicion").val("2");
					
					$("#divRegistroInseminacion").modal({
						backdrop: "static", 
						keyboard: false
					});
				}
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
	}
	
	function inicia(){
		$("#btnBuscarVacaAInseminar").on("click", function(e){
			e.preventDefault();
			buscarVacaAInseminar();
		});
		
		$("#selectTIpoBusqueda").on("change", function(){
			if ($(this).val() == 1) {
				$("#txtBusquedaVaca").val("");
				$("#txtBusquedaVaca").attr("name","codigoAnimal");
				$("#txtBusquedaVaca").focus();
			} else {
				$("#txtBusquedaVaca").val("");
				$("#txtBusquedaVaca").attr("name","nombreAnimal");
				$("#txtBusquedaVaca").focus();
			}
		})
	}
	
	function buscarVacaAInseminar(){
		
		var grabarFormParams = {
			'animalBean' : formToObject( '#formConsuVacaAInse' )
		};
		
		$.ajax({
			url: '${pageContext.request.contextPath}/listarVacasAInseminar?btnBuscar=1',
			data: JSON.stringify(grabarFormParams),
			cache: false,
			async: true,
			type: 'POST',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				
				var rpta = response.dataJson;
                // actualizando lista
                var listaVacasAInseminar = [];
                if (rpta.listaVacasAInseminar != null) {
                    listaVacasAInseminar = rpta.listaVacasAInseminar;
                }
				construirTablaVacasAInseminar(listaVacasAInseminar);
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
	}
	
	function retornarAListarInseminacion(){
		location.href= '${pageContext.request.contextPath}/listarInseminacion';
	}
	
	function limpiarFormularioInseminacion(){
		$('#formInseminacion').bootstrapValidator('resetForm', true);
		$("#selToro").val("");
		$("#txtFechaInseminacion").val("");
		$("#txtObservacion").val("");
	}
	
	function cerraInseminacion(){
		$('#divRegistroInseminacion').modal("hide");
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
					<h3 class="panel-title"><center><strong>LISTADO DE VACAS A INSEMINAR</strong></center></h3>
				</div>
				<div class="panel-body">

					<div class="col-sm-12" id="divSecBusquedaInseminacion">
						<div class="panel panel-primary">
							<div class="panel-heading">	<strong>B&uacute;squeda de vacas a inseminar</strong></div>
							
							<div class="panel-body">
												
								<div class="row">
									<div class="col-sm-12">
										<form id="formConsuVacaAInse" class="form-horizontal" method="POST">

											<div class="form-group">
												<label class="col-sm-2 control-label alignIzquierda">Tipo de B&uacute;squeda:</label>
												
												<div class="col-sm-2">
													<div id="divFechaInseminacionBusq">
														<select name="tipoBusqueda" id="selectTIpoBusqueda" class="form-control tamanoMaximo">
															<option value="">---</option>
															<option value="1">C&Oacute;DIGO VACA</option>
															<option value="2">NOMBRE VACA</option>
														</select>
													</div>
												</div>
												
												<div class="col-sm-3">
													<input id="txtBusquedaVaca" name="" type="text" maxlength="10" size="20" class="form-control">
												</div>
												
												<div class="col-sm-2">
													<div id="divFechaInseminacionBusq" class="alignIzquierda">
														<button id="btnBuscarVacaAInseminar" class="btn btn-primary btn-block" title="Buscar">Buscar</button>
													</div>
												</div>
											</div>
										</form>
									</div>
								</div>
								
							</div>
						</div>
					</div>
				
					<div class="col-sm-12" id="divSecDatosPagRenta">
						<div class="panel panel-primary">
							<div class="panel-heading">	<strong>Lista de Vacas a inseminar</strong></div>
							
							<div class="panel-body">
												
								<div id="dvSubSecInseminacion">
									<div class="col-sm-12">
										<table id ="tblVacasAInseminar" class="table table-bordered responsive" style="width:100%">
											<thead>
												<tr>
													<th width="10%" class="text-center">N&deg;</td>
													<th width="15%" class="text-center">C&oacute;digo Vaca</td>
													<th width="15%" class="text-center">Nombre Vaca</td>
													<th width="15%" class="text-center">Registrar</td>
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
							<input type="button" class="btn btn-primary" value="Retornar" id="btnRetornarInseminacion" onclick="retornarAListarInseminacion()"></input>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</div>

<div id="divRegistroInseminacion" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog">
		<div class="panel panel-primary">
			<%@ include file="registrarInseminacion.jsp" %>
		</div>
	</div>
</div>

</body>

</html>