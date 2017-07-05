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
	
	
	
	function validarNumeroLetra(e){
		/* var key = window.Event ? e.which : e.keyCode;
		return ( (key >= 48 && key <= 57) || (key==32 ) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) ); */
 	}
	
	function validarNumero(e){
		//var key = window.Event ? e.which : e.keyCode;
		//return ( key.which != 8 && key.which != 0 && (key.which < 48 || key.which > 57) );
		
	}
	
	function validarPrecio(e){
		//var key = window.Event ? e.which : e.keyCode;
		//return ( key.which != 46 && key.which != 8 && key.which != 0 && (key.which < 48 || key.which > 57) );
	}

 	$(document).ready(function(){
 		
 		inicia();
 		
  		construirTablaReserva([]);
 		
//  		$("#txtCantidadAdultos, #txtCantidadNinos, #txtCantidadNinosTicket, #txtCantidadAdultosTicket, #txtCantidadInfantesTicket").keypress(function(e){
// 			     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
// 			                return false;
// 			    }
// 		})
 		
//  		$("#txtPresupuestoMinimo, #txtPresupuestoMaximo").keypress(function(e) {
// 	            if (e.which != 46 && e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
// 	                		return false;
// 	            }
//     	});
 		
 		
//  		$('#selServicioAdicional6').change(function() { 
 			
//  			$('#hoteles-group').css("display", "none");  			
//  	        if($(this).is(":checked")) {
//  	        	$('#hoteles-group').css("display", "inline");
//  	        } 	               
 	        
//  	    });
 		
 	});
	
 	function construirTablaReserva( dataGrilla ){
 		
		var table = $('#tblPasajero').dataTable({
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
            pageLength: 10,
            responsive: true,
            bLengthChange: false,
			
            fnDrawCallback: function(oSettings) {
                if (oSettings.fnRecordsTotal() == 0) {
                    $('#tblPasajero_paginate').addClass('hiddenDiv');
                } else {
                    $('#tblPasajero_paginate').removeClass('hiddenDiv');
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
				{"class": ""},
				{"class": ""},
				{"class": "hidden"}

			]
        });
 	}
	
	function inicia(){
		
		$("#selTipoCotizacion").on("change", function(){
			
			if ($(this).val() == 1){
				$("#divPaqueteTuristico").css("display","inline");
				$("#divTicketAereo").css("display","none");
			}else if ($(this).val() == 2){
				$("#divPaqueteTuristico").css("display","none");
				$("#divTicketAereo").css("display","inline");
			}else{
				$("#divPaqueteTuristico").css("display","none");
				$("#divTicketAereo").css("display","none");
			}
		})
		
		$('#divFechaNacimiento').datetimepicker({
			language : 'es',
            autoClose : true,
 			minDate: '01/01/2000',
			
            format: 'DD/MM/YYYY',
            pickTime: false,
			useCurrent: false
        });
		
		
		/*
		
		// carga combo de paises origen ticket
		var jsonPaisTicket = <%=SojoUtil.toJson(listaPais)%>;
				
		document.getElementById("selPaisOrigenTicket").options[0] = new Option("---Seleccione Pais---");
		document.getElementById("selPaisOrigenTicket").options[0].value = "0";

		for (var i = 0; i < jsonPaisTicket.length; i++) {
			document.getElementById("selPaisOrigenTicket").options[i+1] = new Option(jsonPaisTicket[i].nomPais);
			document.getElementById("selPaisOrigenTicket").options[i+1].value = jsonPaisTicket[i].idPais;
		}			
		
		// carga combo de paises destino ticket
		document.getElementById("selPaisDestinoTicket").options[0] = new Option("---Seleccione Pais---");
		document.getElementById("selPaisDestinoTicket").options[0].value = "0";
		
		for (var i = 0; i < jsonPaisTicket.length; i++) {
			document.getElementById("selPaisDestinoTicket").options[i+1] = new Option(jsonPaisTicket[i].nomPais);
			document.getElementById("selPaisDestinoTicket").options[i+1].value = jsonPaisTicket[i].idPais;
		}		
		
		// carga combo de ciudades
		$("#selPaisOrigenTicket").on("change",function(){
						
			$("#selCiudadOrigenTicket").empty().append('whatever');
			
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
						document.getElementById("selCiudadOrigenTicket").options[0] = new Option("---Seleccione Ciudad---");
						document.getElementById("selCiudadOrigenTicket").options[0].value = "";
						
						for (var i = 0; i < listaCiudad.length; i++) {
							document.getElementById("selCiudadOrigenTicket").options[i+1] = new Option(listaCiudad[i].nomCiudad);
							document.getElementById("selCiudadOrigenTicket").options[i+1].value = listaCiudad[i].idCiudad;
						};
					};
					
					
				},
				error: function(data, textStatus, errorThrown) { },
			});
		});
		
		// carga combo de ciudades para paquete turisticos
		$("#selPaisOrigenPaquete").on("change",function(){			
			
			$("#selPaisDestino").empty().append('whatever');
			$("#selCiudadOrigenPaquete").empty().append('whatever');
			
			// carga combo de paises destino
			document.getElementById("selPaisDestino").options[0] = new Option("---Seleccione---");
			document.getElementById("selPaisDestino").options[0].value = "0";
			
			var namePaisOrigen = $("#selPaisOrigenPaquete option:selected").text();	
			
			console.log("namePaisOrigen: " + namePaisOrigen);
			
			var ipais = 1; //posicion 1 de la lista de paises, la posicion 0 corresponde al texto seleccione

			for (var i = 0; i < jsonPaisTicket.length; i++) {
				
				console.log("namePaisOrigen (Json): " + jsonPaisTicket[i].nomPais);
				
				if ( namePaisOrigen != jsonPaisTicket[i].nomPais ) {										
					
					document.getElementById("selPaisDestino").options[ipais] = new Option(jsonPaisTicket[i].nomPais);
					document.getElementById("selPaisDestino").options[ipais].value = jsonPaisTicket[i].idPais;
					
					ipais ++;
				
				}
			}						
			
			document.getElementById("selCiudadOrigenPaquete").options[0] = new Option("---Seleccione Ciudad---");
			document.getElementById("selCiudadOrigenPaquete").options[0].value = "";
			
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
						
						for (var i = 0; i < listaCiudad.length; i++) {
							document.getElementById("selCiudadOrigenPaquete").options[i+1] = new Option(listaCiudad[i].nomCiudad);
							document.getElementById("selCiudadOrigenPaquete").options[i+1].value = listaCiudad[i].idCiudad;
						}
						
					}
				},
				error: function(data, textStatus, errorThrown) {
				}
			});
		});
		
		$("#selPaisDestinoTicket").on("change",function(){
			
			$("#selCiudadDestinoTicket").empty().append('whatever');
			
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
						document.getElementById("selCiudadDestinoTicket").options[0] = new Option("---Seleccione Ciudad---");
						document.getElementById("selCiudadDestinoTicket").options[0].value = "0";
						for (var i = 0; i < listaCiudad.length; i++) {
							document.getElementById("selCiudadDestinoTicket").options[i+1] = new Option(listaCiudad[i].nomCiudad);
							document.getElementById("selCiudadDestinoTicket").options[i+1].value = listaCiudad[i].idCiudad;
						}
					}
				},
				error: function(data, textStatus, errorThrown) {
				}
			});
		});		
		
		
		$("#selTipoPrograma").on("change",function(){
			
			if ($(this).val() == 0){
				$("#divNacional").css("display","inline");
				$("#divInternacional").css("display","none");
				$("#selCiudadDestino").empty().append('whatever');
				
				document.getElementById("selCiudadDestino").options[0] = new Option("---Seleccione---");
				document.getElementById("selCiudadDestino").options[0].value = "0";
				
			} else if ($(this).val() == 1){
				
				$("#divNacional").css("display","inline");
				$("#divInternacional").css("display","none");
				
				var jsonCiudad = <%=SojoUtil.toJson(listaCiudad)%>;
				
				document.getElementById("selCiudadDestino").options[0] = new Option("---Seleccione---");
				document.getElementById("selCiudadDestino").options[0].value = "0";

				for (var i = 0; i < jsonCiudad.length; i++) {
					document.getElementById("selCiudadDestino").options[i+1] = new Option(jsonCiudad[i].nomCiudad);
					document.getElementById("selCiudadDestino").options[i+1].value = jsonCiudad[i].idCiudad;
				}
				
				$("#divNacionalOrigen").css("display","inline");
				$("#divInternacionalOrigen").css("display","none");
				$("#selCiudadOrigenPaquete").empty().append('whatever');								
				
				document.getElementById("selCiudadOrigenPaquete").options[0] = new Option("---Seleccione Ciudad---");
				document.getElementById("selCiudadOrigenPaquete").options[0].value = "0";

				for (var i = 0; i < jsonCiudad.length; i++) {
					document.getElementById("selCiudadOrigenPaquete").options[i+1] = new Option(jsonCiudad[i].nomCiudad);
					document.getElementById("selCiudadOrigenPaquete").options[i+1].value = jsonCiudad[i].idCiudad;
				}
				
				
				
				
			} else {
				
				$("#divInternacional").css("display","inline");
				$("#divNacional").css("display","none");
				var jsonPais = <%=SojoUtil.toJson(listaPais)%>;
				
				document.getElementById("selPaisDestino").options[0] = new Option("---Seleccione---");
				document.getElementById("selPaisDestino").options[0].value = "0";

				for (var i = 0; i < jsonPais.length; i++) {
					document.getElementById("selPaisDestino").options[i+1] = new Option(jsonPais[i].nomPais);
					document.getElementById("selPaisDestino").options[i+1].value = jsonPais[i].idPais;
				}
				
				// carga combo de paises origen para paquetes turisticos
				var jsonPais = <%=SojoUtil.toJson(listaPais)%>;
				$("#divNacionalOrigen").css("display","inline");
				$("#divInternacionalOrigen").css("display","inline");
				
				document.getElementById("selPaisOrigenPaquete").options[0] = new Option("---Seleccione---");
				document.getElementById("selPaisOrigenPaquete").options[0].value = "0";

				for (var i = 0; i < jsonPais.length; i++) {
					document.getElementById("selPaisOrigenPaquete").options[i+1] = new Option(jsonPais[i].nomPais);
					document.getElementById("selPaisOrigenPaquete").options[i+1].value = jsonPais[i].idPais;
				}	
				
			}
			
		})
		
		
		$("#selPaisDestino").on("change",function(){
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
						document.getElementById("selPaisCiudadDestino").options[0] = new Option("---Seleccione---");
						document.getElementById("selPaisCiudadDestino").options[0].value = "0";
						for (var i = 0; i < listaCiudad.length; i++) {
							document.getElementById("selPaisCiudadDestino").options[i+1] = new Option(listaCiudad[i].nomCiudad);
							document.getElementById("selPaisCiudadDestino").options[i+1].value = listaCiudad[i].idCiudad;
						}
					}
				},
				error: function(data, textStatus, errorThrown) {
				}
			});
		});
		
		
		    $("#divFechaPartida,#divFechaRetorno,#divFechaPartidaTicket,#divFechaRetornoTicket").datetimepicker({
		    	locale: "es",
		    	language: 'es',
		    	autoClose : true,
		    	format: 'DD/MM/YYYY',
		    	pickTime: false,		        
		        format: "L",
		        useCurrent: false,
		        showTodayButton: true,
		        showClear: true,
		        minDate: moment(),
		        icons: {
		            time: "fa fa-clock-o",
		            date: "fa fa-calendar",
		            up: "fa fa-arrow-up",
		            down: "fa fa-arrow-down",
		            previous: "fa fa-angle-left",
		            next: "fa fa-angle-right",
		            today: "fa fa-thumb-tack",
		            clear: "fa fa-trash"
		        }
		    });
		    
		    $("#divFechaPartida").on("dp.change", function (e) {
		        $("#divFechaRetorno").data("DateTimePicker").setMinDate(e.date);
		    	//$("#divFechaRetorno").datetimepicker( 'setStartDate', e.date );
		    });
		    
		    $("#divFechaRetorno").on("dp.change", function (e) {
		        $("#divFechaPartida").data("DateTimePicker").setMaxDate(e.date);
		        //$("#divFechaPartida").datetimepicker( 'setEndDate', e.date );
		    });
		    
		    $("#divFechaPartidaTicket").on("dp.change", function (e) {
		        $("#divFechaRetornoTicket").data("DateTimePicker").setMinDate(e.date);
		    	//$("#divFechaRetorno").datetimepicker( 'setStartDate', e.date );
		    });
		    
		    $("#divFechaPartidaTicket").on("dp.change", function (e) {
		        $("#divFechaPartida").data("DateTimePicker").setMaxDate(e.date);
		        //$("#divFechaPartida").datetimepicker( 'setEndDate', e.date );
		    });		    					
		
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
		});				
				
		$('#radTipoticket2').change(function() {
								
			$("#divFechaRegreso").css("display","inline");
			$("#txtFechaRetornoTicket").val("");
			
	        if($(this).is(":checked")) {	        	
	            console.log('checked');	            	            				
				$("#divFechaRegreso").css("display","none");				
	        }	               
	    });
		
		*/
	}		
	
	var contadorTipoHabitacion = 0;
	
	function agregarTipoHabitacion(){
		
		//() tblTipoHabitacion selTipoHabitacion txtCantidadHabitacion
		
		console.log("Agregar Tipo de Habitacion........... ");	
		
		console.log("1- validacion de los campos.............................: ");
		
		var msgHtml = '<strong>Por favor verifique la siguiente informaci�n:</strong><br /><br />\n\n';		
		var validationFail = false;
		
		var tipoHabitacion = $("#selTipoHabitacion option:selected").val();
		var cantidadHabitacion = isNaN(parseInt($("#txtCantidadHabitacion").val(), 10))?0:$("#txtCantidadHabitacion").val();
		
		if ( tipoHabitacion == 0 ) {			
			msgHtml += '- Seleccione el tipo de habitacion<br />\n';
			validationFail = true;
		}	
		
		if ( cantidadHabitacion <= 0 ) {			
			msgHtml += '- Ingrese la cantidad de habitaciones<br />\n';
			validationFail = true;
		};
		
		var cantidadAdultos = isNaN(parseInt($("#txtCantidadAdultos").val(), 10))?0:$("#txtCantidadAdultos").val();
		var cantidadNinos = isNaN(parseInt($("#txtCantidadNinos").val(), 10))?0:$("#txtCantidadNinos").val();
		
		console.log("primera validacion: " + parseInt(cantidadHabitacion,10) + " > " + parseInt(cantidadAdultos,10)+parseInt(cantidadNinos,10));
		
		if ( parseInt(cantidadHabitacion,10) > parseInt(cantidadAdultos,10)+parseInt(cantidadNinos,10) ){
			msgHtml += '- La cantidad de Habitaciones no coincide con la cantidad de personas<br />\n';
			validationFail = true;
		};
		
		if ( validationFail ) {
			
			console.log("mensaje validacion: " + msgHtml);					
			
			$("#mensajeClienteError").html(msgHtml);
			
			$('#divMensajeErrorCliente').modal({
				backdrop: 'static',
				keyboard: false,
			});
			
			return false;
			
        }
        
		console.log("2- agregando nueva fila.............................: ");	
		
		var dataJson = $("#tblTipoHabitacion").DataTable().rows().data();				
		
		if ( dataJson.length > 0 ) {
			
			var cantidadHabTabla = 0;
			
			for (var i=0; i<dataJson.length; i++) {
				
				console.log("destino[0]: " + dataJson[i][0]);//contador/ida fila
				console.log("destino[1]: " + dataJson[i][1]);//Cantidad y tipo Texto				
				console.log("destino[2]: " + dataJson[i][2]);//boton eliminar
				console.log("destino[4]: " + dataJson[i][4]);//parametros
				console.log("destino[3]: " + dataJson[i][3]);//cantidad
				cantidadHabTabla = parseInt(cantidadHabTabla,10) + parseInt(dataJson[i][3],10);//solo cantidad de habitaciones				
				
			}
			
			console.log("2-1 validacion cantidad: " + 
					parseInt(cantidadHabTabla,10)+parseInt(cantidadHabitacion,10) + " > " + parseInt(cantidadAdultos,10)+parseInt(cantidadNinos,10)
			);//cantidad
			
			if ( parseInt(cantidadHabTabla,10)+parseInt(cantidadHabitacion,10) > parseInt(cantidadAdultos,10)+parseInt(cantidadNinos,10) ){
				
				var mensaje = "La cantidad de Habitaciones no coincide con la cantidad de personas";
				
				console.log("mensaje cantidad de habitaciones: " + mensaje);					
				
				$("#mensajeClienteError").html(mensaje);
				
				$('#divMensajeErrorCliente').modal({
					backdrop: 'static',
					keyboard: false,
				});
				
				return false;
			};
		};
		
		contadorTipoHabitacion += 1;
		
		var tipoHabitacionVal = $("#selTipoHabitacion option:selected").text();
		
		//boton eliminar de la tabla
		var botonEliminar ="<button name='"+contadorTipoHabitacion+"' id='"+contadorTipoHabitacion+"'  type='button' class='btn btn-default' onclick='eliminarRegistroTabla(\"tblTipoHabitacion\",this.name)'>";
	 	botonEliminar +="<span class='glyphicon glyphicon-remove' aria-hidden='true'></span></button>";
	 	
	 	// parametros de la tabla a enviar al controlador
		var parametros = tipoHabitacion+"_"+cantidadHabitacion;
		
		// columnas de la tabla
 		var data = [contadorTipoHabitacion,cantidadHabitacion + " Hab. (" + tipoHabitacionVal + ")",botonEliminar,cantidadHabitacion,parametros];
 		
		// prepara y agrega nueva fila a la grilla
		var row = $('#tblTipoHabitacion').DataTable().row;
		row.add(data).draw( false );
		
	}
	
	var contadorPasajeros = 0;
	var contadorVuelo = 0;
	

	function eliminarRegistroTabla(tablaw, fila){
		var tabla = $('#'+tablaw).DataTable();
		tabla.row('#'+fila).remove().draw( false );
	}
	
	function limpiarFormularioInseminacion(){
		$('#formInseminacion').bootstrapValidator('resetForm', true);
		$("#selToro").val("");
		$("#txtFechaInseminacion").val("");
		$("#txtObservacion").val("");
	}
	
	function cargarConfirmacionRegistro(e){
		
		e.preventDefault();
			
		$('#mdlConfirmaRegistro').modal({
			backdrop: 'static',
			keyboard: false
		});
			
	}
	
	function registrarReserva(){
		
		var dataJson = $("#tblPasajero").DataTable().rows().data();
		
		var datosPasajeros = "";		
		
		for (var i=0; i<dataJson.length; i++) {
			datosPasajeros +=  dataJson[i][6] + ",";
		}
		
		console.log("Parametros datosPasajeros: " + datosPasajeros);
	
		var grabarFormParams = {
			'reservaBean' : formToObject( '#frmReserva' ),
		};

		var idCotizacion = $("#txtIdCotizacion").val();
		var idCliente = $("#txtIdCliente").val();
		var idTipoCotizacion = $("#txtIdCotizacion").val();
		var params = "?datosPasajeros="+datosPasajeros+"&idCotizacion="+idCotizacion+"&idCliente="+idCliente+"&idTipoCotizacion="+idTipoCotizacion;
		
		$("#txtNroCotizacion").html("");
		$("#inpNuCotizacion").val(0);
		$("#inpIdCotizacion").val(0);
				
		$("#mensajeDetalleTransaccion").html("");		
		$("#contenedorDetalleTransaccion").css("display", "none");
		
		$.ajax({
			url: '${pageContext.request.contextPath}/grabarReserva'+params,
           	data: JSON.stringify(grabarFormParams),
            cache: false,
            async: true,
            type: 'POST',
            contentType : "application/json; charset=utf-8",
            dataType: 'json',
            success: function(response) {
            	
				
            	console.log("response******************************");
            	console.log(response);
            	
            	console.log("Numero Reserva");
            	console.log(response.dataJson.numeroReserva);
            	
            	$("#txtNroReserva").html(response.dataJson.numeroReserva);
            	/*$("#inpIdCotizacion").val(response.dataJson.idCotizacion);
            	$("#inpNuCotizacion").val(response.dataJson.nroCotizacion);*/
            	
            	$("#contenedorDetalleTransaccion").css("display", "inline");
            	
            	//console.log(response.dataJson.listDestinosDetalle);
            	//console.log(response.dataJson.detalle);
            	
            	//Los detinos y sus caracteristicas solicitadas
            	//$("#mensajeDetalleTransaccion").html(response.dataJson.detalle);
                
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
	
	function buscarPasajero(){
		
		var numeroDocumento = $("#txtNumeroDocumentoPasajero").val();
		
		$.ajax({
			url: '${pageContext.request.contextPath}/buscarPasajero?numeroDocumento='+numeroDocumento,
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
            success: function(response) {
            	
				var rpta = response.dataJson;
				
				$("#txtNombresPasajero").val( "" );
				$("#txtApellidosPasajero").val( "" );
					
				if (rpta.resultado == 1) {
					$("#txtNombresPasajero").val( rpta.nombresPasajero );
					$("#txtApellidosPasajero").val( rpta.apellidosPasajero );
				} else {
					$("#divBusquedaPasajero").modal({
						backdrop: 'static',
						keyboard: false,
					});
				}
				
            },
            error: function(data, textStatus, errorThrown) {
            	
            },
        });
	
	}
	
	function buscarCotizacion(){
		var params = "";
		var nuCoti = $("#txtNumeroCotizacion").val();
		params = "?numeroCotizacion="+nuCoti;
		$.ajax({
			url: '${pageContext.request.contextPath}/obtenerCotizacion'+params,
           	//data: JSON.stringify(grabarFormParams),
            cache: false,
            async: true,
            type: 'POST',
            contentType : "application/json; charset=utf-8",
            dataType: 'json',
            success: function(response) {
                
				var rpta = response.dataJson;
				
				$("#txtNombreCliente").val("");
				$("#txtNumeroDocumento").val("");
				$("#txtDireccionCliente").val("");
				$("#txtTelefonoCliente").val("");
				$("#txtFechaCotizacion").val("");
				$("#txtTipoCotizacion").val("");
				$("#txtEstadoCotizacion").val("");
				$("#txtNumeroAdultos").val("");
				$("#txtNumeroNinos").val("");
				$("#txtPrecioCotizacion").val("");
				
				
				if (rpta.flagCotiEncontrada==1){
					
					$("#mensajeEstadoCotizacion").html("La cotizaci�n [" + rpta.numeroCotizacion+ "] no encuentra en estado APROBADO.");
					
					$("#mdlEstadoCotizacion").modal({
						backdrop: 'static',
						keyboard: false,
					});
					
					return false;
				}
				
				if (rpta.flagCotiEncontrada==2){
					
					$("#mensajeEstadoCotizacion").html("La cotizaci�n [" + rpta.numeroCotizacion+ "] no se encuentra registrada.");
					
					$("#mdlEstadoCotizacion").modal({
						backdrop: 'static',
						keyboard: false,
					});
					
					return false;
				}
									
								
				if (rpta.flagFechaValida==0){
				
					$("#mensajeEstadoCotizacion").html("La fecha cotizaci�n [" + rpta.numeroCotizacion+ "] no est� vigente.");
					
					$("#mdlEstadoCotizacion").modal({
						backdrop: 'static',
						keyboard: false,
					});
					
					return false;
					
				} else {
					if ( rpta.status == 1 ) {
					
						$("#txtNombreCliente").val(rpta.nombreCliente);
						$("#txtNumeroDocumento").val(rpta.documentoCliente);
						$("#txtDireccionCliente").val(rpta.direccionCliente);
						$("#txtTelefonoCliente").val(rpta.telefonoCliente);
						$("#txtFechaCotizacion").val(rpta.fechaCotizacion);
						$("#txtTipoCotizacion").val(rpta.tipoCotizacion);
						$("#txtEstadoCotizacion").val(rpta.estadoCotizacion);
						$("#txtNumeroAdultos").val(rpta.numeroAdultos);
						$("#txtNumeroNinos").val(rpta.numeroNinos);
						$("#txtPrecioCotizacion").val(rpta.precioCotizacion);
						
						$("#txtIdCotizacion").val(rpta.idCotizacion);
						$("#txtIdCliente").val(rpta.idCliente);
						$("#txtIdTipoCotizacion").val(rpta.idTipoCotizacion);
						
						if (rpta.idTipoCotizacion == 1) {
							var listaPaqueteTuristico = [];
							
							if (rpta.listaPaqueteTuristico != null) {
								listaPaqueteTuristico = rpta.listaPaqueteTuristico;
							}
							$("#divTblPaqueteTuristico").show();
							$("#divTblTicketAereo").hide();
							construirTablaListaPaqueteTuristico(listaPaqueteTuristico);
						} else {
							var listaTicketAereo = [];
							
							if (rpta.listaTicketAereo != null) {
								listaTicketAereo = rpta.listaTicketAereo;
							}
							$("#divTblPaqueteTuristico").hide();
							$("#divTblTicketAereo").show();
							construirTablaListaTicketAereo(listaTicketAereo);
						}
					}
				}
					

				
				
				
				return false;				
                
            },
            error: function(data, textStatus, errorThrown) {
            	
            }
        });
	}
	
	function aceptar(){
		location.href = '${pageContext.request.contextPath}/cargarFormRegistrarReserva';
	}	
	
	function formToObject(formID) {
	    var formularioObject = {};
	    var formularioArray = $( formID ).serializeArray();
	    $.each(formularioArray, function(i, v) {
	        formularioObject[v.name] = v.value;
	    });
	    return formularioObject;
	}
	
	function verDetalleVuelos() {
		console.log("cadenaVuelo? " + cadenaVuelo);
	}	
	
	var cadenaStringVuelo = "";
		
	
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
				{"data": "numeroFila"},
				{"data": "ciudadOrigen"},
				{"data": "ciudadDestino"},
				{"data": "tipoVuelo"},
				{"data": "fechaPartida"},
				{"data": "fechaRetorno"}
			]
	    });
		
	}
	
	
	function agregarPasajero(){
		
		contadorPasajeros += 1;
		var idTipoDocumento = $("#selTipoDocumento").val();
		var tipoDocumento = $("#selTipoDocumento option:selected").text();
		var numerodocPasajero = $("#txtNumeroDocumentoPasajero").val();
		var nombrecliente = $("#txtNombresPasajero").val();
		var apellidosPasajero = $("#txtApellidosPasajero").val();
		var fechaNacimiento = $("#txtFechaNacimiento").val();
		var idParentesco = $("#selParentesco").val();
		
		//if (idTipoDocumento = "" || numerodocPasajero = "" || nombrecliente = "" 
			//|| apellidosPasajero = "" || fechaNacimiento = "" || idParentesco = "") {
			
		if (idTipoDocumento == "" || numerodocPasajero == "" || nombrecliente == "" 
			|| apellidosPasajero == "" || fechaNacimiento == "" || idParentesco == ""
			){
				
			$("#divIngresarDatosPasajero").modal({
				backdrop: 'static',
				keyboard: false,
			});
			
			return false;
		}
			
		
		
		var parentesco = $("#selParentesco option:selected").text();
		var botonEliminar ="<button name='"+contadorPasajeros+"' id='"+contadorPasajeros+"'  type='button' class='btn btn-default' onclick='eliminarRegistroTabla(\"tblPasajero\",this.name)'>";
			 botonEliminar +="<span class='glyphicon glyphicon-remove' aria-hidden='true'></span></button>";
 		
		var campo1 = nombrecliente + " " + apellidosPasajero;
		var campo2 = tipoDocumento + " - " + numerodocPasajero;
		var params = idTipoDocumento + "_" + numerodocPasajero + "_" + nombrecliente + "_" + apellidosPasajero
					 + "_" + fechaNacimiento + "_" + idParentesco;
 		var data = [contadorPasajeros, campo1, campo2, fechaNacimiento, parentesco, botonEliminar, params];
 		var row = $('#tblPasajero').DataTable().row;
		
		row.add(data).draw( false );		
				
	}
			
	function construirTablaDetalleVuelo(dataGrilla){
		
		var ix = 1;
		
		//Detalle de Vuelos 		 		
			
			var table = $('#tblDetalleVuelos').dataTable({
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
	                $('#tblDetalleVuelos_paginate').addClass('hiddenDiv');
	            } else {
	                $('#tblDetalleVuelos_paginate').removeClass('hiddenDiv');
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
			columnDefs: [{
				targets: 4,
				render: function(data, type, row){
					if (row !=null && typeof row != 'undefined') {
						
						var cadenaProvee = ix + "-" +row.idProveedor + "-" + row.idAerolinea ;					
						var VerDetalle = "<span> <input type='radio' name='selectConsolidador' id='' value='"+ cadenaProvee +"' /> </span>";
						ix += 1;
						
						return VerDetalle;
					}
					return '';
				}
			}],
			columns: [			
				{"data": "airlineCode"},
				{"data": "fare"},
				{"data": "nombreProveedor"},
				{"data": "comision"}			
			]
	    });
		
	}	
		
	function cerraVerDetalle(){
		$('#divVerDetalleControlAnimal').modal("hide");
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
					<h3 class="panel-title" align="center" id="tituloReserva">${titulo}</h3>
				</div>
				
				<div class="panel-body">
					<div class="row">
						<div class="col-sm-12">
				
							<form id="frmReserva" name="frmReserva" role="form" class="form-horizontal" method="post">
								
								<div class="form-group">
									<div class="col-sm-3" style="text-align:right; font-weight:bold">Fecha Reserva:</div>
									<div class="col-sm-3" id="divCodigoAnimal" >${fechaReserva}
									<span style="display:none">
										<input type="text" name="fechaCotizacion" id="fechaCotizacion" value="" />
									</span>
									</div>									
									
								</div>		
								
								<div class="form-group">
									<div class="col-sm-3" style="text-align:right; font-weight:bold">Nro. Cotizaci&oacute;n:</div>
									<div class="col-sm-3" id="divNumeroCotizacion" >
										<input type="text" name="numeroCotizacion" id="txtNumeroCotizacion" class="form-control tamanoMaximo" value="" />
									</div>
									<div class="col-sm-6">
										<button id="btnCerrar" type="button" class="btn btn-primary centro" onclick="buscarCotizacion()"
											title="Cerrar">Buscar</button>
									</div>
								</div>							
								
								<div class="form-group">
								
									<div style="display:none">
										<input type="text" name="idCotizacion" id="txtIdCotizacion" />
										<input type="text" name="idCliente" id="txtIdCliente" />
										<input type="text" name="idTipoCotizacion" id="txtIdTipoCotizacion" />
									</div>
								
									<div class="col-sm-3" style="text-align:right; font-weight:bold">Fecha Cotizaci&oacute;n:</div>
									<div class="col-sm-3">
										<input type="text" name="fechaCotizacion" id="txtFechaCotizacion" class="form-control tamanoMaximo" readonly="yes" />
									</div>
									
									<div class="col-sm-3" style="text-align:right; font-weight:bold">Tipo Cotizaci&oacute;n:</div>
									<div class="col-sm-3">
										<input type="text" name="tipoCotizacion" id="txtTipoCotizacion" class="form-control tamanoMaximo" readonly="yes" />
									</div>
								</div>
								
								<div class="form-group">
									<div class="col-sm-3" style="text-align:right; font-weight:bold">Cliente:</div>
									<div class="col-sm-3">
										<input type="text" name="nombreCliente" id="txtNombreCliente" class="form-control tamanoMaximo" readonly="yes" />
									</div>
									
									<div class="col-sm-3" style="text-align:right; font-weight:bold">Numero Documento:</div>
									<div class="col-sm-3">
										<input type="text" name="numeroDocumento" id="txtNumeroDocumento" class="form-control tamanoMaximo" readonly="yes" />
									</div>
								</div>
								
								<div class="form-group">
									<div class="col-sm-3" style="text-align:right; font-weight:bold">Direccion Cliente:</div>
									<div class="col-sm-3">
										<input type="text" name="direccionCliente" id="txtDireccionCliente" class="form-control tamanoMaximo" readonly="yes" />
									</div>
									
									<div class="col-sm-3" style="text-align:right; font-weight:bold">Tel&eacute;fono Cliente:</div>
									<div class="col-sm-3">
										<input type="text" name="telefonoCliente" id="txtTelefonoCliente" class="form-control tamanoMaximo" readonly="yes" />
									</div>
								</div>
								
								<div class="form-group">
									<div class="col-sm-3" style="text-align:right; font-weight:bold">Estado Cotizaci&oacute;n:</div>
									<div class="col-sm-3">
										<input type="text" name="estadoCotizacion" id="txtEstadoCotizacion" class="form-control tamanoMaximo" readonly="yes" />
									</div>
									
									<div class="col-sm-3" style="text-align:right; font-weight:bold">Precio Cotizaci&oacute;n:</div>
									<div class="col-sm-3">
										<input type="text" name="precioCotizacion" id="txtPrecioCotizacion" class="form-control tamanoMaximo" readonly="yes" />
									</div>
								</div>
									
								<div class="form-group">
									<div class="col-sm-3" style="text-align:right; font-weight:bold">Num. Adultos:</div>
									<div class="col-sm-3">
										<input type="text" name="numeroAdultos" id="txtNumeroAdultos" class="form-control tamanoMaximo" readonly="yes" />
									</div>
									<div class="col-sm-3" style="text-align:right; font-weight:bold">Num. Ninos:</div>
									<div class="col-sm-3">
										<input type="text" name="numeroNinos" id="txtNumeroNinos" class="form-control tamanoMaximo" readonly="yes" />
									</div>
								</div>
								
								<div class="form-group">
									<div class="col-sm-12">
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
								</div>
								
								<div class="panel panel-primary">

									<div class="panel-heading">
										Datos del pasajero
									</div>

									<div class="panel-body">
									
										<div class="form-group">
											<div class="col-sm-3" style="text-align:right; font-weight:bold">Tipo Documento:</div>
											<div class="col-sm-3">
												<select name="tipoDocumento" id="selTipoDocumento" class="form-control tamanoMaximo"> 
													<option value="">---Seleccione Documento---</option>
													<option value="1">DNI</option>
													<option value="2">Pasaporte</option>
													<option value="3">Carnet de Extranjer&iacute;a</option>
												</select>
											</div>
											
											<div class="col-sm-2" style="text-align:right; font-weight:bold">N&uacute;mero Documento:</div>
											<div class="col-sm-2">
												<input type="text" name="numeroDocumento" id="txtNumeroDocumentoPasajero" class="form-control tamanoMaximo" />
											</div>
											
											<div class="col-sm-2" style="text-align:right; font-weight:bold">
												<button id="btnCerrar" type="button" class="btn btn-primary centro" onclick="buscarPasajero()"
												title="Cerrar">Buscar Pasajero</button>
											</div>
										</div>
										
										<div class="form-group">
											<div class="col-sm-3" style="text-align:right; font-weight:bold">Nombres:</div>
											<div class="col-sm-3">
												<input type="text" name="nombresPasajero" id="txtNombresPasajero" class="form-control tamanoMaximo"  />
											</div>
											
											<div class="col-sm-3" style="text-align:right; font-weight:bold">Apellidos:</div>
											<div class="col-sm-3">
												<input type="text" name="apellidosPasajero" id="txtApellidosPasajero" class="form-control tamanoMaximo"  />
											</div>
										</div>
										
										<div class="form-group">
											<div class="col-sm-3" style="text-align:right; font-weight:bold">Fecha de Nacimiento:</div>
											<div class="col-sm-3">
												<div class="input-group date tamanoMaximo" id="divFechaNacimiento">
													<input id="txtFechaNacimiento" name="fechaNacimiento" type="text" maxlength="30" readonly="yes" class="form-control txtFecha" />
													<span class="input-group-addon datepickerbutton">
														<span class="glyphicon glyphicon-calendar"></span>
													</span>
													<span class="input-group-addon" id="eliminarFecha">
														<span class="glyphicon glyphicon-remove"></span>
													</span>
												</div>
											</div>
											
											<div class="col-sm-3" style="text-align:right; font-weight:bold">Parantesco:</div>
											<div class="col-sm-3">
												<select name="parentesco" id="selParentesco" class="form-control tamanoMaximo"> 
													<option value="">---Seleccione Parentesco---</option>
													<option value="1">Hijo</option>
													<option value="2">Padre</option>
													<option value="3">Madre</option>
													<option value="4">Hermanoo</option>
													<option value="5">Abuelo</option>
													<option value="6">Primo</option>
													<option value="7">T&iacute;o</option>
												</select>
											</div>
										</div>
										
										<div class="form-group">
											<div class="col-sm-6">
												<button id="btnAgregar" type="button" class="btn btn-primary centro" onclick="agregarPasajero()"
													title="Cerrar">AgregarPasajero</button>
											</div>
										</div>	
									
										<div class="form-group">
											<div class="col-sm-12">
												 <table id="tblPasajero" class="table display" style="width: 100%;">
													<thead>
														<tr>
															<th class="text-center">Orden</th>
															<th class="text-center">Nombre Pasajero</th>
															<th class="text-center">Tipo/Nro. Documento</th>
															<th class="text-center">Fecha Nacimiento</th>
															<th class="text-center">Parentesco</th>
															<th class="text-center">Opciones</th>
														</tr>
													</thead>
												</table>
											</div>
										</div>
									</div>
								</div>
								
								
								<div class="form-group">
									<div class="col-sm-3" style="text-align:right; font-weight:bold">Comentario:</div>
									<div class="col-sm-3" id="divCodigoAnimal" >
										<textarea rows="4" cols="120" name="comentarioReserva" id="txtComentarioPasajero" >
										</textarea>
									</div>									
									
								</div>	
								
								<div class="form-group">
									
									<div class="col-sm-12">
										
										<button id="btnRegistrar" class="btn btn-primary" onclick="cargarConfirmacionRegistro(event)"
											title="Continuar">Grabar Reserva</button>
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
							onclick="registrarReserva();" id="btnGrabaRegistro"></input>
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
						<p class="text-center" id="mensajeTransaccion">Se registro la Reserva Nro <strong><span id="txtNroReserva"></span></strong></p>		
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

<div id="mdlEstadoCotizacion" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Mensaje:</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center" id="mensajeEstadoCotizacion"></p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">
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
					<div class="col-sm-12" align="center">
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
					<div class="col-sm-12" align="center">					
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
					<div class="col-sm-12" align="center">					
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
					<div class="col-sm-12" align="center">					
						<input type="button" id="btnRegistro" class="btn btn-primary" onclick="$('#divMensajeErrorCliente').modal('hide');" value="Aceptar"/>
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