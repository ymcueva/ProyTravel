<%@page import="pe.gob.sunat.framework.spring.util.conversion.SojoUtil"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="mapaDatos" scope="request" class="java.util.HashMap" />
<%
	ArrayList listaCiudad = (ArrayList) mapaDatos.get("listCiudad");
	ArrayList listaPais = (ArrayList) mapaDatos.get("listPais");
%>
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
	
	var totalPasajeros = 0;
	
 	$(document).ready(function(){
  		
		$("#divTblTicketAereo").hide();
		$("#divTblPaqueteTuristico").hide();
		
		$("#divPenalidadPaquete").hide();
		$("#divPenalidadTicket").hide();
		
		console.log("Iniciando el sistema...");
		
		var tipoReserva = ${reservaBean.idTipoCotizacion};
		var lista = [];
		
		if ( tipoReserva == 1 ) {			
			lista = ${reservaBean.listaPaqueteTuristico};
			construirTablaListaPaqueteTuristico(lista);			
			$("#divTblPaqueteTuristico").show();
			$("#divTblTicketAereo").hide();
			$("#divPenalidadPaquete").show();
			$("#divPenalidadTicket").hide();
		} else {
			lista = ${reservaBean.listaTicketAereo}; 		
	 		construirTablaListaTicketAereo(lista);	 		
	 		$("#divTblPaqueteTuristico").hide();
			$("#divTblTicketAereo").show();
			$("#divPenalidadPaquete").hide();
			$("#divPenalidadTicket").show();
		} 
		
		 $('input[name="reservaPenalidad[]"]').change(function() {
		    	calcularPenalidad();     
		 });
		
 	});		
	
	function cargarConfirmacionRegistro(e){		
		e.preventDefault();			
		$('#mdlConfirmaRegistro').modal({
			backdrop: 'static',
			keyboard: false
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
	
	function construirTablaListaPaqueteTuristico(dataGrilla){
		
		var ix = 1;
		
		//Detalle de Ticket Aereo
		var table = $('#tblPaqueteTuristico').dataTable({
	        data: dataGrilla,
			bDestroy: true,
	        ordering: false,
	        searching: false,
	        paging: false,
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
	                $('#tblPaqueteTuristico_paginate').addClass('hiddenDiv');
	            } else {
	                $('#tblPaqueteTuristico_paginate').removeClass('hiddenDiv');
	            }
	        },
	        
	        fnRowCallback: function (nRow, aData, iDisplayIndex) {
				$(nRow).attr('align', 'center');
				$(nRow).attr('rowClasses','tableOddRow');
	            return nRow;
	        },
			language: {
	            url: "/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/plug-ins/1.10.7/i18n/Spanish.json"
			},
			columns: [			
				{"data": "numeroFila"},
				{"data": "ciudadDestinoPaquete"},
				{"data": "servicioTour"},
				{"data": "servicioHotel"},
				{"data": "servicioAerolinea"}
			]
	    });
		
	}
	
		
	function construirTablaListaTicketAereo(dataGrilla){		
		var ix = 1;		
		//Detalle de Ticket Aereo
		var table = $('#tblTicketAereo').dataTable({
	        data: dataGrilla,
			bDestroy: true,
	        ordering: false,
	        searching: false,
	        paging: false,
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
	                $('#tblTicketAereo_paginate').addClass('hiddenDiv');
	            } else {
	                $('#tblTicketAereo_paginate').removeClass('hiddenDiv');
	            }
	        },
	        
	        fnRowCallback: function (nRow, aData, iDisplayIndex) {
				$(nRow).attr('align', 'center');
				$(nRow).attr('rowClasses','tableOddRow');
	            return nRow;
	        },
			language: {
	            url: "/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/plug-ins/1.10.7/i18n/Spanish.json"
			},
			columns: [			
				{"data": "numeroFila", "class":"hidden"},
				{"data": "ciudadOrigen"},
				{"data": "ciudadDestino"},
				{"data": "tipoVuelo"},
				{"data": "fechaPartida"},
				{"data": "fechaRetorno"}
			]
	    });
		
	}
		
	function cerraVerDetalle(){
		$('#divVerDetalleControlAnimal').modal("hide");
	}	
	
	function validarNumero(e){
		var key = window.Event ? e.which : e.keyCode;
		return ( key >= 48 && key <= 57 );
 	}
	
	function validarLetra(e){
		var key = window.Event ? e.which : e.keyCode;
		return (key >= 97 && key <= 122) || (key >= 65 && key <= 90);
 	}
	
	function validarNumeroLetra(e){
		var key = window.Event ? e.which : e.keyCode;
		return (  (key >= 44 && key <= 46) || (key >= 48 && key <= 57) || (key==32 ) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) );
 	}
	
	function validarNumeroLetra2(e){
		var key = window.Event ? e.which : e.keyCode;
		return ( (key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) );
 	}
	
	function mostrarMensajeValidFormulario(mensaje){
		$("#divFormularioVacio").html(mensaje);
		$('#mdlValidaFormulario').modal({
			backdrop: 'static',
			keyboard: false
		});
	}
	
	
	function valid(e){		
		var idCotizacion = $("#txtIdCotizacion").val();		
		var comentario = $("#txtComentarioPasajero").val();
		var tiPenalidad = $( "input:checked" ).length;
		var tiMotivo = $("#selMotivoAnulacion").val();
		
		if(idCotizacion == ""){
			mostrarMensajeValidFormulario("Por favor verifique su reserva");
			return false;
		}
		
		if ( tiPenalidad <= 0 ) {
			mostrarMensajeValidFormulario("Seleccione las penalidades");
			return false;
		}
		
		if ( tiMotivo <= 0 ) {
			mostrarMensajeValidFormulario("Seleccione el motivo de la anulación de la reserva");
			return false;
		}
		
		if (comentario == "") {
			mostrarMensajeValidFormulario("Ingrese un comentario");
			return false;
		}
		
		cargarConfirmacionRegistro(e);		
	}
	
	function anularReserva() {
		
		console.log("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ");
		console.log("Anulacion de Reserva");
		
		var chkValReservaPenalidad = "";
		
		$('input[name="reservaPenalidad[]"]:checked').each(function() {
			chkValReservaPenalidad += $(this).val() + ",";
		});
		
		var grabarFormParams = {
				'reservaBean' : formToObject( '#frmReserva' ),
		};		
				
		var params = "?reservaPenalidad="+chkValReservaPenalidad;
		
		console.log( "GET params: " + params );
		
		$.ajax({            
			url: '${pageContext.request.contextPath}/admin/anularReserva'+params,
           	data: JSON.stringify(grabarFormParams),
            cache: false,
            async: true,
            type: 'POST',
            contentType : "application/json; charset=utf-8",
            dataType: 'json',
            success: function(response) {
				
            	var rpta = response.dataJson;
            	$("#txtNroReserva").text(rpta.idReserva);
            	
				$("#divRegistroOK").modal({
					backdrop: 'static',
					keyboard: false
				});
				
				return false;
                
            },
            error: function(data, textStatus, errorThrown) {
            	//alert(data);
            	//alert(textStatus);
            	//alert(errorThrown);
            }
        });
		
	}
	
	function aceptar() {
		location.href= '${pageContext.request.contextPath}/admin/listarReserva';
	}
	
	function calcularPenalidad() {		
		
		var precio = $("#txtPrecioCotizacion").val();
		var acumulador = 0;
		
		$('input[name="reservaPenalidad[]"]:checked').each(function() {
			var itemPenalidad = $(this).val();			
			var item = itemPenalidad.split("-");
			acumulador += parseFloat(item[1]);			
		});
		
		var penalidad = acumulador * precio;
		var strPenalidad = parseFloat(Math.round(penalidad * 100) / 100).toFixed(2);
		$("#txtPenalidadTotal").val(strPenalidad);		
		
	}
	
	
</script>

</head>

<body>


<div id="container" class="container" style="width: 100%">
	<div class="col-md-12" id="divConsForm" style="margin:0px 0px 0px 0px;">
		<div class="col-md-7">&nbsp;</div>
		<div class="col-md-3">
			<span style="color:#337ab7">Usuario: <%=session.getAttribute("codigoUsuario")%></span>
		</div>
		<div class="col-md-2">
			<a href="logout">Cerrar Sesion</a>
		</div>
	</div>
	<div class="row col-md-offset-0 col-md-12">
		<div class="principal">
			<div class="panel panel-primary">
								
				<div class="panel-heading" >
					<h3 class="panel-title" align="center" id="tituloReserva">${titulo}</h3>
				</div>
				
				<div class="panel-body">
					<div class="row">
						<div class="col-md-12">
				
							<form id="frmReserva" name="frmReserva" role="form" class="form-horizontal" method="post">
								
								<div class="form-group">
									<div class="col-md-3" style="text-align:right; font-weight:bold">Fecha:</div>
									<div class="col-md-3" id="divCodigoAnimal">${fechaAnularReserva} </div>									
									
								</div>		
								
								<div class="form-group">
									<div class="col-md-3" style="text-align:right; font-weight:bold">Nro. Reserva:</div>
									<div class="col-md-3" id="divNumeroCotizacion" >
										<input type="text" name="" id="txtNumeroReserva" class="form-control tamanoMaximo" value="${reservaBean.numeroReserva}" readonly />
									</div>
									<div class="col-md-2" style="text-align:right; font-weight:bold">Fecha Reserva:</div>
									<div class="col-md-3" id="divNumeroCotizacion" >
										<input type="text" name="" id="txtFechaReserva" class="form-control tamanoMaximo" value="${reservaBean.fechaReserva}" readonly />
									</div>			
									<div class="col-md-1">&nbsp;</div>
								</div>							
								
								<div class="form-group">	
															
									<div style="display:none">   
										<input type="text" name="idCotizacion" id="txtIdCotizacion" value="${reservaBean.idCotizacion}" />
										<input type="text" name="idReserva" id="txtIdReserva" value="${reservaBean.idReserva}" />
										<input type="text" name="idCliente" id="txtIdCliente" value="${reservaBean.idCliente}" />
										<input type="text" name="idTipoCotizacion" id="txtIdTipoCotizacion" value="${reservaBean.idTipoCotizacion}" />
									</div>
									
									<div class="col-md-3" style="text-align:right; font-weight:bold">Tipo Reserva:</div>
									<div class="col-md-3">
										<input type="text" name="tipoCotizacion" id="txtTipoCotizacion" class="form-control tamanoMaximo" value="${reservaBean.tipoCotizacion}" readonly="yes" />
									</div>
									<div class="col-md-2" style="text-align:right; font-weight:bold">Estado Reserva:</div>
									<div class="col-md-3" id="divNumeroCotizacion" >
										<input type="text" name="" id="txtEstadoReserva" class="form-control tamanoMaximo" value="${reservaBean.estadoReserva}" readonly />
									</div>
									<div class="col-md-1">&nbsp;</div>
								</div>
								
								<div class="form-group">
									<div class="col-md-3" style="text-align:right; font-weight:bold">Precio Reserva (USD):</div>
									<div class="col-md-3">
										<input type="text" name="precioCotizacion" id="txtPrecioCotizacion" class="form-control tamanoMaximo" value="${reservaBean.precioCotizacion}" readonly="yes" />
									</div>
									<div class="col-md-2" style="text-align:right; font-weight:bold">Num. Pasajeros:</div>
									<div class="col-md-3">
										<input type="text" name="numeroAdultos" id="txtNumeroAdultos" class="form-control tamanoMaximo"  value="${reservaBean.numeroPasajeros}" readonly="yes" />
									</div>
									<div class="col-md-1">&nbsp;</div>
								</div>
								
								<div class="form-group">
									<div class="col-md-3" style="text-align:right; font-weight:bold">Cliente:</div>
									<div class="col-md-3">
										<input type="text" name="nombreCliente" id="txtNombreCliente" class="form-control tamanoMaximo" value="${reservaBean.nombreCliente}" readonly="yes" />
									</div>									
									<div class="col-md-2" style="text-align:right; font-weight:bold">Numero Documento:</div>
									<div class="col-md-3">
										<input type="text" name="numeroDocumento" id="txtNumeroDocumento" class="form-control tamanoMaximo" value="${reservaBean.documentoCliente}" readonly="yes" />
									</div>
									<div class="col-md-1">&nbsp;</div>
								</div>
								
								<div class="form-group">
									<div class="col-md-3" style="text-align:right; font-weight:bold">Direccion Cliente:</div>
									<div class="col-md-3">
										<input type="text" name="direccionCliente" id="txtDireccionCliente" class="form-control tamanoMaximo" value="${reservaBean.direccionCliente}" readonly="yes" />
									</div>									
									<div class="col-md-2" style="text-align:right; font-weight:bold">Tel&eacute;fono Cliente:</div>
									<div class="col-md-3">
										<input type="text" name="telefonoCliente" id="txtTelefonoCliente" class="form-control tamanoMaximo" value="${reservaBean.telefonoCliente}" readonly="yes" />
									</div>
									<div class="col-md-1">&nbsp;</div>
								</div>
								
								<div class="form-group">
									<div class="col-md-12">&nbsp;</div>
									<div class="col-md-2">&nbsp;</div>
									<div class="col-md-8">
										<div id="divTblTicketAereo" style="display:none">
											<table id ="tblTicketAereo" class="table table-bordered responsive">
												<thead>
													<tr>
														<th width="5%" class="text-center">Orden</td>
														<th width="19%" class="text-center">Ciudad Origen</td>																										
														<th width="19%" class="text-center">Destino</td>
														<th width="19%" class="text-center">Tipo Vuelo</td>
														<th width="19%" class="text-center">Fecha Partida</td>
														<th width="19%" class="text-center">Fecha Retorno</td>
													</tr>
												</thead>
											</table>																			
										</div>
										<div id="divTblPaqueteTuristico" style="display:none">
											<table id ="tblPaqueteTuristico" class="table table-bordered responsive">
												<thead>
													<tr>
														<th width="5%" class="text-center">Orden</td>
														<th width="19%" class="text-center">Destino</td>																										
														<th width="19%" class="text-center">Servicio Tour</td>
														<th width="19%" class="text-center">Servicio Hotel</td>
														<th width="19%" class="text-center">Servicio Aerol&iacute;nea</td>
													</tr>
												</thead>
											</table>	
										</div>
									</div>
									<div class="col-md-2">&nbsp;</div>
									<div class="col-md-12">&nbsp;</div>		
								</div>
								
								<div class="form-group">
									<div class="col-md-3" style="text-align:right; font-weight:bold">Motivo de Anulaci&oacute;n (Cliente):</div>
									<div class="col-md-3" >
										<select name="motivoAnulacion" id="selMotivoAnulacion" class="form-control tamanoMaximo"> 
											<option value="0">---Seleccione---</option>
											<option value="1">Cliente no cumplió los requisitos a tiempo</option>
											<option value="2">Cliente Desistió</option>
										</select>
									</div>
									<div class="col-md-2" style="text-align:right; font-weight:bold">Penalidades:</div>
									<div class="col-md-4" >										
										<div id="divPenalidadTicket">
											<label style="width:auto; padding-right:80px;" for="selPenalidad1">
												<input type="checkbox" name="reservaPenalidad[]" id="selReservaPenalidad1" value="1-0.20" class="0.20" /> 
												 Penalidad por anulaci&oacute;n
											</label>
											<label style="width:auto; padding-right:80px;" for="selPenalidad2">
												<input type="checkbox" name="reservaPenalidad[]" id="selReservaPenalidad2" value="2-0.10" class="0.10" /> 
												 Penalidad de aerol&iacute;nea
											</label>
											<label style="width:auto; padding-right:80px;" for="selPenalidad3">
												<input type="checkbox" name="reservaPenalidad[]" id="selReservaPenalidad3" value="3-0.05" class="0.05" /> 
												 Gastos de aerol&iacute;nea
											</label>
											<label style="width:auto; padding-right:80px;" for="selPenalidad4">
												<input type="checkbox" name="reservaPenalidad[]" id="selReservaPenalidad4" value="4-0.05" class="0.05" /> 
												 Gastos consolidados
											</label>
											<label style="width:auto; padding-right:80px;" for="selPenalidad5">
												<input type="checkbox" name="reservaPenalidad[]" id="selReservaPenalidad5" value="5-0.05" class="0.05" /> 
												 Devoluci&oacute;n de comisi&oacute;n
											</label>
											<label style="width:auto; padding-right:80px;" for="selPenalidad6">
												<input type="checkbox" name="reservaPenalidad[]" id="selReservaPenalidad6" value="6-0.05" class="0.05" /> 
												 Gastos de gesti&oacute;n reembolso agencia
											</label>
										</div>										
										<div id="divPenalidadPaquete">
											<label style="width:auto; padding-right:80px;" for="selPenalidad6">
												<input type="checkbox" name="reservaPenalidad[]" id="selReservaPenalidad7" value="7-0.20" class="0.20" /> 
												 Penalidad por anulaci&oacute;n
											</label>
											<label style="width:auto; padding-right:80px;" for="selPenalidad6">
												<input type="checkbox" name="reservaPenalidad[]" id="selReservaPenalidad8" value="8-0.10" class="0.10" /> 
												 Gastos de proveedor
											</label>
											<label style="width:auto; padding-right:80px;" for="selPenalidad6">
												<input type="checkbox" name="reservaPenalidad[]" id="selReservaPenalidad9" value="9-0.05" class="0.05" /> 
												 Gastos de gesti&oacute;n reembolso agencia
											</label>
										</div>										
									</div>																					
								</div>
								
								<div class="form-group">
									<div class="col-md-3" style="text-align:right; font-weight:bold">Penalidades Calculadas:</div>
									<div class="col-md-3">
										<input type="text" name="penalidadTotal" id="txtPenalidadTotal" class="form-control tamanoMaximo" value="0.0" readonly="yes" />
									</div>									
									<div class="col-md-6">&nbsp;</div>
								</div>
								
								<div class="form-group">
									<div class="col-md-3" style="text-align:right; font-weight:bold">Comentario:</div>
									<div class="col-md-6" id="divCodigoAnimal" >										
										<textarea class="form-control" rows="5" name="comentarioReserva" id="txtComentarioPasajero"></textarea>
									</div>								
									<div class="col-md-3">&nbsp;</div>	
								</div>
								<div class="form-group">									
									<div class="col-md-12" style="text-align:center">										
										<input type="button" class="btn btn-primary" value="Anular Reserva"
											onclick="valid(event)"></input>
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

<div id="divRegistroInseminacion" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog">
		<div class="panel panel-primary">
			
		</div>
	</div>
</div>

	
<div id="mdlConfirmaRegistro" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Confirmaci&oacute;n Registro</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center">&iquest;Desea Grabar?</p></div>
				<div class="modal-footer">
					<div class="col-md-12" align="center">
						<input type="button" class="btn btn-primary" intermediateChanges="false" data-dismiss="" value="Si"
							onclick="anularReserva();" id="btnGrabaRegistro"></input>
						<button type="button" id="btnRegistroNo" class="btn btn-primary" data-dismiss="modal">No</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	
	
<div id="divRegistroOK" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Anulación Satisfactoria</strong></div>
			<div class="panel-body">
				<div class="modal-body">
													
					<div class="col-md-12" align="center">
						<p class="text-center" id="mensajeTransaccion">Se anulo la Reserva Nro <strong><span id="txtNroReserva"></span></strong></p>		
					</div>
					
				</div>
				<div class="row">&nbsp;</div>	
				<div class="modal-footer">
					<div class="col-md-12" align="center">
						<input type="button" id="btnRegistro" class="btn btn-primary" onclick="aceptar()" value="Aceptar"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="mdlEstadoCotizacion" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Mensaje:</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center" id="mensajeEstadoCotizacion"></p></div>
				<div class="modal-footer">
					<div class="col-md-12" align="center">
						<input type="button" class="btn btn-primary" intermediateChanges="false" data-dismiss="" value="Aceptar"
							onclick="$('#mdlEstadoCotizacion').modal('hide');" id="btnGrabaRegistro"></input>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="mdlValidacionTicket" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Mensaje:</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center" id="validacionTicketMsg"></p></div>
				<div class="modal-footer">
					<div class="col-md-12" align="center">
						<input type="button" class="btn btn-primary" intermediateChanges="false" data-dismiss="" value="Si"
							onclick="cerraInseminacion();" id="btnGrabaRegistro"></input>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<div id="divIngresarDatosPasajero" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>B&uacte;squeda Pasajero</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center" id="mensajeClienteError">Por favor ingresar los datos del pasajero</p></div>
				<div class="modal-footer">
					<div class="col-md-12" align="center">					
						<input type="button" id="btnRegistro" class="btn btn-primary" onclick="$('#divIngresarDatosPasajero').modal('hide');" value="Aceptar"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<div id="divBusquedaPasajero" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>B&uacte;squeda Pasajero</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center" id="mensajeClienteError">El pasajero no existe</p></div>
				<div class="modal-footer">
					<div class="col-md-12" align="center">					
						<input type="button" id="btnRegistro" class="btn btn-primary" onclick="$('#divBusquedaPasajero').modal('hide');" value="Aceptar"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="divMensajeErrorCliente" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Validaci&oacute;n</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center" id="mensajeClienteError"></p></div>
				<div class="modal-footer">
					<div class="col-md-12" align="center">					
						<input type="button" id="btnRegistro" class="btn btn-primary" onclick="$('#divMensajeErrorCliente').modal('hide');" value="Aceptar"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="divMensaje" class="modal fade" role="error">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Validaci&oacute;n</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center" id="mensajeError"></p></div>
				<div class="modal-footer">
					<div class="col-md-12" align="center">					
						<input type="button" id="btnRegistro" class="btn btn-primary" onclick="$('#divMensaje').modal('hide');" value="Aceptar"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<div id="mdlValidaFormulario" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Completar Formulario</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center" id="divFormularioVacio"></p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">					
						<input type="button" id="btnAutorizacion" class="btn btn-primary"  onclick="$('#mdlValidaFormulario').modal('hide');" value="Aceptar"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<input type="hidden" id="inpIdCotizacion" name="txIdCotizacion" />
<input type="hidden" id="inpNuCotizacion" name="txNuCotizacion" />


</body>

</html>
