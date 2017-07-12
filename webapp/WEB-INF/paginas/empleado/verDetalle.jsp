<%@page import="pe.com.paxtravel.bean.ClienteBean"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Hola Mundo Spring</title>
	
	<spring:url value="/resources/js/jquery/1.11.2/jquery.min.js" var="jquery" />
	<spring:url value="/resources/bootstrap/3.3.2/js/bootstrap.min.js" var="btmin" />
	<spring:url value="/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/media/js/jquery.dataTables.min.js" var="dtmin" />
	<spring:url value="/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/extensions/Responsive/js/dataTables.responsive.js" var="dtresp" />
	<spring:url value="/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/plug-ins/1.10.7/i18n/Spanish.json" var="spanish" />
	<spring:url value="/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/extensions/Scroller/js/dataTables.scroller.js" var="dtscroll" />
	
	<!-- estilos -->	
	<spring:url value="/resources/bootstrap/3.3.2/css/bootstrap.min.css" var="btcss" />
	<spring:url value="/resources/bootstrap/3.3.2/css/bootstrap-theme.min.css" var="btthcss" />
	<spring:url value="/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/media/css/jquery.dataTables.css" var="dtjqcss" />
	<spring:url value="/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/media/css/jquery.dataTables_themeroller.css" var="dtthcss" />
	<spring:url value="/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/extensions/Responsive/css/dataTables.responsive.css" var="dtrpcss" />
	<spring:url value="/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/extensions/Scroller/css/dataTables.scroller.css" var="dtsccss" />
	
	<!-- datetimepicker -->
	<spring:url value="/resources/bootstrap/3.3.2/plugins/bootstrap-datetimepicker-3.1.3/js/moment-with-locales.js" var="dtpcmm" />
	<spring:url value="/resources/bootstrap/3.3.2/plugins/bootstrap-datetimepicker-3.1.3/js/bootstrap-datetimepicker.min.js" var="dtpcbt" />
	<spring:url value="/resources/bootstrap/3.3.2/plugins/bootstrap-datetimepicker-3.1.3/css/bootstrap-datetimepicker.min.css" var="btdtcss" />
	
	
	<script src="${jquery}"></script>
	<script src="${btmin}"></script>
	<script src="${dtmin}"></script>
	<script src="${dtresp}"></script>
	<script src="${dtscroll}"></script>
	<script src="${dtpcmm}"></script>
	<script src="${dtpcbt}"></script>
	
	<link  href="${btcss}" rel="stylesheet">
	<link  href="${btthcss}" rel="stylesheet">
	<link  href="${dtjqcss}" rel="stylesheet">
	<link  href="${dtthcss}" rel="stylesheet">
	<link  href="${dtrpcss}" rel="stylesheet">
	<link  href="${dtsccss}" rel="stylesheet">
	<link  href="${btdtcss}" rel="stylesheet">
	
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
		
		divOculto {
		
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

	        $("#btnRetornar").on("click",function(){
	        	javascript:window.history.back();
	        });
	        
		});
	</script>
	
</head>

<body>
	<div id="container">
        <div class="col-sm-12" id="divConsForm">
        
        	<div class="panel panel-primary">
		
				<div class="panel-heading">
                    <h3 class="panel-title" align="center">FORMULARIO DE EMPLEADO</h3>
                </div>
                
                <div class="panel-body">
               		<div class="panel panel-primary">

						<div class="panel-heading">
							Datos del Empleado
						</div>

						<div class="panel-body">

							<div class="row">
								<div class="col-sm-4">
									 <p class="text-left"><strong>Codigo:</strong></p>
								</div>
								<div class="col-sm-8">
									 <p class="text-left">${codigo}</p>
								</div>
							</div>

							<div class="row">
								<div class="col-sm-4">
									 <p class="text-left"><strong>Usuario:</strong></p>
								</div>
								<div class="col-sm-8">
									 <p class="text-left">${usuario}</p>
								</div>
							</div>

							<div class="row">
								<div class="col-sm-4">
									 <p class="text-left"><strong>Nombre:</strong></p>
								</div>
								<div class="col-sm-8">
									 <p class="text-left">${nombre}</p>
								</div>
							</div>

							<div class="row">
								<div class="col-sm-4">
									 <p class="text-left"><strong>Apellido Paterno:</strong></p>
								</div>
								<div class="col-sm-8">
									 <p class="text-left">${paterno}</p>
								</div>
							</div>

							<div class="row">
								<div class="col-sm-4">
									 <p class="text-left"><strong>Apellido Materno:</strong></p>
								</div>
								<div class="col-sm-8">
									 <p class="text-left">${materno}</p>
								</div>
							</div>

							<div class="row">
								<div class="col-sm-4">
									 <p class="text-left"><strong>DNI:</strong></p>
								</div>
								<div class="col-sm-8">
									 <p class="text-left">${dni}</p>
								</div>
							</div>

							<div class="row">
								<div class="col-sm-4">
									 <p class="text-left"><strong>Fecha de Nacimiento:</strong></p>
								</div>
								<div class="col-sm-8">
									 <p class="text-left">${fechaNacimiento}</p>
								</div>
							</div>
							
							<div class="form-group">
								<div class="col-sm-2 col-sm-offset-10">
									<button id="btnRetornar" class="btn btn-primary btn-block" title="Retornar">Retornar</button>
								</div>
							</div>

						</div>

					</div>
                	
                	
                </div>
            </div>
			
		</div>
	</div>
	
	
	
</body>

</html>