<%@page import="pe.gob.sunat.framework.spring.util.conversion.SojoUtil"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="mapaDatos" scope="request" class="java.util.HashMap" />
<%
	ArrayList listaCiudad = (ArrayList) mapaDatos.get("listaCiudad");
	ArrayList listaPais = (ArrayList) mapaDatos.get("listaPais");
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">

    <script src="/a/resources/js/jquery/1.11.2/jquery.min.js"></script>
	<script src="/a/resources/js/jquery/1.11.2/jquery.maskMoney.js"></script>
	
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
	
	<script src="/a/resources/bootstrap/3.3.2/plugins/jquery.inputmask-3.1/dist/jquery.inputmask.bundle.js" type="text/javascript"></script>
	
	<script>
	
 	$(document).ready(function(){
 		inicia();
  		construirTablaDestino([]);
		
		// carga combo de paises origen ticket
		var jsonPaisTicket = <%=SojoUtil.toJson(listaPais)%>;
				
		document.getElementById("selIdDestinoPais").options[0] = new Option("---Seleccione Pais---");
		document.getElementById("selIdDestinoPais").options[0].value = "0";

		for (var i = 0; i < jsonPaisTicket.length; i++){
			document.getElementById("selIdDestinoPais").options[i+1] = new Option(jsonPaisTicket[i].nomPais);
			document.getElementById("selIdDestinoPais").options[i+1].value = jsonPaisTicket[i].idPais;
		}
		
		
		$("#chkFlagCantidadDias").change(function () {
			
			$("#txtNumeroDiasEstadia").val("");
			
			if ($("#chkFlagCantidadDias").is(":checked")) {
				$("#divNumeroDias").show();
			} else {
				$("#divNumeroDias").hide();
			}
			
		});
		
		$("#divFechaInicioDuracion").on("dp.change", function (e) {
			var fechaInicio = $("#txtFechaPartida").val();
			var fechasalida = $("#txtFechaPartida").val();
			var fechasalida =  sumarRestarFecha(90, fechasalida);
            $('#divFechaFinDuracion').data("DateTimePicker").setMaxDate(fechasalida);
			$('#divFechaFinDuracion').data("DateTimePicker").setMinDate(fechaInicio);
		});
		
		
		$("#selIdTipoPaqueteTuristico").on("change",function(){
			
			if($(this).val()==1){
				$("#selIdDestinoPais").empty().append('whatever');
				document.getElementById("selIdDestinoPais").options[0] = new Option("---Seleccione Pais---");
				document.getElementById("selIdDestinoPais").options[0].value = "";
				document.getElementById("selIdDestinoPais").options[1] = new Option("Peru");
				document.getElementById("selIdDestinoPais").options[1].value = "1";
				
				$("#selIdDestinoPais option[value=1]").attr("selected",true);
				$.ajax({
					url: '${pageContext.request.contextPath}/listarCiudad?idPais=1',
					cache: false,
					async: true,
					type: 'POST',
					contentType : "application/json; charset=utf-8",
					dataType: 'json',
					success: function(response) {
						
						var rpta = response.dataJson;
						
						// actualizando lista
						var listaCiudad = [];
						if (rpta.listaCiudad != null) {
							
							listaCiudad = rpta.listaCiudad;
							document.getElementById("selIdDestinoCiudad").options[0] = new Option("---Seleccione Ciudad---");
							document.getElementById("selIdDestinoCiudad").options[0].value = "";
							
							for (var i = 0; i < listaCiudad.length; i++) {
								document.getElementById("selIdDestinoCiudad").options[i+1] = new Option(listaCiudad[i].nomCiudad);
								document.getElementById("selIdDestinoCiudad").options[i+1].value = listaCiudad[i].idCiudad;
							};
						};
					},
					error: function(data, textStatus, errorThrown) { },
				});
				
			} else if($(this).val()==2){
				
				$("#selIdDestinoCiudad").empty().append('whatever');
				document.getElementById("selIdDestinoCiudad").options[0] = new Option("---Seleccione Ciudad---");
				document.getElementById("selIdDestinoCiudad").options[0].value = "";
				
				$.ajax({
					url: '${pageContext.request.contextPath}/listarPaisXTipoPaquete?idTipoPaquete=2',
					cache: false,
					async: true,
					type: 'POST',
					contentType : "application/json; charset=utf-8",
					dataType: 'json',
					success: function(response) {
						
						var rpta = response.dataJson;
						
						// actualizando lista
						var listaPais = [];
						if (rpta.listaPais != null) {
							
							listaPais = rpta.listaPais;
							document.getElementById("selIdDestinoPais").options[0] = new Option("---Seleccione Pais---");
							document.getElementById("selIdDestinoPais").options[0].value = "";
							
							for (var i = 0; i < listaPais.length; i++) {
								document.getElementById("selIdDestinoPais").options[i+1] = new Option(listaPais[i].nomPais);
								document.getElementById("selIdDestinoPais").options[i+1].value = listaPais[i].idPais;
							};
						};
					},
					error: function(data, textStatus, errorThrown) { },
				});
			
			} else {
				$("#selIdDestinoPais").empty().append('whatever');
				$("#selIdDestinoCiudad").empty().append('whatever');
				document.getElementById("selIdDestinoPais").options[0] = new Option("---Seleccione Pais---");
				document.getElementById("selIdDestinoPais").options[0].value = "";
				document.getElementById("selIdDestinoCiudad").options[0] = new Option("---Seleccione Ciudad---");
				document.getElementById("selIdDestinoCiudad").options[0].value = "";
			}
		});
		
		
		$("#selIdDestinoPais").on("change",function(){
						
			$("#selIdDestinoCiudad").empty().append('whatever');
			
			$.ajax({
				url: '${pageContext.request.contextPath}/listarCiudad?idPais='+$(this).val(),
				cache: false,
				async: true,
				type: 'POST',
				contentType : "application/json; charset=utf-8",
				dataType: 'json',
				success: function(response) {
					
					var rpta = response.dataJson;
					
					// actualizando lista
					var listaCiudad = [];
					if (rpta.listaCiudad != null) {
						
						listaCiudad = rpta.listaCiudad;
						document.getElementById("selIdDestinoCiudad").options[0] = new Option("---Seleccione Ciudad---");
						document.getElementById("selIdDestinoCiudad").options[0].value = "";
						
						for (var i = 0; i < listaCiudad.length; i++) {
							document.getElementById("selIdDestinoCiudad").options[i+1] = new Option(listaCiudad[i].nomCiudad);
							document.getElementById("selIdDestinoCiudad").options[i+1].value = listaCiudad[i].idCiudad;
						};
					};
				},
				error: function(data, textStatus, errorThrown) { },
			});
		});
 	});
	
	function sumarRestarFecha(d, fecha){
		var Fecha = new Date();
		var sFecha = fecha || (Fecha.getDate() + "/" + (Fecha.getMonth() +1) + "/" + Fecha.getFullYear());
		var sep = sFecha.indexOf('/') != -1 ? '/' : '-'; 
		var aFecha = sFecha.split(sep);
		var fecha = aFecha[2]+'/'+aFecha[1]+'/'+aFecha[0];
		fecha= new Date(fecha);
		fecha.setDate(fecha.getDate()+parseInt(d));
		var anno=fecha.getFullYear();
		var mes= fecha.getMonth()+1;
		var dia= fecha.getDate();
		mes = (mes < 10) ? ("0" + mes) : mes;
		dia = (dia < 10) ? ("0" + dia) : dia;
		var fechaFinal = dia+sep+mes+sep+anno;
		return (fechaFinal);
	}
	
 	function construirTablaDestino( dataGrilla ){
 		
		var table = $('#tblDestino').dataTable({
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
            pageLength: 20,
            responsive: true,
            bLengthChange: false,
			info: false,
			
            fnDrawCallback: function(oSettings) {
                if (oSettings.fnRecordsTotal() == 0) {
                    $('#tblDestino_paginate').addClass('hiddenDiv');
                } else {
                    $('#tblDestino_paginate').removeClass('hiddenDiv');
                }
            },
            
            fnRowCallback: function (nRow, aData, iDisplayIndex) {
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
	
	function makeInputMask( controlQuery, mask, maxlength, valorInicial ) {
    	var control = $( controlQuery );
    	control.inputmask( mask, {placeholder: ''});
		if ( maxlength != null ) {
			control.prop('maxlength', maxlength);
		}
		if ( valorInicial != null ) {
			control.val( valorInicial );
		}
    }
	
	function inicia(){
		
		var fechaActual = new Date();
		
		
		$("#divNumeroDias").hide();
		$('#divFechaInicioDuracion').datetimepicker({
			language : 'es',
            autoClose : true,
 			minDate: fechaActual,
            format: 'DD/MM/YYYY',
            pickTime: false,
			useCurrent: false
        });
		
		/*$('#divFechaInicioDuracion').on('dp.change dp.show', function(e) {
			var fechasalida = $("#txtFechaPartida").val();
			alert("fechasalida: " + fechasalida);
			 $("#id_deadline").datepicker({minDate: dateToday});
		});*/

		$('#divFechaFinDuracion').datetimepicker({
			language : 'es',
            autoClose : true,
 			maxDate: '01/01/2999',
			minDate: fechaActual,
            format: 'DD/MM/YYYY',
            pickTime: false,
			useCurrent: false
        });
		
	}
	
	function validarNumero(e){
		var key = window.Event ? e.which : e.keyCode;
		return ( key >= 48 && key <= 57 );
 	}
	
	function validarNumeroLetra(e){
		var key = window.Event ? e.which : e.keyCode;
		return (  (key >= 44 && key <= 46) || (key >= 48 && key <= 57) || (key==32 ) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) );
 	}
	
	
	function retornaDiferencia(e){
		e.preventDefault();
		
		var fInicio = $("#txtFechaPartida").val();
		var fFin = $("#txtFechaRetorno").val();
		
		fInicio = fInicio.substring(6) + "-" +  fInicio.substring(3,5) + "-"  +  fInicio.substring(0,2);
		fFin = fFin.substring(6) + "-" +  fFin.substring(3,5) + "-"  +  fFin.substring(0,2);
		
		var fechaInicio = new Date( fInicio ).getTime();
		var fechaFin = new Date( fFin ).getTime();
		
		var diferenciaDias = fechaFin - fechaInicio;
		
		var cantidadDias = diferenciaDias/(1000*60*60*24);
		
		return cantidadDias;
	}
	
	function mostrarMensajeValidFormulario(mensaje){
		$("#divFormularioVacio").html(mensaje);
		$('#mdlValidaFormulario').modal({
			backdrop: 'static',
			keyboard: false
		});
	}
	
	function valid(e){
		
		var numDias = $("#txtNumeroDiasEstadia").val();
		var fPartida = $("#txtFechaPartida").val();
		var fRetorno = $("#txtFechaRetorno").val();
		var idServicio = "";
		var comentario = $("#txtComentarioOrden").val();
		
		$(".chkServicio:checked").each(function() {
			idServicio += $(this).val();
        });
		
		if (($('#chkFlagCantidadDias').is(':checked')) && numDias == "" ){
			mostrarMensajeValidFormulario("Ingresar el n\u00FAmero de d\u00EDas");
			return false;
		}
		
		if (fPartida.length==0 || fRetorno.length==0) {
			mostrarMensajeValidFormulario("Ingresar las fechas de Partida y de Fecha Retorno");
			return false;
		}
		
		var difDias = retornaDiferencia(e) + "";
		if ( difDias.substring(0,1) == "-" ) {
			mostrarMensajeValidFormulario("La fecha retorno no puede ser mayor a la fecha de partida");
			return false;
		}
		
		if (idServicio.length==0) {
			mostrarMensajeValidFormulario("Seleccionar los servicios tur\u00EDsticos");
			return false;
		}
		
		if (comentario == "") {
			mostrarMensajeValidFormulario("Ingresar comentario");
			return false;
		}
		
		cargarConfirmacionRegistro(e);
		
		/*if (($('#chkFlagCantidadDias').is(':checked')) && numDias !="" ){
			var cantidadDiasFecha = retornaDiferencia(e);
			var txtNumeroDias = numDias;
			
			if (cantidadDiasFecha > txtNumeroDias){
				$('#mdlValidaCantidadDias').modal({
					backdrop: 'static',
					keyboard: false
				});
				
				return false;
			} else {
				cargarConfirmacionRegistro(e);
			}
		} else {
			cargarConfirmacionRegistro(e);
		}*/
		
	}
	
	function cargarConfirmacionRegistro(e){
		
		e.preventDefault();
		
		$('#mdlConfirmaRegistro').modal({
			backdrop: 'static',
			keyboard: false
		});
		/*if ( ! ($('#chkAutorizacion').is(':checked')) ){
			$("#divMensajeBusquedaAutomatica").modal({
				backdrop: 'static',
				keyboard: false,
			});
		} else {
			$('#mdlConfirmaRegistro').modal({
				backdrop: 'static',
				keyboard: false
			});
		}*/
	}
	
	var contador = 0;
	var arregloPaises = [];
	function agregarDestino(){
		var idCiudad = $("#selIdDestinoCiudad").val();
		var nombreCiudad = $("#selIdDestinoCiudad option:selected").text();
		
		if (arregloPaises.length > 0) {
			if ( arregloPaises.indexOf(idCiudad) >= 0){
				$("#mensajeError").html("La ciudad " + nombreCiudad + " ya fue registrada."); 
				
				$("#divMensaje").modal({
					backdrop: 'static',
					keyboard: false,
				});
				
				return false;
			}
		}
		
		var idFila = $("#selIdDestinoCiudad option:selected").val();
		var pais = $("#selIdDestinoPais option:selected").text();
		var ciudad = $("#selIdDestinoCiudad option:selected").text();
		
		contador += 1;
			
		var botonEliminar ="<button name='"+contador+"' id='"+contador+"'  type='button' class='btn btn-default' onclick='eliminarDestino(this.name,"+idCiudad+")'>";
			 botonEliminar +="<span class='glyphicon glyphicon-remove' aria-hidden='true'></span></button>";
 		
 		var data = [contador,pais,ciudad,botonEliminar,idFila];
		var row = $('#tblDestino').DataTable().row;
		
		row.add(data).draw( false );
		
		arregloPaises[contador] = "" +idCiudad;
	}
	
	function eliminarDestino(fila, idCiudad){
		
		var codigoCiudad = "" + idCiudad;
		var indice = arregloPaises.indexOf(codigoCiudad);
		arregloPaises.splice(indice, 1); 
		contador -= 1;
		var tabla = $('#tblDestino').DataTable();
		tabla.row('#'+fila).remove().draw( false );
	}
	
	
	function registrarOrden(){
		
		var e = document.createEvent('Event');
		
		var flagCantidadDias = 0;
		var numeroDias = 0;
		
		
		if ( $('#chkFlagCantidadDias').is(':checked') && ( $("#txtNumeroDiasEstadia").val() != "")){
			flagCantidadDias = 1;
			numeroDias = $("#txtNumeroDiasEstadia").val();
		} else {
			numeroDias = retornaDiferencia(e);
		}
		
		// Validando Busqueda automatica
		
		var dataJson = $("#tblDestino").DataTable().rows().data();
		
		var idDestino = "";		
		
		for (var i=0; i<dataJson.length; i++) {
			idDestino +=  dataJson[i][4] + ",";
		}
		
		var idServicio = ""
		$(".chkServicio:checked").each(function() {
			idServicio += $(this).val()+"_";
        });
		
		var idMotivo = ""
		$(".chkMotivo:checked").each(function() {
			idMotivo += $(this).val()+"_";
        });
		
		var grabarFormParams = {
			'ordenBean' : formToObject( '#frmOrden' ),
		};
		
		var params = "?idServicio="+idServicio+"&idMotivo="+idMotivo+"&idDestino="+idDestino+"&flagCantidadDias="+flagCantidadDias+"&numeroDias="+numeroDias;
		
		$.ajax({
			url: '${pageContext.request.contextPath}/grabarOrden'+params,
           	data: JSON.stringify(grabarFormParams),
            cache: false,
            async: true,
            type: 'POST',
            contentType : "application/json; charset=utf-8",
            dataType: 'json',
            success: function(response) {
            	
				$("#txtNroOrden").html("["+response.dataJson.numeroOrden+"]");
                
				$("#divRegistroOK").modal({
					backdrop: 'static',
					keyboard: false,
				});
				
				return false;
            },
            error: function(data, textStatus, errorThrown) {
            	
            },
        });
	}
	
	function aceptarAutorizacion(){
		
		$('#divMensajeBusquedaAutomatica').modal("hide");
		
		$("#mdlConfirmaRegistro").modal({
			backdrop: 'static',
			keyboard: false,
		});
		
	}
	
	function aceptar(){
		location.href = '${pageContext.request.contextPath}/cargarFormRegistrarOrden';
	}
	
	function formToObject(formID) {
	    var formularioObject = {};
	    var formularioArray = $( formID ).serializeArray();
	    $.each(formularioArray, function(i, v) {
	        formularioObject[v.name] = v.value;
	    });
	    return formularioObject;
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

	.alignDerecha{
		text-align:right;
	}
	.alignIzquierda{
		text-align:left !important;
	}
	.alignCentro{
		text-align:center;
	}
	
	.txtFecha{
		background-color: #FFF !important;
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
					<h3 class="panel-title" align="center" id="tituloOrden">${titulo}</h3>
				</div>
				
				<div class="panel-body">
					<div class="row">
						<div class="col-sm-12">
				
							<form id="frmOrden" name="frmOrden" role="form" class="form-horizontal" method="post">
								
								<div class="panel panel-primary">

									<div class="panel-heading">
										Datos de la orden
									</div>

									<div class="panel-body">
										<div class="form-group">
											<label class="col-md-3" style="text-align:right;">Fecha Orden:</label>
											<div class="col-md-3">${fechaOrden} </div>
											
											<label class="col-md-2 col-sm-offset-0 control-label alignDerecha">
													<input  type="checkbox" id="chkFlagCantidadDias"  name="flagCantidadDias">&nbsp;
											Num. D&iacute;as de Estad&iacute;a:</input>
											</label>
											
											<div class="col-md-3" id="divNumeroDias">
												<input id="txtNumeroDiasEstadia" name="numeroDiasEstadia" style="width:150px; height:29px" 
												 onkeypress="return validarNumero(event)" type="text" class="form-control tamanoMaximo" />
											</div>
										</div>		
										
										<div class="form-group">
											<label class="col-md-3 control-label alignDerecha">Fecha Partida:</label>
											<div class="col-md-3">
												<div class="input-group date tamanoMaximo" id="divFechaInicioDuracion">
													<input id="txtFechaPartida" name="fechaPartida" type="text" maxlength="30" readonly="yes" class="form-control txtFecha" />
													<span class="input-group-addon datepickerbutton hidden-xs-down">
														<span class="glyphicon glyphicon-calendar"></span>
													</span>
													<span class="input-group-addon hidden-xs-down" id="eliminarFecha">
														<span class="glyphicon glyphicon-remove"></span>
													</span>
												</div>
											</div>
											
											<label class="col-md-2 col-sm-offset-0 control-label alignDerecha" >Fecha Retorno:</label>
											<div class="col-md-3">
												<div class="input-group date tamanoMaximo" id="divFechaFinDuracion">
													<input id="txtFechaRetorno" name="fechaRetorno" type="text" maxlength="30" readonly="yes" class="form-control txtFecha" />
													<span class="input-group-addon datepickerbutton">
														<span class="glyphicon glyphicon-calendar"></span>
													</span>
													<span class="input-group-addon" id="eliminarFecha">
														<span class="glyphicon glyphicon-remove"></span>
													</span>
												</div>
											</div>
										</div>
											
										<div class="form-group">
											
											<div class="col-md-3 control-label" style="text-align:right; font-weight:bold">Tipo Paquete Tur&iacute;stico:</div>
											<div class="col-md-3">
												<select name="idTipoPaqueteTuristico" id="selIdTipoPaqueteTuristico" class="form-control tamanoMaximo"> 
													<option value="">---Seleccione Documento---</option>
													<option value="1">Nacional</option>
													<option value="2">Internacional</option>
												</select>
											</div>
											
											
											<label class="col-md-2 col-sm-offset-0 control-label alignDerecha" >Presupuesto:</label>
											<div class="col-md-3">
												<input type="text" name="presupuestoMaximo" id="txtPresupuestoMaximo" class="form-control tamanoMaximo" />
											</div>
										</div>
									
									</div>
									
								</div>
								
								
								<div class="panel panel-primary">

									<div class="panel-heading">
										Servicio Tur&iacute;stico
									</div>

									<div class="panel-body">
										<div class="form-group">
											
											<label for="chkServicio1" class="col-sm-2 col-sm-offset-2 control-label ">
												<input style="margin-left:-330px;" type="checkbox" id="chkServicio1" value="2" class="chkServicio" name="chkServicio">&nbsp;Ticket A&eacute;reo</input>
											</label>
											
											<label for="chkServicio2" class="col-sm-2 control-label ">
												<input style="margin-left:-330px;" type="checkbox" id="chkServicio2" value="3" class="chkServicio" name="chkServicio">&nbsp;Tour</input>
											</label>
											
											<label for="chkServicio3" class="col-sm-2 control-label ">
												<input style="margin-left:-330px;" type="checkbox" id="chkServicio3" value="6" class="chkServicio" name="chkServicio">&nbsp;Hotel</input>
											</label>
											
										</div>
									</div>
									
									
								</div>
								
								
								<div class="panel panel-primary">

									<div class="panel-heading">
										Motivo de viaje
									</div>

									<div class="panel-body">
										<div class="form-group">
													
											<label for="chkMotivo1" class="col-sm-2 col-sm-offset-1 control-label ">
												<input style="margin-left:-330px;" type="checkbox" id="chkMotivo1" value="1" class="chkMotivo" name="chkMotivo">&nbsp;Cultural</input>
											</label>
											
											<label for="chkMotivo2" class="col-sm-2 control-label ">
												<input style="margin-left:-330px;" type="checkbox" id="chkMotivo2" value="2" class="chkMotivo" name="chkMotivo">&nbsp;Deportes</input>
											</label>
											
											<label for="chkMotivo3" class="col-sm-2 control-label ">
												<input style="margin-left:-330px;" type="checkbox" id="chkMotivo3" value="3" class="chkMotivo" name="chkMotivo">&nbsp;Relajaci&oacute;n</input>
											</label>
											
											<label for="chkMotivo4" class="col-sm-2 control-label ">
												<input style="margin-left:-330px;" type="checkbox" id="chkMotivo4" value="4" class="chkMotivo" name="chkMotivo">&nbsp;Playa</input>
											</label>
											
										</div>
									
									</div>
									
								</div>
								
								<div class="panel panel-primary">
									<div class="panel-heading">
										Destinos
									</div>

									<div class="panel-body">
									
										<div class="form-group">
											<div class="col-sm-2" style="text-align:right; font-weight:bold">Pais Destino:</div>
											<div class="col-sm-3">
												<select name="idDestinoPais" id="selIdDestinoPais" class="form-control tamanoMaximo"> 
													<option value="">---Seleccione Pa&iacute;s---</option>
												</select>
											</div>
											
											<div class="col-sm-2" style="text-align:right; font-weight:bold">Ciudad Destino:</div>
											<div class="col-sm-3">
												<select name="idDestinoCiudad" id="selIdDestinoCiudad" class="form-control tamanoMaximo"> 
													<option value="">---Seleccione Ciudad---</option>
												</select>
											</div>
											
											<div class="col-sm-2">
												<button id="btnAgregar" type="button" class="btn btn-primary centro" onclick="agregarDestino()"
													title="Cerrar">Agregar Destino</button>
											</div>
										</div>
									
									
										<div class="form-group">
											<div class="col-sm-12">
												<table id ="tblDestino" class="table table-bordered responsive" style="width:100%">
													<thead>
														<tr>
															<th width="5%" class="text-center">Orden</td>
															<th width="15%" class="text-center">Pa&iacute;s</td>
															<th width="15%" class="text-center">Destino</td>
															<th width="15%" class="text-center">Opciones</td>
														</tr>
													</thead>
												</table>
											</div>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label alignDerecha">Comentario:</label>
									<div class="col-sm-9">
										<textarea class="form-control" rows="5" name="comentarioOrden" id="txtComentarioOrden" 
										onkeypress="return validarNumeroLetra(event)"></textarea>
									</div>
								</div>	
								
								<!--
								<div class="form-group">
									<label for="chkAutorizacion" class="col-sm-8 control-label ">
										<input style="margin-left:-330px;" type="checkbox" id="chkAutorizacion" name="autorizacion">&nbsp;
										B&uacute;squeda autom&aacute;tica de informaci&oacute;n:</input>
									</label>
								</div>-->
								
								<br />
								
								<div class="form-group">
									
									<div class="col-sm-12" style="text-align:center">
										<input type="button" class="btn btn-primary" value="Aceptar"
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
					<div class="col-sm-12" align="center">
						<input type="button" class="btn btn-primary" intermediateChanges="false" data-dismiss="" value="Si"
							onclick="registrarOrden();" id="btnGrabaRegistro"></input>
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
			<div class="panel-heading"> <strong>Registro Satisfactorio</strong></div>
			<div class="panel-body">
				<div class="modal-body">
													
					<div class="col-sm-12" align="center">
						<p class="text-center" id="mensajeTransaccion">Se registro la Orden Nro <strong><span id="txtNroOrden"></span></strong></p>		
					</div>
					
				</div>
				<div class="row">&nbsp;</div>	
				<div class="modal-footer">
					<div class="col-sm-12" align="center">
						<input type="button" id="btnRegistro" class="btn btn-primary" onclick="aceptar()" value="Aceptar"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="divMensajeBusquedaAutomatica" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>B&uacute;squeda Autom&aacute;tica</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center">La orden de planificaci&oacute;n se crear&aacute; sin opci&oacute;n a b&uacute;squeda autom&aacute;tica de informaci&oacute;n para el paquete tur&iacute;stico</p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">					
						<input type="button" id="btnAutorizacion" class="btn btn-primary" onclick="aceptarAutorizacion()" value="Aceptar"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="mdlValidaCantidadDias" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Validaci&oacute;n Cantidad D&iacute;as</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center">El rango de fechas seleccionada excede con el n&uacute;mero de d&iacute;as permitido de la estad&iacute;a</p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">					
						<input type="button" id="btnAutorizacion" class="btn btn-primary"  onclick="$('#mdlValidaCantidadDias').modal('hide');" value="Aceptar"/>
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

</body>

</html>
