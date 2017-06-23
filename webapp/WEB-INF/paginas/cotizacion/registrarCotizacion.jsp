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
 		
 		construirTablaCotizacion([]);
 		
 		$("#txtCantidadAdultos, #txtCantidadNinos, #txtCantidadNinosTicket, #txtCantidadAdultosTicket, #txtCantidadInfantesTicket").keypress(function(e){
			     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
			                return false;
			    }
		})
 		
 		$("#txtPresupuestoMinimo, #txtPresupuestoMaximo").keypress(function(e) {
	            if (e.which != 46 && e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	                		return false;
	            }
	            
	            /* var RE = /^[0-9]+([,\.][0-9]*)?$/;
	 			
	 		    if ( !RE.test($(this).val()) ) {
	 		    	return false;
	 		    }; */
	 		    
    	});
 		
 		
 		$('#selServicioAdicional6').change(function() { 
 			
 			$('#hoteles-group').css("display", "none");  			
 	        if($(this).is(":checked")) {
 	        	$('#hoteles-group').css("display", "inline");
 	        } 	               
 	        
 	    });
 		
 	});
	
 	function construirTablaCotizacion( dataGrilla ){
 		
 		
 		
 		$('#tblTipoHabitacion').dataTable({
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
                    $('#tblTipoHabitacion_paginate').addClass('hiddenDiv');
                } else {
                    $('#tblTipoHabitacion_paginate').removeClass('hiddenDiv');
                }
            },
            
            fnRowCallback: function (nRow, aData, iDisplayIndex) {
				//alert(aData[0]);
				
				console.log("- - - - - - - - - - - - - -- ");
				console.log("Contador de filas tblTipoHabitacion: " + aData[0]);
				
				$(nRow).attr('id', aData[0]);
				$(nRow).attr('align', 'center');
				$(nRow).attr('rowClasses','tableOddRow');
                return nRow;
            },
			language: {
                url: "/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/plug-ins/1.10.7/i18n/Spanish.json"
			},
			columns: [
				{"class": "hidden"},	            
				{"class": ""},						
	            {"class": "botones"},
	            {"class": "hidden"},
	            {"class": "hidden"}
			],
        });
		
 		
		var table = $('#tblDestino').dataTable({
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
                    $('#tblDestino_paginate').addClass('hiddenDiv');
                } else {
                    $('#tblDestino_paginate').removeClass('hiddenDiv');
                }
            },
            
            fnRowCallback: function (nRow, aData, iDisplayIndex) {
				//alert(aData[0]);
				
				console.log("- - - - - - - - - - - - - -- ");
				console.log("Contador de filas: " + aData[0]);
				
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
		
		
 		var table = $('#tblVuelos').dataTable({
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
                    $('#tblVuelos_paginate').addClass('hiddenDiv');
                } else {
                    $('#tblVuelos_paginate').removeClass('hiddenDiv');
                }
            },
            
            fnRowCallback: function (nRow, aData, iDisplayIndex) {
				//alert(aData[0]);
				$(nRow).attr('id', aData[0]);
				$(nRow).attr('align', 'center');
				$(nRow).attr('rowClasses','tableOddRow');
                return nRow;
            },
			language: {
                url: "/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/plug-ins/1.10.7/i18n/Spanish.json"
			},
			columns: [
				{"class": "hidden"},
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
		
		
	}		
	
	var contadorTipoHabitacion = 0;
	
	function agregarTipoHabitacion(){
		
		//() tblTipoHabitacion selTipoHabitacion txtCantidadHabitacion
		
		console.log("Agregar Tipo de Habitacion........... ");	
		
		console.log("1- validacion de los campos.............................: ");
		
		var msgHtml = '<strong>Por favor verifique la siguiente información:</strong><br /><br />\n\n';		
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
	
	
	
	
	var contadorDestinos = 0;
	
	function agregarDestino(){
		
		console.log("Agregar Destinos........... ");	
		
		console.log("1- validacion de los campos.............................: ");
		
		var msgHtml = '<strong>Por favor verifique la siguiente información:</strong><br /><br />\n\n';
		var validationFail = false;
				
		var tipoPrograma = $("#selTipoPrograma option:selected").val();
		
		if ( tipoPrograma == 0 ) {			
			msgHtml += '- Seleccione el tipo de programa para filtrar los destinos<br />\n';
			validationFail = true;
		}		 		
		
		 var ciudadOrigenVal = $("#selCiudadOrigenPaquete option:selected").val();
		var ciudadDestinoVal = $("#selPaisCiudadDestino option:selected").val();		
		var ciudadDestinoNacVal = $("#selCiudadDestino option:selected").val();
		
		if (ciudadOrigenVal == 0) {        	        	
     		msgHtml += '- Seleccione la ciudad de origen<br />\n';
     		validationFail = true;
      	}
		
		if ( tipoPrograma == 1 ) {
			//Programa Nacional		
			
			if (ciudadDestinoNacVal == 0) {        	        	
	    		msgHtml += '- Seleccione la ciudad nacional de destino<br />\n';
	    		validationFail = true;        	
	      	};
			
		} else if ( tipoPrograma == 2 ) {
			//Programa Internacional
						
			if (ciudadDestinoVal == 0) {        	        	
	    		msgHtml += '- Seleccione la ciudad de destino<br />\n';
	    		validationFail = true;        	
	      	};
			
		}
		
		var fPartida = $("#txtFechaPartida").val();		
		var fRetorno = $("#txtFechaRetorno").val();
		
		
		if ( fPartida == '' ) {
			msgHtml += '- Seleccione la fecha de partida<br />\n';
			validationFail = true;
    	};
    	
    	if ( fRetorno == '' ) {
			msgHtml += '- Seleccione la fecha de retorno<br />\n';
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
		
		
		
		
		
		
		
		
		var tipoPrograma = $("#selTipoPrograma").val();
		var pais = "";
		var ciudad = "";		
		
		var dataJson = $("#tblDestino").DataTable().rows().data();					
		
		
		
		if ( dataJson.length > 0 ) {
			
			var ciudadSeleccionada = ciudad = $("#selCiudadDestino option:selected").text();
		
			for (var i=0; i<dataJson.length; i++) {
								
				console.log("destino[0]: " + dataJson[i][0]);//contador
				console.log("destino[1]: " + dataJson[i][1]);//pais
				console.log("destino[2]: " + dataJson[i][2]);//ciudad
				console.log("destino[3]: " + dataJson[i][3]);//boton eliminar
				console.log("destino[4]: " + dataJson[i][4]);//id de fila
				
				if ( ciudadSeleccionada == dataJson[i][2] ){
					
					var mensaje = "La ciudad ya fue agregada, seleccione otra";
					
					console.log("mensaje ciudad: " + mensaje);					
					
					$("#mensajeClienteError").html(mensaje);
					
					$('#divMensajeErrorCliente').modal({
						backdrop: 'static',
						keyboard: false,
					});
					
					return false;
				}
				
			}
		
		}
		
		if (tipoPrograma == 1) {
			parametros = "1_"+$("#selCiudadDestino option:selected").val();
			pais = "Peru";
			ciudad = $("#selCiudadDestino option:selected").text();
		} else if (tipoPrograma == 2) {
			parametros = $("#selPaisDestino option:selected").val()+"_"+$("#selPaisCiudadDestino option:selected").val();
			pais = $("#selPaisDestino option:selected").text();
			ciudad = $("#selPaisCiudadDestino option:selected").text();
		}
		
		contadorDestinos += 1;
			
		var botonEliminar ="<button name='"+contadorDestinos+"' id='"+contadorDestinos+"'  type='button' class='btn btn-default' onclick='eliminarRegistroTabla(\"tblDestino\",this.name)'>";
			 botonEliminar +="<span class='glyphicon glyphicon-remove' aria-hidden='true'></span></button>";
 		
		// columnas de la tabla destino
 		var data = [contadorDestinos,pais,ciudad,botonEliminar,parametros];
 		
		// prepara y agrega nueva fila a la grilla
		var row = $('#tblDestino').DataTable().row;		
		row.add(data).draw( false );
		
	}
	
	function preAgregarFilaTicket(){
		$('#mdlConfirmaRegistroTicket').modal({
			backdrop: 'static',
			keyboard: false
		});
		//validacionTicketMsg mdlValidacionTicket	
	}
	
	var contadorVuelo = 0;
	
	function agregarFilaTicket(){
		
		console.log("agregarFilaTicket.............................: ");		
		
		console.log("1- validacion de los campos.............................: ");
		
		var isSoloIda = false;
		var txtOpcion = 'Ida y Vuelta';
		
		var fPartidaTicket = $("#txtFechaPartidaTicket").val();
		var fRetornoTicket = $("#txtFechaRetornoTicket").val();
		
		var msgHtml = '<strong>Por favor verifique la siguiente información:</strong><br /><br />\n\n';
		var validation = false;
		
		if ( fPartidaTicket == '' ) {
			msgHtml += '- Seleccione la fecha de partida<br />\n';
			validation = true;
    	};
		
        if($("#radTipoticket2").is(":checked")) {
        	isSoloIda = true;
        	txtOpcion = 'Sólo ida';
        	fRetornoTicket = '-';
        }
        
        if (!isSoloIda) {        	
        	if ( fRetornoTicket == '' ) {
        		msgHtml += '- Seleccione la fecha de retorno<br />\n';
        		validation = true;
        	};        	
        }
        
        var ciudadOrigenVal = $("#selCiudadOrigenTicket option:selected").val();
		var ciudadDestinoVal = $("#selCiudadDestinoTicket option:selected").val();
		
		if (ciudadOrigenVal == 0) {        	        	
       		msgHtml += '- Seleccione la ciudad de origen<br />\n';
       		validation = true;     	
        }
		
		if (ciudadDestinoVal == 0) {        	        	
      		msgHtml += '- Seleccione la ciudad de destino<br />\n';
      		validation = true;        	
        }
        
        if ( validation ) {
			
			console.log("mensaje validacion: " + msgHtml);					
			
			$("#mensajeClienteError").html(msgHtml);
			
			$('#divMensajeErrorCliente').modal({
				backdrop: 'static',
				keyboard: false,
			});
			
			return false;
			
        }       
        
		
		console.log("2- agregando nueva fila.............................: ");	
		
		        
		
		/* var tipoTicket = $('input:radio[name=tipoTicket]:checked').val();
		var tipoOperacion = "";
		
		if (tipoTicket==1){
			tipoOperacion = "Ida/Vuelta";
		} else {
			tipoOperacion = "Ida";
		} */
		
					
		var ciudadOrigen = $("#selCiudadOrigenTicket option:selected").text();
		var ciudadDestino = $("#selCiudadDestinoTicket option:selected").text();
		
		var paisOrigen = $("#selPaisOrigenTicket option:selected").text();
		var paisDestino = $("#selPaisDestinoTicket option:selected").text();
		
		/* var cantidadAdultos = $("#txtCantidadAdultosTicket").val();
		var cantidadNinos = $("#txtCantidadNinosTicket").val();
		var cantidadInfantes = $("#txtCantidadInfantesTicket").val(); */
		
		//var VerDetalle = "<span> <a href='javascript:;' onclick='verDetalleControlAnimal()' title='Ver' ><span class='glyphicon glyphicon-eye-open'></span></a> </span>";		
		// + "-" + $("#numeroCotizacion").val() + "-" + tipoOperacion
		
		var parametrosDetalle = ciudadOrigen + "-" + ciudadDestino + "-"  + 
			fPartidaTicket  + "-" + fRetornoTicket + "-"  + 
			ciudadOrigenVal + "-" + ciudadDestinoVal ;		
		
		console.log("parametrosDetalle: " + parametrosDetalle);
		
		//var VerDetalle = "<span> <a href='javascript:;' onclick='verDetalleControlAnimal(\""+ parametrosDetalle + "\")' title='Ver' ><span class='glyphicon glyphicon-eye-open'></span></a> </span>";		
		//var VerDetalle = "<span> <a href='javascript:;' onclick='verDetalleVuelos(\""+ parametrosDetalle + "\")' title='Ver' ><span class='glyphicon glyphicon-eye-open'></span></a> </span>";
				
		contadorVuelo += 1;
		
		var botonEliminar ="<button name='"+contadorVuelo+"' id='"+contadorVuelo+"'  type='button' class='btn btn-default' onclick='eliminarRegistroTabla(\"tblVuelos\",this.name)'>";
			 botonEliminar +="<span class='glyphicon glyphicon-remove' aria-hidden='true'></span></button>";
 		
		//var parametros = fPartidaTicket+","+fRetornoTicket+","+ciudadOrigenVal+","+ciudadDestinoVal+","+cantidadAdultos+","+cantidadNinos+";";
		var parametros = fPartidaTicket+","+fRetornoTicket+","+ciudadOrigenVal+","+ciudadDestinoVal+","+ ((isSoloIda)?'1':'0')+";";
		console.log("parametros vuelos: " + parametros);
		
		//tipoOperacion
		//" " + VerDetalle
 		var data = [contadorVuelo, txtOpcion, fPartidaTicket,fRetornoTicket,ciudadOrigen+ " ("+ paisOrigen +")", ciudadDestino + 
 		            " ("+ paisDestino +")",botonEliminar,parametros];		
 		var row = $('#tblVuelos').DataTable().row;
		
		row.add(data).draw( false );		
						
		$("#selCiudadOrigenTicket").empty().append('whatever');			
		$("#selCiudadDestinoTicket").empty().append('whatever');
				
		$('#selPaisOrigenTicket').val(0);
		$('#selPaisDestinoTicket').val(0);
		
		$("#txtFechaPartidaTicket").val("");
		$("#txtFechaRetornoTicket").val("");
		
		$('#radTipoticket2').attr('checked', false);
		
		$("#divFechaRegreso").css("display","inline");	
				
		
		
	}
	
	

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
	
	function validarCotiPaquete() {
		
		console.log("Grabando cotizacion.............");	
		
		var msgHTML = '';
		
		//1- Validar Cliente
		if ( $("#txtIdCliente").val() <= 0 || $("#txtDescripcionCliente").val() == '' ) {
			msgHTML += 'Debe buscar un <strong>cliente. <br />';
		}
		
		//2- Validar Tipo de Cotizacion							
		if ( $("#selTipoCotizacion").val() == 0 ){
			msgHTML += 'Debe seleccionar el <strong>tipo de cotizacion</strong> <br />';
		}
		
		//3- Validar Tipo de Programa
		if ( $("#selTipoPrograma").val() == 0 ){
			msgHTML += 'Debe seleccionar el <strong>tipo de programa</strong> <br />';
		}		
		
		//4- Fecha de partida
		if ( $("#txtFechaPartida").val() == '' ){
			msgHTML += 'Seleccione la <strong>fecha de partida</strong> <br />';
		}
		
		//5- Fecha de salida
		if ( $("#txtFechaRetorno").val() == '' ){
			msgHTML += 'Seleccione la <strong>fecha de retorno</strong> <br />';
		}
		
		//6- Destinos
		var dataJson = $("#tblDestino").DataTable().rows().data();		
		
		if ( dataJson.length <= 0 ) {
			msgHTML += 'Ingrese al menos un <strong>destino</strong> <br />';
		}		
		
		//7- Cantidad Adultos
		if ( $("#txtCantidadAdultos").val() == '' ){
			msgHTML += 'Ingrese la <strong>cantidad de adultos</strong> <br />';
		}		
		
		//8- Comentarios
		if ( $("#txtObservacion").val() == '' ){
			msgHTML += 'Ingrese un <strong>comentario</strong> <br />';
		}				
		
		if ( msgHTML.length > 0 || msgHTML != '' ) {
			
			
			var mensaje = "<strong>Verifique la siguiente informacion:</strong> <br /><br />" + msgHTML;
			
			console.log("mensaje: " + mensaje);					
			
			$("#mensajeClienteError").html(mensaje);
			
			$('#divMensajeErrorCliente').modal({
				backdrop: 'static',
				keyboard: false
			}); 
			
			return false;
			
			
		} 
		
		console.log("Paso las validaciones... ");	
		
		return true;
		
	}
	
	
	function registrarCotiPaquete(){					
		
		var dataJson = $("#tblDestino").DataTable().rows().data();
		
		var datosDestino = "";		
		
		for (var i=0; i<dataJson.length; i++) {						
			datosDestino +=  dataJson[i][4] + ",";
		}
		
		console.log("Destinos: " + datosDestino);
		
		var datosHoteles = "";
		
		if($("#selServicioAdicional6").is(":checked")) {			
			var dataJsonHoteles = $("#tblTipoHabitacion").DataTable().rows().data();
			
			for (var i=0; i<dataJsonHoteles.length; i++) {						
				datosHoteles +=  dataJsonHoteles[i][4] + ",";
			};			
        }
		
		var chkValMotivoViaje = "";
		$('input[name="motivoViajeCotiza[]"]:checked').each(function() {
			chkValMotivoViaje += $(this).val() + ",";
		});
		
		var chkValServicioAdicional = "";
		$('input[name="servicioAdicional[]"]:checked').each(function() {
			chkValServicioAdicional += $(this).val() + ",";
		});

		var grabarFormParams = {
			'cotizacionBean' : formToObject( '#frmCotizacion' ),
		};
		
		var idCliente = $("#txtIdCliente").val();
		
		var params = "?motivoViaje="+chkValMotivoViaje+"&servAdicional="+chkValServicioAdicional+"&datosDestino="+datosDestino+"&idCliente="+idCliente+"&datosHoteles="+datosHoteles;
		
		console.log( "GET params: " + params );
		
		$("#txtNroCotizacion").html("");
		$("#inpNuCotizacion").val(0);
		
		$.ajax({
            //url: '${pageContext.request.contextPath}/grabarTransaccionCotizacion?motivoViaje='+chkValMotivoViaje+"&servAdicional"+chkValServicioAdicional,
			url: '${pageContext.request.contextPath}/grabarCotiPaquete'+params,
           	data: JSON.stringify(grabarFormParams),
            cache: false,
            async: true,
            type: 'POST',
            contentType : "application/json; charset=utf-8",
            dataType: 'json',
            success: function(response) {
                
            	console.log("response******************************");
            	console.log(response);
            	
            	console.log("Numero Cotizacion");
            	console.log(response.dataJson.nroCotizacion);
            	
            	$("#txtNroCotizacion").html(response.dataJson.nroCotizacion);  
            	$("#inpNuCotizacion").val(response.dataJson.nroCotizacion);
            	
				//alert("response: "+ response);
				
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
	
	
	function cargarConfirmacionRegistro(e, tipo){
		
		e.preventDefault();
		
		if (tipo ==1){
			
			//alert("paquee");
			if (validarCotiPaquete()) {
			
				$('#mdlConfirmaRegistroPaquete').modal({
					backdrop: 'static',
					keyboard: false
				});
			
			};
			
		} else {
			
			//alert("ticket");
			
			if ( validarCotiTicket() ) {
				
				$('#mdlConfirmaRegistroTicket').modal({
					backdrop: 'static',
					keyboard: false
				});
				
			}
			
			
		}
			
	}
	
	function validarCotiTicket() {		
			
			console.log("Grabando cotizacion (Ticket).............");	
			
			var msgHTML = '';
			
			//1- Validar Cliente
			if ( $("#txtIdCliente").val() <= 0 || $("#txtDescripcionCliente").val() == '' ) {
				msgHTML += 'Debe buscar un cliente. <br />';
			}
			
			//2- Validar Tipo de Cotizacion							
			if ( $("#selTipoCotizacion").val() == 0 ){
				msgHTML += 'Debe seleccionar el tipo de cotizacion. <br />';
			}
			
			//6- Vuelos
			var dataJson = $("#tblVuelos").DataTable().rows().data();		
			
			if ( dataJson.length <= 0 ) {
				msgHTML += 'Ingrese al menos un vuelo. <br />';
			}		
			
			//7- Cantidad Adultos
			if ( $("#txtCantidadAdultosTicket").val() == '' ){
				msgHTML += 'Ingrese la cantidad de adultos. <br />';
			}		
			
			//8- Comentarios
			if ( $("#txtObservacionTicket").val() == '' ){
				msgHTML += 'Ingrese un comentario. <br />';
			}				
			
			if ( msgHTML.length > 0 || msgHTML != '' ) {				
				
				var mensaje = "Verifique la siguiente informacion: <br /><br />" + msgHTML;
				
				console.log("mensaje: " + mensaje);					
				
				$("#mensajeClienteError").html(mensaje);
				
				$('#divMensajeErrorCliente').modal({
					backdrop: 'static',
					keyboard: false,
				}); 
				
				return false;
				
				
			} 
			
			console.log("Paso las validaciones... ");	
			
			return true;
					
	}
	
	
	function registrarTransaccionCotizacionTicket(){
		
		var dataJson = $("#tblVuelos").DataTable().rows().data();
		
		var datosVuelos = "";		
		
		for (var i=0; i<dataJson.length; i++) {						
			datosVuelos +=  dataJson[i][7] + ",";
			
		}
		
		console.log("Parametros Vuelos: " + datosVuelos);
	
		var grabarFormParams = {
			'cotizacionBean' : formToObject( '#frmCotizacion' ),
		};

		var idCliente = $("#txtIdCliente").val();
		var params = "?datosVuelos="+datosVuelos+"&idCliente="+idCliente;
		$("#txtNroCotizacion").html("");
		$("#inpNuCotizacion").val(0);
		$("#inpIdCotizacion").val(0);
				
		$("#mensajeDetalleTransaccion").html("");		
		$("#contenedorDetalleTransaccion").css("display", "none");
		
		$.ajax({
			url: '${pageContext.request.contextPath}/grabarCotiTicket'+params,
           	data: JSON.stringify(grabarFormParams),
            cache: false,
            async: true,
            type: 'POST',
            contentType : "application/json; charset=utf-8",
            dataType: 'json',
            success: function(response) {
            	
            	console.log("response******************************");
            	console.log(response);
            	
            	console.log("Numero Cotizacion");
            	console.log(response.dataJson.nroCotizacion);            	
            	
            	$("#txtNroCotizacion").html(response.dataJson.nroCotizacion);
            	$("#inpIdCotizacion").val(response.dataJson.idCotizacion);
            	$("#inpNuCotizacion").val(response.dataJson.nroCotizacion);
            	
            	$("#contenedorDetalleTransaccion").css("display", "inline");
            	
            	console.log(response.dataJson.listDestinosDetalle);
            	console.log(response.dataJson.detalle);
            	
            	//Los detinos y sus caracteristicas solicitadas
            	$("#mensajeDetalleTransaccion").html(response.dataJson.detalle);
                
				$("#divRegistroOK").modal({
					backdrop: 'static',
					keyboard: false,
				});
				
				return false;
                
            },
            error: function(data, textStatus, errorThrown) {
            	//alert(data);
            	//alert(textStatus);
            	//alert(errorThrown);
            },
        });
	}
	
	var vuelosListParams = {};
	
	function buscarVuelos() {
		console.log("***********************************************************************");
		console.log("buscar vuelos");
		
		$("#infoDetalleVuelos").html("");
		$("#infoDetalleVuelos").html("display", "none");
		$("#botonGrabarVuelos").css("display", "none");
		$("#botonEnviarCotizacion").css("display", "none");
		
		var nroCotizacion = $("#inpNuCotizacion").val();
		
		console.log("Numero Cotizacion");
		console.log(nroCotizacion);		
		
		$.ajax({
			url: '${pageContext.request.contextPath}/buscarVuelos?nroCotizacion='+nroCotizacion,
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
            success: function(response) {
            	
            	console.log("respuesta buscar vuelos");
            	console.log(response);
            	console.log(response.dataJson.detalleVuelos);
            	console.log(response.dataJson.listaVuelos);
            	
            	var mensajeDetalleVuelos = "";
            	
            	if ( response.dataJson.cantidadVuelos > 0 ){
            	
            	vuelosListParams = response.dataJson.listaVuelos;
            	
            	console.log("transform");
            	console.log(vuelosListParams);
            	
            	mensajeDetalleVuelos = response.dataJson.detalleVuelos;
            	$("#botonGrabarVuelos").css("display", "inline");
            	//$("#botonBuscarVuelos").css("", "");
            	
            	} else {
            		mensajeDetalleVuelos = "No se encontraron vuelos disponibles";
            	}
            	
            	$("#infoDetalleVuelos").html(mensajeDetalleVuelos);
            	$("#infoDetalleVuelos").html("display", "inline");
            	
            },
            error: function(data, textStatus, errorThrown) {
            	//alert(data);
            	//alert(textStatus);
            	//alert(errorThrown);
            },
        });
	}
	
	function grabarVuelos(){		
		console.log("grabar vuelos");
		
		console.log(vuelosListParams);
		
		var nroCotizacion = $("#txtNroCotizacion").text();
		$("#botonEnviarCotizacion").css("display", "none");
		$("#mensajeEnvioCotizacion").css("display", "none");
		$("#mensajeEnvioCotizacion").html("");
		$("#mensajeGrabarCotizacion").html("");
		
		$.ajax({
			url: '${pageContext.request.contextPath}/grabarVuelos?nroCotizacion='+nroCotizacion,
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
            success: function(response) {
            	console.log("respuesta grabar vuelos");
            	console.log(response);
            	console.log(response.dataJson);
            	$("#botonGrabarVuelos").css("display", "none");
            	$("#botonBuscarVuelos").css("display", "none");
            	$("#botonEnviarCotizacion").css("display", "inline");
            	
            	$("#mensajeGrabarCotizacion").css("display", "inline");
            	$("#mensajeGrabarCotizacion").html("Vuelo registrado en la cotizacion");
            },
            error: function(data, textStatus, errorThrown) {
            	//alert(data);
            	//alert(textStatus);
            	//alert(errorThrown);
            },
        });
	}
	
	function enviarVuelos(){
		console.log("enviar vuelos");
		var idCotizacion = $("#inpIdCotizacion").val();
		$.ajax({
			url: '${pageContext.request.contextPath}/enviarPaquete?idCotizacion='+idCotizacion,
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
            success: function(response) {
            	
            	console.log("respuesta enviar vuelos");
            	console.log(response);
            	console.log(response.dataJson);
            	
            	$("#botonEnviarCotizacion").css("display", "none");            	
            	$("#mensajeEnvioCotizacion").css("display", "inline");
        		$("#mensajeEnvioCotizacion").html("Cotizacion enviada");
            	
            },
            error: function(data, textStatus, errorThrown) {
            	//alert(data);
            	//alert(textStatus);
            	//alert(errorThrown);
            },
        });
	}
	

	function buscarCliente(){
		
		var params = "";
		
		var tipoDocu = $("#selTipoDocumentoCliente").val();
		var nuDocu = $("#txtCampoBusquedaCliente").val();
		params = "?tipoDocumento="+tipoDocu+"&numeroDocumento="+nuDocu;
		//alert("params: "  + params);
		$.ajax({
			url: '${pageContext.request.contextPath}/obtenerNombreCliente'+params,
           	//data: JSON.stringify(grabarFormParams),
            cache: false,
            async: true,
            type: 'POST',
            contentType : "application/json; charset=utf-8",
            dataType: 'json',
            success: function(response) {
                
				var rpta = response.dataJson;
				
				console.log("status cliente: " + rpta.status);
				
				if ( rpta.status == 1 ) {
									
					$("#txtDescripcionCliente").val(rpta.nombreCliente);
					$("#txtIdCliente").val(rpta.idCliente);					
				
				} else {
					
					var mensaje = rpta.mensajeCliente;
					
					console.log("mensaje cliente: " + mensaje);					
					
					$("#mensajeClienteError").html(mensaje);
					
					$('#divMensajeErrorCliente').modal({
						backdrop: 'static',
						keyboard: false
					}); 
					
				}
				
				
				return false;				
                
            },
            error: function(data, textStatus, errorThrown) {
            	//alert(data);
            	//alert(textStatus);
            	//alert(errorThrown);
            }
        });
	}
	
	function aceptar(){
		location.href = '${pageContext.request.contextPath}/cargarFormRegistrarCotizacion';
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
		
	function verDetalleControlAnimal(cadenaVuelo){
			
		console.log("cadenaVuelo? " + cadenaVuelo);
			
			cadenaStringVuelo = cadenaVuelo;
			
			$.ajax({
				url: '${pageContext.request.contextPath}/verDetalleVuelos?cadenaVuelo='+cadenaVuelo,
				cache: false,
				async: true,
				type: 'GET',
				contentType : "application/json; charset=utf-8",
				dataType: 'json',
				success: function(response) {
					
					
					var rpta = response.dataJson;
					
	                // actualizando lista
	                var listaCotizacion = [];
	                
	                if (rpta.vuelosBean != null) {
	                    listaCotizacion = rpta.vuelosBean;
	                }
	                
	                construirTablaDetalleVuelo(listaCotizacion);	
	                
	                $("#divVerDetalleControlAnimal").modal({
						backdrop: 'static',
						keyboard: false
					});
					
				},
				error: function(data, textStatus, errorThrown) {
				}
			});
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
				//alert(aData[0]);
				//$(nRow).attr('id', aData[0]);
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
		
		
	function guardarDetalleFareInfo(){		
			
			var cadenaOption = $('input:radio[name=selectConsolidador]:checked').val(); //fila, idproveedor, idaerolinea
			
			console.log("check? " + cadenaOption);
			
			var dataOption = cadenaOption.split("-");
			
			var rowOption = dataOption[0];
			
			var idProveedor = dataOption[1];
			
			var idAerolinea = dataOption[2];
			
			var dataJson = $("#tblDetalleVuelos").DataTable().rows().data();
			
			var comision = dataJson[rowOption-1].comision;
			
			var fare = dataJson[rowOption-1].fare;
		
			var grabarFormParams = {
				'cotizacionBean' : formToObject( '#frmCotizacion' )
			};
	
			//var params = "?datosVuelos="+datosVuelos+"&tipoCotizacion=2&flagIdaVuelta="+flagIdaVuelta+"&flagIda="+flagIda+"&flagRuta="+flagRuta;
			var params = "?idProveedor="+idProveedor+"&idAerolinea="+idAerolinea+"&fare="+fare;
			
			console.log ("params?guardarDetalleFareInfo? " + params );
			
			$.ajax({
				url: '${pageContext.request.contextPath}/grabarDetalleVuelos'+params,
	           	data: JSON.stringify(grabarFormParams),
	            cache: false,
	            async: true,
	            type: 'POST',
	            contentType : "application/json; charset=utf-8",
	            dataType: 'json',
	            success: function(response) {
	                
					/* $("#divRegistroOK").modal({
						backdrop: 'static',
						keyboard: false
					});
					
					return false; */
					
	            	cerraVerDetalle();
			
	                
	            },
	            error: function(data, textStatus, errorThrown) {
	            	//alert(data);
	            	//alert(textStatus);
	            	//alert(errorThrown);
	            }
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
				
							<form id="frmCotizacion" name="frmCotizacion" role="form" class="form-horizontal" method="post">
								
								<div class="form-group">
									<div class="col-sm-3" style="text-align:right; font-weight:bold">Fecha Cotizaci&oacute;n:</div>
									<div class="col-sm-3" id="divCodigoAnimal" >${fechaCotizacion}
									<span style="display:none">
										<input type="text" name="fechaCotizacion" value="${fechaCotizacion}" />
									</span>
									</div>									
									
								</div>								
								
								<div class="form-group">
									<div class="col-sm-3" style="text-align:right; font-weight:bold">Doc. Identidad:</div>
									<div class="col-sm-3">
										
										<select name="tipoDocumentoCliente" id="selTipoDocumentoCliente" class="form-control tamanoMaximo" >
											<option value="0">Seleccione</option>
											<option value="1">DNI</option>
											<option value="2">Pasaporte</option>
											<option value="3">Carnet de Extranjer&iacute;a</option>
										</select>
										
									</div>
									
									<div class="col-sm-3">
										<input type="text" class="form-control tamanoMaximo" name="campoBusquedaCliente" id="txtCampoBusquedaCliente" />
									</div>
									
									<div class="col-sm-3">
										<button id="btnCerrar" type="button" class="btn btn-primary centro" onclick="buscarCliente()"
											title="Cerrar">Buscar Cliente</button>
									</div>
								</div>
								
								
								<div class="form-group">
									<div class="col-sm-3" style="text-align:right; font-weight:bold">Cliente:</div>
									
									<div class="col-sm-8">
										<input type="text" name="descripcionCliente" id="txtDescripcionCliente" class="form-control tamanoMaximo" readonly />
										<span style="display:none">
											<input type="text" name="idCliente" id="txtIdCliente" class="form-control tamanoMaximo" />
										</span>
									</div>
								</div>
								
								<div class="form-group">
									<div class="col-sm-3" style="text-align:right; font-weight:bold">Tipo Cotizaci&oacute;n:</div>
									
									<div class="col-sm-3" id="divNombreAnimal">
										<select name="idTipoCotizacion" id="selTipoCotizacion" class="form-control tamanoMaximo"> 
											<option value="0">---Seleccione---</option>
											<option value="1">Paquete Tur&iacute;stico</option>
											<option value="2">Ticket A&eacute;reo</option>
										</select>
									</div>
								</div>
				
								<div id="divPaqueteTuristico" style="display:none">
									<div class="panel panel-primary">
										<div class="panel-heading" >
											<h3 class="panel-title" align="left" id="tituloInseminacion">PAQUETE TURISTICO</h3>
										</div>
										
										<div class="panel-body">
											<div class="row">
												<div class="col-sm-12">
												
													<div class="form-group">
																												
														<div class="col-sm-2" style="text-align:right; font-weight:bold">Tipo Programa:</div>
															<div class="col-sm-3" id="divNombreAnimal">
															<select name="idTipoPrograma" id="selTipoPrograma" class="form-control tamanoMaximo"> 
																<option value="0">---Seleccione---</option>
																<option value="1">Nacional</option>
																<option value="2">Internacional</option>
															</select>
														</div>		
														
														<div class="col-sm-2" style="text-align:right; font-weight:bold">Motivo de Viaje:</div>
														
														<div class="col-sm-4" style="text-align: left">
															
															<label style="width:120px;" for="selCodigoMotivo1">
															<input type="checkbox" name="motivoViajeCotiza[]" id="selMotivoViaje1" value="1"> Cultural</input>
															</label>
															
															<label style="width:120px;" for="selCodigoMotivo2">
															<input type="checkbox" name="motivoViajeCotiza[]" id="selMotivoViaje2" value="2"> Deportes</input>
															</label>
															
															<label style="width:120px;" for="selCodigoMotivo3">
															<input type="checkbox" name="motivoViajeCotiza[]" id="selMotivoViaje3" value="3"> Relajaci&oacute;n</input>
															</label>
															
															<label style="width:120px;" for="selCodigoMotivo4">
															<input type="checkbox" name="motivoViajeCotiza[]" id="selMotivoViaje4" value="4"> Playa</input>
															</label>
															
														</div>
														
																									
													</div>
													
												
													<div class="form-group">
																												
														<div class="col-sm-2" style="text-align:right; font-weight:bold">Origen Partida:</div>
														
														<div id="divInternacionalOrigen">
															<div class="col-sm-3" id="divPaisDestino">
																<select name="paisOrigenPaquete" id="selPaisOrigenPaquete" class="form-control tamanoMaximo"> 
																	<option value="0">---Seleccione País---</option>
																	
																</select>
															</div>														
														</div>
														
														<div id="divNacionalOrigen">
														
															<div class="col-sm-2" style="text-align:right; font-weight:bold">Ciudad Partida:</div>
															
															<div class="col-sm-3" id="divCiudadDestino">
																<select name="idOrigenPartida" id="selCiudadOrigenPaquete" class="form-control tamanoMaximo"> 
																	<option value="0">---Seleccione Ciudad---</option>																
																</select>
															</div>
														</div>
																																							
													</div>	
													
													<div class="form-group">														
														<div class="col-sm-2" style="text-align:right; font-weight:bold">Fecha Partida:</div>
														
														<div class="col-sm-3">
															<div class="input-group date tamanoMaximo" id="divFechaPartida">
																<input name="fechaSalida" id="txtFechaPartida" readonly="yes" type="text" class="form-control tamanoMaximo txtFecha" ></input>
																<span class="input-group-addon">
																	<span class="glyphicon glyphicon-calendar"></span>
																</span>
															</div>
														</div>
														
														<div class="col-sm-2" style="text-align:right; font-weight:bold">Fecha Retorno:</div>
														<div class="col-sm-3">
															<div class="input-group date tamanoMaximo" id="divFechaRetorno">
																<input name="fechaRetorno" id="txtFechaRetorno" readonly="yes" type="text" class="form-control tamanoMaximo txtFecha" ></input>
																<span class="input-group-addon">
																	<span class="glyphicon glyphicon-calendar"></span>
																</span>
															</div>
														</div>
													</div>
													
													<div class="form-group">
														<div class="col-sm-12">
															<div class="col-sm-2" style="text-align:right; font-weight:bold">Presupuesto:</div>
															<div class="col-sm-2">
																<input name="presupuestoMaximo" id="txtPresupuestoMaximo" type="text" class="form-control tamanoMaximo" onkeypress="return validarPrecio(event)" ></input>
															</div>															
															<div class="col-sm-2" style="text-align:right; font-weight:bold">Cantidad Adultos:</div>
															<div class="col-sm-1">
																<input name="cantidadAdultos" id="txtCantidadAdultos" type="text" class="form-control tamanoMaximo" onkeypress="return validarNumero(event)" ></input>
															</div>															
															<div class="col-sm-2" style="text-align:right; font-weight:bold">Cantidad Ni&ntilde;os:</div>
															<div class="col-sm-1">
																<input name="cantidadNinos" id="txtCantidadNinos" type="text" class="form-control tamanoMaximo" onkeypress="return validarNumero(event)" ></input>
															</div>
														</div>
													</div>
													
													
													<div class="form-group">													
													
														<div class="col-sm-12">
														
														<div class="panel panel-primary">
																																		
																<div class="panel-heading">
																	<h3 class="panel-title" align="center" id="tituloInseminacion">DESTINOS</h3>
																</div>
																
																<div class="panel-body">
																	<div class="form-group">																			
																			<div class="col-sm-4">
																																					
																				<div id="divNacional">
																					<div class="col-sm-12">Ciudad:</div>
																					
																					<div class="col-sm-12" id="divCiudadDestino">
																						<select name="ciudadDestino" id="selCiudadDestino" class="form-control tamanoMaximo"> 
																							<option value="0">---Seleccione---</option>
																							
																						</select>
																					</div>
																					
																				</div>
																				
																				<div id="divInternacional" style="display:none">
																	
																					<div class="col-sm-12">Pais:</div>
																					
																					<div class="col-sm-12" id="divPaisDestino">
																						<select name="paisDestino" id="selPaisDestino" class="form-control tamanoMaximo"> 
																							<option value="0">---Seleccione---</option>
																							
																						</select>
																					</div>
																					
																					<div class="col-sm-12">&nbsp;</div>
																					
																					<div class="col-sm-12">Ciudad:</div>																																										
																					
																					<div class="col-sm-12" id="divCiudadDestino">
																						<select name="paisCiudadDestino" id="selPaisCiudadDestino" class="form-control tamanoMaximo"> 
																							<option value="0">---Seleccione---</option>																							
																						</select>
																					</div>
																				</div>
																				
																				<div class="col-sm-12">&nbsp;</div>
																				
																				<div class="col-sm-12" style="text-align: left;">
																					<button id="btnCerrar" type="button"
																						class="btn btn-primary " onclick="agregarDestino()"
																						title="Agregar Destino">Agregar</button>
																				</div>
																			
																			</div>
																			
																			<div class="col-sm-8">																			
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
														</div>
													</div>
													
														<div class="form-group">
															<div class="col-sm-2" style="text-align:right; font-weight:bold">Servicios:</div>
															<div class="col-sm-9">																
																<fieldset>										
																		<legend style="margin:7px; font-size:15px;"></legend>
																		
																		<div class="form-group">
																			<div class="col-sm-12">	
																				<label style="width:auto; padding-right:80px;" for="selServicioAdicional2">
																				<input type="checkbox" name="servicioAdicional[]" id="selServicioAdicional2" value="2" /> Ticket A&eacute;reo
																				</label>																			
																				<label style="width:auto; padding-right:80px;" for="selServicioAdicional3">
																				<input type="checkbox" name="servicioAdicional[]" id="selServicioAdicional3" value="3"/> Tour
																				</label>																			
																				<label style="width:auto; padding-right:80px;" for="selServicioAdicional6">
																				<input type="checkbox" name="servicioAdicional[]" id="selServicioAdicional6" value="6" /> Hotel
																				</label>
																				<!-- <label style="width:auto; padding-left:50px; padding-right:80px;" for="selServicioAdicional1">
																				<input type="checkbox" name="servicioAdicional[]" id="selServicioAdicional1" value="1"> Seguro M&eacute;dico</input>
																				</label> 
																				<label style="width:auto; padding-left:50px; padding-right:80px;" for="selServicioAdicional4">
																				<input type="checkbox" name="servicioAdicional[]" id="selServicioAdicional4" value="4"> Transporte Local</input>
																				</label>																		
																				<label style="width:auto; padding-right:80px;" for="selServicioAdicional5">
																				<input type="checkbox" name="servicioAdicional[]" id="selServicioAdicional5" value="5"> Restaurante</input>
																				</label> -->
																			</div>
																			
																			<!-- DIV HOTELES INICIO -->
																			<div id="hoteles-group" style="display:none">
																			
																				<div class="col-sm-12">&nbsp;</div>
																																							
																				<div class="col-sm-12">
																					<div class="col-sm-2" style="text-align:right; font-weight:bold">Tipo Alojamiento:</div>
																					<div class="col-sm-4">
																						<select name="tipoAlojamiento" id="selTipoAlojamiento" class="form-control tamanoMaximo"> 
																							<option value="0">---Seleccione---</option>
																							<option value="1">Hotel</option>
																							<option value="2">Hostal</option>
																							<option value="3">Casa</option>																	
																						</select>
																					</div>	
																					<div class="col-sm-2" style="text-align:right; font-weight:bold">Categor&iacute;a Alojamiento:</div>
																					<div class="col-sm-4">
																						<select name="categoriaAlojamiento" id="selCategoriaAlojamiento" class="form-control tamanoMaximo"> 
																							<option value="0">---Seleccione---</option>
																							<option value="1">1 Estrella</option>
																							<option value="2">2 Estrellas</option>
																							<option value="3">3 Estrellas</option>
																							<option value="4">4 Estrellas</option>
																							<option value="5">5 Estrellas</option>
																							<option value="6">Est&aacute;ndar</option>
																							<option value="7">Premium</option>
																						</select>
																					</div>
																					
																				</div>
																				
																				<div class="col-sm-12">&nbsp;</div>
																				
																				<div class="col-sm-12">&nbsp;</div>
																				
																				<div class="col-sm-12">
																				
																					<div class="col-sm-6">
																						<!--  fila uno -->
																						<div class="col-sm-12" style="text-align:left; ">Cantidad Habitaciones:</div>
																						<!--  fila dos -->		
																						<div class="col-sm-12">																																									
																							<div class="col-sm-6"style="text-align:left; ">
																								<input name="cantidadHabitacion" id="txtCantidadHabitacion" type="text" class="form-control tamanoMaximo" onkeypress="return validarNumero(event)" ></input>
																							</div>
																						</div>																																											
																						<!--  fila tres -->		
																						<div class="col-sm-12" style="text-align:left; ">Tipo Habitaci&oacute;n:</div>
																						<!--  fila cuatro -->	
																						<div class="col-sm-12">																					
																							<div class="col-sm-10"style="text-align:left; ">
																								<select name="tipoHabitacion" id="selTipoHabitacion" class="form-control tamanoMaximo"> 
																									<option value="0">---Seleccione---</option>
																									<option value="1">Deluxe</option>
																									<option value="2">Executive</option>
																									<option value="3">Classic</option>
																									<option value="4">Sheraton Club</option>
																									<option value="5">Habitacion Doble</option>																								
																								</select>
																							</div>
																						</div>	
																						
																						<!--  fila seis -->		
																							
																						<div class="col-sm-12">&nbsp;</div>
																																								
																						<!--  fila seis -->
																						<div class="col-sm-12" style="text-align: left;">
																							<button id="btnCerrar" type="button"
																								class="btn btn-primary " onclick="agregarTipoHabitacion()"
																								title="Agregar">Agregar</button>
																						</div>								
																					</div>
																					
																					<div class="col-sm-6">																					
																						<div class="col-sm-12">																			
																							<table id ="tblTipoHabitacion" class="table table-bordered responsive">
																								<thead>
																									<tr>
																										<th width="5%" class="text-center">&nbsp;</td>
																										<th width="75%" class="text-center">Cantidad / Habitaci&oacute;n</td>																										
																										<th width="10%" class="text-center">Opciones</td>
																										<th width="5%" class="text-center">&nbsp;</td>
																										<th width="5%" class="text-center">&nbsp;</td>
																									</tr>
																								</thead>
																							</table>																			
																						</div>																					
																					</div>														
																				
																				</div>																		
																			</div>		
																			<!-- DIV HOTELES FIN -->
																																																						
																		</div>
																																			
																</fieldset>
															</div>
														</div>
																												
														<div class="form-group">
															<div class="col-sm-2" style="text-align:right; font-weight:bold">Comentarios:</div>
															<div class="col-sm-9" id="divNombreAnimal">
																<textarea class="form-control" name="observacion" id="txtObservacion" onkeypress="return validarNumeroLetra(event)" rows="4" cols="98" value="s" /></textarea>
															</div>
														</div>
														
														<div class="row">&nbsp;</div>
														
														<div class="form-group">
															<!-- <div class="col-sm-4" style="text-align: center">
																<button id="btnCerrar" type="button"
																	class="btn btn-primary centro" onclick="cerraInseminacion()"
																	title="Cerrar">Cerrar</button>
															</div>
															<div class="col-sm-4" style="text-align: center">
																<button id="btnLimpiar" type="button"
																	class="btn btn-primary centro" onclick="limpiarFormularioInseminacion()"
																	title="Limpiar">Limpiar</button>
															</div> -->
															<div class="col-sm-12" style="text-align: center">
																<button id="btnRegistrar" class="btn btn-primary" onclick="cargarConfirmacionRegistro(event,1)"
																	title="Continuar">Grabar</button>
															</div>
														</div>													
												</div>
											</div>
										</div>
										
										

										
									</div>
									
								</div>
								
								<div id="divTicketAereo" style="display:none">
									<div class="panel panel-primary">
										<div class="panel-heading" >
											<h3 class="panel-title" align="left" id="tituloInseminacion">TICKET AEREO</h3>
										</div>
										
										<div class="panel-body">
											<div class="row">
												<div class="col-sm-12">													
									
													<div class="form-group">														
														<div class="col-sm-2" style="text-align:right; "> &nbsp;</div>
														<div class="col-sm-2" style="text-align:right;"><label style="width:120px;" for="radTipoticket"><input type="checkbox" name="tipoTicket" id="radTipoticket2" value="1" /> Sólo Ida</label></div>
													
														<!-- <div class="col-sm-2" style="text-align:right;">Viaje:</div>
														<div class="col-sm-9" style="text-align: left">
															  <label style="width:120px;" for="radTipoticket">
																<input type="radio" name="tipoTicket" id="radTipoticket1" value="2"> Ida y vuelta</input>
															</label>
														</div>														
														<div class="col-sm-2" style="text-align:right; font-weight:bold">Tipo de Cabina:</div>
														<div class="col-sm-4">
															<select name="tipoCabina" id="tipoCabina" class="form-control tamanoMaximo"> 
																	<option value="">---Seleccione---</option>
																	<option value="1">Economy</option>
																	<option value="2">Premium Economy</option>
																	<option value="3">Premium Business</option>																	
																</select>
														</div> -->														
													</div>
													
													<div class="form-group">
														<div class="col-sm-2" style="text-align:right; font-weight:bold">Fecha Ida:</div>
														<div class="col-sm-3">
															<div class="input-group date tamanoMaximo" id="divFechaPartidaTicket">
																<input name="fechaPartidaTicket" id="txtFechaPartidaTicket" readonly="yes" type="text" class="form-control tamanoMaximo txtFecha" ></input>
																<span class="input-group-addon">
																	<span class="glyphicon glyphicon-calendar"></span>
																</span>
															</div>
														</div>
														
														<div id="divFechaRegreso">
															<div class="col-sm-2" style="text-align:right; font-weight:bold">Fecha Regreso:</div>
															<div class="col-sm-3">
																<div class="input-group date tamanoMaximo" id="divFechaRetornoTicket">
																	<input name="fechaRetornoTicket" id="txtFechaRetornoTicket" readonly="yes" type="text" class="form-control tamanoMaximo txtFecha" ></input>
																	<span class="input-group-addon">
																		<span class="glyphicon glyphicon-calendar"></span>
																	</span>
																</div>
														</div>
														</div>																												
													</div>
													
													<div class="form-group">
														<div class="col-sm-2" style="text-align:right; ">Origen:</div>
														
														<div class="col-sm-3" id="divPaisOrigenTicket">
															<select name="paisOrigenTicket" id="selPaisOrigenTicket" class="form-control tamanoMaximo"> 
																<option value="0">---Seleccione País---</option>
																
															</select>
														</div>
														
														<div class="col-sm-2" style="text-align:right">Ciudad:</div>
														
														<div class="col-sm-3" id="divCiudadOrigenTicket">
															<select name="ciudadOrigenTicket" id="selCiudadOrigenTicket" class="form-control tamanoMaximo"> 
																<option value="0">---Seleccione Ciudad---</option>
																
															</select>
														</div>
													</div>
													
													<div class="form-group">
														<div class="col-sm-2" style="text-align:right; "> Destino:</div>
														
														<div class="col-sm-3" id="divPaisDestinoTicket">
															<select name="paisDestinoTicket" id="selPaisDestinoTicket" class="form-control tamanoMaximo"> 
																<option value="0">---Seleccione País---</option>
																
															</select>
														</div>
														
														<div class="col-sm-2" style="text-align:right">Ciudad:</div>
														
														<div class="col-sm-3" id="divCiudadDestinoTicket">
															<select name="ciudadDestinoTicket" id="selCiudadDestinoTicket" class="form-control tamanoMaximo"> 
																<option value="0">---Seleccione Ciudad---</option>
																
															</select>
														</div>
													</div>	
										
													<div class="form-group">
														<div class="col-sm-2" style="text-align:right; "> &nbsp;</div>														
														<div class="col-sm-2" style="text-align: center">
															<button id="btnCerrar" type="button"
																class="btn btn-primary centro" onclick="agregarFilaTicket()"
																title="Cerrar">Agregar Tramo</button>
														</div>														
													</div>		
													
													<div class="form-group">
														<div class="col-sm-2" style="text-align:right; "> &nbsp;</div>
													</div>		
													
													<div id="dvSubSecParir">
														<div class="col-sm-2" style="text-align:right; "> &nbsp;</div>
														<div class="col-sm-8">
															<table id ="tblVuelos" class="table table-bordered responsive" style="width:100%">
																<thead>
																	<tr>					
																		<th width="5%" class="text-center">&nbsp;</td>										
																		<th width="15%" class="text-center">Ida / Vuelta</td>
																		<th width="15%" class="text-center">Fecha Ida</td>			
																		<th width="15%" class="text-center">Fecha Regreso</td>																		
																		<th width="20%" class="text-center">Origen</td>
																		<th width="20%" class="text-center">Destino</td>																		
																		<th width="10%" class="text-center">Opciones</td>
																	</tr>
																</thead>
															</table>
														</div>
													</div>
													
													<div class="form-group">
														<div class="col-sm-2" style="text-align:right; "> &nbsp;</div>
													</div>
													
													<div class="form-group">
													
														<div class="col-sm-2" style="text-align:right; ">Adultos:</div>
														<div class="col-sm-1">
															<input name="cantidadAdultosTicket" id="txtCantidadAdultosTicket" type="text" class="form-control tamanoMaximo" onkeypress="return validarNumero(event)" ></input>
														</div>
														
														<div class="col-sm-3" style="text-align:right; ">N° Ni&ntilde;os:</div>
														<div class="col-sm-1">
															<input name="cantidadNinosTicket" id="txtCantidadNinosTicket" type="text" class="form-control tamanoMaximo" onkeypress="return validarNumero(event)" ></input>
														</div>
														
														<div class="col-sm-3" style="text-align:right; ">N° Infante:</div>
														<div class="col-sm-1">
															<input name="cantidadInfantesTicket" id="txtCantidadInfantesTicket" type="text" class="form-control tamanoMaximo" onkeypress="return validarNumero(event)" ></input>
														</div>
														
													</div>
													
													<div class="form-group">
															<div class="col-sm-3" style="text-align:right; font-weight:bold">Comentarios:</div>
															<div class="col-sm-8" id="divNombreAnimal">
																<textarea class="form-control" name="observacionTicket" id="txtObservacionTicket" onkeypress="return validarNumeroLetra(event)" rows="4" cols="98" value="s" /></textarea>
															</div>
													</div>
													
												</div>
											</div>
											
										</div>
										
										<div class="row">&nbsp;</div>
						
										<div class="form-group">
											<div class="col-sm-12" style="text-align: center">
												<button id="btnRegistrar" class="btn btn-primary" onclick="cargarConfirmacionRegistro(event,2)"
													title="Continuar">Grabar</button>
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

<div id="divRegistroInseminacion" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog">
		<div class="panel panel-primary">
			
		</div>
	</div>
</div>




<div id="mdlConfirmaRegistroPaquete" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Confirmaci&oacute;n Registro de Cotizaci&oacute;n <br />Paquete Tur&iacute;stico</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center">&iquest;Desea Grabar?</p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">
						<input type="button" class="btn btn-primary" intermediateChanges="false" data-dismiss="" value="Si"
							onclick="registrarCotiPaquete();" id="btnGrabaRegistro"></input>
						<button type="button" id="btnRegistroNo" class="btn btn-primary" data-dismiss="modal">No</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	
	
<div id="mdlConfirmaRegistroTicket" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Confirmaci&oacute;n Registro</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center">&iquest;Desea Grabar?</p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">
						<input type="button" class="btn btn-primary" intermediateChanges="false" data-dismiss="" value="Si"
							onclick="registrarTransaccionCotizacionTicket();" id="btnGrabaRegistro"></input>
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
						<p class="text-center" id="mensajeTransaccion">Se registro la Cotizaci&oacute;n Nro <span id="txtNroCotizacion"></span></p>		
					</div>
					
					<!-- contenedor Ticket Inicio -->
					<div id="contenedorDetalleTransaccion" style="display: none;">
						<div id="mensajeDetalleTransaccion" class="col-sm-12" align="center"></div>
						<div id="botonBuscarVuelos" class="col-sm-12" align="center">
							<input type="button" id="btnBuscarVuelos" class="btn btn-primary" onclick="buscarVuelos()" value="Buscar Vuelos" />
						</div>
						<div class="row">&nbsp;</div>
						<div id="infoDetalleVuelos" style="display: none; border: 1px solid blue; padding: 2%; margin: 2%;"></div>						
						<div id="botonGrabarVuelos" style="display: none; " class="col-sm-12" align="center">
							<input type="button" id="btnGrabarVuelos" class="btn btn-primary" onclick="grabarVuelos()" value="Grabar Vuelos" />
						</div>						
						<div id="mensajeGrabarCotizacion" style="display: none; padding: 2%; margin: 2%;"></div>
						<div id="botonEnviarCotizacion" style="display: none; " class="col-sm-12" align="center">
							<input type="button" id="btnEnviarVuelos" class="btn btn-primary" onclick="enviarVuelos()" value="Enviar Cotizacion" />
						</div>
						<div class="row">&nbsp;</div>
						<div id="mensajeEnvioCotizacion" style="display: none; padding: 2%; margin: 2%;"></div>
					</div>
					<!-- contenedor Ticket Fin -->
					
				</div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">
						<input type="button" id="btnRegistro" class="btn btn-primary" onclick="aceptar()" value="Aceptar"/>
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



<div id="divVerDetalleControlAnimal" class="modal fade" role="dialog" style="text-center:center">
	<div class="modal-dialog">
		<div class="panel panel-primary">
			<%@ include file="verDetalleVuelos.jsp" %>
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