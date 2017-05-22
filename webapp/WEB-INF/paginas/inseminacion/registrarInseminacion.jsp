<style>
	.txtFecha{
		background-color: #FFF !important;
	}
</style>
<script>
	
	$(document).ready(function(){
	
        $.ajaxSetup({
            scriptCharset: "utf-8",
            contentType: "application/json; charset=utf-8"
        });
        jQuery.support.cors = true;
		
		
		$("#formInseminacion").bootstrapValidator({
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields:{
				toro: {
					validators: {
						notEmpty: {
							message: 'Seleccione toro para la inseminaci&oacute;n'
						}
					}
				},
				fechaInseminacion: {
					validators: {
						notEmpty: {
							message: 'Ingrese una fecha de inseminaci&oacute;n'
						}
					}
				},
				codigoToro: {
					validators: {
						notEmpty: {
							message: 'Seleccione un toro'
						}
					}
				},
				tipoInseminacion: {
					validators: {
						notEmpty: {
							message: 'Seleccione un m&eacute;todo de reproducci&oacute;n'
						}
					}
				}
			}
		}).on('success.form.bv', function(e){
			registrarInseminacion();
		});
		
		$("#selTipoInseminacion").val("1");
		
		var dpFechaInseminacion  = $('#divFechaInseminacion').datetimepicker({
			language : 'es',
            autoClose : true,
// 			minDate: $('#txtFechaIngreso').val(),
            format: 'DD/MM/YYYY',
            pickTime: false,
			useCurrent: false
        });

		dpFechaInseminacion.on("dp.change dp.show", function(e){
			$('#formInseminacion').bootstrapValidator('revalidateField', 'fechaInseminacion');
			/*var fechaPag = $('#divPRentaManualFecPago').datetimepicker().data().date;
			$("#txtFechaPagoManual").val("");
			$("#txtFechaPagoManual").val(fechaPag);*/
		});

        
	});
	
	function registrarInseminacion(){
		
		var grabarFormParams = {
			'inseminacionBean' : formToObject( '#formInseminacion' )
		};
		
		var ruta = "";
		if ( $("#txtflagEdicion").val() == 1 ) {
			ruta = '${pageContext.request.contextPath}/editarInseminacion';
		} else{ 
			ruta = '${pageContext.request.contextPath}/grabarInseminacion';
		}
		
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
					$("#divConfirmacionRegistroInseminacion").modal({
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
	
	function formToObject(formID) {
	    var formularioObject = {};
	    var formularioArray = $( formID ).serializeArray();
	    $.each(formularioArray, function(i, v) {
	        formularioObject[v.name] = v.value;
	    });
	    return formularioObject;
	}

	function aceptar(){
		$('#divRegistroInseminacion').modal("hide");
		location.href = '${pageContext.request.contextPath}/listarInseminacion';
	}
	
	function validarNumeroLetra(e){
		var key = window.Event ? e.which : e.keyCode;
		return ( (key >= 48 && key <= 57) || (key==32 ) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) );
 	}
</script>

<div class="panel-heading" >
	<h3 class="panel-title" align="center" id="tituloInseminacion"></h3>
</div>

<div class="panel-body">
	<div class="row">
		<div class="col-sm-12">

			<form id="formInseminacion" name="formInseminacion" role="form" class="form-horizontal" method="post">
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">C&oacute;digo Animal:</div>
					<input type="hidden" name="codigoVaca" id="txtCodigoAnimal" />
					<input type="hidden" name="flagEdicion" id="txtflagEdicion" />
					<input type="hidden" name="codigoInseminacion" id="txtCodigoInseminacion" />
					<div class="col-sm-8" id="divCodigoAnimal" ></div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">Nombre Animal:</div>
					<div class="col-sm-8" id="divNombreAnimal"></div>
				</div>

				<div class="form-group">
					<label class="col-sm-4" style="text-align:right;">Toro:</label>
					<div class="col-sm-8" style="text-align: left">
						<select name="codigoToro" id="selToro" class="form-control tamanoMaximo"> 
							<option value="">---Seleccione---</option>
							<option value="78HO00003">78HO00003 - CHESTER</option>
							<option value="78HO00004">78HO00004 - POLAR</option>
						</select>
					</div>
				</div>
				
				<div class="form-group">
				
					<label class="col-sm-4" style="text-align:right;">Metodo de Reproduccion:</label>
					<div class="col-sm-8" style="text-align: left">
						<select name="tipoInseminacion" id="selTipoInseminacion" class="form-control tamanoMaximo"> 
							<option value="">---Seleccione---</option>
							<option value="1">Inseminación</option>
							<option value="2">Natural</option>
						</select>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">Fecha Inseminaci&oacute;n:</div>
					<div class="col-sm-8">
						<div class="input-group date tamanoMaximo" id="divFechaInseminacion">
							<input name="fechaInseminacion" id="txtFechaInseminacion" readonly="yes" type="text" class="form-control tamanoMaximo txtFecha" ></input>
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">Observaciones:</div>
					<div class="col-sm-8" id="divNombreAnimal">
						<textarea name="observacion" id="txtObservacion" onkeypress="return validarNumeroLetra(event)" rows="4" cols="50" value="s" /></textarea>
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
						<button id="btnRegistrar" class="btn btn-primary" 
							title="Continuar">Registrar</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>

<div id="divConfirmacionRegistroInseminacion" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Registro Satisfactorio</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center" id="mensajeTransaccion">Se registro satisfactoriamente la inseminaci&oacute;n de la vaca</p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">
						<input type="button" id="btnRegistro" class="btn btn-primary" onclick="aceptar()" value="Aceptar"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

