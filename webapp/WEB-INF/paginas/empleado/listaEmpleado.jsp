<%@page import="pe.com.paxtravel.bean.ClienteBean"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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

	        inicia();
	        
	        $("#btnPopupAceptarParamMin").on("click",function(){
	        	if (isEmpty('#txtNombres', '')) $('#txtNombres').focus();
	        	if (!isEmptySelect('#tipoUsuario', '')) $('#tipoUsuario').focus();
	        	$( '#divModalPopupParamMin' ).modal( 'hide' );
	        });
	        
	        $("#btnImprimirEmpleado").on("click", function(){
	        	window.print();
	        })
	        
		});

        function inicia(){
        	
        	
        	//llenando combo lista de usuarios
        	var jsonUsuarios = <%=SojoUtil.toJson(listaTipoUsuario)%>;
        	document.getElementById("selTipoUsuario").options[0] = new Option("---");
    		document.getElementById("selTipoUsuario").options[0].value = "";

        	for (var i = 0; i < jsonUsuarios.length; i++) {
				document.getElementById("selTipoUsuario").options[i+1] = new Option(jsonUsuarios[i].descripcion);
       	        document.getElementById("selTipoUsuario").options[i+1].value = jsonUsuarios[i].codigo;
    		}
        	
        	fillGrilla( [] );
        	$('#divFecNac').datetimepicker({
	            language: 'es',
	            autoClose : true,
	            format: 'DD/MM/YYYY',
				pickTime: false,
				autoClose:true,
				useCurrent: false
	        });
	        	
        	//buscando empleado
        	$("#btnBuscarEmpleado").on('click', function(e){
        		e.preventDefault();
        		buscar();
        	})
        	//limpiando el formulario de busqueda y la grilla
        	$("#btnLimpiarEmpleado").on('click', function(e){
        		e.preventDefault();
        		$( '#formEmpleado' ).trigger( 'reset' );
        		fillGrilla( [] );
        	})
        	//exportar data a excel
        	$("#btnExportarEmpleado").on('click', function(e){
        		e.preventDefault();
        		exportarExcel();
        	})
        }
        
        function exportarExcel(){
        	if (gDataGrilla == null || gDataGrilla.length==0){
        		showMensajeAlert( 'Exportar Excel', 'No existe información para Exportar a Excel');
    			return;
        	}
        	
        	var params = $("#formEmpleado").serialize();
        	$(location).prop( 'href', 'exportaListaEmpleado?' + params);
        }
        
        function buscar() {
        	if ( $("#selTipoUsuario").val()=="" ){
        		$("#divModalPopupParamMin").modal();
        		return;
        	}
        	
			$.ajax({
	            url: 'obtenerEmpleadosInicial',
	            data: $('#formEmpleado').serialize(),
	            cache: false,
	            async: false,
	            type: 'GET',
	            dataType: 'json',
	            success: function(data) {
	                if (handleErrorJson(data)) {
	                    return;
	                }
	                rpta = data.dataJson;

            	    // actualizando lista
	                var listaEmpleados = [];
	                if (rpta.listaEmpleados != null) {
	                	listaEmpleados = rpta.listaEmpleados;
	                }
					alert(listaEmpleados);
	                fillGrilla(listaEmpleados);
	            },
	            error: function(data, textStatus, errorThrown) {
	                handleError(data);
	            }
        	}); 
        }
        
		function isEmpty( controlID ) {
			return $.trim( $( controlID ).val() ) == '';
		}
		
		function isEmptySelect( controlID, compareTo ) {
			val = $( controlID ).val();
			varia = $.trim(val) == compareTo; 	
			return varia; 
		}

		function fillGrilla(dataGrilla){
			
			gDataGrilla = dataGrilla;
			var table = $('#tblEmpleados').dataTable({
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
	            iDisplayLength: generarTamanioPagina( rpta.pagConForm ),
	            responsive: true,
	            bLengthChange: false,
	            info: false,
            	language: {
                    url: "http://localhost:7001/PaxTravelInternational/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/plug-ins/1.10.7/i18n/Spanish.json"
                },
	            
	            fnDrawCallback: function(oSettings) {
	                if (oSettings.fnRecordsTotal() != 0) {
	                    $('#tblEmpleados_paginate').addClass('hiddenDiv');
	                } else {
	                    $('#tblEmpleados_paginate').removeClass('hiddenDiv');
	                }
	            },
	            columnDefs: [{
	            	targets: 8,
	            	render: function(data, type, row){
	            		if (row !=null && typeof row != 'undefined') {
	            			return "<span> <a href='verDetalleEmpleado?codigoEmpleado="+row.codigo+"' title='Ver Detalle' ><span class='glyphicon glyphicon-search'></span></a> </span>";
	            		}
	            		return '';
	            	}
	            }],
	            columns: [
					{ data: "codigo" }, 
					{ data: "username" },
					{ data: "nombre", "class": "text-center" },
					{ data: "paterno" }, 
					{ data: "materno", "class": "text-center" },
					{ data: "fechaNacimiento", "class": "text-center" },
					{ data: "dni" }, 
					{ data: "tipoUsuario", "class": "text-center" },
					{ data: "Ver Detalle", "class": "text-center" }
	            ]
			});
		}
		
		<%@ include file="../commons/commons-javascript-functions.jsp" %>
		
	</script>
	
</head>

<body>
	<div id="container">
        <div class="col-sm-12" id="divConsForm">
        
        	<div class="panel panel-primary">
		
				<div class="panel-heading">
                    <h3 class="panel-title" align="center">FILTROS DE BÚSQUEDA</h3>
                </div>
                
                <div class="panel-body">
                	<div class="row">
                		<div class="col-sm-12">
       			
							<form id="formEmpleado" class="form-horizontal" method="POST">
	                			<div class="form-group">
									<label class="col-sm-3 control-label">Nombres:</label>
									<div class="col-sm-3">
										<input id="txtNombres" name="nombre" type="text" maxlength="30" class="form-control">
									</div>
									<label class="col-sm-3 control-label">Usuario:</label>
									<div class="col-sm-3">
										<input id="txtUsername" name="username" type="text" maxlength="30" class="form-control">
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label">Apellido Paterno:</label>
									<div class="col-sm-3">
										<input id="txtApe_pat" name="paterno" type="text" maxlength="30" class="form-control">
									</div>
									<label class="col-sm-3 control-label">Apellido Materno:</label>
									<div class="col-sm-3">
										<input id="txtApe_mat" name="materno" type="text" maxlength="30" class="form-control">
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label">DNI:</label>
									<div class="col-sm-3">
										<input id="txtDni" name="dni" type="text" maxlength="30" class="form-control">
									</div>
									<label class="col-sm-3 control-label">Fecha de Nacimiento:</label>
									<div class="col-sm-3" id="divFecNac">
										<div class="input-group date" >
											<input id="txtFec_nac" type="text" name="fechaNacimiento" maxlength="10" class="form-control">
											<span class="input-group-addon">
												<span class="glyphicon glyphicon-calendar"></span>
											</span>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label">Tipo Usuario:</label>
									<div class="col-sm-3">
										<select name="tipoUsuario" id="selTipoUsuario" class="form-control tamanoMaximo"> </select>
									</div>
									<div class="col-sm-6">
										
									</div>
								</div>
								
								<div class="row">&nbsp;</div>
								
								<div class="form-group">
									<div class="col-sm-2 col-sm-offset-8">
										<button id="btnLimpiarEmpleado" class="btn btn-primary btn-block" title="Limpiar">Limpiar</button>
									</div>
									<div class="col-sm-2">
										<button id="btnBuscarEmpleado" type="button" class="btn btn-primary btn-block" title="Buscar">Buscar</button>
									</div>
								</div>
							</form>
                		</div>
                	</div>
                </div>
            </div>
			<div class="panel panel-primary">
		
				<div class="panel-heading">
                    <h3 class="panel-title" align="center">LISTANDO EMPLEADOS</h3>
                </div>
                
                <div class="panel-body">
							<div class="row">&nbsp;</div>	
							<div id="divTablaConsForm">
								<table id="tblEmpleados" class="table-bordered display" cellspacing="0" width="100%" >
									<thead>
										<tr>
											<th class="text-center">CODIGO</th>
											<th>USUARIO</th>
											<th>NOMBRE</th>
											<th>PATERNO</th>
											<th>MATERNO</th>
											<th>FECHA DE NACIMIENTO</th>
											<th>DNI</th>
											<th>ESTADO</th>
											<th>VER DETALLE</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>			
							
							<div class="row">&nbsp;</div>
							<div class="row">&nbsp;</div>
						
							<div class="row">
								<div class="col-sm-2 col-sm-offset-8">
									<button id="btnImprimirEmpleado" class="btn btn-primary btn-block" title="Imprimir">Imprimir</button>
								</div>
								<div class="col-sm-2">
									<button id="btnExportarEmpleado" class="btn btn-primary btn-block" title="Exportar a Excel">Exportar a Excel</button>
								</div>					
							</div>
							 			
							<div class="row">&nbsp;</div>
<!-- 						</div> -->
<!-- 					</div> -->
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../commons/commons-mensaje-popup.jsp" %>
	
	<!-- mensaje especial parametros minimos (solo porque tiene problemas en IE8) -->
	<div id="divModalPopupParamMin" class="modal fade" tabindex="-1" role="dialog" >
	    <div class="modal-dialog">
	    	<div class="modal-content">
		    	<div class="panel panel-warning">
		            <div class="panel-heading">Mensaje</div>
		            <div class="panel-body">
		                <div class="modal-body">
		                	Debe ingresar los par&aacute;metros para la b&uacute;squeda, las combinaciones m&iacute;nimas son: <br> 
		                 	Tipo Usuario<br />
						</div>
		                <div class="text-center">
		                    <button id="btnPopupAceptarParamMin" type="button" class="btn btn-primary">Aceptar</button>
		                </div>
		            </div>
		        </div>
	    	</div>
	    </div>
	</div> 
</body>

</html>