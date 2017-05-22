<%@page import="pe.gob.sunat.framework.spring.util.conversion.SojoUtil"%>
<%@page import="java.util.ArrayList"%>
<%-- <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%> --%>
<%-- <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%-- <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%-- <%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%> --%>
<%-- <%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> --%>
<jsp:useBean id="mapaDatos" scope="request" class="java.util.HashMap" />
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<% 
ArrayList listaTipoUsuarios = (ArrayList) mapaDatos.get("listTipoUsuario");
ArrayList listaEstado = (ArrayList) mapaDatos.get("listEstado");

// System.out.print("listaTipoUsuarios: " + listaTipoUsuarios.size());
%>
<!DOCTYPE html>

<html lang="es">
<head><br>a<br>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<%-- <spring:url value="/resources/js/jquery/1.11.2/jquery.min.js" var="jquery" /> --%>
<%-- <script src="${jquery}"></script> --%>

    <script src="/a/resources/js/jquery/1.11.2/jquery.min.js"></script>
    <script src="/a/resources/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/media/js/jquery.dataTables.min.js"></script>
	<script src="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/extensions/Responsive/js/dataTables.responsive.js"></script>
	<script src="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/plug-ins/1.10.7/i18n/Spanish.json"></script>
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
	<script src="/a/resources/bootstrap/3.3.2/plugins/bootstrap-datetimepicker-3.1.3/css/bootstrap-datetimepicker.min.css"></script>
	
	<!-- bootstrap validator-->
	<script src="/a/resources/js/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
	
	
<script>

 	$(document).ready(function(){
 		inicia();
 		
 		var jsonUsuarios = <%=SojoUtil.toJson(listaTipoUsuarios)%>;
		var jsonEstado = <%=SojoUtil.toJson(listaEstado)%>;
		
		document.getElementById("selCodigoTipoUsuario").options[0] = new Option("---------");
		document.getElementById("selCodigoTipoUsuario").options[0].value = "";
		
		document.getElementById("selEstado").options[0] = new Option("---------");
		document.getElementById("selEstado").options[0].value = "";
		
		for (var i = 0; i < jsonUsuarios.length; i++) {
	        document.getElementById("selCodigoTipoUsuario").options[i+1] = new Option(jsonUsuarios[i].descripcion);
	        document.getElementById("selCodigoTipoUsuario").options[i+1].value = jsonUsuarios[i].codigo;
		}
		
		for (var i = 0; i < jsonEstado.length; i++) {
	        document.getElementById("selEstado").options[i+1] = new Option(jsonEstado[i].descripcion);
	        document.getElementById("selEstado").options[i+1].value = jsonEstado[i].codigo;
		}
 		
 		$('#frmDatosEmpleado').bootstrapValidator({
 			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
 			fields:{
 				codigoTipoUsuario: {
 					validators: {
 						notEmpty: {
 							message: 'Seleccione un Tipo de usuario'
 						}
 					}
 				},
 				username: {
 					validators: {
 						notEmpty: {
 							message: 'Ingrese un n&uacute;mero de Documento'
 						},
 						stringLength: {
 							min:1,
 							max:8,
 							message: 'El n&uacute;mero de documento debe ser m&aacute;ximo 8 caracteres'
 						},
 						regexp: {
							regexp: /^[a-z\-*0-9]+$/i,
							message: 'Solo numeros letras y guiones'
 						}
 					}
 				},
 				apellidoPaterno: {
 					validators: {
 						stringLength: {
 							min:1,
 							max:30,
 							message: 'El apellido paterno debe ser m&aacute;ximo 30 caracteres'
 						},
	 					regexp: {
	 						regexp: /^[a-zñáéíóú\s]+$/i,
	 						message: 'Solo debe ingresar letras'
	 					}
 					}
 				},
 				apellidoMaterno: {
 					validators: {
 						stringLength: {
 							min:1,
 							max:30,
 							message: 'El apellido materno debe ser m&aacute;ximo 30 caracteres'
 						},
	 					regexp: {
	 						regexp: /^[a-zñáéíóú\s]+$/i,
	 						message: 'Solo debe ingresar letras'
	 					}
 					}
 				},
 				nombre: {
 					validators: {
	 					regexp: {
	 						regexp: /^[a-zñáéíóú\s]+$/i,
 							message: 'El nombre debe ser m&aacute;ximo 30 caracteres'
	 					}
 					}
 				},
 				fechaNacimiento: {
 					validators: {
 						callback:{
 							message: 'Seleccione una fecha',
 							callback: function(value, validator, $field){
 								if(value=="")return false;
								else return true;
								
 							}
 						}
 					}
 				},
 				fechaIngreso: {
 					validators: {
 						callback:{
							message:'Ingrese fecha de ingreso del pa&iacute;s v&aacute;lida',
							callback: function (value, validator, $field){
								var fechaSalida = $('#fecCese').val();
								var arrfechaSalida = fechaSalida.split("/");
								var anio = arrfechaSalida[2];
								var mes = arrfechaSalida[1];
								var dia = arrfechaSalida[0];
								var dFechaSalida = new Date(anio+"/"+mes+"/"+dia);

								if(fechaSalida==""){
									return false;
								}
								
								var fechaIngresoPais = $('#fecIngreso').val();
								var arrfechaIngresoPais = fechaIngresoPais.split("/");
								var anio = arrfechaIngresoPais[2];
								var mes = arrfechaIngresoPais[1];
								var dia = arrfechaIngresoPais[0];
								var dFechaIngreso = new Date(anio+"/"+mes+"/"+dia);

								if(dFechaIngreso>dFechaSalida){
									return false;
								}
								// si la fecha de ingreso es mayor o igual a la fecha de salida retorna
								return dFechaIngreso>=dFechaSalida;
							}
						}
 					}
 				},
 				fechaSalida: {
 					validators: {
 						callback:{
							message:'Ingrese fecha de salida del pa&iacute;s v&aacute;lida',
							callback: function (value, validator, $field){
								var fechaSalida = $('#fecCese').val();
								var arrfechaSalida = fechaSalida.split("/");
								var anio = arrfechaSalida[2];
								var mes = arrfechaSalida[1];
								var dia = arrfechaSalida[0];
								var dFechaSalida = new Date(anio+"/"+mes+"/"+dia);

								if(fechaSalida==""){
									return false;
								}
								
								var fechaIngresoPais = $('#fecIngreso').val();
								var arrfechaIngresoPais = fechaIngresoPais.split("/");
								var anio = arrfechaIngresoPais[2];
								var mes = arrfechaIngresoPais[1];
								var dia = arrfechaIngresoPais[0];
								var dFechaIngreso = new Date(anio+"/"+mes+"/"+dia);
								
								// si la fecha de ingreso es mayor o igual a la fecha de salida retorna
								return dFechaSalida>=dFechaIngreso;
							}
						}
 					}
 				},
 				fechaCese: {
 					validators: {
 						notEmpty: {
 							message: 'ingresar fecha de cese'
 						}
 					}
 				}
 			}
 		}).on('success.form.bv', function(e){
 			confirmarRegistro();
 		});
 		
 		// validando fechas
 		$('#divFecIngreso').on('dp.change dp.show', function(e) {
 			// limpia todos los objetos del formulario -> resetForm
 			//$('#frmDatosEmpleado').bootstrapValidator('resetForm', true);
 			//limpia un objeto especifico de un formulario
 			$('#frmDatosEmpleado').bootstrapValidator('revalidateField', 'fechaIngreso');
 			$('#frmDatosEmpleado').bootstrapValidator('revalidateField', 'fechaCese');
 		});
 		
 		$('#divFecCese').on('dp.change dp.show', function(e) {
 			$('#frmDatosEmpleado').bootstrapValidator('revalidateField', 'fechaIngreso');
 			$('#frmDatosEmpleado').bootstrapValidator('revalidateField', 'fechaCese');
 		});
 		
 		
 		$('#formCliente').bootstrapValidator({
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			excluded: [':disabled'],
			fields: {
				codigo: {
                    validators: {
                        notEmpty: {
                            message: 'Ingrese un código'
                        },
                        callback: {
                        	message: 'mensaje personalidado',
                        	callback: function(value, validator, $field){
                        		if (value != "s"){
                        			return true;
                        		} else {
                        			return false;
                        		}
                        	}
                        }
                    }
                },
                estado: {
                    validators: {
                        notEmpty: {
                            message: 'Seleccione un estado'
                        }
                    }
                }
			}
 			
 		}).on('success.form.bv', function(e) {
 			agregarCliente();
 		});
 		
 		
 		$('#frmValidacionesAdicionales').bootstrapValidator({
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			excluded: [':disabled'],
			fields: {
				hidValidacion01: {
                    validators: {
                        callback: {
                        	message:'Ingrese fecha de ingreso al pa&iacute;s v&aacute;lida',
                        	callback: function(value, validator, $field){
                        		return validarGrillasVacias();
                        	}
                        }
                    }
                }
			}
 		}).on('success.form.bv', function(e) {
 			e.preventDefault();
 		})
 		
 		construirTablaCliente([]);
 		
 	});
 	
 	function agregarCliente(){
 	
 		var codigo = $("#txtCodigo").val();
 		var paterno = $("#txtPaterno").val();
 		var materno = $("#txtMaterno").val();
 		var nombre = $("#txtNombreCliente").val();
 		var dni = $("#txtDni").val();
 		var ciudad = $("#txtCiudad").val();
 		var direccion = $("#txtDireccion").val();
 		var telefono = $("#txtTelefono").val();
 		//var estado = $("#selEstado").val();
 		var estado = $("#selEstado option:selected").text();
 		
 		var botonEditar = "<button name='"+dni+"' type='button' class='btn btn-default' onclick='editarCliente(this.name)'>";
			botonEditar +="<span class='glyphicon glyphicon-pencil' aria-hidden='true'></span></button>";

		var botonEliminar ="<button name='"+dni+"' type='button' class='btn btn-default' onclick='eliminarCliente(this.name)'>";
			 botonEliminar +="<span class='glyphicon glyphicon-remove' aria-hidden='true'></span></button>";
 		
 		var data = [botonEditar+"&nbsp;&nbsp;&nbsp"+botonEliminar,codigo,paterno,materno,nombre,dni,ciudad,direccion,telefono,estado];
		var row = $('#tblCliente').DataTable().row;
		var index = $('#hidFilaEditarCliente').val();
		if(index==""){
			row.add(data).draw( false );
		}else{
			$('#tblCliente').DataTable().row(document.getElementById(idFilaEditar)).data( data ).draw();
		}
		
		$('#hidFilaEditarCliente').val("");
		$('#divCliente').modal('hide');
// 		$('#frmValidacionesAdicionales').bootstrapValidator('revalidateField', 'hidValidacion01');
		
 	}
 	
 	function construirTablaCliente( dataGrilla ){
 		var table = $('#tblCliente').dataTable({
            data: dataGrilla,
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
                    $('#tblCliente_paginate').addClass('hiddenDiv');
                } else {
                    $('#tblCliente_paginate').removeClass('hiddenDiv');
                }
            },
            
            fnRowCallback: function (nRow, aData, iDisplayIndex) {
				$(nRow).attr('id', aData[5]);
				$(nRow).attr('align', 'center');
				$(nRow).attr('rowClasses','tableOddRow');
                return nRow;
            },
			
            /*
			language: {
                url: "/a/js/libs/bootstrap/3.3.2/plugins/datatables-1.10.7/plug-ins/1.10.7/i18n/Spanish.json"
			},*/
			columns: [
	            {"class": "botones"},
				{"class": ""},
				{"class": ""},
				{"class": ""},
				{"class": ""},
				{"class": ""},
				{"class": ""},
				{"class": ""},
				{"class": ""},
				{"class": ""}
			]
        });
 	}
 	
 	function validarGrillasVacias(){
 		var tblCliente = $("#tblCliente").DataTable().rows().data();
 		if(tblCliente.length==0){
			$("#mensajeCliente").removeAttr("style");
			$("#mensajeCliente").css({"color" : "red", "display" : "inline", "font-size" : "12px" });
			return false;
		}
 	}
 	
 	function registrarEmpleado(){
		 $.ajax({
	         url: '${pageContext.request.contextPath}/cargarDatosSession',
	       	 data: $('#frmRegistrar').serialize(),
	         cache: false,
	         async: true,
	         type: 'GET',
	         contentType : "application/json; charset=utf-8",
	         dataType: 'json',
	         success: function(response) {
	         	$(location).prop( 'href', '${pageContext.request.contextPath}/registrarPassword');
	         },
	         error: function(data, textStatus, errorThrown) {
	        	 alert(eval("'"  + data + "'" )+ " - " + textStatus + " - " + errorThrown);
	         }
	     });
	 }

 	// valida en base a una empresion regular
 	function ev(x, event){
 		//var regex = /^[a-zñáéíóú\s]+$/i;
 		// VALIDA SOLO NUMEROS POR EXPRESION REGULAR
 		var regex = /^[0-9\s]+$/i;
 		var _event = event || window.event;
 	    var key = _event.keyCode || _event.which;
 	    key = String.fromCharCode(key);
 	    if(!regex.test(key)) {
 	    	return false;
 	        /*_event.returnValue = false;
 	        if (_event.preventDefault){
 	        	alert("1");
 	            _event.preventDefault();
 	        } else{
 	        	alert("2");
 	        }*/
 	    }
 	}
 	
	function inicia(){
		$("#divFecNac").datetimepicker({
			language: 'es',
            autoClose : true,
            format: 'DD/MM/YYYY',
			pickTime: false,
			autoClose:true,
			useCurrent: false,
			pickerPosition: "bottom-right"
		});
		
		$("#divFecIngreso").datetimepicker({
			language: 'es',
            autoClose : true,
            format: 'DD/MM/YYYY',
			pickTime: false,
			autoClose:true,
			useCurrent: false,
			pickerPosition: "bottom-right"
		});
		
		$("#divFecCese").datetimepicker({
			language: 'es',
            autoClose : true,
            format: 'DD/MM/YYYY',
			pickTime: false,
			autoClose:true,
			useCurrent: false,
			pickerPosition: "bottom-right"
		});
	}
	
	function mostrarCliente(){
		$('#formCliente').bootstrapValidator('resetForm', true);
		$("#divCliente").modal({
			backdrop: 'static',
			keyboard: false
		});
	}
	
	function guardarClienteTmp(){
		$('#formCliente').submit();
	}
	
	function editarCliente(fila){
		$('#formCliente').bootstrapValidator('resetForm', true);
	
		var table = $('#tblCliente').DataTable();
		var index = table.row(document.getElementById(fila)).index();
		idFilaEditar = fila;
		var estado = (table.rows().data()[index][9])=="Activo"?1:2;
		
		$('#txtCodigo').val(table.rows().data()[index][1]);
		$('#txtPaterno').val(table.rows().data()[index][2]);
		$('#txtMaterno').val(table.rows().data()[index][3]);
		$('#txtNombreCliente').val(table.rows().data()[index][4]);
		$('#txtDni').val(table.rows().data()[index][5]);
		$('#txtCiudad').val(table.rows().data()[index][6]);
		$('#txtDireccion').val(table.rows().data()[index][7]);
		$('#txtTelefono').val(table.rows().data()[index][8]);
		$('#selEstado').val(estado);		
		
		$('#hidFilaEditarCliente').val(index);
		$('#divCliente').modal({
			backdrop: 'static',
			keyboard: false
        });
	}

	function eliminarCliente(fila){
		var tabla = $('#tblCliente').DataTable();
		tabla.row('#'+fila).remove().draw( false );
// 		$('#frmValidacionesAdicionales').bootstrapValidator('revalidateField', 'hidValidacion01');
	}
	
	function confirmarRegistro(){
		$('#mdlConfirmaRegistro').modal({
			backdrop: 'static',
			keyboard: false
		});	
	}
	
	function registrarTransaccion(){

		var dataJson = $("#tblCliente").DataTable().rows().data();
		
		var datosCliente = [];
		
		for (var i=0; i<dataJson.length; i++){
			var obj = new Object();
			obj.CODIGO    = dataJson[i][1];
			obj.PATERNO   = dataJson[i][2];
			obj.MATERNO   = dataJson[i][3];
			obj.NOMBRE    = dataJson[i][4];
			obj.DNI       = dataJson[i][5];
			obj.CIUDAD    = dataJson[i][6];
			obj.DIRECCION = dataJson[i][7];
			obj.TELEFONO  = dataJson[i][8];
			obj.ESTADO    = dataJson[i][9];
			datosCliente[i] = obj;
		}
		
		var grabarFormParams = {
			'empleadoBean' : formToObject( '#frmDatosEmpleado' ),
			'datosCliente' : datosCliente 
		};


		$.ajax({
            url: '${pageContext.request.contextPath}/grabarTransaccion?mensaje=hola',
           	data: JSON.stringify(grabarFormParams),
            cache: false,
            async: true,
            type: 'POST',
            contentType : "application/json; charset=utf-8",
            dataType: 'json',
            success: function(response) {
            	alert(response);
            },
            error: function(data, textStatus, errorThrown) {
            	alert(data);
            	alert(textStatus);
            	alert(errorThrown);
            }
        });
		alert("holaa");
		
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

</head>

<body>


<div id="container" class="container" style="width: 100%">
	<div class="row col-sm-offset-0 col-sm-12">
		<div class="principal">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title"><center><strong>REGISTRO DE EMPLEADO</strong></center></h3>
				</div>
				<div class="panel-body">

					<div class="col-sm-12">
						<div class="panel panel-primary">
						<div class="panel-heading">	<strong>Datos del Extranjero No Domiciliado </strong></div>
						<div class="panel-body">
							<div class="col-sm-12" id="dvSecDatosExtNoDom">
								<form class="form-horizontal" role="form" name="frmDatosEmpleado" id="frmDatosEmpleado" method="post">
									
									<div class="form-group">
										<div class="col-sm-5">Tipo de Usuario:</div>
										<div class="col-sm-5">
											<select name="codigoTipoUsuario" id="selCodigoTipoUsuario" class="form-control tamanoMaximo"> </select>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-5">Usuario:</div>
										<div class="col-sm-5">
											<input name="username" id="txtUsername" type="text" class="form-control tamanoMaximo" value="${t6625Bean.numeroDocumento}"></input>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-5">Password:</div>
										<div class="col-sm-5">
											<input name="password" id="txtPassword" type="password" class="form-control tamanoMaximo" value="${t6625Bean.numeroDocumento}"></input>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-5">Confirmar Password:</div>
										<div class="col-sm-5">
											<input name="confirmarPassword" id="txtConfirmaPassword" type="password" class="form-control tamanoMaximo" value="${t6625Bean.numeroDocumento}"></input>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-5">Apellido Paterno:</div>
										<div class="col-sm-5">
											<input name="apellidoPaterno" id="txtApellidoPaterno" type="text" class="form-control tamanoMaximo" maxlength="30" value="${t6625Bean.apellidoPaterno}"></input>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-5">Apellido Materno:</div>
										<div class="col-sm-5">
											<input name="apellidoMaterno" id="txtApellidoMaterno" type="text" class="form-control tamanoMaximo" maxlength="30" value="${t6625Bean.apellidoMaterno}"></input>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-5">Nombres:</div>
										<div class="col-sm-5">
											<input name="nombre" id="txtNombre" type="text" class="form-control tamanoMaximo" maxlength="40" value="${t6625Bean.nombre}"></input>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-5">Fecha de Nacimiento:</div>
										<div class="col-sm-3" id="divFecNac">
											<div class="input-group date">
												<input id="fecNacimiento" type="text" name="fechaNacimiento" class="form-control" maxlength="10" />
												<span class="input-group-addon">
													<span class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>
											
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-5">Fecha de Ingreso:</div>
										<div class="col-sm-3" id="divFecIngreso">
											<div class="input-group date">
												<input id="fecIngreso" type="text" name="fechaIngreso" readonly="yes" value="${fechaIngreso}" class="form-control" maxlength="10" />
												<span class="input-group-addon">
													<span class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>
											
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-5">Fecha de Cese:</div>
										<div class="col-sm-3" id="divFecCese">
											<div class="input-group date">
												<input id="fecCese" type="text" name="fechaCese" readonly="yes" value="${fechaCese}" class="form-control" maxlength="10" />
												<span class="input-group-addon">
													<span class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>
											
										</div>
									</div>
									
									
									
									
									
								</form>
							</div>
						</div>
						</div>
					</div>
					
					
					<div class="col-sm-12" id="divSecDatosPagRenta">
						<div class="panel panel-primary">
							<div class="panel-heading">	<strong>Detalles de Clientes y Sucursales</strong></div>
							<input type="hidden" id="hidFilaEditarCliente" name="hidFilaEditarCliente" value="">
							
							<div class="panel-body">
												
								<div id="dvSubSecPagRenta">
									<div class="col-sm-12" align="right">
										<div class="form-group">
											<input type="button" class="btn btn-primary" intermediateChanges="false" data-dismiss="modal" value="Agregar Cliente" id="btnAgregaCliente" onclick="mostrarCliente()"></input>
										</div>
									</div>
									
									
									<div class="col-sm-12">
										<table id ="tblCliente" class="table table-bordered responsive" style="width:100%">
											<thead>
												<tr>
													<th width="10%" class="text-center">Opciones</td>
													<th width="10%" class="text-center">Codigo</td>
													<th width="25%" class="text-center">Paterno</td>
													<th width="25%" class="text-center">Materno</td>
													<th width="25%" class="text-center">Nombre</td>
													<th width="10%" class="text-center">DNI</td>
													<th width="10%" class="text-center">Ciudad</td>
													<th width="25%" class="text-center">Dirección</td>
													<th width="10%" class="text-center">Tel&eacute;fono</td>
													<th width="10%" class="text-center">Estado</td>
												</tr>
											</thead>
										</table>
										
									</div>
									
									<div class="col-xs-12">
										<span id="mensajeCliente" style="display: none">(*)Ingrese por lo menos un cliente</span>
										<form id="frmValidacionesAdicionales" name="frmValidacionesAdicionales" class="form-inline" align="left">
											<input type="hidden" id="hidValidacion01" name="hidValidacion01" value="">
										</form>
									</div>
									
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12" align="center">
							<button id="btnLimpiarEmpleado" class="btn btn-primary" title="Limpiar">Limpiar</button>
							<button id="btnBuscarEmpleado" type="button" class="btn btn-primary" onclick="registrarTransaccion()" title="Buscar">Registrar Transaccion</button>
						</div>
					</div>
					
				</div>

				
			</div>

			
		</div>
	</div>
</div>

<div id="divCliente" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
		
			<div class="panel-heading">
				<h3 class="panel-title"><strong>Cliente</strong></h3>
			</div>
		
		
			<div class="panel-body">
				<form id="formCliente" name="formCliente">
				
						<div class="form-group">
							<div class="col-md-4 control-label" style="text-align: left">Código:</div>
							<div class="col-md-5">
								<input id="txtCodigo" name="codigo" type="text" class="form-control tamanoMaximo" 
								style="padding-right:25px" maxlength="15" />
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-md-4 control-label" style="text-align: left">Paterno</div>
							<div class="col-md-5">
								<input id="txtPaterno" name="paterno" type="text" class="form-control tamanoMaximo" 
								style="padding-right:25px" maxlength="15" />
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-md-4 control-label" style="text-align: left">Materno:</div>
							<div class="col-md-5">
								<input id="txtMaterno" name="materno" type="text" class="form-control tamanoMaximo" 
								style="padding-right:25px" maxlength="15" />
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-4 control-label" style="text-align: left">Nombre:</div>
							<div class="col-md-5">
								<input id="txtNombreCliente" name="nombre" type="text" class="form-control tamanoMaximo" 
								style="padding-right:25px" maxlength="15" />
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-md-4 control-label" style="text-align: left">DNI:</div>
							<div class="col-md-5">
								<input id="txtDni" name="dni" type="text" class="form-control tamanoMaximo" 
								style="padding-right:25px" maxlength="15" />
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-md-4 control-label" style="text-align: left">Ciudad:</div>
							<div class="col-md-5">
								<input id="txtCiudad" name="importePagado" type="text" class="form-control tamanoMaximo" 
								style="padding-right:25px" maxlength="15" />
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-md-4 control-label" style="text-align: left">Dirección:</div>
							<div class="col-md-5">
								<input id="txtDireccion" name="direccion" type="text" class="form-control tamanoMaximo" 
								style="padding-right:25px" maxlength="15" />
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-md-4 control-label" style="text-align: left">Teléfono:</div>
							<div class="col-md-5">
								<input id="txtTelefono" name="telefono" type="text" class="form-control tamanoMaximo" 
								style="padding-right:25px" maxlength="15" />
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-md-4 control-label" style="text-align: left">Estado:</div>
							<div class="col-md-5">
								<select name="estado" id="selEstado" class="form-control tamanoMaximo"> </select>
							</div>
						</div>
				</form>
			</div>
			
			<div class="modal-footer">
				<div class="col-sm-12" align="center">
					<input type="button" class="btn btn-primary" intermediateChanges="false" data-dismiss="" value="Aceptar"
						onclick="guardarClienteTmp();" id="btnGuardar01"></input>
					<button type="button" class="btn btn-primary cerrar" data-dismiss="modal" onclick="cancelar()">Cancelar</button>
				</div>
			</div>
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
							onclick="registrarTransaccion();" id="btnGrabaRegistro"></input>
						<button type="button" id="btnRegistroNo" class="btn btn-primary" data-dismiss="modal">No</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	

	<div id="mdlCorreo" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="panel panel-info">
				<div class="panel-heading">  <div id="divTituloInfo"> </div></div>
				<div class="panel-body">
					<div class="modal-body"> <div id="divMensajeInfo"> </div></div>
					<div class="modal-footer"><center><button type="button" class="btn btn-primary" data-dismiss="" onclick="aceptarRegistroCorreo();">Aceptar</button></center>
					</div>
				</div>
			</div>
		</div>
	</div>

	
</body>

</html>