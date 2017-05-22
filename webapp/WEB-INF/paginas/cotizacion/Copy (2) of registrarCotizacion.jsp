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

 	$(document).ready(function(){
		
 		inicia();
 		
 		construirTablaCotizacion([]);

		
 	});
 	
	
	
 	function construirTablaCotizacion( dataGrilla ){
		
		var table = $('#tblDestino').dataTable({
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
		
		
 		var table = $('#tblVuelos').dataTable({
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
                    $('#tblVuelos_paginate').addClass('hiddenDiv');
                } else {
                    $('#tblVuelos_paginate').removeClass('hiddenDiv');
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
		
		
		// carga combo de paises origen
		var jsonPaisTicket = <%=SojoUtil.toJson(listaPais)%>;
				
		document.getElementById("selPaisOrigenTicket").options[0] = new Option("---Seleccione---");
		document.getElementById("selPaisOrigenTicket").options[0].value = "";

		for (var i = 0; i < jsonPaisTicket.length; i++) {
			document.getElementById("selPaisOrigenTicket").options[i+1] = new Option(jsonPaisTicket[i].nomPais);
			document.getElementById("selPaisOrigenTicket").options[i+1].value = jsonPaisTicket[i].idPais;
		}
		
		// carga combo de paises destino
		document.getElementById("selPaisDestinoTicket").options[0] = new Option("---Seleccione---");
		document.getElementById("selPaisDestinoTicket").options[0].value = "";

		for (var i = 0; i < jsonPaisTicket.length; i++) {
			document.getElementById("selPaisDestinoTicket").options[i+1] = new Option(jsonPaisTicket[i].nomPais);
			document.getElementById("selPaisDestinoTicket").options[i+1].value = jsonPaisTicket[i].idPais;
		}
		
		// carga combo de ciudades
		$("#selPaisOrigenTicket").on("change",function(){
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
						document.getElementById("selCiudadOrigenTicket").options[0] = new Option("---Seleccione---");
						document.getElementById("selCiudadOrigenTicket").options[0].value = "";
						for (var i = 0; i < listaCiudad.length; i++) {
							document.getElementById("selCiudadOrigenTicket").options[i+1] = new Option(listaCiudad[i].nomCiudad);
							document.getElementById("selCiudadOrigenTicket").options[i+1].value = listaCiudad[i].idCiudad;
						}
					}
				},
				error: function(data, textStatus, errorThrown) {
				}
			});
		});
		
			
		
		// carga combo de ciudades para paquete turisticos
		$("#selPaisOrigenPaquete").on("change",function(){
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
						document.getElementById("selCiudadOrigenPaquete").options[0] = new Option("---Seleccione---");
						document.getElementById("selCiudadOrigenPaquete").options[0].value = "";
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
						document.getElementById("selCiudadDestinoTicket").options[0] = new Option("---Seleccione---");
						document.getElementById("selCiudadDestinoTicket").options[0].value = "";
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
				document.getElementById("selCiudadDestino").options[0].value = "";
				
			} else if ($(this).val() == 1){
				
				$("#divNacional").css("display","inline");
				$("#divInternacional").css("display","none");
				
				var jsonCiudad = <%=SojoUtil.toJson(listaCiudad)%>;
				
				document.getElementById("selCiudadDestino").options[0] = new Option("---Seleccione---");
				document.getElementById("selCiudadDestino").options[0].value = "";

				for (var i = 0; i < jsonCiudad.length; i++) {
					document.getElementById("selCiudadDestino").options[i+1] = new Option(jsonCiudad[i].nomCiudad);
					document.getElementById("selCiudadDestino").options[i+1].value = jsonCiudad[i].idCiudad;
				}
				
				$("#divNacionalOrigen").css("display","inline");
				$("#divInternacionalOrigen").css("display","none");
				$("#selCiudadOrigenPaquete").empty().append('whatever');								
				
				document.getElementById("selCiudadOrigenPaquete").options[0] = new Option("---Seleccione---");
				document.getElementById("selCiudadOrigenPaquete").options[0].value = "";

				for (var i = 0; i < jsonCiudad.length; i++) {
					document.getElementById("selCiudadOrigenPaquete").options[i+1] = new Option(jsonCiudad[i].nomCiudad);
					document.getElementById("selCiudadOrigenPaquete").options[i+1].value = jsonCiudad[i].idCiudad;
				}
				
				
				
				
			} else {
				
				$("#divInternacional").css("display","inline");
				$("#divNacional").css("display","none");
				var jsonPais = <%=SojoUtil.toJson(listaPais)%>;
				
				document.getElementById("selPaisDestino").options[0] = new Option("---Seleccione---");
				document.getElementById("selPaisDestino").options[0].value = "";

				for (var i = 0; i < jsonPais.length; i++) {
					document.getElementById("selPaisDestino").options[i+1] = new Option(jsonPais[i].nomPais);
					document.getElementById("selPaisDestino").options[i+1].value = jsonPais[i].idPais;
				}
				
				// carga combo de paises origen para paquetes turisticos
				var jsonPais = <%=SojoUtil.toJson(listaPais)%>;
				$("#divNacionalOrigen").css("display","inline");
				$("#divInternacionalOrigen").css("display","inline");
				
				document.getElementById("selPaisOrigenPaquete").options[0] = new Option("---Seleccione---");
				document.getElementById("selPaisOrigenPaquete").options[0].value = "";

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
						document.getElementById("selPaisCiudadDestino").options[0].value = "";
						for (var i = 0; i < listaCiudad.length; i++) {
							document.getElementById("selPaisCiudadDestino").options[i+1] = new Option(listaCiudad[i].nomCiudad);
							document.getElementById("selPaisCiudadDestino").options[i+1].value = listaCiudad[i].idCiudad;
						}
					}
				},
				error: function(data, textStatus, errorThrown) {
				}
			});
		})
		
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
		
		$('#divFechaRetornoTicket').datetimepicker({
			language : 'es',
            autoClose : true,
 			minDate: '01/01/2000',
			
            format: 'DD/MM/YYYY',
            pickTime: false,
			useCurrent: false
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
		})
	}
	var contador = 0;
	function agregarDestino(){
		
		var tipoPrograma = $("#selTipoPrograma").val();
		var pais = "";
		var ciudad = "";
		var ifFila = ""
		if (tipoPrograma == 1){
			idFila = "1_"+$("#selCiudadDestino option:selected").val();
			pais = "Peru";
			ciudad = $("#selCiudadDestino option:selected").text();
		} else if (tipoPrograma == 2){
			idFila = $("#selPaisDestino option:selected").val()+"_"+$("#selPaisCiudadDestino option:selected").val();
			pais = $("#selPaisDestino option:selected").text();
			ciudad = $("#selPaisCiudadDestino option:selected").text();
		}
		contador += 1;
			
		var botonEliminar ="<button name='"+contador+"' id='"+contador+"'  type='button' class='btn btn-default' onclick='eliminarDestino(this.name)'>";
			 botonEliminar +="<span class='glyphicon glyphicon-remove' aria-hidden='true'></span></button>";
 		
 		var data = [contador,pais,ciudad,botonEliminar,idFila];
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
	
	function agregarFilaTicket(){
		
		var tipoTicket = $('input:radio[name=tipoTicket]:checked').val();
		var tipoOperacion = "";
		
		if (tipoTicket==1){
			tipoOperacion = "Ida/Vuelta";
		} else {
			tipoOperacion = "Ida";
		}
		var fPartidaTicket = $("#txtFechaPartidaTicket").val();
		var fRetornoTicket = $("#txtFechaRetornoTicket").val();
		
		var ciudadOrigenVal = $("#selCiudadOrigenTicket option:selected").val();
		var ciudadDestinoVal = $("#selCiudadDestinoTicket option:selected").val();
		var ciudadOrigen = $("#selCiudadOrigenTicket option:selected").text();
		var ciudadDestino = $("#selCiudadDestinoTicket option:selected").text();
		var cantidadAdultos = $("#txtCantidadAdultosTicket").val();
		var cantidadNinos = $("#txtCantidadNinosTicket").val();
		
		//var VerDetalle = "<span> <a href='javascript:;' onclick='verDetalleControlAnimal()' title='Ver' ><span class='glyphicon glyphicon-eye-open'></span></a> </span>";
		
		var parametrosDetalle = ciudadOrigen + "-" + ciudadDestino + "-"  + fPartidaTicket  + "-"  + ciudadOrigenVal + "-" + ciudadDestinoVal + "-" + tipoOperacion + "-" + $("#numeroCotizacion").val();
		var VerDetalle = "<span> <a href='javascript:;' onclick='verDetalleControlAnimal(\""+ parametrosDetalle + "\")' title='Ver' ><span class='glyphicon glyphicon-eye-open'></span></a> </span>";
		
		var botonEliminar ="<button name='"+contador+"' id='"+contador+"'  type='button' class='btn btn-default' onclick='eliminarVuelo(this.name)'>";
			 botonEliminar +="<span class='glyphicon glyphicon-remove' aria-hidden='true'></span></button>";
 		
		//var parametros = fPartidaTicket+","+fRetornoTicket+","+ciudadOrigenVal+","+ciudadDestinoVal+","+cantidadAdultos+","+cantidadNinos+";";
		var parametros = fPartidaTicket+","+ciudadOrigenVal+","+ciudadDestinoVal+";";
		
 		var data = [tipoOperacion,fPartidaTicket,ciudadOrigen,ciudadDestino,botonEliminar+ " " + VerDetalle,parametros];
		
 		var row = $('#tblVuelos').DataTable().row;
		
		row.add(data).draw( false );
		
	}
	
	function eliminarVuelo(fila){
		//alert(fila);
		var tabla = $('#tblVuelos').DataTable();
		tabla.row('#'+fila).remove().draw( false );
	}
	
	function eliminarDestino(fila){
		//alert(fila);
		var tabla = $('#tblDestino').DataTable();
		tabla.row('#'+fila).remove().draw( false );
	}
	
	function limpiarFormularioInseminacion(){
		$('#formInseminacion').bootstrapValidator('resetForm', true);
		$("#selToro").val("");
		$("#txtFechaInseminacion").val("");
		$("#txtObservacion").val("");
	}
	
	
	function registrarTransaccionCotizacion(){
		
		//alert("paquete");
		
		var dataJson = $("#tblDestino").DataTable().rows().data();
		
		var datosDestino = "";
		var motivo_viaje = [];
		
		for (var i=0; i<dataJson.length; i++) {
			
			var obj = new Object();
			
			datosDestino +=  dataJson[i][4];
			
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
			'cotizacionBean' : formToObject( '#frmCotizacion' )
		};

		var idCliente = $("#txtIdCliente").val();
		
		var params = "?motivoViaje="+chkValMotivoViaje+"&servAdicional="+chkValServicioAdicional+"&datosDestino="+datosDestino+"&idCliente="+idCliente;
		
		$.ajax({
            //url: '${pageContext.request.contextPath}/grabarTransaccionCotizacion?motivoViaje='+chkValMotivoViaje+"&servAdicional"+chkValServicioAdicional,
			url: '${pageContext.request.contextPath}/grabarTransaccionCotizacion'+params,
           	data: JSON.stringify(grabarFormParams),
            cache: false,
            async: true,
            type: 'POST',
            contentType : "application/json; charset=utf-8",
            dataType: 'json',
            success: function(response) {
                
				alert("response: "+ response);
				
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
			$('#mdlConfirmaRegistro').modal({
				backdrop: 'static',
				keyboard: false
			});
			
		} else {
			
			//alert("ticket");
			$('#mdlConfirmaRegistroTicket').modal({
				backdrop: 'static',
				keyboard: false
			});
			
			
		}
			
	}
	
	
	
	function registrarTransaccionCotizacionTicket(){

	
		//alert("ticket");
		var dataJson = $("#tblVuelos").DataTable().rows().data();
		
		/* var tipoTicket = "";
		$('input[name="tipoTicket[]"]:checked').each(function() {
			tipoTicket += $(this).val() + ",";
		}); */
		
		var flagIdaVuelta = 0;
		var flagIda = 0;
		
		if ($("#radTipoticket1").is(":checked")) {
			flagIdaVuelta = 1;
		}
		if ($("#radTipoticket2").is(":checked")) {
			flagIda = 1;
		}
		
		var flagRuta = 0;
		if ($("#chkRuta").is(":checked")) {
			flagRuta = 1;
		}
		
		var datosVuelos = "";
		var motivo_viaje = [];
		
		for (var i=0; i<dataJson.length; i++) {
			
			var obj = new Object();
			console.log("datoVuelos? " + dataJson[i][8]);
			datosVuelos += dataJson[i][8] + ";";
			
		}
		
		
	
		var grabarFormParams = {
			'cotizacionBean' : formToObject( '#frmCotizacion' )
		};

		var params = "?datosVuelos="+datosVuelos+"&tipoCotizacion=2&flagIdaVuelta="+flagIdaVuelta+"&flagIda="+flagIda+"&flagRuta="+flagRuta;
		
		$.ajax({
			url: '${pageContext.request.contextPath}/grabarTransaccionCotizacion'+params,
           	data: JSON.stringify(grabarFormParams),
            cache: false,
            async: true,
            type: 'POST',
            contentType : "application/json; charset=utf-8",
            dataType: 'json',
            success: function(response) {
                
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
									963599253
									
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
										<input type="text" name="descripcionCliente" id="txtDescripcionCliente" class="form-control tamanoMaximo" />
										<span style="display:none">
											<input type="text" name="idCliente" id="txtIdCliente" class="form-control tamanoMaximo" />
										</span>
									</div>
								</div>
								
								<div class="form-group">
									<div class="col-sm-3" style="text-align:right; font-weight:bold">Tipo Cotizaci&oacute;n:</div>
									
									<div class="col-sm-3" id="divNombreAnimal">
										<select name="tipoCotizacion" id="selTipoCotizacion" class="form-control tamanoMaximo"> 
											<option value="">---Seleccione---</option>
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
															<select name="tipoPrograma" id="selTipoPrograma" class="form-control tamanoMaximo"> 
																<option value="">---Seleccione---</option>
																<option value="1">Nacional</option>
																<option value="2">Internacional</option>
															</select>
														</div>													
													</div>
													
												
													<div class="form-group">
																												
														<div class="col-sm-2" style="text-align:right; font-weight:bold">Origen Partida:</div>
														
														<div id="divInternacionalOrigen">
															<div class="col-sm-3" id="divPaisDestino">
																<select name="paisOrigenPaquete" id="selPaisOrigenPaquete" class="form-control tamanoMaximo"> 
																	<option value="">---Seleccione País---</option>
																	
																</select>
															</div>														
														</div>
														
														<div id="divNacionalOrigen">
															<div class="col-sm-2" style="text-align:right">Ciudad:</div>
															
															<div class="col-sm-3" id="divCiudadDestino">
																<select name="ciudadOrigenPaquete" id="selCiudadOrigenPaquete" class="form-control tamanoMaximo"> 
																	<option value="">---Seleccione---</option>																
																</select>
															</div>
														</div>
																																							
													</div>																																																			
									
													<div class="form-group">
														<label class="col-sm-3" style="text-align:right;">Motivo de Viaje:</label>
														<div class="col-sm-8" style="text-align: left">
															
															<label style="width:120px;" for="selCodigoMotivo1">
															<input type="checkbox" name="motivoViajeCotiza[]" id="selMotivoViaje1" value="1">Cultural</input>
															</label>
															
															<label style="width:120px;" for="selCodigoMotivo2">
															<input type="checkbox" name="motivoViajeCotiza[]" id="selMotivoViaje2" value="2">Deportes</input>
															</label>
															
															<label style="width:120px;" for="selCodigoMotivo3">
															<input type="checkbox" name="motivoViajeCotiza[]" id="selMotivoViaje3" value="3">Relajaci&oacute;n</input>
															</label>
															
															<label style="width:120px;" for="selCodigoMotivo4">
															<input type="checkbox" name="motivoViajeCotiza[]" id="selMotivoViaje4" value="4">Playa</input>
															</label>
															
														</div>
													</div>
													
													<div class="form-group">
														<div class="col-sm-3" style="text-align:right; font-weight:bold">Fecha Partida:</div>
														<div class="col-sm-3">
															<div class="input-group date tamanoMaximo" id="divFechaPartida">
																<input name="fechaPartida" id="txtFechaPartida" readonly="yes" type="text" class="form-control tamanoMaximo txtFecha" ></input>
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
														
														<!--
															<fieldset>
																<legend >Agregar Destinos</legend>-->
															<div class="panel panel-primary">
																				
																<div class="panel-heading" >
																	<h3 class="panel-title" align="center" id="tituloInseminacion">AGREGAR DESTINO</h3>
																</div>
																
																<div class="panel-body">
																	<div class="form-group">
																		<div class="col-sm-12">
																			
																			
																			<div id="divNacional">
																				<div class="col-sm-2">Ciudad Destino:</div>
																				
																				<div class="col-sm-3" id="divCiudadDestino">
																					<select name="ciudadDestino" id="selCiudadDestino" class="form-control tamanoMaximo"> 
																						<option value="">---Seleccione---</option>
																						
																					</select>
																				</div>
																			</div>
																			
																			<div id="divInternacional" style="display:none">
																			
																				<div class="col-sm-2">Pais Destino:</div>
																				
																				<div class="col-sm-3" id="divPaisDestino">
																					<select name="paisDestino" id="selPaisDestino" class="form-control tamanoMaximo"> 
																						<option value="">---Seleccione---</option>
																						
																					</select>
																				</div>
																				
																				<div class="col-sm-2">Ciudad Destino:</div>
																				
																				<div class="col-sm-3" id="divCiudadDestino">
																					<select name="paisCiudadDestino" id="selPaisCiudadDestino" class="form-control tamanoMaximo"> 
																						<option value="">---Seleccione---</option>
																						
																					</select>
																				</div>
																			</div>
																			
																			<div class="col-sm-2" style="text-align: center">
																				<button id="btnCerrar" type="button"
																					class="btn btn-primary centro" onclick="agregarDestino()"
																					title="Cerrar">Agregar Destino</button>
																			</div>
																			
																		</div>
																	</div>
																	
																	<div id="dvSubSecParir">
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
														</div>
														
														
														<div class="form-group">
															<div class="col-sm-3" style="text-align:right; font-weight:bold">Tipo Alojamiento:</div>
															<div class="col-sm-3">
																<select name="tipoAlojamiento" id="selTipoAlojamiento" class="form-control tamanoMaximo"> 
																	<option value="">---Seleccione---</option>
																	<option value="1">Hotel</option>
																	<option value="2">Hostal</option>
																	<option value="3">Casa</option>
																	
																</select>
															</div>
															
															<div class="col-sm-2" style="text-align:right; font-weight:bold">Cantidad Adultos:</div>
															<div class="col-sm-3">
																<input name="cantidadAdultos" id="txtCantidadAdultos" type="text" class="form-control tamanoMaximo" ></input>
															</div>
														</div>
														
														
														<div class="form-group">
															<div class="col-sm-3" style="text-align:right; font-weight:bold">Categor&iacute;a Alojamiento:</div>
															<div class="col-sm-3">
																<select name="categoriaAlojamiento" id="selCategoriaAlojamiento" class="form-control tamanoMaximo"> 
																	<option value="">---Seleccione---</option>
																	<option value="1">1 Estrella</option>
																	<option value="2">2 Estrellas</option>
																	<option value="3">3 Estrellas</option>
																	<option value="4">4 Estrellas</option>
																	<option value="5">5 Estrellas</option>
																	<option value="6">Est&aacute;ndar</option>
																	<option value="7">Premium</option>
																</select>
															</div>
															
															<div class="col-sm-2" style="text-align:right; font-weight:bold">Cantidad Ni&ntilde;os:</div>
															<div class="col-sm-3">
																<input name="cantidadNinos" id="txtCantidadNinos" type="text" class="form-control tamanoMaximo" ></input>
															</div>
														</div>
														
														<div class="form-group">
														
															<div class="col-sm-3" style="text-align:right; font-weight:bold">Servicios Adicionales:</div>
															
															<div class="col-sm-8">
																
																<fieldset>
																	<legend style="margin:7px; font-size:15px;">  </legend>
																	
																		<label style="width:auto; padding-left:50px; padding-right:220px;" for="selServicioAdicional1">
																		<input type="checkbox" name="servicioAdicional" id="selServicioAdicional1" value="1">Seguro M&eacute;dico</input>
																		</label>
																		
																		<label style="width:auto; padding-right:220px;" for="selServicioAdicional2">
																		<input type="checkbox" name="servicioAdicional[]" id="selServicioAdicional2" value="2">Ticket A&eacute;reo</input>
																		</label>
																		
																		<label style="width:auto; padding-right:220px;" for="selServicioAdicional3">
																		<input type="checkbox" name="servicioAdicional[]" id="selServicioAdicional3" value="3">Tour</input>
																		</label>
																		
																		<br />
																		
																		<label style="width:auto; padding-left:50px; padding-right:207px;" for="selServicioAdicional4">
																		<input type="checkbox" name="servicioAdicional[]" id="selServicioAdicional4" value="4">Transporte Local</input>
																		</label>
																		
																		<label style="width:auto; padding-right:170px;" for="selServicioAdicional5">
																		<input type="checkbox" name="servicioAdicional[]" id="selServicioAdicional5" value="5">Restaurante</input>
																		</label>
																	
																</fieldset>
															</div>
														</div>
																						
														<div class="form-group">
															<div class="col-sm-3" style="text-align:right; font-weight:bold">Presupuesto M&iacute;nimo:</div>
															<div class="col-sm-3">
																<input name="presupuestoMinimo" id="txtPresupuestoMinimo" type="text" class="form-control tamanoMaximo" ></input>
															</div>
															
															<div class="col-sm-2" style="text-align:right; font-weight:bold">Presupuesto M&aacute;ximo:</div>
															<div class="col-sm-3">
																<input name="presupuestoMaximo" id="txtPresupuestoMaximo" type="text" class="form-control tamanoMaximo" ></input>
															</div>
														</div>
														
														<div class="form-group">
															<div class="col-sm-3" style="text-align:right; font-weight:bold">Observaciones:</div>
															<div class="col-sm-8" id="divNombreAnimal">
																<textarea class="form-control" name="observacion" id="txtObservacion" onkeypress="return validarNumeroLetra(event)" rows="4" cols="98" value="s" /></textarea>
															</div>
														</div>
														
													</div>
												</div>
											</div>
										</div>
										
										<div class="row">&nbsp;</div>
						
										<div class="form-group">
											<div class="col-sm-4" style="text-align: center">
												<button id="btnCerrar" type="button"
													class="btn btn-primary centro" onclick="cerraInseminacion()"
													title="Cerrar">Cerrar</button>
											</div>
											<div class="col-sm-4" style="text-align: center">
												<button id="btnLimpiar" type="button"
													class="btn btn-primary centro" onclick="limpiarFormularioInseminacion()"
													title="Limpiar">Limpiar</button>
											</div>
											<div class="col-sm-4" style="text-align: center">
												<button id="btnRegistrar" class="btn btn-primary" onclick="cargarConfirmacionRegistro(event,1)"
													title="Continuar">Registrar</button>
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
													<div class="form-group">&nbsp;
													</div>
															
									
													<div class="form-group">
														<label class="col-sm-2" style="text-align:right;">Viaje:</label>
														<div class="col-sm-9" style="text-align: left">
															
															<label style="width:120px;" for="radTipoticket">
																<input type="radio" name="tipoTicket" id="radTipoticket1" value="1">Ida y vuelta</input>
															</label>
															
															<label style="width:120px;" for="radTipoticket">
																<input type="radio" name="tipoTicket" id="radTipoticket2" value="2">Sólo Ida</input>
															</label>
															
														</div>
													</div>
													
													<div class="form-group">
														<div class="col-sm-2" style="text-align:right; font-weight:bold">Fecha:</div>
														<div class="col-sm-3">
															<div class="input-group date tamanoMaximo" id="divFechaPartidaTicket">
																<input name="fechaPartidaTicket" id="txtFechaPartidaTicket" readonly="yes" type="text" class="form-control tamanoMaximo txtFecha" ></input>
																<span class="input-group-addon">
																	<span class="glyphicon glyphicon-calendar"></span>
																</span>
															</div>
														</div>
														
														<!-- <div class="col-sm-2" style="text-align:right; font-weight:bold">Fecha Retorno:</div>
														<div class="col-sm-3">
															<div class="input-group date tamanoMaximo" id="divFechaRetornoTicket">
																<input name="fechaRetornoTicket" id="txtFechaRetornoTicket" readonly="yes" type="text" class="form-control tamanoMaximo txtFecha" ></input>
																<span class="input-group-addon">
																	<span class="glyphicon glyphicon-calendar"></span>
																</span>
															</div>
														</div> -->
														
													</div>
													
													<div class="form-group">
														<div class="col-sm-2" style="text-align:right; font-weight:bold">Origen:</div>
														
														<div class="col-sm-3" id="divPaisDestino">
															<select name="paisOrigenTicket" id="selPaisOrigenTicket" class="form-control tamanoMaximo"> 
																<option value="">---Seleccione País---</option>
																
															</select>
														</div>
														
														<div class="col-sm-2" style="text-align:right">Ciudad:</div>
														
														<div class="col-sm-3" id="divCiudadDestino">
															<select name="ciudadOrigenTicket" id="selCiudadOrigenTicket" class="form-control tamanoMaximo"> 
																<option value="">---Seleccione---</option>
																
															</select>
														</div>
													

													</div>
													
													<div class="form-group">
														<div class="col-sm-2" style="text-align:right; font-weight:bold"> Destino:</div>
														
														<div class="col-sm-3" id="divPaisDestino">
															<select name="paisDestinoTicket" id="selPaisDestinoTicket" class="form-control tamanoMaximo"> 
																<option value="">---Seleccione País---</option>
																
															</select>
														</div>
														
														<div class="col-sm-2" style="text-align:right">Ciudad:</div>
														
														<div class="col-sm-3" id="divCiudadDestino">
															<select name="ciudadDestinoTicket" id="selCiudadDestinoTicket" class="form-control tamanoMaximo"> 
																<option value="">---Seleccione---</option>
																
															</select>
														</div>
													
													</div>	
													
													
													
													
										
													<div class="form-group">
														
														<div class="col-sm-2" style="text-align:right; font-weight:bold">N° Ni&ntilde;os:</div>
														<div class="col-sm-2">
															<input name="cantidadNinosTicket" id="txtCantidadNinosTicket" type="text" class="form-control tamanoMaximo" ></input>
														</div>
														
														<div class="col-sm-2" style="text-align:right; font-weight:bold">N° Adultos:</div>
														<div class="col-sm-2">
															<input name="cantidadAdultosTicket" id="txtCantidadAdultosTicket" type="text" class="form-control tamanoMaximo" ></input>
														</div>
														
														<div class="col-sm-2" style="text-align:right; font-weight:bold">N° Infante:</div>
														<div class="col-sm-2">
															<input name="cantidadInfantesTicket" id="txtCantidadInfantesTicket" type="text" class="form-control tamanoMaximo" ></input>
														</div>
														
														<!--  <div class="col-sm-2">
															<input name="ruta" id="chkRuta" type="checkbox" class="tamanoMaximo" >Ruta</input>
														</div>  -->
														
														
														<div class="col-sm-2" style="text-align: center">
															<button id="btnCerrar" type="button"
																class="btn btn-primary centro" onclick="agregarFilaTicket()"
																title="Cerrar">A&ntilde;adir</button>
														</div>
													</div>
													
													<div class="form-group">
														
														<div class="col-sm-2" style="text-align:right; font-weight:bold">Tipo de Cabina:</div>
														<div class="col-sm-2">
															<select name="tipoCabina" id="tipoCabina" class="form-control tamanoMaximo"> 
																	<option value="">---Seleccione---</option>
																	<option value="1">Economy</option>
																	<option value="2">Premium Economy</option>
																	<option value="3">Premium Business</option>																	
																</select>
														</div>
														
													</div>
													
													<div id="dvSubSecParir">
														<div class="col-sm-12">
															<table id ="tblVuelos" class="table table-bordered responsive" style="width:100%">
																<thead>
																	<tr>
																		<th width="5%" class="text-center">Tipo</td>
																		<th width="15%" class="text-center">Fecha </td>																		
																		<th width="15%" class="text-center">Origen</td>
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




<div id="mdlConfirmaRegistro" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Confirmaci&oacute;n Registro</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center">&iquest;Desea Grabar?</p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">
						<input type="button" class="btn btn-primary" intermediateChanges="false" data-dismiss="" value="Si"
							onclick="registrarTransaccionCotizacion();" id="btnGrabaRegistro"></input>
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
				<div class="modal-body"> <p class="text-center" id="mensajeTransaccion">Se registro satisfactoriamente la Cotizaci&oacute;n</p></div>
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


</body>

</html>