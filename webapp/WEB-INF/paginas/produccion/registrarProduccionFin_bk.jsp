<%@page import="pe.com.paxtravel.bean.ClienteBean"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="pe.gob.sunat.framework.spring.util.conversion.SojoUtil"%>
<jsp:useBean id="mapaDatos" scope="request" class="java.util.HashMap" />
<%
	ArrayList listaTipoUsuario = (ArrayList) mapaDatos.get("listTipoUsuario");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Hola Mundo Spring</title>
	
    <script src="/a/resources/js/jquery/1.11.2/jquery.min.js"></script>
    <script src="/a/resources/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/media/js/jquery.dataTables.min.js"></script>
	<script src="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/extensions/Responsive/js/dataTables.responsive.js"></script>
	<!--<script src="/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/plug-ins/1.10.7/i18n/Spanish.json"></script>-->
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
	<!--<script src="/a/resources/bootstrap/3.3.2/plugins/bootstrap-datetimepicker-3.1.3/css/bootstrap-datetimepicker.min.css"></script>-->
	
	<!-- bootstrap validator-->
	<script src="/a/resources/js/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
	
	
	
    <style type="text/css">
        .margin-sup {
            margin-top: 200px
        }
        
        .altura {
            height: 400px
        }
        
        .ancho {
            width: 750px
        }
        
        .ancho1 {
            width: 665px !important;
        }
        
        .tamanoMaximo {
            /*max-width: 350px !important;*/
            min-width: 100px !important;
            font-size: 12px;
        }
        
        .tamanoMinimo {
            /*max-width: 350px !important;*/
            min-width: 50px !important;
            font-size: 12px;
        }
        
        fieldset.scheduler-border {
            border: 1px groove #ddd !important;
            padding: 0 1.2em 0.4em 1.4em !important;
            margin: 0 0 1.5em 0 !important;
            -webkit-box-shadow: 0px 0px 0px 0px #000;
            box-shadow: 0px 0px 0px 0px #000;
        }
        
        legend.scheduler-border {
            width: inherit;
            /* Or auto */
            padding: 0 2px;
            /* To give a bit of padding on the left and right */
            border-bottom: none;
            margin-bottom: 0
        }
        
        .vcenter {
		    display: inline-block;
		    vertical-align: middle;
		    float: none;
		}
		
		/* quitar la alineacion a la derecha por default */
		.form-horizontal .control-label {
			text-align: left;
		}
		
		/* quitar el icono en la grilla */
		table.dataTable thead .sorting_asc {
			background-image: none;
		}
		
		table.dataTable thead th {
			border: 1px solid gray;
			background: Gainsboro !important;
			align: center;
		}
				
		table.dataTable tbody td {
			border: 1px solid gray !important;
		}
		
		.borde_fechas {
			border: 1px solid #848484 !important;
			margin-left: 3px;
		}
		
		.padding_fechas {
			margin-top: 10px;
			margin-bottom: 8px;
		}
		
		.alinearDerecha{
			text-align: right important!;
		}

    </style>
	<script type="text/javascript">
	
		var rpta = "";
		var gDataGrilla = null;
		
		$(document).ready(function(){
	        $.ajaxSetup({
	            scriptCharset: "utf-8",
	            contentType: "application/json; charset=utf-8"
	        });
	        jQuery.support.cors = true;

			/*
	        inicia();
	        
	        $("#btnPopupAceptarParamMin").on("click",function(){
	        	if (isEmpty('#txtNombres', '')) $('#txtNombres').focus();
	        	if (!isEmptySelect('#tipoUsuario', '')) $('#tipoUsuario').focus();
	        	$( '#divModalPopupParamMin' ).modal( 'hide' );
	        });
	        
	        $("#btnImprimirEmpleado").on("click", function(){
	        	window.print();
	        })*/
			
			$("#formProduccion").bootstrapValidator({
				feedbackIcons: {
					valid: 'glyphicon glyphicon-ok',
					invalid: 'glyphicon glyphicon-remove',
					validating: 'glyphicon glyphicon-refresh'
				},
				fields:{
					codigoAnimal: {
						validators: {
							notEmpty: {
								message: 'Ingrese codigo del animal'
							}
						}
					}
					
				}
			}).on('success.form.bv', function(e){
				continuaRegistro();
			});
	        
		});
		
		function registrarProduccion(){

			$.ajax({
	            url: '${pageContext.request.contextPath}/registrarProduccion',
// 	           	data: $('#formProduccion').serialize(),
	            cache: false,
	            async: true,
	            type: 'GET',
	            contentType : "application/json; charset=utf-8",
	            dataType: 'json',
	            success: function(response) {
	            	alert("registroooo");
	            },
	            error: function(data, textStatus, errorThrown) {
	            }
	        });
		
			/*$.ajax({
	            url: '${pageContext.request.contextPath}/continuarRegistro',
	           	data: $('#formProduccion').serialize(),
	            cache: false,
	            async: true,
	            type: 'GET',
	            contentType : "application/json; charset=utf-8",
	            dataType: 'json',
	            success: function(response) {
	            	$(location).prop( 'href', '${pageContext.request.contextPath}/abrirRegistroCorreo?');
	            },
	            error: function(data, textStatus, errorThrown) {
	            }
	        });*/
		}
		
		function limpiar(){
			$('#formProduccion').bootstrapValidator('resetForm', true);
		}
		
	</script>
	
</head>

<body>
	<div id="container">
        <div class="col-sm-12" id="divConsForm" style="width:35%; margin:120px 0px 0px 550px;">
        
        	<div class="panel panel-primary">
		
				<div class="panel-heading">
                    <h3 class="panel-title" align="center">${titulo}</h3>
                </div>
                
                <div class="panel-body">
                	<div class="row">
                		<div class="col-sm-12">
       			
							<form id="formProduccion" class="form-horizontal" method="POST">
	                			<div class="form-group">
									<label class="col-sm-10 control-label" style="text-align: right;">Fecha:</label>
									<div class="col-sm-2" style="text-align: right; padding-top: 5px">
										04/08/1986
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-4 control-label" style="text-align:right; padding-top:20px;">Código Animal:</label>
									<label class="col-sm-8 control-label" style="text-align:right; padding-top:20px;">${codigoAnimal}</label>
								</div>
								
								<div class="form-group">
									<label class="col-sm-4 control-label" style="text-align:right; padding-top:20px;">Cantidad Producida:</label>
									<label class="col-sm-8 control-label" style="text-align:right; padding-top:20px;">${cantidadProducida}</label>
								</div>
							
								<div class="row">&nbsp;</div>
								
								<div class="form-group">
									<div class="col-sm-6" style="text-align:center">
										<button id="btnRetornar" type="button" class="btn btn-primary centro" onclick="retornar()" style="width:220px;" title="Retornar">Retornar</button>
									</div>
									<div class="col-sm-6" style="text-align:center">
										<button id="btnRegistrar" class="btn btn-primary" style="width:220px;" title="Registrar" onclick="registrarProduccion()">Registrar</button>
									</div>
								</div>
							</form>
                		</div>
                	</div>
                </div>
            </div>
		</div>
	</div>

</body>

</html>