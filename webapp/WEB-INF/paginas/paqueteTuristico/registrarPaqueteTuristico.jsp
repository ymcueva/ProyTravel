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

		$(document).ready(function(){
		
			inicia();
 		
 				
		});
		
		
		
		function buscarOrdenesPlanificacion(){
			
			var params = "";
			var numOrden = $("#txtcodOrden").val();
			
			
			params = "?nuorden="+numOrden;
			alert("params: "  + params);
			$.ajax({
				url: '${pageContext.request.contextPath}/obtenerOrdenPlanificacion'+params,
	           	//data: JSON.stringify(grabarFormParams),	           	
	            cache: false,
	            async: true,
	            type: 'POST',
	            contentType : "application/json; charset=utf-8",
	            dataType: 'json',
	            success: function(response) {
	                
					var rpta = response.dataJson;
					
					alert(response.estado)
					//alert(rpta.descripcion +rpta.observacion)
					$("#txtDescripcion").val(rpta.descripcion);
					$("#txtObservacion").val(rpta.observacion);
					
					return false;
	                
	            },
	            error: function(data, textStatus, errorThrown) {
	            	alert(data);
	            	alert(textStatus);
	            	alert(errorThrown);
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
		
		function aceptar(){
			location.href = '${pageContext.request.contextPath}/cargarFormRegistrarPaqueteTuristico';
		}
		
	
		
		function registrarPaqTuristico(){
			
			
			var grabarFormParams = {
					'paqueteTuristicoBean' : formToObject('#frmRegPaqueteTuristico')
			};
			
			var idOrden = $("#txtcodOrden").val();
			//var nomPaquete = $("#txtpaqueteTuristico").val();
			
			alert(idOrden);
			//alert(nomPaquete);
			
			//var params = "?idOrden="+idOrden+"&nombre="+nomPaquete;
			 
			var ruta ="";
			if ( $("#txtflagEdicion").val() == 1 ) {
				ruta = '${pageContext.request.contextPath}/editarInseminacion';
			} else{ 
				ruta = '${pageContext.request.contextPath}/grabarTransaccionPaqTuristico';
			}
			
			alert(ruta);
			
			$.ajax({
				url: ruta,
				data: JSON.stringify(grabarFormParams),
				cache: false,
				async: true,
				type: 'POST',
				contentType : "application/json; charset=utf-8",
				dataType: 'json',
				success: function(response) {
					
					if (response.estado = "ok") {
						if ( $("#txtflagEdicion").val() == 1 ) {
							$("#mensajeTransaccion").html("Se modific&oacute; satisfactoriamente la inseminaci&oacute;n de la vaca");
						}
						$("#divRegistroGrabadoCorrectamente").modal({
							backdrop: 'static',
							keyboard: false
						});
						return false;
					}
					
				},
				error: function(data, textStatus, errorThrown) {
				}
			});
		
		}
		
		
		
		
		

	function cargarConfirmacionRegistro(e, tipo){
		e.preventDefault();
		
		if (tipo ==1){
			
			//alert("paquee");
			$('#mdlConfirmaRegistro').modal({
				backdrop: 'static',
				keyboard: false
			});
			
		} 
			
	}
	
	
	//Function Limpiar Formulario 
	function limpiarFormularioPaqTuristico(){
		$('#frmRegPaqueteTuristico').bootstrapValidator('resetForm', true);		
		$("#txtPresupuestoMinimo").val("");
		$("#txtPresupuestoMaximo").val("");
		$("#txtDescripcion").val("");
	}

	$('#divFechaPartida').datetimepicker({
			language : 'es',
            autoClose : true,
 			minDate: '01/01/2000',
			
            format: 'DD/MM/YYYY',
            pickTime: false,
			useCurrent: false
        });
		
		$('#divFechaPartidaTicket').datetimepicker({
			language : 'es',
            autoClose : true,
 			minDate: '01/01/2000',
			
            format: 'DD/MM/YYYY',
            pickTime: false,
			useCurrent: false
        });
		
		$('#divFechaRetorno').datetimepicker({
			language : 'es',
            autoClose : true,
 			minDate: '01/01/2000',
			
            format: 'DD/MM/YYYY',
            pickTime: false,
			useCurrent: false
        });
		
 
	
	
 	function construirTablaCotizacion( dataGrilla ){
		
		// construyendo tabla destino
		var table = $('#tblDestinos').dataTable({
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
                   $('#tblDestino_paginate').addClass('hiddenDiv');
               } else {
                   $('#tblDestino_paginate').removeClass('hiddenDiv');
               }
            },
            
           fnRowCallback: function (nRow, aData, iDisplayIndex) {
				alert(aData[0]);
				$(nRow).attr('id', aData[0]);
				$(nRow).attr('align', 'center');
				$(nRow).attr('rowClasses','tableOddRow');
               return nRow;
            },
			language: {
               url: "/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/plug-ins/1.10.7/i18n/Spanish.json"
			},
			columns: [
	            {"class": "botones"},
				{"class": ""},
				{"class": ""},
				{"class": ""},
				{"class": "hidden"}
			]
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
								
					<div class="panel-heading" >
						<h3 class="panel-title" align="center" id="tituloInseminacion">${titulo}</h3>
					</div>
				
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-12">
				
								<form id="frmRegPaqueteTuristico" name="frmRegPaqueteTuristico" role="form" class="form-horizontal" method="post">
									
									<div class="form-group">										
										<input type="hidden" name="flagEdicion" id="txtflagEdicion" />								
										<div class="col-sm-8" id="divCodigoAnimal" ></div>
									</div>
									
									
									<div class="form-group">
										<div class="col-sm-3"  style="text-align:right; font-weight:bold">Fecha:</div>
										<div class="col-sm-3" id="divCodigoAnimal" >${fecha}
										<span style="display:none">
											<input type="text" name="fecha"  value="${fecha}" />
										</span>
										</div>
									</div>
									
									<div class="col-sm-12" id="divSecBusqOrdenPlanificacion">
										<div class="panel panel-primary">
											<div class="panel-heading">	<strong>B&uacute;squeda de Orden de Planificacion</strong></div>
											
											<div class="panel-body">
																
												<div class="row">
													<div class="col-sm-12">
													  
													  
															<div class="form-group">
															
																<label class="col-sm-2">Nro de Orden:</label>	
																
																<div class="col-sm-3">
																	<input type="text" class="form-control tamanoMaximo" name="codigoOrden" id="txtcodOrden" />
																</div>	
																
																																													
																<div class="col-sm-3">
																	<input id="txtDescripcionOrden" onkeypress="return validarNumeroLetra(event)" name="descripcionOrden" type="text" maxlength="30" class="form-control" />
																</div>
																
																<div class="col-sm-2">
																<!--	<button id="btnBuscarOrdenPlanificacion" class="btn btn-primary btn-block"  title="Buscar">Buscar</button> -->
																	<button id="btnBuscarOrdenPlanificacion" type="button" class="btn btn-primary centro" onclick="buscarOrdenesPlanificacion()" title="Buscar Orden">Buscar</button>
																</div>
																
																<label class="col-sm-1">Fecha Orden:</label>	
																<div class="col-sm-1">
																	<input id="txtFechaOrden" name="fechaOrden" type="text" maxlength="10" class="form-control" />	
																
																</div>
															</div>
															
															
															
															
															
															<div class="form-group">
																<div class="col-sm-2" style="text-align:right; font-weight:bold">Cliente:</div>
																<div class="col-sm-9" id="divNombreAnimal">
																	<input id="txtCliente" name="nombreCliente" type="text" maxlength="80" class="form-control" />
																</div>
															</div>
															
															<div class="form-group">
																<div class="col-sm-2" style="text-align:right; font-weight:bold">Descripci&oacute;n:</div>
																<div class="col-sm-9" id="divNombreAnimal">
																	<textarea class="form-control" name="descripcion" id="txtDescripcion" onkeypress="return validarNumeroLetra(event)" rows="3" cols="98" /></textarea>
																</div>
															</div>
															
															<div class="form-group">
																<div class="col-sm-2" style="text-align:right; font-weight:bold">Presupuesto M&iacute;nimo:</div>
																<div class="col-sm-3">
																	<input name="ImMin" id="txtPresupuestoMinimo" type="text" class="form-control tamanoMaximo"></input>
																</div>
																
																<div class="col-sm-2 col-md-offset-1" style="text-align:right; font-weight:bold">Presupuesto M&aacute;ximo:</div>
																<div class="col-sm-3">
																	<input name="ImMax" id="txtPresupuestoMaximo" type="text" class="form-control tamanoMaximo"></input>
																</div>
															</div>
															
															<div class="form-group">
																<div class="col-sm-2" style="text-align:right; font-weight:bold">Observaciones:</div>
																<div class="col-sm-9" id="divNombreAnimal">
																	<textarea class="form-control" name="observacion" id="txtObservacion" onkeypress="return validarNumeroLetra(event)" rows="3" cols="98"  placeholder="Observaciones"/></textarea>
																</div>
															</div>
													</div>
												</div>
												
											</div>
										</div>
									</div>
									
									<div class="col-sm-12" id="divReservaHistoricas">
										<div class="panel panel-primary">
											<div class="panel-heading">	<strong>Reservas Historicas</strong></div>
											
											<div class="panel-body">
																
												<div class="row">
													<div class="col-sm-12">
													  
														<div class="form-group">
																<label class="col-sm-6 control-label alignDerecha">Propuesta de Busqueda de Informacion Historica:</label>	
																<div class="col-sm-2">
																	<button id="btnBuscarInseminacion" class="btn btn-primary btn-block" title="Buscar">Buscar</button>
																</div>														
														</div>		
													</div>
												</div>
												
											</div>
										</div>
									</div>
									
									<div class="col-sm-12" id="divDestinos">
										<div class="panel panel-primary">
											<div class="panel-heading">	<strong>Destinos</strong></div>
											
											<div class="panel-body">
																
												<div class="row">
													<div class="col-sm-12">
													  
														<div id="divSubDestinos">
															<div class="col-sm-12">
																
																	<table id ="tblDestinos" class="table table-bordered responsive table-hover" style="width:100%">
																		<thead>
																			<tr>
																				<th width="5%" class="text-center">Orden</td>																						
																				<th width="15%" class="text-center">Destino</td>
																				<th width="15%" class="text-center">Nro Dias</td>
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
									
									<div class="col-sm-12" id="divServiviosTuristicos">
										<div class="panel panel-primary">
											<div class="panel-heading">	<strong>Servicios Turisticos</strong></div>
											
											<div class="panel-body">
																
												<div class="row">
												
													<div class="col-sm-12">
													  
														<div id="divSubServiciosTuristicos">
															<div class="col-sm-12">
																<table id ="tblServiciosTuristicos" class="table table-bordered responsive" style="width:60%">
																	<thead>
																		<tr>
																			<th width="5%" class="text-center">Orden</td>																						
																			<th width="15%" class="text-center">Servicio Turistico</td>
																			<th width="15%" class="text-center">Buscar</td>
																		</tr>
																	</thead>
																	
																	
																</table>
																
																<div class="form-group">
																
																	<label class=" control-label col-sm-2">Fecha Partida:</label>																
																	
																	<div class="col-sm-3">
																		<div class="input-group date tamanoMaximo" id="divFechaPartida">
																			<input name="fechaPartida" id="txtFechaPartida"  type="text" class="form-control tamanoMaximo txtFecha" ></input>
																			<span class="input-group-addon">
																				<span class="glyphicon glyphicon-calendar"></span>
																			</span>
																		</div>
																	</div>
																	
																	
																	
																	<label class=" control-label col-sm-2 col-md-offset-2">Fecha Retorno:</label>
																	<div class="col-sm-3">
																		<div class="input-group date tamanoMaximo" id="divFechaRetorno">
																			<input name="fechaRetorno" id="txtFechaRetorno"  type="text" class="form-control tamanoMaximo txtFecha" ></input>
																			<span class="input-group-addon">
																				<span class="glyphicon glyphicon-calendar"></span>
																			</span>
																		</div>
																	</div>																
																	
																</div>
																
																<div class="form-group">
																	<label class=" control-label col-sm-2">Cantidad adultos 22:</label>	
																
																	<div class="col-sm-3">
																		<input id="txtcantAdultos" name="nuNinos" type="text" maxlength="30" class="form-control" placeholder="Cantidad Adultos">
																	</div>
																	<label class=" control-label col-sm-2 col-md-offset-2">Cantidad Ninos:</label>	
																
																	<div class="col-sm-3">
																		<input id="txtcantNinos" name="nuAdultos" type="text" maxlength="30" class="form-control" placeholder="Cantidad Ninos">
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
										<div class="col-sm-3"  style="text-align:right; font-weight:bold">Nombre Paquete Turistico:</div>
										
										<div class="col-sm-4">
											<input id="nombre" name="nombre" type="text" maxlength="30" class="form-control">
										</div>
										
										<div class="col-sm-2" style="text-align:right; font-weight:bold">Tipo Programa:</div>
											<div class="col-sm-3" id="divNombreAnimal">
												<select name="tipoPrograma" id="selTipoPrograma" class="form-control tamanoMaximo"> 
													<option value="">---Seleccione---</option>
													<option value="1">Pendiente</option>
													<option value="2">Finalizado</option>
												</select>
											</div>
										
									</div>
									
									<div class="row">&nbsp;</div>
									
									<!-- Botones de formulario -->
									
									<div class="container-fluid">
										<div class="row">
											<div class="col-sm-12" style="text-align: center">
											
											<div class="form-group">
												<div class="col-sm-3">
													<button id="btnCerrar" type="button" class="btn btn-primary centro" onclick="cerraInseminacion()" title="Cerrar">Cerrar</button>
												</div>
												<div class="col-sm-3">
													<button id="btnLimpiar" type="button" class="btn btn-primary centro" onclick="limpiarFormularioPaqTuristico()" title="Limpiar">Limpiar</button>
												</div>
												<div class="col-sm-3"> 
													<button id="btnRegistrar" class="btn btn-primary" onclick="cargarConfirmacionRegistro(event,1)" title="Continuar">Registrar</button>
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
	
		
		<div id="divRegistroPaqTuristico" class="modal fade" role="dialog" style="text-center:center">
			<div class="modal-dialog">
				<div class="panel panel-primary">
							
				</div>
			</div>
		</div> 
		
		
	
	
		<!-- DIALOGO PARA GRABAR SI O NO    -->
		<div id="mdlConfirmaRegistro" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="panel panel-info">
					<div class="panel-heading"> <strong>Confirmaci&oacute;n Registro</strong></div>
					<div class="panel-body">
						<div class="modal-body"> <p class="text-center">&iquest;Desea Grabar?</p></div>
						<div class="modal-footer">
							<div class="col-sm-12" align="center">
								<input type="button" class="btn btn-primary" intermediateChanges="false" data-dismiss="" value="Si"
									onclick="registrarPaqTuristico();" id="btnGrabaRegistro"></input>
								<button type="button" id="btnRegistroNo" class="btn btn-primary" data-dismiss="modal">No</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>


			<!--   MENSAJE GRABADO CORRECTAMENTE -->
		<div id="divRegistroGrabadoCorrectamente" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="panel panel-info">
					<div class="panel-heading"> <strong>Registro Satisfactorio</strong></div>
					<div class="panel-body">
						<div class="modal-body"> <p class="text-center" id="mensajeTransaccion">Se registro satisfactoriamente la 	Cotizaci&oacute;n</p></div>
							<div class="modal-footer">
								<div class="col-sm-12" align="center">
									<input type="button" id="btnRegistro" class="btn btn-primary" onclick="aceptar()" value="Aceptar"/>
								</div>
							</div>
					</div>
				</div>
			</div>
		</div>
		
		
		
									
									
		<!-- Diseño de ayuda de busqueda de ordenes  -->
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
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary">Save changes</button>
					</div>
				</div>

			</div>
		</div> 
	
	
	

</body>

</html>

