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
		
		function inicia() {
			
			$("#btnBuscarPropuesta").attr("disabled", true);
			
			buscarPropuesta();
			
		}
		
		function cerrarVuelo(){
			$('#divVerDetalleControlAnimal').modal("hide");
		}	
		
		function aceptarTour() {
			var tr = $("#tblTours tbody").find('input[name="optSelTour"]:checked').closest('tr');
			var idtour = tr.find('input[id="idTour"]').val();
			var descripcion = tr.find("td").eq(2).text();
			
			
			
			$("#hdnTour").val(idtour);
			
			var msj = "Seleccione el Tour";
			
			if(idtour == ""){
				$("#mensajeClienteError").html(msj);
				
				$('#divMensajeErrorCliente').modal({
					backdrop: 'static',
					keyboard: false
				}); 
				
				return false;
			}
			
			var destino = $("#hdnRowDestino").val();
			//var destino = tr.find('input[id="tmp_idDestino"]').val();
			//alert(destino);
			
			var detalle = "";
			
			$("#tblDestinos tbody > tr").each(function () {
				var row = $(this);
				var destinoRow = row.find('input[id="tmp_idDestino"]').val();
				
				if(destinoRow == destino) {
					alert("Iguales");
					detalle = "Descripcion : " + descripcion ;
					//row.children('td')[6].innerHTML(detalle);
					//row.find('label[id="tmp-tour"]').text(detalle);
					row.find("td").eq(6).text(detalle);
				}
				
				
			});
			
			$('#ModalBusqTour').modal("hide");
			
			
			
		}
		
		function obtenerDatosTour(){
			var tr = $("#tblTours tbody").find('input[name="optSelTour"]:checked').closest('tr');
			var servicio = tr.find('input[id="servicio"]').val();
			var itinerario = tr.find('input[id="itinerario"]').val();
			
			$("#txtItinerario").val(itinerario);
			$("#txtServicios").val(servicio);
			
				
		}
		
		function obtenerfilaservicio() {
				
				var tr = $("#tblServiciosTuristicos tbody").find('input[name="optSelServicio"]:checked').closest('tr');
				
				var td = tr.find('input[id="idServicio"]').val();
				
				$("#hdnIdServicioSel").val(td);
				

		}
		
		function buscarHoteles(idOrden,idDestino) {
			var params = "";
			params = "?idorden="+idOrden + "&iddestino=" + idDestino;
			$.ajax({
				url: '${pageContext.request.contextPath}/verHoteles'+params,
	           	//data: JSON.stringify(grabarFormParams),	           	
	            cache: false,
	            async: true,
	            type: 'POST',
	            contentType : "application/json; charset=utf-8",
	            dataType: 'json',
	            success: function(response) {
	            	
	            	
	            },
	            error: function(data, textStatus, errorThrown) {

	            }
	        });
			
			return false;
	            
		}
		
		function buscarTour(idDestino){
			params = "?idDestino="+idDestino;
			$.ajax({
				url: '${pageContext.request.contextPath}/verTours'+params,
	           	//data: JSON.stringify(grabarFormParams),	           	
	            cache: false,
	            async: true,
	            type: 'POST',
	            contentType : "application/json; charset=utf-8",
	            dataType: 'json',
	            success: function(response) {
	            	var rpta = response.dataJson;
	            	var listaTours = [];
	                
	                if (rpta.listaTour != null) {
	                	listaTours = rpta.listaTour;
	                }
	                
	                //Construir tabla
	                var nuevaFila = "";
					var cont = 0;
								
					$("#tblTours tbody").html("");
	                for(var i = 0;i< listaTours.length;i++){
	                	 cont++;
						 nuevaFila+= "<tr>";
						 nuevaFila+= "<input type='hidden' id='idTour' value='" + listaTours[i].idTour + "' />";
						 nuevaFila+= "<input type='hidden' id='servicio' value='" + listaTours[i].servicios + "' />";
						 nuevaFila+= "<input type='hidden' id='itinerario' value='" + listaTours[i].itinerario + "' />";
						 
						 nuevaFila+= "<td class='text-center'>" + "<input type='radio' class='myOptTour' id='optSelTour_" + i + "' name='optSelTour' onclick='changeValue(this.id,2);obtenerDatosTour();'>" + "</td>";
						 nuevaFila+= "<td class='text-center'>" + cont + "</td>";
						 nuevaFila+= "<td class='text-center'>" + listaTours[i].descripcion + "</td>";
						 nuevaFila+= "<td class='text-center'>" + listaTours[i].duracion + "</td>";
						 nuevaFila+= "<td class='text-center'>" + listaTours[i].precioAdulto + "</td>";
						 nuevaFila+= "<td class='text-center'>" + listaTours[i].precioNino + "</td>";
						 
						 nuevaFila+="</tr>";	                	
	                	
	                }
	                
	                $("#tblTours tbody").append(nuevaFila);
	                
	                
	                $('#ModalBusqTour').modal({
						backdrop: 'static',
						keyboard: false
					});
	            	
	            },
	            error: function(data, textStatus, errorThrown) {

	            }
	        });
			
			return false;
		}
		
		function buscarVuelos(idOrigen,idDestino,fechPartida){
			var cadena = idOrigen + "-" + idDestino + "-" + fechPartida;
			params = "?cadenaVuelo="+cadena;
			$.ajax({
				url: '${pageContext.request.contextPath}/verVuelos'+params,
	           	//data: JSON.stringify(grabarFormParams),	           	
	            cache: false,
	            async: true,
	            type: 'POST',
	            contentType : "application/json; charset=utf-8",
	            dataType: 'json',
	            success: function(response) {
	            	var rpta = response.dataJson;
	            	var listaVuelos = [];
	                
	                if (rpta.listaVuelos != null) {
	                	listaVuelos = rpta.listaVuelos;
	                }
	                
	                //Construir tabla
	                var nuevaFila = "";
					var cont = 0;
								
					$("#tblDetalleVuelos tbody").html("");
	                for(var i = 0;i< listaVuelos.length;i++){
	                	cont++;
						 nuevaFila+= "<tr>";
						 nuevaFila+= "<td class='text-center'>" + "<input type='radio' class='myOptAerolinea' id='optSelAerolinea_" + i + "' name='optSelAerolinea' onclick='changeValue(this.id,1);'>" + "</td>";
						 nuevaFila+= "<td class='text-center' id='nomAerolinea'>" + listaVuelos[i].nombreAerolinea + "</td>";
						 nuevaFila+= "<td class='text-center' id='precioAerolinea'>" + listaVuelos[i].precio + "</td>";
						 nuevaFila+= "<td class='text-center' id='proveedor'>" + listaVuelos[i].nombreProveedor + "</td>";
						 nuevaFila+= "<td class='text-center' id='comision'>" + listaVuelos[i].comision + "%</td>";
						 
						 nuevaFila+="</tr>";	                	
	                	
	                }
	                
	                $("#tblDetalleVuelos tbody").append(nuevaFila);
	                
	                
	                $('#ModalBusqVuelo').modal({
						backdrop: 'static',
						keyboard: false
					});
	            	
	            },
	            error: function(data, textStatus, errorThrown) {

	            }
	        });
			
			return false;
			
		}
		
		
		
		function mostrarBusquedaDestino(iddetalle,item) {
			
			var idservicio = $("#hdnIdServicioSel").val();
			//alert(idservicio);
			
			var msj = "";
			if(idservicio == "") {
				msj = "Debe seleccionar un servicio";
				$("#mensajeClienteError").html(msj);
				$('#divMensajeErrorCliente').modal({
					backdrop: 'static',
					keyboard: false
				}); 
				
				return false;
			}
			
			
			var tr = $(item).parents("tr");
			var html = $(item).parents("tr").html();
			
			var fechapartida = $("#txtFechaPartida").val();
			var origen = tr.find('input[id="tmp_idOrigen"]').val();
			var destino = tr.find('input[id="tmp_idDestino"]').val();
			
			$("#hdnRowDestino").val(destino);
			
			//alert(origen);
			//Servicio de Hotel
			if(idservicio == 6) {
				$('#ModalBusqHotel').modal({
					backdrop: 'static',
					keyboard: false
				});
			}
			
			//Servicio Ticket Aereo
			if(idservicio == 2){
				buscarVuelos(origen,destino,fechapartida);
			}
			
			//Servicio Tour
			if(idservicio == 3){
				buscarTour(destino);
			}
			
			/*	
			tr.find("td").each(function(){
				alert($(this).html());
			});
			*/			
			
		}
		
		function cerrarVuelo(){
			$('#ModalBusqVuelo').modal("hide");
		}
		
		function cerrarTour(){
			$('#ModalBusqTour').modal("hide");
		}
		
		function buscarPropuesta(){
			
			$("#btnBuscarPropuesta").on("click",function(){
				var params = "";
				var numOrden = $("#txtcodOrden").val();
				params = "?nuorden="+numOrden;
				//alert(params);
				//return false;
				$.ajax({
					url: '${pageContext.request.contextPath}/obtenerOrdenDestino'+params,
		           	//data: JSON.stringify(grabarFormParams),	           	
		            cache: false,
		            async: true,
		            type: 'POST',
		            contentType : "application/json; charset=utf-8",
		            dataType: 'json',
		            success: function(response) {
		                
						var rpta = response.dataJson;
						$("#tblDestinos tbody").html("");
						$("#tblServiciosTuristicos tbody").html("");
						if(rpta.status == 1){
							var listaOrdenDestino = [];
							
							 if (rpta.listaOrdenDestino != null) {
								 listaOrdenDestino = rpta.listaOrdenDestino;
								 
								 var nuevaFila="";
								 var VerBuscar = "";
								 var cont = 0;
								 for (var i = 0; i < listaOrdenDestino.length; i++) {
									 //alert(listaOrdenDestino[i].idDetalle);
									 cont++;
									 VerBuscar = "<span> <a href='javascript:;' onclick='mostrarBusquedaDestino(\""+listaOrdenDestino[i].idDetalle+"\",this)' title='Buscar' ><span class='glyphicon glyphicon-search'></span></a> </span>";
									 
									 nuevaFila+= "<tr>";
									 nuevaFila+= "<td class='text-center'>" + cont + "</td>";
									 nuevaFila+= "<input type='hidden' id='tmp_idOrigen' value='" + listaOrdenDestino[i].idOrigen + "' />";
									 nuevaFila+= "<input type='hidden' id='tmp_idDestino' value='" + listaOrdenDestino[i].idDestino + "' />";
									 nuevaFila+= "<td class='text-center'>" + listaOrdenDestino[i].idaVuelta + "</td>";
									 nuevaFila+= "<td class='text-center'>" + listaOrdenDestino[i].nomDestino + "</td>";
									 nuevaFila+= "<td class='text-center'>" + "" + "</td>";
									 nuevaFila+= "<td class='text-center'>" + "" + "</td>";
									 nuevaFila+= "<td class='text-center'>" + "" + "</td>";
									 nuevaFila+= "<td class='text-left'>" + "" + "</td>";
									 nuevaFila+= "<td class='text-center'>" + VerBuscar + "</td>";
									 nuevaFila+="</tr>";
								 }
								
								 $("#tblDestinos tbody").append(nuevaFila);
				                	
							 }
							
						}
						else {
							
						}
						
						if(rpta.statusServicio == 1) {
							var listaOrdenServicio = [];
							if(rpta.listaOrdenServicio != null){
								listaOrdenServicio = rpta.listaOrdenServicio;
								
								var nuevaFila = "";
								var VerBuscar = "";
								var cont = 0;
								var nombre = "tblServiciosTuristicos";
								for (var i = 0; i < listaOrdenServicio.length; i++) {
									 //alert(listaOrdenDestino[i].idDetalle);
									 cont++;
									 nuevaFila+= "<tr>";
									 nuevaFila+= "<input type='hidden' id='idServicio' value='" + listaOrdenServicio[i].idServicio + "' />";
									 nuevaFila+= "<td class='text-center'>" + cont + "</td>";
									 nuevaFila+= "<td class='text-center' id='nomservicio'>" + listaOrdenServicio[i].nomServicio + "</td>";
									 nuevaFila+= "<td class='text-center'>" + "<input type='radio' class='myOptServicio' id='optSelServicio_" + i + "' name='optSelServicio' onclick='changeValue(this.id,0);obtenerfilaservicio();'>" + "</td>";
									 nuevaFila+="</tr>";
								 }
								
								 $("#tblServiciosTuristicos tbody").append(nuevaFila);
							}
						}
						else {
							
						}
						
						return false;
		                
		            },
		            error: function(data, textStatus, errorThrown) {

		            }
		        });
				
				return false;
				
			});
			
			
			
			
			
			
		}
		
		function changeValue(objId,idtabla) {
			 
			var tabla = "";
			
			if(idtabla == 0)
				tabla = "tblServiciosTuristicos";
			else if(idtabla == 1)
				tabla = "tblDetalleVuelos";
			else if(idtabla == 2)
				tabla = "tblTours";
			
			 var grd = document.getElementById(tabla);
			 
	         //Collect A
	         var rdoArray = grd.getElementsByTagName("input");
	         //alert(objId);
	         for (i = 0; i <= rdoArray.length - 1; i++) {	 
	        	 //alert(rdoArray[i].id);
	             if (rdoArray[i].type == 'radio') {
	                 if (rdoArray[i].id != objId) {
	                	 rdoArray[i].checked = false;
	                	 //alert(rdoArray[i].id);
	                 }
	             }

	         }
		}
		
		function buscarOrdenesPlanificacion(){
			
			var params = "";
			var numOrden = $("#txtcodOrden").val();
			
			
			params = "?nuorden="+numOrden;
			//alert("params: "  + params);
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
					var msj = rpta.mensaje;
					var estado = rpta.idestado;
					$("#btnBuscarPropuesta").attr("disabled", true);
					
					if(rpta.status == 1) {
						
						if(estado != 6) {
							msj = "La orden de planificación no se encuentra asignada";
							
							$("#txtDescripcionOrden").val("");
							$("#txtObservacion").val("");
							$("#txtPresupuestoMinimo").val("");
							$("#txtPresupuestoMaximo").val("");
							$("#txtCliente").val("");
							$("#txtFechaOrden").val("");
							$("#txtDescripcion").val("");
							$("#txtFechaPartida").val("");
							$("#txtFechaRetorno").val("");
							$("#txtcantAdultos").val("");
							$("#txtcantNinos").val("");
							$("#hdIdOrden").val("");
							
							$("#mensajeClienteError").html(msj);
							
							$('#divMensajeErrorCliente').modal({
								backdrop: 'static',
								keyboard: false
							}); 
							
							
							
							return false;
							
						}
						
						
						$("#txtDescripcionOrden").val(rpta.descripcion);
						$("#txtObservacion").val(rpta.observacion);
						$("#txtPresupuestoMinimo").val(rpta.presupuestomin);
						$("#txtPresupuestoMaximo").val(rpta.presupuestomax);
						$("#txtCliente").val(rpta.cliente);
						$("#txtFechaOrden").val(rpta.fechaorden);
						$("#txtFechaPartida").val(rpta.fechapartida);
						$("#txtFechaRetorno").val(rpta.fecharetorno);
						$("#txtcantAdultos").val(rpta.nuaultos);
						$("#txtcantNinos").val(rpta.nuninos);
						$("#hdIdOrden").val(rpta.idorden);
						$("#btnBuscarPropuesta").attr("disabled", false);
						
						var listaOrdenMotivo = [];
						var texto = "";
						var cont = 0;
		                if (rpta.listaOrdenMotivo != null) {
		                	listaOrdenMotivo = rpta.listaOrdenMotivo;
		                	
		                	for (var i = 0; i < listaOrdenMotivo.length; i++) {
		               			texto = listaOrdenMotivo[i].nomMotivo;
		               			cont++;
		               			if(cont == listaOrdenMotivo.length)
		                			$("#txtDescripcion").append(texto);
		               			else
		               				$("#txtDescripcion").append(texto + " - ");
		                	}
		                }
						
					}
					else {
						$("#txtDescripcionOrden").val("");
						$("#txtObservacion").val("");
						$("#txtPresupuestoMinimo").val("");
						$("#txtPresupuestoMaximo").val("");
						$("#txtCliente").val("");
						$("#txtFechaOrden").val("");
						$("#txtDescripcion").val("");
						$("#txtFechaPartida").val("");
						$("#txtFechaRetorno").val("");
						$("#txtcantAdultos").val("");
						$("#txtcantNinos").val("");
						$("#hdIdOrden").val("");
						
						if(msj != "") {
							$("#mensajeClienteError").html(msj);
							
							$('#divMensajeErrorCliente').modal({
								backdrop: 'static',
								keyboard: false
							}); 
						}
						
						
					}
					
					//alert(response.estado);
					//alert(rpta.descripcion +rpta.observacion)
					
					
					return false;
	                
	            },
	            error: function(data, textStatus, errorThrown) {
	            	//alert(data);
	            	//alert(textStatus);
	            	//alert(errorThrown);
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
									
									<input type="hidden" value="" id="hdnIdServicioSel" />
									<input type="hidden" value="" id="hdnRowDestino" />
									<input type="hidden" value="" id="hdIdOrden" />
									<input type="hidden" value="" id="hdIdPaquete" />
									
									
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
															    <label class="col-sm-2 control-label">Nro.Orden:</label>																														
																<div class="col-sm-1">
																	<input type="text" class="form-control tamanoMaximo" name="codigoOrden" id="txtcodOrden" />
																</div>	
																
																																													
																<div class="col-sm-2">
																	<input id="txtDescripcionOrden" onkeypress="return validarNumeroLetra(event)" name="descripcionOrden" type="text" maxlength="30" class="form-control" />
																</div>
																
																<div class="col-sm-2">
																<!--	<button id="btnBuscarOrdenPlanificacion" class="btn btn-primary btn-block"  title="Buscar">Buscar</button> -->
																	<button id="btnBuscarOrdenPlanificacion" type="button" class="btn btn-primary centro" onclick="buscarOrdenesPlanificacion()" title="Buscar Orden">Buscar</button>
																</div>
																
																<label class="col-sm-2 control-label">Fecha Orden:</label>	
																<div class="col-sm-2">
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
																<div class="col-sm-2" style="text-align:right; font-weight:bold">Motivo de Viaje</div>
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
																
																	<label class=" control-label col-sm-2">Fecha Partida:</label>																
																	
																	<div class="col-sm-3">
																		<div class="input-group date tamanoMaximo" id="divFechaPartida">
																			<input name="fechaPartida" id="txtFechaPartida"  type="text" class="form-control tamanoMaximo txtFecha" />
																			
																		</div>
																	</div>
																	
																	<label class=" control-label col-sm-2 col-md-offset-2">Fecha Retorno:</label>
																	
																	<div class="col-sm-3">
																		<div class="input-group date tamanoMaximo" id="divFechaRetorno">
																			<input name="fechaRetorno" id="txtFechaRetorno"  type="text" class="form-control tamanoMaximo txtFecha" />																		
																		</div>
																	</div>		
															</div>		
																	
																	
															<div class="form-group">
																	<label class=" control-label col-sm-2">Cantidad adultos:</label>	
																
																	<div class="col-sm-3">
																		<input id="txtcantAdultos" name="nuNinos" type="text" maxlength="30" class="form-control" placeholder="Cantidad Adultos">
																	</div>
																	<label class=" control-label col-sm-2 col-md-offset-2">Cantidad Ninos:</label>	
																
																	<div class="col-sm-2">
																		<input id="txtcantNinos" name="nuAdultos" type="text" maxlength="30" class="form-control" placeholder="Cantidad Ninos">
																	</div>		
															</div>
																		
															
															<div class="form-group">
																<div class="col-sm-2" style="text-align:right; font-weight:bold">Comentario:</div>
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
																
																<label class="col-sm-6 control-label alignDerecha checkbox-inline">Propuesta de Busqueda de Informacion Historica:
																  <input style="margin-left:-330px;" type="checkbox" id="chkPropuesta" name="chkPropuesta" />
																</label>	
																<div class="col-sm-2">
																	<button id="btnBuscarPropuesta" class="btn btn-primary btn-block" title="Buscar" >Buscar</button>
																</div>														
														</div>		
													</div>
												</div>
												
											</div>
										</div>
									</div>
									
									<div class="col-sm-12" id="divServiviosTuristicos" align="center">
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
																			<th width="15%" class="text-center">Opcion</td>
																		</tr>
																	</thead>
																	<tbody>
																			
																    </tbody>
																	
																</table>
																
																
																
																
															
																					
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
																				<th width="5%" class="text-center">Item</td>
																				<th width="5%" class="text-center">Tipo</td>
																				<th width="10%" class="text-center">Destino</td>
																				<th width="15%" class="text-center">Hotel</td>
																				<th width="15%" class="text-center">Vuelo</td>
																				<th width="15%" class="text-center">Restaurante</td>
																				<th width="15%" class="text-center">Tour</td>
																				<th width="10%" class="text-center">Opcion</td>
																			</tr>
																		</thead>
																		<tbody>
																			
																		</tbody>
																	</table>
																					
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
										
										<div class="col-sm-2" style="text-align:right; font-weight:bold">Estado Paquete Turístico:</div>
											<div class="col-sm-2" id="divNombreAnimal">
												<select name="tipoPrograma" id="selTipoPrograma" class="form-control tamanoMaximo"> 
													<option value="">---Seleccione---</option>
													<option value="4">Pendiente</option>
													<option value="5">Finalizado</option> 
													<option value="6">Asignado</option>
													<option value="7">Disponible</option>
												</select>
											</div>
										
									</div>
									
									<div class="row">&nbsp;</div>
									
									<!-- Botones de formulario -->
									
									<div class="container-fluid">
										<div class="row">
											<div class="col-sm-12" style="text-align: center">
											
											<div class="form-group">
												
												<div class="col-sm-13"> 
													<button id="btnRegistrar" class="btn btn-primary" onclick="cargarConfirmacionRegistro(event,1)" title="Continuar">Grabar</button>
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
		
		<!-- Busqueda de Alojamientos -->
		<div id="ModalBusqHotel" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="panel panel-primary">
					<%@ include file="verHoteles.jsp" %>
				</div>
			</div>
		</div>
		
		<!-- Busqueda de Vuelos -->
		<div id="ModalBusqVuelo" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="panel panel-primary">
					<%@ include file="verDetalleVuelos.jsp" %>
				</div>
			</div>
		</div>
		 	 
		<!-- Busqueda de Tours -->
		<div id="ModalBusqTour" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="panel panel-primary">
					<%@ include file="verTour.jsp" %>
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

