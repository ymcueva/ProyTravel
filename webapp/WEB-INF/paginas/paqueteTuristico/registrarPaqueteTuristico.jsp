<%@page import="pe.gob.sunat.framework.spring.util.conversion.SojoUtil"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="mapaDatos" scope="request" class="java.util.HashMap" />
<%
	
	String idEstado = "0";
	String modifica = "1";
	Double totalGasto = 0d;
	Double totalTicket = 0d;
	Double totalTour = 0d;
	Double totalHotel = 0d;

	if(mapaDatos.get("idEstadoPaquete") != "")
	   idEstado = mapaDatos.get("idEstadoPaquete").toString();
	
	if(mapaDatos.get("modifica") != "")
		   modifica = mapaDatos.get("modifica").toString();
	
	if(mapaDatos.get("totalGasto") != "")
		totalGasto = Double.parseDouble(mapaDatos.get("totalGasto").toString());
	
	if(mapaDatos.get("totalTicket") != "")
		totalTicket = Double.parseDouble(mapaDatos.get("totalTicket").toString());
	
	if(mapaDatos.get("totalTour") != "")
		totalTour = Double.parseDouble(mapaDatos.get("totalTour").toString());
	
	if(mapaDatos.get("totalHotel") != "")
		totalHotel = Double.parseDouble(mapaDatos.get("totalHotel").toString());
	
	
	
	ArrayList listaDetalleHotel = (ArrayList) mapaDatos.get("listaDetalleHotel");
	
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
		
		
		/* Important part */
		
		
		#popupHoteles{
		    height: 750px;
		    overflow-y: auto;
		}
		
	</style>
	
<script>

		$(document).ready(function(){
		
			inicia();
			
			$("#btnBuscarHotel").on('click',function(e){
				
				var tipo = $("#tipoAlojamiento").val();
				var categoria = $("#categoriaAlojamiento").val();
				var destino = $("#hdnRowDestino").val();
				var tipobusqueda = $("#tipobusqueda").val();
				var valorbusqueda = $("#txtValorBusqueda").val();
				
				buscarHoteles(destino,tipo,categoria,tipobusqueda,valorbusqueda);
				
				
			});
			
			$("#btnBuscarTour").on('click',function(e){
				var destino = $("#hdnRowDestino").val();
				var tipobusqueda = $("#tipobusquedaTour").val();
				var valorbusqueda = $("#txtValorBusquedaTour").val();
				buscarTour(destino,tipobusqueda,valorbusqueda);
			});
			
			
			
			$("#tipoHabitacion").on('change',function(){
				var valor = $(this).val();
				
				obtenerDatosTipoHabitacion(valor);
				
				
			});
			
			
			$("#btnBuscarPropuesta").on("click",function(){
				buscarPropuesta();
				
				return false;
			});
 		
 				
		});
		
		function inicia() {
			
			$("#btnBuscarPropuesta").attr("disabled", true);
			soloNumeros("#txtCantidad","keypress");
			soloLetras("#nombre","keypress");
			soloLetras("#txtObservacionPaquete","keypress");
			
		
			
			var idPaquete = $("#hdIdPaquete").val();
			
			
			if(idPaquete != ""){
				
				var idestado = <%=idEstado%>;
				var modifica = <%=modifica%>;
				var totalGastos = <%=totalGasto%>;
				var totalTickets = <%=totalTicket%>;
				var totalHoteles = <%=totalHotel%>;
				var totalTours = <%=totalTour%>;
				
				
				
				$("#selTipoPrograma").val(idestado);
				$("#btnBuscarPropuesta").attr('disabled', false);
				
				$("#btnBuscarOrdenPlanificacion").attr('disabled',true);
				$("#txtcodOrden").attr('disabled',true);
				
				$("#hdnOrdenValida").val("1");
				
				if(modifica == 0){
					$("#btnBuscarPropuesta").hide();
					$("#btnBuscarOrdenPlanificacion").hide();
					$("#btnRegistrar").hide();
				}
				
				
				//Buscar los destinos y servicios
				buscarPropuesta();
				
				//mostando el detalle de los hotel y la desripcion de cada servicio
				var jsonDetalleHotel = <%=SojoUtil.toJson(listaDetalleHotel)%>;
				var detalleTour = "";
				var detalleAerolinea = "";
				var detalleHotel = "";
				var filaHabitacion = "";
				var detallehabitacion = "";
				var cantAdulto = $("#txtcantAdultos").val();
			    var cantNino = $("#txtcantNinos").val();
			    var origen = $("#hdnNomOrigen").val();

				
				$("#tblDestinos tbody > tr").each(function () {
					var row = $(this);
					var destinoRow = row.find('input[id="tmp_idDestino"]').val();
					var idAerolinea = row.find('input[id="tmp_idAerolinea"]').val();
					var idTour = row.find('input[id="tmp_idTour"]').val();
					
					if(modifica == 0) {
						row.find('.hrefBusqueda').hide();
					}
					//	row.find('td:eq(6)').attr("disabled", true);
					
					//Mostrando datos del tour
					if(idTour != "0"){
						var preAdulto = row.find('input[id="tmp_preAdultoTour"]').val();
						var preNino = row.find('input[id="tmp_preNinoTour"]').val();
						var totalTour = parseFloat(preAdulto)* parseInt(cantAdulto) + parseFloat(preNino) * parseInt(cantNino);
						
						row.find('input[id="tmp_totalTour"]').val(totalTour);
						
						
						
						
						var verEliminarTour = "<span> <a href='javascript:;' onclick='eliminarTour(this)' title='Eliminar' ><span class='glyphicon glyphicon-trash'></span></a> </span>";
						
						
						detalleTour = "Descripcion : " + row.find('input[id="tmp_desTour"]').val() ;
						detalleTour += "<br />";
						detalleTour += "Horas :" + row.find('input[id="tmp_duracionTour"]').val();
						detalleTour += "<br />";
						detalleTour += "Costo :" + totalTour;
						detalleTour += "<br />";
						
						if(modifica == 1)
							detalleTour += verEliminarTour;
						
						
						row.find("td").eq(5).html(detalleTour);
					}
					
					
					
					//Mostrando datos del vuelo
					if(idAerolinea != "0") {
						
						var precio = row.find('input[id="tmp_precioAerolinea"]').val();
						
						var adultos = parseInt($("#txtcantAdultos").val());
						var ninos = parseInt($("#txtcantNinos").val());
						var personas = parseInt(adultos + ninos);
						var preciofinal = parseFloat(precio) / parseInt(personas);
						row.find('input[id="tmp_precioAerolinea"]').val(preciofinal);
						
						
						var verEliminarVuelo = "<span> <a href='javascript:;' onclick='eliminarVuelo(this)' title='Eliminar' ><span class='glyphicon glyphicon-trash'></span></a> </span>";
						
						detalleAerolinea = "Aerolinea: " + row.find('input[id="tmp_nomAerolinea"]').val();
						detalleAerolinea+= "<br />";
						detalleAerolinea+= "Origen: " + origen;
						detalleAerolinea+= "<br />";
						detalleAerolinea+= "Precio: " + preciofinal;
						detalleAerolinea+= "<br />";
						detalleAerolinea+= "Comision: " + row.find('input[id="tmp_comision"]').val();
						
						if(modifica == 1)
							detalleAerolinea+= verEliminarVuelo;
						
						
						row.find("td").eq(4).html(detalleAerolinea);
					}
					
					
					//Mostrando datos del hotel
					var conthoteles = 0;
					detallehabitacion = "";
					var nomTipo = "";
					var nomCategoria = "";
					var nomHotel = "";
					var dias = 0;
					var subtotal = 0;
					
					for (var i = 0; i < jsonDetalleHotel.length; i++) {
						//console.log("DestinoRow :" + destinoRow);
						//console.log("idDestino :" + jsonDetalleHotel[i].idDestino);
						
						
						if(parseInt(destinoRow) == jsonDetalleHotel[i].idDestino){
							conthoteles++;
							
							row.find('input[id="tmp_idHotel"]').val(jsonDetalleHotel[i].idHotel);
							row.find('input[id="tmp_idProveedorHotel"]').val(jsonDetalleHotel[i].idProveedor);
							row.find('input[id="tmp_idTipoAlojamiento"]').val(jsonDetalleHotel[i].idCategoriaAlojamiento);
							row.find('input[id="tmp_idCategoriaAlojamiento"]').val(jsonDetalleHotel[i].idCategoriaAlojamiento);
							
							filaHabitacion = jsonDetalleHotel[i].idHotelHabitacion + "-" + jsonDetalleHotel[i].idTipo + "-" + jsonDetalleHotel[i].imPrecio + "-" + jsonDetalleHotel[i].cantidad;
							detallehabitacion += filaHabitacion + "|";
							
							row.find('input[id="tmp_Habitaciones"]').val(detallehabitacion);
							nomTipo = jsonDetalleHotel[i].nomTipo;
							nomCategoria = jsonDetalleHotel[i].nomCategoria;
							nomHotel = jsonDetalleHotel[i].nomHotel;
							dias = jsonDetalleHotel[i].dias;
							subtotal += (parseFloat(jsonDetalleHotel[i].imPrecio) * parseInt(jsonDetalleHotel[i].cantidad)) * parseInt(dias); 
							
						}
						
					}
					
					console.log("Total Hoteles :" + conthoteles);
					
					if(conthoteles > 0){
						var noches = dias - 1;
						var estadia = "";
						estadia = dias.toString() + " dias";
						if(noches > 0){
							if(noches == 1)
								estadia += " y " + noches.toString() + " noche";
							else
								estadia += " y " + noches.toString() + " noches";
						}
						
						row.find('input[id="tmp_totalHotel"]').val(subtotal);
						var verEliminarHotel = "<span> <a href='javascript:;' onclick='eliminarHotel(this)' title='Eliminar' ><span class='glyphicon glyphicon-trash'></span></a> </span>";
						
						detalleHotel = "Hotel :" + nomHotel;
						detalleHotel += "<br />";
						detalleHotel +="Estadia :" + estadia;
						detalleHotel += "<br />";
						detalleHotel +="Costo :" + subtotal; 
						detalleHotel += "<br />";
						detalleHotel +="Tipo Alojamiento :" + nomTipo; 
						detalleHotel += "<br />";
						detalleHotel +="Categoria Alojamiento :" + nomCategoria; 
						detalleHotel += "<br />";
						
						
						if(modifica == 1)
							detalleHotel += verEliminarHotel;
						
						row.find("td").eq(3).html(detalleHotel);      
					}
					
					origen = row.find("td").eq(1).text();
			
				});
				
				//Calculando los totales
				$("#hdnTotalTour").val(totalTours);
				$("#hdnTotalTicket").val(totalTickets);
				$("#hdnTotalHotel").val(totalHoteles);
				$("#txtTotalGasto").val(totalGastos);
				
				
				
			}
			
			
		}
		
		function soloNumeros(obj, evt) {
			
			$(obj).bind(evt, function (e) {
				return (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) ? false : true;
			})

			$(obj).on("paste", function (e) {
				e.preventDefault();
			});
		}
		
		function soloLetras(obj, evt) {
			$(obj).bind(evt, function (e) {
				charCode = (document.all) ? e.keyCode : e.which;
			    return (/^[a-zA-Z0-9 �� �� �� �� �� ��]$/.test(String.fromCharCode(charCode))) ? true : false;
			})
		}
		
		function soloLetrasNumeros(obj, evt) {
			$(obj).bind(evt, function (e) {
				charCode = (document.all) ? e.keyCode : e.which;
			    return (/[^A-Za-z0-9]$/.test(String.fromCharCode(charCode))) ? false : true;
			})
		}
		
		function cerrarVuelo(){
			$('#divVerDetalleControlAnimal').modal("hide");
		}
		
		function aceptarVuelo() {
			var tr = $("#tblDetalleVuelos tbody").find('input[name="optSelAerolinea"]:checked').closest('tr');
			var idaerolinea = tr.find('input[id="idAerolinea"]').val();
			var idproveedor = tr.find('input[id="idProveedor"]').val();
			var urlaerolinea = tr.find('input[id="urlAerolinea"]').val();
			
			
			$("#hdnAerolinea").val(idaerolinea);
			
            var msj = "Seleccione la Aerolinea";
			
			if(idaerolinea == "" || idaerolinea == "0" || idaerolinea == null){
				$("#mensajeClienteError").html(msj);
				
				$('#divMensajeErrorCliente').modal({
					backdrop: 'static',
					keyboard: false
				}); 
				
				return false;
			}
			
			var destino = $("#hdnRowDestino").val();
			var aerolinea = tr.find("td").eq(1).text();
			var precio = tr.find("td").eq(2).text();
			
			var adultos = parseInt($("#txtcantAdultos").val());
			var ninos = parseInt($("#txtcantNinos").val());
			var personas = parseInt(adultos + ninos);
			var preciofinal = parseFloat(precio) * parseInt(personas);
			
			
			var comision = tr.find("td").eq(4).text();
			
			
			var detalle = "";
			var totalFilaGasto = parseFloat(0);
			var origen = $("#hdnNomOrigen").val();
			
			
			$("#tblDestinos tbody > tr").each(function () {
				var row = $(this);
				var destinoRow = row.find('input[id="tmp_idDestino"]').val();
				
				if(destinoRow == destino) {
					row.find('input[id="tmp_idAerolinea"]').val(idaerolinea);
					row.find('input[id="tmp_precioAerolinea"]').val(preciofinal);
					row.find('input[id="tmp_idProveedorAerolinea"]').val(idproveedor);
					row.find('input[id="tmp_urlAerolinea"]').val(urlaerolinea);
					row.find('input[id="tmp_comision"]').val(comision);
					row.find('input[id="tmp_nomAerolinea"]').val(aerolinea);
					
					
					
					var verEliminar = "<span> <a href='javascript:;' onclick='eliminarVuelo(this)' title='Eliminar' ><span class='glyphicon glyphicon-trash'></span></a> </span>";
					
					
					detalle = "Aerolinea: " + aerolinea;
					detalle+= "<br />";
					detalle+= "Origen: " + origen;
					detalle+= "<br />";
					detalle+= "Precio: " + preciofinal;
					detalle+= "<br />";
					detalle+= "Comision: " + comision;
					detalle+= "<br />";
					detalle+= verEliminar;
					
					row.find("td").eq(4).html(detalle);
				}
				
				origen = row.find("td").eq(1).text();
				
				totalFilaGasto = totalFilaGasto + parseFloat(row.find('input[id="tmp_precioAerolinea"]').val());
				
			});
			

			$("#hdnTotalTicket").val(totalFilaGasto);
			var totalTour = parseFloat($("#hdnTotalTour").val());
			var totalTicket = parseFloat($("#hdnTotalTicket").val());
			var totalHotel = parseFloat($("#hdnTotalHotel").val());
			var subtotal = totalTour + totalTicket + totalHotel;
						
			$("#txtTotalGasto").val(subtotal);		
				
			
			$('#ModalBusqVuelo').modal("hide");
			
		}
		
		function aceptarHotel(){
			var tr = $("#tblHoteles tbody").find('input[name="optSelHotel"]:checked').closest('tr');
			var idhotel = tr.find('input[id="idHotel"]').val();
			var tipo = tr.find('input[id="tmp_tipo"]').val();
			var categoria = tr.find('input[id="tmp_categoria"]').val();
			var idtipo = tr.find('input[id="tmp_idtipo"]').val();
			var idcategoria = tr.find('input[id="tmp_idcategoria"]').val();
			var idproveedor = tr.find('input[id="tmp_idproveedor"]').val();
			//var dias = tr.find('input[id="tmp_dias"]').val();
			
			
			var nomhotel = tr.find('td').eq(1).text();
			var costo = tr.find('td').eq(2).text();
			var msj = "";
			var cont = 0;
			var detallehabitacion = "";
			
			if(idhotel == "")
				msj = "Debe Seleccionar un Hotel";
			
			var detalle = "";
			var fila = "";
			var totalCantidad = parseInt(0);
			
			$("#tblTipoHabitacion tbody > tr").each(function () {
				var row = $(this);
				var idhotelhabitacion = row.find('input[id="idHotelHabitacion"]').val();
				var idtipo = row.find('input[id="idTipo"]').val();
				var precio = row.find('td').eq(2).text();
				var cantidad = row.find('td').eq(1).text();
				
				fila = idhotelhabitacion + "-" + idtipo + "-" + precio + "-" + cantidad;
				detallehabitacion += fila + "|";
				
				totalCantidad += parseInt(cantidad);
				
				cont++;
			});
			
			if(cont == 0)
				msj = "Debe agregar un tipo de habitacion";
			
			
			
			if(msj != ""){
				$("#mensajeClienteError").html(msj);
				
				$('#divMensajeErrorCliente').modal({
					backdrop: 'static',
					keyboard: false
				}); 
				
				return false;
			}
			
			var destino = $("#hdnRowDestino").val();
			var totalFilaGasto = parseFloat(0);
			$("#tblDestinos tbody > tr").each(function () {
				var row = $(this);
				var destinoRow = row.find('input[id="tmp_idDestino"]').val();
								
				if(destinoRow == destino) {
	
					row.find('input[id="tmp_idHotel"]').val(idhotel);
					row.find('input[id="tmp_idProveedorHotel"]').val(idproveedor);
					row.find('input[id="tmp_idTipoAlojamiento"]').val(idtipo);
					row.find('input[id="tmp_idCategoriaAlojamiento"]').val(idcategoria);
					row.find('input[id="tmp_Habitaciones"]').val(detallehabitacion);
					row.find('input[id="tmp_totalHotel"]').val(costo);
					row.find('input[id="tmp_nomTipoAlojamiento"]').val(tipo);
					row.find('input[id="tmp_nomCategoriaAlojamiento"]').val(categoria);
					row.find('input[id="tmp_nomHotel"]').val(nomhotel);
					

					var dias = row.find('input[id="tmp_dias"]').val();
					var noches = dias - 1 ;
					
					
					var estadia = "";
					estadia = dias.toString() + " dias";
					
					if(noches > 0){
						if(noches == 1)
							estadia += " y " + noches.toString() + " noche";
						else
							estadia += " y " + noches.toString() + " noches";
					}
					
					var verEliminar = "<span> <a href='javascript:;' onclick='eliminarHotel(this)' title='Eliminar' ><span class='glyphicon glyphicon-trash'></span></a> </span>";
					
					
					detalle = "Hotel :" + nomhotel;
					detalle += "<br />";
					detalle +="Estadia :" + estadia;
					detalle += "<br />";
					detalle +="Costo :" + costo; 
					detalle += "<br />";
					detalle +="Tipo Alojamiento :" + tipo; 
					detalle += "<br />";
					detalle +="Categoria Alojamiento :" + categoria; 
					detalle += "<br />";
					detalle += verEliminar;
					
					row.find("td").eq(3).html(detalle);
				}
				
				totalFilaGasto = totalFilaGasto + parseFloat(row.find('input[id="tmp_totalHotel"]').val());
				
			});
			
			    $("#hdnTotalHotel").val(totalFilaGasto);
				var totalTour = parseFloat($("#hdnTotalTour").val());
				var totalTicket = parseFloat($("#hdnTotalTicket").val());
				var totalHotel = parseFloat($("#hdnTotalHotel").val());
				var subtotal = totalTour + totalTicket + totalHotel;
				
				$("#txtTotalGasto").val(subtotal);		
			
				$('#ModalBusqHotel').modal("hide");
			
			
		}
		
		function aceptarTour() {
			var tr = $("#tblTours tbody").find('input[name="optSelTour"]:checked').closest('tr');
			var idtour = tr.find('input[id="idTour"]').val();
			var descripcion = tr.find("td").eq(2).text();
			var dias = tr.find("td").eq(3).text();
			var preAdulto = parseFloat(tr.find("td").eq(4).text());
			var preNino = parseFloat(tr.find("td").eq(5).text());
			var cantAdulto = parseInt($("#txtcantAdultos").val());
			var cantNino = parseInt($("#txtcantNinos").val());
			var total = (preAdulto*cantAdulto) + (preNino*cantNino);
			
			/*
			var gastoTotal = $("#txtTotalGasto").val();
			var impGasto = parseFloat(0);
			
			if(gastoTotal == "")
				gastoTotal = 0;
			
			impGasto = parseFloat(gastoTotal);
			
			impGasto = parseFloat(impGasto) + parseFloat(total);
			*/
			
			
			
			$("#hdnTour").val(idtour);
			
			
			
			var msj = "Seleccione el Tour";
			
			if(idtour == "" || idtour == "0" || idtour == null){
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
			var totalFilaGasto = parseFloat(0);
			
			
			var verEliminar = "<span> <a href='javascript:;' onclick='eliminarTour(this)' title='Eliminar' ><span class='glyphicon glyphicon-trash'></span></a> </span>";
				
			
			$("#tblDestinos tbody > tr").each(function () {
				var row = $(this);
				var destinoRow = row.find('input[id="tmp_idDestino"]').val();
				
				if(destinoRow == destino) {
					//Datos tour
					row.find('input[id="tmp_idTour"]').val(idtour);
					row.find('input[id="tmp_desTour"]').val(descripcion);
					row.find('input[id="tmp_preAdultoTour"]').val(preAdulto);
					row.find('input[id="tmp_preNinoTour"]').val(preNino);
					row.find('input[id="tmp_duracionTour"]').val(dias);
					row.find('input[id="tmp_totalTour"]').val(total);
					
					
					//alert("Iguales");
					detalle = "Descripcion : " + descripcion ;
					detalle += "<br />";
					detalle += "Horas :" + dias;
					detalle += "<br />";
					detalle += "Costo :" + total;
					detalle += "<br />";
					detalle += verEliminar;
					
					//row.children('td')[6].innerHTML(detalle);
					//row.find('label[id="tmp-tour"]').text(detalle);
					row.find("td").eq(5).html(detalle);
				}
				
				totalFilaGasto = totalFilaGasto + parseFloat(row.find('input[id="tmp_totalTour"]').val());
				
				
			});
			
			
			
			$("#hdnTotalTour").val(totalFilaGasto);
			var totalTour = parseFloat($("#hdnTotalTour").val());
			var totalTicket = parseFloat($("#hdnTotalTicket").val());
			var totalHotel = parseFloat($("#hdnTotalHotel").val());
			var subtotal = totalTour + totalTicket + totalHotel;
			
			$("#txtTotalGasto").val(subtotal);
			
			
			
			
			$('#ModalBusqTour').modal("hide");
			
			
			
		}
		
		function obtenerDatosTour(){
			var tr = $("#tblTours tbody").find('input[name="optSelTour"]:checked').closest('tr');
			var servicio = tr.find('input[id="servicio"]').val();
			var itinerario = tr.find('input[id="itinerario"]').val();
			
			
			$("#txtItinerario").val(itinerario);
			$("#txtServicios").val(servicio);
			
				
		}
		
		function eliminarTour(fila) {
			var tr = $(fila).closest('tr');
			tr.find('input[id="tmp_idTour"]').val("0");
			tr.find('input[id="tmp_desTour"]').val("");
			tr.find('input[id="tmp_preAdultoTour"]').val("0");
			tr.find('input[id="tmp_preNinoTour"]').val("0");
			tr.find('input[id="tmp_duracionTour"]').val("0");
			tr.find('input[id="tmp_totalTour"]').val("0");
			tr.find('td').eq(4).text("");
			
			//Calcular el total gastado y el total por tour
			var totalGasto = parseFloat(0);
			
			$("#tblDestinos tbody > tr").each(function () {
				var row = $(this);
				totalGasto = totalGasto + parseFloat(row.find('input[id="tmp_totalTour"]').val());
			});
			
			$("#hdnTotalTour").val(totalGasto);
			var totalTour = parseFloat($("#hdnTotalTour").val());
			var totalTicket = parseFloat($("#hdnTotalTicket").val());
			var totalHotel = parseFloat($("#hdnTotalHotel").val());
			var subtotal = totalTour + totalTicket + totalHotel;
			
			$("#txtTotalGasto").val(subtotal);    
			
		}
		
		function eliminarHotel(fila){
			var tr = $(fila).closest('tr');
			tr.find('input[id="tmp_idHotel"]').val("0");
			tr.find('input[id="tmp_idProveedorHotel"]').val("0");
			tr.find('input[id="tmp_idTipoAlojamiento"]').val("0");
			tr.find('input[id="tmp_idCategoriaAlojamiento"]').val("0");
			tr.find('input[id="tmp_Habitaciones"]').val("");
			tr.find('input[id="tmp_totalHotel"]').val("0");
			tr.find('td').eq(2).text("");
			
			//Calcular el total gastado y el total por hotel
			var totalGasto = parseFloat(0);
			
			$("#tblDestinos tbody > tr").each(function () {
				var row = $(this);
				totalGasto = totalGasto + parseFloat(row.find('input[id="tmp_totalHotel"]').val());
			});
			
			$("#hdnTotalHotel").val(totalGasto);
			var totalTour = parseFloat($("#hdnTotalTour").val());
			var totalTicket = parseFloat($("#hdnTotalTicket").val());
			var totalHotel = parseFloat($("#hdnTotalHotel").val());
			var subtotal = totalTour + totalTicket + totalHotel;
			
			$("#txtTotalGasto").val(subtotal);    
			
		}
		
		function actualizarCosto(fila){
			var tr = $(fila).closest('tr');
			var dias = tr.find('input[id="txtNuDias"]').val();
			var msj = "Debe Ingresar Los d�as de estad�a";
			
			if(dias == "" || dias == "0") {
				$("#mensajeClienteError").html(msj);
				
				$('#divMensajeErrorCliente').modal({
					backdrop: 'static',
					keyboard: false
				}); 
				
				return false;
			}
			
			tr.find('input[id="tmp_dias"]').val(dias);
			
			var subtotal = parseFloat(0);
			var totalHotel = parseFloat(0);
			var totalFilaGasto = parseFloat(0);
			var row_detalle = "";
			var fila = "";
			var tabla = "";
			var precio = parseFloat(0);
			var cantidad = parseInt(0);
			//Actualizar Hotel
			if(tr.find("td").eq(3).text() != "") {
				var detalle = tr.find('input[id="tmp_Habitaciones"]').val();
				var indice = parseInt(detalle.length) - 1;
				//alert(indice);
				detalle = detalle.substring(0,indice);
				
				
				tabla = detalle.split('|');
				
				
				
				for(var i = 0; i < tabla.length; i++) {
					if(tabla[i] != "") {
						fila = tabla[i].split('-');
						precio = fila[2];
						cantidad = fila[3];
						subtotal = (precio * cantidad) * dias;
						totalHotel += subtotal;
					}
				}
				
				//Actualizando valores en la grilla
				var noches = dias - 1 ;		
				var estadia = "";
				estadia = dias + " dias";
				
				if(noches > 0){
					if(noches == 1)
						estadia += " y " + noches + " noche";
					else
						estadia += " y " + noches + " noches";
				}
				
				var verEliminar = "<span> <a href='javascript:;' onclick='eliminarHotel(this)' title='Eliminar' ><span class='glyphicon glyphicon-trash'></span></a> </span>";
				var nomhotel = tr.find('input[id="tmp_nomHotel"]').val();
				var tipo = tr.find('input[id="tmp_nomTipoAlojamiento"]').val();
				var categoria = tr.find('input[id="tmp_nomTipoAlojamiento"]').val();
				tr.find('input[id="tmp_totalHotel"]').val(totalHotel);
				
				row_detalle = "Hotel :" + nomhotel;
				row_detalle += "<br />";
				row_detalle +="Estadia :" + estadia;
				row_detalle += "<br />";
				row_detalle +="Costo :" + totalHotel; 
				row_detalle += "<br />";
				row_detalle +="Tipo Alojamiento :" + tipo; 
				row_detalle += "<br />";
				row_detalle +="Categoria Alojamiento :" + categoria; 
				row_detalle += "<br />";
				row_detalle += verEliminar;
				
				tr.find("td").eq(3).html(row_detalle);
				
				//Recalcular el total
				$("#tblDestinos tbody > tr").each(function () {
					var costo = parseFloat(row.find('input[id="tmp_totalHotel"]').val());
					totalFilaGasto += costo;
				});
				
				$("#hdnTotalHotel").val(totalFilaGasto);
				var totalTour = parseFloat($("#hdnTotalTour").val());
				var totalTicket = parseFloat($("#hdnTotalTicket").val());
				var totalHotel = parseFloat($("#hdnTotalHotel").val());
				var total_destino = totalTour + totalTicket + totalHotel;
				
				$("#txtTotalGasto").val(total_destino);		
			
				
			}
			
			
			
		
			
		}
		
		function eliminarVuelo(fila){
			var tr = $(fila).closest('tr');
			tr.find('input[id="tmp_idAerolinea"]').val("0");
			tr.find('input[id="tmp_idProveedorAerolinea"]').val("0");
			tr.find('input[id="tmp_precioAerolinea"]').val("0");
			tr.find('input[id="tmp_urlAerolinea"]').val("");
			tr.find('input[id="tmp_nomAerolinea"]').val("");
			tr.find('input[id="tmp_comision"]').val("0");
			tr.find('input[id="tmp_totalAerolinea"]').val("0");
			tr.find('td').eq(3).text("");
			
			//Calcular el total gastado y el total por Vuelo
			var totalGasto = parseFloat(0);
			
			$("#tblDestinos tbody > tr").each(function () {
				var row = $(this);
				totalGasto = totalGasto + parseFloat(row.find('input[id="tmp_precioAerolinea"]').val());
			});
			
			$("#hdnTotalTicket").val(totalGasto);
			var totalTour = parseFloat($("#hdnTotalTour").val());
			var totalTicket = parseFloat($("#hdnTotalTicket").val());
			var totalHotel = parseFloat($("#hdnTotalHotel").val());
			var subtotal = totalTour + totalTicket + totalHotel;
			
			$("#txtTotalGasto").val(subtotal);    
			
		}
		
		function eliminarRegistroTabla(fila){
			//$(this).closest('tr').remove();
			var tr = $(fila).closest('tr');
			tr.remove();
			
			//Calculando subtotal
			var total = 0;
			$("#tblTipoHabitacion tbody > tr").each(function () {
				var row = $(this);
				
				var subtotal = parseFloat(row.find("td").eq(3).text());
				
				total += subtotal;
				
				
			});
			
			var trhotel = $("#tblHoteles tbody").find('input[name="optSelHotel"]:checked').closest('tr');
			trhotel.find("td").eq(2).text(total);
			
			
		}
		
		function agregarTipoHabitacion(){
			
			console.log("- - - - - - - - - - - - - - - - - -- - - - -- - - - - - - - - - -- - - - - - - - - - - -");
			console.log("Agregar Tipo Habitacion");
			
			var idtipo = $("#tipoHabitacion").val();
			var cantidad = $("#txtCantidad").val();
			var msj = "";
			
			if(idtipo == "" || idtipo == null){
				msj = "Seleccione el tipo de habitacion";
				$("#mensajeClienteError").html(msj);
				
				$('#divMensajeErrorCliente').modal({
					backdrop: 'static',
					keyboard: false
				}); 
				
				return false;
			}
			
			if(cantidad == ""){
				msj = "Ingrese la cantidad";
				$("#mensajeClienteError").html(msj);
				
				$('#divMensajeErrorCliente').modal({
					backdrop: 'static',
					keyboard: false
				}); 
				
				return false;
			}
			
			var cantAdulto = parseInt($("#txtcantAdultos").val());
			var cantNino = parseInt($("#txtcantNinos").val());
			var personas = cantAdulto + cantNino;
			
			
			var idhotelhabitacion = $("#hdnHotelHabitacion").val();
        	var nomtipo = $("#hdnNomTipoHabitacion").val();
        	var precio = $("#hdnPrecio").val();        	
			
			var nuevaFila = "";
			nuevaFila = "<tr>";
			
			var dias = $("#hdnDiasHotel").val();
			
			console.log("idtipo, cantidad idhotelhabitacion, nomtipo, precio, dias");
			console.log(idtipo + ", " + cantidad + ", " + idhotelhabitacion + ", " + nomtipo + ", " + precio + ", " + dias);			
			
			console.log("(parseFloat(precio) * parseInt(cantidad)) * parseInt(dias)");
			console.log((parseFloat(precio) * parseInt(cantidad)) * parseInt(dias));
			
			var subtotal = (parseFloat(precio) * parseInt(cantidad)) * parseInt(dias);
			
			var VerEliminar = "<span> <a href='javascript:;' onclick='eliminarRegistroTabla(this)' title='Eliminar' ><span class='glyphicon glyphicon-remove'></span></a> </span>";
							
			nuevaFila+= "<input type='hidden' id='idHotelHabitacion' value='" + idhotelhabitacion + "' />";
			nuevaFila+= "<input type='hidden' id='idTipo' value='" + idtipo + "' />";
			
			nuevaFila+= "<td class='text-center'>" + nomtipo + "</td>";
			nuevaFila+= "<td class='text-center'>" + cantidad + "</td>";
			nuevaFila+= "<td class='text-center'>" + precio + "</td>";
			nuevaFila+= "<td class='text-center'>" + subtotal + "</td>";
			nuevaFila+= "<td class='text-center'>" + VerEliminar + "</td>";			
			
			nuevaFila += "</tr>"; 
			
			var total = 0;
			var encontro = "0";
			var totalCantidad = parseInt(0);
			//validando que no se ingresedos veces el mismo tipo de habitacion
			$("#tblTipoHabitacion tbody > tr").each(function () {
				var row = $(this);
				
				var tipo = row.find("td").eq(0).text();
				
				if(tipo == nomtipo){
					encontro = "1";
					msj = "No puede agregar el mismo tipo de habitacion";
					$("#mensajeClienteError").html(msj);
					
					$('#divMensajeErrorCliente').modal({
						backdrop: 'static',
						keyboard: false
					}); 
					
					return false;
				}
				
				
				
			});
			
			var cantidadHab = parseInt($("#hdnNumHabitaciones").val()) + parseInt(cantidad) ;
			
			if(cantidadHab > personas) {
				msj = "El n�mero de habitaciones no puede ser mayor al de personas";
				$("#mensajeClienteError").html(msj);
				
				$('#divMensajeErrorCliente').modal({
					backdrop: 'static',
					keyboard: false
				}); 
				
				return false;
			}
			
			
			if (encontro == "0"){
				$("#tblTipoHabitacion tbody").append(nuevaFila);
	           
			}
			
			
			
			//Calculando subtotal
			console.log("- - - - - - - - - - - - - - - - - - -");
			console.log("calculando subtotal:");
			
			$("#tblTipoHabitacion tbody > tr").each(function () {
				
				var row = $(this);				
				var subtotal = parseFloat(row.find("td").eq(3).text());				
				console.log("each subtotal");
				console.log(subtotal);				
				total += subtotal;	
				totalCantidad += parseInt(row.find("td").eq(1).text());
				
				
			});
			
			$("#hdnNumHabitaciones").val(totalCantidad);
			
			console.log("creando fila:");
			var tr = $("#tblHoteles tbody").find('input[name="optSelHotel"]:checked').closest('tr');			
			tr.find("td").eq(2).text(total);
			
		}
		
		function obtenerDatosTipoHabitacion(idtipo) {
			var tr = $("#tblHoteles tbody").find('input[name="optSelHotel"]:checked').closest('tr');
			var idhotel = tr.find('input[id="idHotel"]').val();
			var params = "";
			params = "?idhotel=" + idhotel + "&idtipo=" + idtipo;
			$.ajax({
				url: '${pageContext.request.contextPath}/obtenerDatosTipoHabitacion'+params,
	           	//data: JSON.stringify(grabarFormParams),	           	
	            cache: false,
	            async: true,
	            type: 'POST',
	            contentType : "application/json; charset=utf-8",
	            dataType: 'json',
	            success: function(response) {
	            	
	            	
	            	var rpta = response.dataJson;
	            	
	            	$("#hdnHotelHabitacion").val(rpta.idHotelHabitacion);
	            	$("#hdnIdTipoHabitacion").val(rpta.idTipoHabitacion);
	            	$("#hdnNomTipoHabitacion").val(rpta.nomTipoHabitacion);
	            	$("#hdnPrecio").val(rpta.precio);
					
	                
	            },
	            error: function(data, textStatus, errorThrown) {

	            }
	        });
			
			return false;
			
		}
		
		function obtenerDatosHotel(){
			var tr = $("#tblHoteles tbody").find('input[name="optSelHotel"]:checked').closest('tr');
			var idhotel = tr.find('input[id="idHotel"]').val();
			var params = "";
			params = "?idhotel=" + idhotel;
			$.ajax({
				url: '${pageContext.request.contextPath}/verTiposHabitacion'+params,
	           	//data: JSON.stringify(grabarFormParams),	           	
	            cache: false,
	            async: true,
	            type: 'POST',
	            contentType : "application/json; charset=utf-8",
	            dataType: 'json',
	            success: function(response) {
	            	var rpta = response.dataJson;
	            	var listaTipoHabitacion = [];
	                
	                if (rpta.listaTipoHabitacion != null) {
	                	listaTipoHabitacion = rpta.listaTipoHabitacion;
	                }
	                
	                var valor = "";
	                var texto = "---Seleccione---";
	                //Construir combo
	                $("#tipoHabitacion option").remove();
	                $("#tipoHabitacion").append("<option value=" + valor + ">" + texto + "</option>");
	  
	                for(var i = 0;i< listaTipoHabitacion.length;i++){
	                	 $("#tipoHabitacion").append("<option value=" + listaTipoHabitacion[i].idTipoHabitacion + ">" + listaTipoHabitacion[i].nomTipoHabitacion + "</option>");
	                	
	                }
					
	                $("#tblTipoHabitacion tbody").html("");
					
	                
	            },
	            error: function(data, textStatus, errorThrown) {

	            }
	        });
			
			return false;
			
			
			
		}
		
		function obtenerfilaservicio() {
				
				var tr = $("#tblServiciosTuristicos tbody").find('input[name="optSelServicio"]:checked').closest('tr');
				
				var td = tr.find('input[id="idServicio"]').val();
				
				$("#hdnIdServicioSel").val(td);
				

		}
		
		function buscarHoteles(idDestino,tipo,categoria,tipobusqueda,valorbusqueda) {
			var params = "";
			var idcotizacion = $("#hdnIdCotizacion").val();
			
			params = "?iddestino=" + idDestino + "&tipo=" + tipo + "&categoria=" + categoria + "&tipobusqueda=" + tipobusqueda + "&valor=" + valorbusqueda;
			params += "&idcotizacion=" + idcotizacion;
			
			$.ajax({
				url: '${pageContext.request.contextPath}/verHoteles'+params,
	           	//data: JSON.stringify(grabarFormParams),	           	
	            cache: false,
	            async: true,
	            type: 'POST',
	            contentType : "application/json; charset=utf-8",
	            dataType: 'json',
	            success: function(response) {
	            	var rpta = response.dataJson;
	            	var listaHotel = [];
	            	var listaCotizacionDetaHabitacion = [];
	                
	                if (rpta.listaHotel != null) {
	                	listaHotel = rpta.listaHotel;
	                }
	                
	                if (rpta.listaCotizacionDetaHabitacion != null) {
	                	listaCotizacionDetaHabitacion = rpta.listaCotizacionDetaHabitacion;
	                }
	                
	                
	                //Construir tabla
	                var nuevaFila = "";
					var cont = 0;
					var conthabitacion = 0;
					
					$("#tblHoteles tbody").html("");
					$("#tblTipoHabitacion tbody").html("");
					$("#tipoHabitacion").val("");
					$("#txtCantidad").val("");
					$("#tipoHabitacion option").remove();
					$("#txtTipoAlojamiento").val("");
					$("#txtCategoriaAlojamiento").val("");
					$("#tblHabitacionesConfiguracion tbody").html("");
					
					if(rpta.existecotizacion == "1") {
						$("#txtTipoAlojamiento").val(rpta.tipoalojamiento);
						$("#txtCategoriaAlojamiento").val(rpta.categorialojamiento);
						
						for(var i = 0; i<listaCotizacionDetaHabitacion.length;i++){
							conthabitacion++;
							nuevaFila+= "<tr>";
							nuevaFila+= "<td class='text-center'>" + conthabitacion + "</td>";
							nuevaFila+= "<td class='text-center'>" + listaCotizacionDetaHabitacion[i].tipoHabitacion + "</td>";
							nuevaFila+= "<td class='text-center'>" + listaCotizacionDetaHabitacion[i].nuHabitaciones + "</td>";
							nuevaFila+="</tr>";
						}
						$("#tblHabitacionesConfiguracion tbody").append(nuevaFila);
						
					}
					else {
						$("#txtTipoAlojamiento").val("");
						$("#txtCategoriaAlojamiento").val("");
					}
					
					nuevaFila = "";
					
	                for(var i = 0;i< listaHotel.length;i++){
	                	 cont++;
						 nuevaFila+= "<tr>";
						 nuevaFila+= "<input type='hidden' id='idHotel' value='" + listaHotel[i].idHotel + "' />";
						 nuevaFila+= "<input type='hidden' id='tmp_tipo' value='" + listaHotel[i].nomTipo + "' />";
						 nuevaFila+= "<input type='hidden' id='tmp_categoria' value='" + listaHotel[i].nomCategoria + "' />";
						 nuevaFila+= "<input type='hidden' id='tmp_idtipo' value='" + listaHotel[i].idTipoAlojamiento + "' />";
						 nuevaFila+= "<input type='hidden' id='tmp_idcategoria' value='" + listaHotel[i].idCategoriaAlojamiento + "' />";
						 nuevaFila+= "<input type='hidden' id='tmp_idproveedor' value='" + listaHotel[i].idProveedor + "' />";
						 
						 
						 nuevaFila+= "<td class='text-center'>" + "<input type='radio' class='myOptHotel' id='optSelHotel_" + i + "' name='optSelHotel' onclick='changeValue(this.id,3);obtenerDatosHotel();'>" + "</td>";
						 nuevaFila+= "<td class='text-center'>" + listaHotel[i].descripcion + "</td>";
						 nuevaFila+= "<td class='text-center'>" + listaHotel[i].precio + "</td>";
						 nuevaFila+= "<td class='text-center'>" + listaHotel[i].nomTipo + "</td>";
						 nuevaFila+= "<td class='text-center'>" + listaHotel[i].nomCategoria + "</td>";
						 
						 nuevaFila+="</tr>";	                	
	                	
	                }
	                
	                $("#tblHoteles tbody").append(nuevaFila);
	                
					
	            	
	            	
	            	$('#ModalBusqHotel').modal({
						backdrop: 'static',
						keyboard: false
					});
	            	
	            },
	            error: function(data, textStatus, errorThrown) {

	            }
	        });
			
			return false;
	            
		}
		
		
		function buscarTour(idDestino,tipobusqueda,valorbusqueda){
			params = "?idDestino="+idDestino;
			params += "&tipobusqueda=" + tipobusqueda;
			params += "&valorbusqueda=" + valorbusqueda;
			
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
					$("#txtItinerario").val("");
					$("#txtServicios").val("");
					
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
		
		function buscarVuelos(idOrigen,idDestino,fechPartida,destino){
			var cadena = idOrigen + "," + idDestino + "," + fechPartida + "," + destino;
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
						 nuevaFila+= "<input type='hidden' id='idAerolinea' value='" + listaVuelos[i].idAerolinea + "' />";
						 nuevaFila+= "<input type='hidden' id='idProveedor' value='" + listaVuelos[i].idProveedor + "' />";
						 nuevaFila+= "<input type='hidden' id='urlAerolinea' value='" + listaVuelos[i].href + "' />";
						 
						 
						 nuevaFila+= "<td class='text-center'>" + "<input type='radio' class='myOptAerolinea' id='optSelAerolinea_" + i + "' name='optSelAerolinea' onclick='changeValue(this.id,1);'>" + "</td>";
						 nuevaFila+= "<td class='text-center'>" + listaVuelos[i].nombreAerolinea + "</td>";
						 nuevaFila+= "<td class='text-center'>" + listaVuelos[i].precio + "</td>";
						 nuevaFila+= "<td class='text-center'>" + listaVuelos[i].nombreProveedor + "</td>";
						 nuevaFila+= "<td class='text-center'>" + listaVuelos[i].comision + "%</td>";
						 
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
			
			var diash = tr.find('input[id="txtNuDias"]').val();
			
			if(diash == "" || diash == "0") {
				msj = "Debe Ingresar los d�as de estad�a";
				$("#mensajeClienteError").html(msj);
				$('#divMensajeErrorCliente').modal({
					backdrop: 'static',
					keyboard: false
				}); 
				
				return false;
			}
			
			
			tr.find('input[id="tmp_dias"]').val(diash);
			//var fechapartida = $("#txtFechaPartida").val();
			var origen = tr.find('input[id="tmp_idOrigen"]').val();
			var destino = tr.find('input[id="tmp_idDestino"]').val();
			var dias = tr.find('input[id="tmp_dias"]').val();
			var isoOrigen = tr.find('input[id="tmp_isoOrigen"]').val();
			var isoDestino = tr.find('input[id="tmp_isoDestino"]').val();
			var fechapartida = tr.find('input[id="tmp_fechaPartida"]').val();
			
			
			$("#hdnDiasHotel").val(dias);
			
			$("#hdnRowDestino").val(destino);
			
			//alert(origen);
			//Servicio de Hotel
			if(idservicio == 6) {
				buscarHoteles(destino,"","","","");
			}
			
			//Servicio Ticket Aereo
			else if(idservicio == 2){
				buscarVuelos(isoOrigen,isoDestino,fechapartida,destino);
			}
			
			//Servicio Tour
			else if(idservicio == 3){
				buscarTour(destino,"","");
			}
			
			else {
				msj = "No se puede asignar detalle a este servicio";
				$("#mensajeClienteError").html(msj);
				$('#divMensajeErrorCliente').modal({
					backdrop: 'static',
					keyboard: false
				}); 
				
				return false;
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
		
		function cerrarHotel(){
			$('#ModalBusqHotel').modal("hide");			
		}
		
		function buscarPropuesta(){
			
				var idPaquete = $("#hdIdPaquete").val();
				
				var busInteligente = 0;
				
				if($('#chkPropuesta').prop('checked')) {
					busInteligente = 1;
				}
				else {
					busInteligente = 0;
				}
				
				var tipoPrograma = $("#hdnTipoPrograma").val();
				
				var params = "";
				var numOrden = $("#txtcodOrden").val();
				
				var cotizacion = $("#hdnIdCotizacion").val();
				$("#txtTotalGasto").val("0");
				$("#hdnTotalTour").val("0");
				$("#hdnTotalTicket").val("0");
				$("#hdnTotalHotel").val("0");
				
				if(cotizacion == "0" && busInteligente == 1) {
					//$("#mensajeClienteError").html("Debe tener una cotizaci�n asociada para realizar la busqueda historica");
					$("#chkPropuesta").prop("checked", false);
					$("#chkPropuesta").attr('disabled','disabled');
					
					/*
					$('#divMensajeErrorCliente').modal({
						backdrop: 'static',
						keyboard: false
					}); 
					*/
					return false;
					
				}
				
				
				var verActualizar = "<span> <a href='javascript:;' onclick='actualizarCosto(this)' title='Actualizar Servicos' ><span class='glyphicon glyphicon-ok'></span></a> </span>";
				
				
				
				params = "?nuorden="+numOrden;
				params += "&idpaquete=" + idPaquete;
				params += "&busInteligente=" + busInteligente;
				params += "&tipoPrograma=" + tipoPrograma;
				//alert(params);
				$.ajax({
					url: '${pageContext.request.contextPath}/obtenerOrdenDestino'+params,
		           	//data: JSON.stringify(grabarFormParams),	           	
		            cache: false,
		            async: false,
		            type: 'POST',
		            contentType : "application/json; charset=utf-8",
		            dataType: 'json',
		            success: function(response) {
		                
						var rpta = response.dataJson;
						var obj = "#txtNuDias";
						var evt = "keypress";
						
						$("#tblDestinos tbody").html("");
						$("#tblServiciosTuristicos tbody").html("");
						if(rpta.status == 1){
							console.log("status :" + rpta.status);
							var listaOrdenDestino = [];
							//$('#selTipoPrograma').prop('disabled', false);
							
							 if (rpta.listaOrdenDestino != null) {
								 listaOrdenDestino = rpta.listaOrdenDestino;
								 
								 var nuevaFila="";
								 var VerBuscar = "";
								 var cont = 0;
								 for (var i = 0; i < listaOrdenDestino.length; i++) {
									 //alert(listaOrdenDestino[i].idDetalle);
									 cont++;
									 VerBuscar = "<span> <a class='hrefBusqueda' href='javascript:;' onclick='mostrarBusquedaDestino(\""+listaOrdenDestino[i].idDetalle+"\",this)' title='Buscar' ><span class='glyphicon glyphicon-search'></span></a> </span>";
									 
									 nuevaFila+= "<tr>";
									 nuevaFila+= "<td class='text-center'>" + cont + "</td>";
									 nuevaFila+= "<input type='hidden' id='tmp_idOrigen' value='" + listaOrdenDestino[i].idOrigen + "' />";
									 nuevaFila+= "<input type='hidden' id='tmp_idDestino' value='" + listaOrdenDestino[i].idDestino + "' />";
									 nuevaFila+= "<input type='hidden' id='tmp_dias' value='" + listaOrdenDestino[i].nuDias + "' />";
									 nuevaFila+= "<input type='hidden' id='tmp_tipo' value='" + listaOrdenDestino[i].tiIda + "' />";
									 nuevaFila+= "<input type='hidden' id='tmp_isoOrigen' value='" + listaOrdenDestino[i].isoOrigen + "' />";
									 nuevaFila+= "<input type='hidden' id='tmp_isoDestino' value='" + listaOrdenDestino[i].isoDestino + "' />";
									 nuevaFila+= "<input type='hidden' id='tmp_fechaPartida' value='" + listaOrdenDestino[i].fePartidaDestino + "' />";
									 
									 
									
									 nuevaFila+= "<input type='hidden' id=tmp_idTour value='" + listaOrdenDestino[i].idTour + "' />";
									 nuevaFila+= "<input type='hidden' id=tmp_desTour value='" + listaOrdenDestino[i].nomTour + "' />";
									 nuevaFila+= "<input type='hidden' id=tmp_preAdultoTour value='" + listaOrdenDestino[i].preAdultoTour + "' />";
									 nuevaFila+= "<input type='hidden' id=tmp_preNinoTour value='" + listaOrdenDestino[i].preNinoTour + "' />";
									 nuevaFila+= "<input type='hidden' id=tmp_duracionTour value='" + listaOrdenDestino[i].diasTour + "' />";
									 nuevaFila+= "<input type='hidden' id=tmp_totalTour value='0' />";
									 
									 nuevaFila+= "<input type='hidden' id=tmp_idAerolinea value='" + listaOrdenDestino[i].idAerolinea + "' />";
									 nuevaFila+= "<input type='hidden' id=tmp_idProveedorAerolinea value='" + listaOrdenDestino[i].idProveedorAerolinea + "' />";
									 nuevaFila+= "<input type='hidden' id=tmp_precioAerolinea value='" + listaOrdenDestino[i].precioAerolinea + "' />";
									 nuevaFila+= "<input type='hidden' id=tmp_urlAerolinea value='" + listaOrdenDestino[i].urlAerolinea + "' />";
									 nuevaFila+= "<input type='hidden' id=tmp_nomAerolinea value='" + listaOrdenDestino[i].nombreAerolinea + "' />";
									 nuevaFila+= "<input type='hidden' id=tmp_comision value='" + listaOrdenDestino[i].comision + "' />";
									 nuevaFila+= "<input type='hidden' id=tmp_totalAerolinea value='0' />";
										
									 
									 nuevaFila+= "<input type='hidden' id=tmp_idHotel value='" + listaOrdenDestino[i].idHotel + "' />";
									 nuevaFila+= "<input type='hidden' id=tmp_idProveedorHotel value='" + listaOrdenDestino[i].idProveedorHotel + "' />";
									 nuevaFila+= "<input type='hidden' id=tmp_idTipoAlojamiento value='" + listaOrdenDestino[i].idTipoAlojamiento + "' />";
									 nuevaFila+= "<input type='hidden' id=tmp_idCategoriaAlojamiento value='" + listaOrdenDestino[i].idCategoriaAlojamiento + "' />";
									 nuevaFila+= "<input type='hidden' id=tmp_Habitaciones value='" + listaOrdenDestino[i].habitaciones + "' />";
									 nuevaFila+= "<input type='hidden' id=tmp_totalHotel value='0' />";
									 nuevaFila+= "<input type='hidden' id=tmp_nomTipoAlojamiento value='" + listaOrdenDestino[i].nomTipoAlojamiento + "' />";
									 nuevaFila+= "<input type='hidden' id=tmp_nomCategoriaAlojamiento value='" + listaOrdenDestino[i].nomCatAlojamiento + "' />";
									 nuevaFila+= "<input type='hidden' id=tmp_nomHotel value='" + listaOrdenDestino[i].nomHotel + "' />";
											
									 
									 nuevaFila+= "<td class='text-center'>" + listaOrdenDestino[i].nomDestino + "</td>";
									 nuevaFila+= "<td class='text-right'>" + "<input type='text' class='form-control text-center' id='txtNuDias' maxlength='2' value='" + listaOrdenDestino[i].nuDias + "' onclick='soloNumeros(\""+obj+"\",\""+evt+"\");' />"; 
									 nuevaFila+= "<br />" + verActualizar + "</td>";
									 nuevaFila+= "<td class='text-left'>" + "" + "</td>";
									 nuevaFila+= "<td class='text-left'>" + "" + "</td>";
									 nuevaFila+= "<td class='text-left'>" + "" + "</td>";
									 nuevaFila+= "<td class='text-center'>" + VerBuscar + "</td>";
									 nuevaFila+="</tr>";
								 }
								
								 $("#tblDestinos tbody").append(nuevaFila);
				                	
							 }
							 
							 
							 //Mostrando los totales y resultado de la busqueda inteligente
							 var detalleTour = "";
							 var detalleAerolinea = "";
							 var detalleHotel = "";
							 var filaHabitacion = "";
							 var detallehabitacion = "";
							 var habitaciones = "";
							 var totalHotel = parseFloat(0);
							 var totalTours = parseFloat(0);
							 var totalTicket = parseFloat(0);
							 var cantAdulto = $("#txtcantAdultos").val();
							 var cantNino = $("#txtcantNinos").val();
							 var origen = $("#hdnNomOrigen").val();
							 
							 $("#tblDestinos tbody > tr").each(function () {
									var row = $(this);
									var destinoRow = row.find('input[id="tmp_idDestino"]').val();
									var idAerolinea = row.find('input[id="tmp_idAerolinea"]').val();
									var idTour = row.find('input[id="tmp_idTour"]').val();
									var idHotel = row.find('input[id="tmp_idHotel"]').val();
									
									//Mostrando datos del tour
									if(idTour != "0"){
										var preAdulto = row.find('input[id="tmp_preAdultoTour"]').val();
										var preNino = row.find('input[id="tmp_preNinoTour"]').val();
										
										
										
										var totalTour = parseFloat(preAdulto)* parseInt(cantAdulto) + parseFloat(preNino) * parseInt(cantNino);
										row.find('input[id="tmp_totalTour"]').val(totalTour);
										totalTours = totalTours + totalTour ;
										
										var verEliminarTour = "<span> <a href='javascript:;' onclick='eliminarTour(this)' title='Eliminar' ><span class='glyphicon glyphicon-trash'></span></a> </span>";
										
										
										detalleTour = "Descripcion : " + row.find('input[id="tmp_desTour"]').val() ;
										detalleTour += "<br />";
										detalleTour += "Horas :" + row.find('input[id="tmp_duracionTour"]').val();
										detalleTour += "<br />";
										detalleTour += "Costo :" + totalTour;
										detalleTour += "<br />";
										detalleTour += verEliminarTour;
										row.find("td").eq(5).html(detalleTour);
									}
									
									
									//Mostrando datos del vuelo
									if(idAerolinea != "0") {
										
										var precio = row.find('input[id="tmp_precioAerolinea"]').val();
										
										var adultos = parseInt($("#txtcantAdultos").val());
										var ninos = parseInt($("#txtcantNinos").val());
										var personas = parseInt(adultos + ninos);
										var preciofinal = parseFloat(precio) * parseInt(personas);
										row.find('input[id="tmp_precioAerolinea"]').val(preciofinal);
										
										
										var verEliminarVuelo = "<span> <a href='javascript:;' onclick='eliminarVuelo(this)' title='Eliminar' ><span class='glyphicon glyphicon-trash'></span></a> </span>";
										totalTicket = totalTicket + parseFloat(row.find('input[id="tmp_precioAerolinea"]').val());
										detalleAerolinea = "Aerolinea: " + row.find('input[id="tmp_nomAerolinea"]').val();
										detalleAerolinea+= "<br />";
										detalleAerolinea+= "Origen: " + origen;
										detalleAerolinea+= "<br />";
										detalleAerolinea+= "Precio: " + preciofinal;
										detalleAerolinea+= "<br />";
										detalleAerolinea+= "Comision: " + row.find('input[id="tmp_comision"]').val();
										detalleAerolinea+= verEliminarVuelo;
										row.find("td").eq(4).html(detalleAerolinea);
									}
									
									
									
									
								   if(idHotel != "0") {	
									habitaciones = row.find('input[id="tmp_Habitaciones"]').val();
									//console.log("Habitaciones : " + habitaciones);
									
									if(habitaciones != "" || habitaciones != null) {
										
										//Mostrando datos del hotel
										var conthoteles = 0;
										detallehabitacion = "";
										var nomTipo = "";
										var nomCategoria = "";
										var nomHotel = "";
										var dias = 0;
										var subtotal = 0;
										var indice = parseInt(habitaciones.length) - 1;
										//alert(indice);
										habitaciones = habitaciones.substring(0,indice);
										
										
										
									
										var listaHabitaciones = habitaciones.split('|');
										nomTipo = row.find('input[id="tmp_nomTipoAlojamiento"]').val();
										nomCategoria = row.find('input[id="tmp_nomCategoriaAlojamiento"]').val();
										nomHotel = row.find('input[id="tmp_nomHotel"]').val();
										dias = row.find('input[id="tmp_dias"]').val();
										console.log("Dias : " + dias);
										console.log("Lista Habitaciones :" + listaHabitaciones.length);
										
										var precio = parseFloat(0);
										var cantidad = parseInt(0);
										subtotal = 0;
										for(var i = 0;i < listaHabitaciones.length;i++){
											conthoteles++;
											filaHabitacion = listaHabitaciones[i].split('-');
											precio = parseFloat(filaHabitacion[2]);
											cantidad = parseInt(filaHabitacion[3]);
											subtotal += (precio * cantidad) * parseInt(dias); 
											//totalHotel += subtotal;		
										}
										
										totalHotel += subtotal;
										
										if(conthoteles > 0){
											var noches = dias - 1;
											var estadia = "";
											estadia = dias.toString() + " dias";
											if(noches > 0){
												if(noches == 1)
													estadia += " y " + noches.toString() + " noche";
												else
													estadia += " y " + noches.toString() + " noches";
											}
											
											row.find('input[id="tmp_totalHotel"]').val(subtotal);
											var verEliminarHotel = "<span> <a href='javascript:;' onclick='eliminarHotel(this)' title='Eliminar' ><span class='glyphicon glyphicon-trash'></span></a> </span>";
											
											detalleHotel = "Hotel :" + nomHotel;
											detalleHotel += "<br />";
											detalleHotel +="Estadia :" + estadia;
											detalleHotel += "<br />";
											detalleHotel +="Costo :" + subtotal; 
											detalleHotel += "<br />";
											detalleHotel +="Tipo Alojamiento :" + nomTipo; 
											detalleHotel += "<br />";
											detalleHotel +="Categoria Alojamiento :" + nomCategoria; 
											detalleHotel += "<br />";
											detalleHotel += verEliminarHotel;
											
											row.find("td").eq(3).html(detalleHotel);      
										}
										
										
										
										
									}
								   }
								    
									
									origen = row.find("td").eq(1).text();
							 });		
							 
							 
							
							 var presupuesto = $("#txtPresupuestoMaximo").val();
							 
							 if(busInteligente == 1){
								 
								 $("#hdnTotalTour").val(totalTours);
								 $("#hdnTotalTicket").val(totalTicket);
								 $("#hdnTotalHotel").val(totalHotel);
								 
								 var totalPackage = parseFloat(totalTours) + parseFloat(totalTicket) + parseFloat(totalHotel);
								 $("#txtTotalGasto").val(totalPackage);
								 
								 if(totalPackage > presupuesto && cumple == 0){
									 $("#selTipoPrograma").val(5);
									 $('#selTipoPrograma').prop('disabled', true);
								 }
								 else {
									 $("#selTipoPrograma").val(4);
									 $('#selTipoPrograma').prop('disabled', false);
								 }			 
							 }
							 else {
								 $('#selTipoPrograma').prop('disabled', false);
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
				
		
			
			
			
			
			
		}
		
		function changeValue(objId,idtabla) {
			 
			var tabla = "";
			
			if(idtabla == 0)
				tabla = "tblServiciosTuristicos";
			else if(idtabla == 1)
				tabla = "tblDetalleVuelos";
			else if(idtabla == 2)
				tabla = "tblTours";
			else if(idtabla == 3)
				tabla = "tblHoteles";
			
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
	            	
	            	console.log("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
	            	console.log(response);
	                
					var rpta = response.dataJson;
					var msj = rpta.mensaje;
					var estado = rpta.idestado;
					$("#btnBuscarPropuesta").attr("disabled", true);
					$("#tblServiciosTuristicos tbody").html("");
					$("#tblDestinos tbody").html("");
					$("#txtTotalGasto").val(0);
					$("#selTipoPrograma").val("");
					$("#selTipoPrograma").attr("disabled", false);
					
					if(rpta.status == 1) {
						
						var hoy = new Date();
						var fecha_partida = rpta.fechapartida.substring(0,10);
						var from = fecha_partida.split("-");
						
						
						var fechPartida = new Date(from[2], from[1] - 1, from[0]);
						
						if(fechPartida < hoy) {
							msj = "No se encuentra en fecha para esta orden";
							$("#txtDescripcionOrden").val("");
							$("#txtObservacion").val("");
							//$("#txtPresupuestoMinimo").val("");
							$("#txtPresupuestoMaximo").val("");
							$("#txtCliente").val("");
							$("#txtFechaOrden").val("");
							$("#txtDescripcion").val("");
							$("#txtFechaPartida").val("");
							$("#txtFechaRetorno").val("");
							$("#txtcantAdultos").val("");
							$("#txtcantNinos").val("");
							$("#hdIdOrden").val("");
							$("#hdnOrdenValida").val("0");
							$("#hdnTipoPrograma").val("0");
							$("#hdnIdCotizacion").val("0");
							$("#hdnIdOrigen").val("0");
							$("#hdnNomOrigen").val("");
							$("#mensajeClienteError").html(msj);
							
							$('#divMensajeErrorCliente').modal({
								backdrop: 'static',
								keyboard: false
							}); 
							
							return false;
						}
						
						
						if(estado != 6) {
							msj = "La orden de planificacion no se encuentra asignada";
							
							$("#txtDescripcionOrden").val("");
							$("#txtObservacion").val("");
							//$("#txtPresupuestoMinimo").val("");
							$("#txtPresupuestoMaximo").val("");
							$("#txtCliente").val("");
							$("#txtFechaOrden").val("");
							$("#txtDescripcion").val("");
							$("#txtFechaPartida").val("");
							$("#txtFechaRetorno").val("");
							$("#txtcantAdultos").val("");
							$("#txtcantNinos").val("");
							$("#hdIdOrden").val("");
							$("#hdnOrdenValida").val("0");
							$("#hdnTipoPrograma").val("0");
							$("#hdnIdCotizacion").val("0");
							$("#hdnIdOrigen").val("0");
							$("#hdnNomOrigen").val("");
							
							$("#mensajeClienteError").html(msj);
							
							$('#divMensajeErrorCliente').modal({
								backdrop: 'static',
								keyboard: false
							}); 
							
							
							
							return false;
							
						}
						
						
						$("#txtDescripcionOrden").val(rpta.descripcion);
						$("#txtObservacion").val(rpta.observacion);
						//$("#txtPresupuestoMinimo").val(rpta.presupuestomin);
						$("#txtPresupuestoMaximo").val(rpta.presupuestomax);
						$("#txtCliente").val(rpta.cliente);
						$("#txtFechaOrden").val(rpta.fechaorden);
						$("#txtFechaPartida").val(rpta.fechapartida);
						$("#txtFechaRetorno").val(rpta.fecharetorno);
						$("#txtcantAdultos").val(rpta.nuaultos);
						$("#txtcantNinos").val(rpta.nuninos);
						$("#hdIdOrden").val(rpta.idorden);
						$("#hdnOrdenValida").val("1");
						$("#hdnTipoPrograma").val(rpta.tipoPrograma);
						$("#txtDescripcion").val(rpta.motivo);
						$("#hdnIdCotizacion").val(rpta.idCotizacion);
						$("#hdnIdOrigen").val(rpta.idOrigen);
						$("#hdnNomOrigen").val(rpta.nomOrigen);
						
						$("#btnBuscarPropuesta").attr("disabled", false);
						
						/*
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
						*/
					}
					else {
						$("#txtDescripcionOrden").val("");
						$("#txtObservacion").val("");
						//$("#txtPresupuestoMinimo").val("");
						$("#txtPresupuestoMaximo").val("");
						$("#txtCliente").val("");
						$("#txtFechaOrden").val("");
						$("#txtDescripcion").val("");
						$("#txtFechaPartida").val("");
						$("#txtFechaRetorno").val("");
						$("#txtcantAdultos").val("");
						$("#txtcantNinos").val("");
						$("#hdIdOrden").val("");
						$("#hdnOrdenValida").val("0");
						$("#hdnTipoPrograma").val("0");
						$("#hdnIdCotizacion").val("0");
						$("#hdnIdOrigen").val("0");
						$("#hdnNomOrigen").val("0");
						
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
			
			if($("#txtTotalGasto").val() == "")
				$("#txtTotalGasto").val("0");
			
			if($("#txtPresupuestoMaximo").val() == "")
				$("#txtPresupuestoMaximo").val("0");
			
			var busInteligente = 0;
			
			if($('#chkPropuesta').prop('checked')) {
				busInteligente = 1;
			}
			else {
				busInteligente = 0;
			}
			
			
			var totalgasto = parseFloat($("#txtTotalGasto").val());
			var presupuestoMax = parseFloat($("#txtPresupuestoMaximo").val());
			var msj = "";
			
			
			if(busInteligente == 0 && totalgasto > presupuestoMax){
				msj += "El total de gasto excede al presupuesto <br />\n";
			}
			
			var idestado = $("#selTipoPrograma").val();
			
			if(idestado == "")
				msj += "Debe seleccionar el estado del paquete <br />\n";
			
			
			var nombre = $("#nombre").val();
			
			if(nombre == "")
				msj += "Debe ingresar el nombre del paquete <br />\n";
			
				
			var orden_valida = $("#hdnOrdenValida").val();
			
			if(orden_valida == "0")
				msj += "Debe ingresar una orden valida <br />\n";
			
			
				
			if(msj != "") {
				$("#mensajeClienteError").html(msj);
				
				$('#mdlConfirmaRegistro').modal("hide");
				
				
				$('#divMensajeErrorCliente').modal({
					backdrop: 'static',
					keyboard: false
				}); 
				
				return false;
			}
			
			$('#txtTotalGasto').removeAttr('disabled');
			$("#chkPropuesta").removeAttr('disabled');
			
			
			
			var idOrden = $("#txtcodOrden").val();
			//var nomPaquete = $("#txtpaqueteTuristico").val();
			
			//alert(idOrden);
			//alert(nomPaquete);
			
			//var params = "?idOrden="+idOrden+"&nombre="+nomPaquete;
			
			
			var destinos = "";
			var filaDestino = "";
			var filaTour = "";
			var tours = "";
			var tickets = "";
			var filaTicket = "";
			var filaHotel = "";
			var hoteles = "";
			
			var adultos = $("#txtcantAdultos").val();
			var ninos = $("#txtcantNinos").val();
			var personas = parseInt(adultos) + parseInt(ninos);
			
			$("#tblDestinos tbody > tr").each(function () {
				
				var row = $(this);
				var destinoRow = row.find('input[id="tmp_idDestino"]').val();
				var dias = row.find('input[id="tmp_dias"]').val();
				var idTour = row.find('input[id="tmp_idTour"]').val();
				var desTour = row.find('input[id="tmp_desTour"]').val();
				var preAdultoTour = row.find('input[id="tmp_preAdultoTour"]').val();
				var preNinoTour = row.find('input[id="tmp_preNinoTour"]').val();
				var idAerolinea = row.find('input[id="tmp_idAerolinea"]').val();
				var idProvAerolinea = row.find('input[id="tmp_idProveedorAerolinea"]').val();
				var precioAerolinea = row.find('input[id="tmp_precioAerolinea"]').val();
				var urlAerolinea = row.find('input[id="tmp_urlAerolinea"]').val();
				var tipo = row.find('input[id="tmp_tipo"]').val();
				var fechaPartida = row.find('input[id="tmp_fechaPartida"]').val();
				
				var idhotel = row.find('input[id="tmp_idHotel"]').val();
				var idprovhotel = row.find('input[id="tmp_idProveedorHotel"]').val();
				var idtipoalojamiento = row.find('input[id="tmp_idTipoAlojamiento"]').val();
				var idcatalojamiento = row.find('input[id="tmp_idCategoriaAlojamiento"]').val();
				var habitaciones = row.find('input[id="tmp_Habitaciones"]').val();
				var desHotel = "";
				
				
				var item = row.find('td').eq(0).text();
				
				//registrando destinos 
				
				filaDestino = destinoRow + "," + item + "," + dias + "," + fechaPartida;
				
				destinos += filaDestino + ";";
				
				
				//registrando tours
				if(idTour != "0") {
					filaTour = idTour + "," + desTour + "," + personas + "," +  preAdultoTour + "," + preNinoTour + "," + destinoRow ;
					tours += filaTour + ";";
				}
				
				//registrando tickets	
				if(idAerolinea != "0"){
					
					console.log("- - - - - - - - - - - Ticket[]");

					filaTicket = idProvAerolinea + "," + idAerolinea + "," + precioAerolinea + "," + destinoRow + "," + tipo + "," + fechaPartida + "," + urlAerolinea ;					
					console.log(filaTicket);
					
					tickets += filaTicket + ";";
					console.log(tickets);
					
				}
				
				//registrando hoteles
				if(idhotel != "0"){
					
					filaHotel = destinoRow + "," + idhotel + "," + idprovhotel + "," + idtipoalojamiento + "," + idcatalojamiento + "," + desHotel + "," + adultos + "," + ninos + "," + habitaciones;
					hoteles += filaHotel + ";";
				}
				
				
			});
			
			console.log("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			console.log("tickets");
			console.log(tickets);
			
			
			var modo = $("#txtflagEdicion").val();
			
			var params = "?destinos=" + destinos; 
			params += "&tours=" + tours;
			//params += "&tickets=" + tickets;
			params += "&hoteles=" + hoteles;
			params += "&modo=" + modo;
			
			console.log("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			console.log("params");
			console.log(params);
			
			var ruta ="";
			/*
			if ( $("#txtflagEdicion").val() == 1 ) {
				ruta = '${pageContext.request.contextPath}/editarInseminacion';
			} else{ 
				ruta = '${pageContext.request.contextPath}/grabarTransaccionPaqTuristico'+params;
			}
			*/
			
			ruta = '${pageContext.request.contextPath}/grabarTransaccionPaqTuristico'+params;
			
			//alert(ruta);
			
			var obj = formToObject('#frmRegPaqueteTuristico');
			obj["tickets"] = tickets;
			
			var grabarFormParams = {
					'paqueteTuristicoBean' : obj					
			};
			
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
							$("#mensajeTransaccion").html("Se modific&oacute; satisfactoriamente el paquete turi&oacute;stico");
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
		//$("#txtPresupuestoMinimo").val("");
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
									<input type="hidden"  id="hdIdOrden" name="idOrden" value="${idOrden}" />
									<input type="hidden" name ="idPaquete"  id="hdIdPaquete" value="${idPaquete}" />
									<input type="hidden" name="totalTour" id="hdnTotalTour" value="${totalTour}"/>
									<input type="hidden" name="totalTicket" id="hdnTotalTicket" value="${totalTicket}"/>
									<input type="hidden" name="totalHotel" id="hdnTotalHotel" value="${totalHotel}"/>
									<input type="hidden" name="idCotizacion" id="hdnIdCotizacion" value="${idCotizacion}"/>
									<input type="hidden" name="idOrigen" id="hdnIdOrigen" value="${idOrigen}"/>
									<input type="hidden" name="nomOrigen" id="hdnNomOrigen" value="${nomOrigen}"/>
									
									
									
									<input type="hidden" value="0" id="hdnOrdenValida" />
									<input type="hidden" value="0" name="idTipoPaquete" id="hdnTipoPrograma" value="${idTipoPaquete}" />
									
									<div class="form-group">										
										<input type="hidden" name="flagEdicion" id="txtflagEdicion" value="${modo}" />								
										<div class="col-sm-8" id="divCodigoAnimal" ></div>
									</div>
									
									
									<div class="form-group">
										<div class="col-sm-3"  style="text-align:right; font-weight:bold">Fecha:</div>
										<div class="col-sm-3" id="divCodigoAnimal" >${fecha}
										<span style="display:none">
											<input type="text" name="fecha"   value="${fecha}" />
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
																	<input type="text" class="form-control tamanoMaximo" name="codigoOrden" id="txtcodOrden" value="${nuOrden}" />
																</div>	
																
																																													
																<div class="col-sm-2">
																	<input id="txtDescripcionOrden" readonly="readonly" onkeypress="return validarNumeroLetra(event)" name="descripcionOrden" value="${descripcion}" type="text" maxlength="30" class="form-control" />
																</div>
																
																<div class="col-sm-2">
																<!--	<button id="btnBuscarOrdenPlanificacion" class="btn btn-primary btn-block"  title="Buscar">Buscar</button> -->
																	<button id="btnBuscarOrdenPlanificacion" type="button" class="btn btn-primary centro" onclick="buscarOrdenesPlanificacion()" title="Buscar Orden">Buscar</button>
																</div>
																
																<label class="col-sm-2 control-label">Fecha Orden:</label>	
																<div class="col-sm-2">
																	<input id="txtFechaOrden" readonly="readonly" name="fechaOrden" type="text" maxlength="10" class="form-control" value="${fechaorden}" />	
																
																</div>
															</div>
															
															
															
															
															
															<div class="form-group">
																<div class="col-sm-2" style="text-align:right; font-weight:bold">Cliente:</div>
																<div class="col-sm-9" id="divNombreAnimal">
																	<input id="txtCliente" readonly="readonly" name="nombreCliente" type="text" maxlength="80" class="form-control" value="${cliente}" />
																</div>
															</div>
															
															<div class="form-group">
																<div class="col-sm-2" style="text-align:right; font-weight:bold">Motivo de Viaje</div>
																<div class="col-sm-9" id="divNombreAnimal">
																	<textarea class="form-control" readonly="readonly" name="descripcion" id="txtDescripcion" onkeypress="return validarNumeroLetra(event)" rows="3" cols="98" >${motivoViaje}</textarea>
																</div>
															</div>
															
															<div class="form-group">
																
																<label class=" control-label col-sm-2">Presupuesto:</label>	
																<div class="col-sm-3">
																	<input name="ImMax" readonly="readonly" id="txtPresupuestoMaximo" type="text" class="form-control tamanoMaximo" value="${presupuestomax}"></input>
																</div>
															</div>
															
															<div class="form-group">
																
																	<label class=" control-label col-sm-2">Fecha Partida:</label>																
																	
																	<div class="col-sm-3">
																		<div class="input-group date tamanoMaximo" id="divFechaPartida">
																			<input name="feInicio" readonly="readonly" id="txtFechaPartida"  type="text" class="form-control tamanoMaximo txtFecha" value="${fechapartida}" />
																			
																		</div>
																	</div>
																	
																	<label class=" control-label col-sm-2 col-md-offset-2">Fecha Retorno:</label>
																	
																	<div class="col-sm-3">
																		<div class="input-group date tamanoMaximo" id="divFechaRetorno">
																			<input name="feFin" readonly="readonly" id="txtFechaRetorno"  type="text" class="form-control tamanoMaximo txtFecha" value="${fecharetorno}" />																		
																		</div>
																	</div>		
															</div>		
																	
																	
															<div class="form-group">
																	<label class=" control-label col-sm-2">Cantidad adultos:</label>	
																
																	<div class="col-sm-3">
																		<input id="txtcantAdultos" readonly="readonly" name="nuNinos" type="text" maxlength="30" class="form-control" value="${nuaultos}" placeholder="Cantidad Adultos">
																	</div>
																	<label class=" control-label col-sm-2 col-md-offset-2">Cantidad Ninos:</label>	
																
																	<div class="col-sm-2">
																		<input id="txtcantNinos" readonly="readonly" name="nuAdultos" type="text" maxlength="30" class="form-control" value="${nuninos}" placeholder="Cantidad Ninos">
																	</div>		
															</div>
																		
															
															<div class="form-group">
																<div class="col-sm-2" style="text-align:right; font-weight:bold">Comentario:</div>
																<div class="col-sm-9" id="divNombreAnimal">
																	<textarea class="form-control" readonly="readonly" id="txtObservacion" name="comentario"  onkeypress="return validarNumeroLetra(event)" rows="3" cols="98"  placeholder="Observaciones de la Orden">${comentario}</textarea>
																</div>
															</div>
													</div>
												</div>
												
											</div>
										</div>
									</div>
									
									<div class="col-sm-12" id="divReservaHistoricas">
										<div class="panel panel-primary">
											<div class="panel-heading">	<strong>B&uacute;squeda Autom&aacute;tica</strong></div>
											
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
																				<th width="10%" class="text-center">Destino</td>
																				<th width="10%" class="text-center">D&iacute;as</td>
																				<th width="15%" class="text-center">Hotel</td>
																				<th width="15%" class="text-center">Vuelo</td>
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
											<input id="nombre" name="nombre" type="text" maxlength="30" class="form-control" value="${nombrePaquete}">
										</div>
										
										<div class="col-sm-2" style="text-align:right; font-weight:bold">Estado Paquete Turistico:</div>
											<div class="col-sm-2" id="divNombreAnimal">
												<select name="idEstado" id="selTipoPrograma" class="form-control tamanoMaximo"  > 
													<option value="">---Seleccione---</option>
													<option value="4">Pendiente</option>
													<option value="5">Finalizado</option> 
													<option value="6">Asignado</option>
													<option value="7">Disponible</option>
												</select>
											</div>
										
									</div>
									
									<div class="form-group">
										<div class="col-sm-3"  style="text-align:right; font-weight:bold">Precio Total:</div>
										
										<div class="col-sm-2">
											<input id="txtTotalGasto" name="totalGasto" type="text" maxlength="30" class="form-control" disabled="disabled" value="${totalGasto}">
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-sm-3" style="text-align:right; font-weight:bold">Observaciones:</div>
											<div class="col-sm-8" id="divObservacionPaquete">
													<textarea class="form-control" name="observacion" maxlength="2000" id="txtObservacionPaquete" rows="3" cols="90"  placeholder="Observaciones">${observacion}</textarea>
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
						<div class="modal-body"> <p class="text-center" id="mensajeTransaccion">Se registro satisfactoriamente el Paquete Turi&oacute;stico</p></div>
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

