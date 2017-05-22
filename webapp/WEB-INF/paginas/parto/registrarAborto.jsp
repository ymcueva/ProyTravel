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
		
		
		$("#formAborto").bootstrapValidator({
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields:{
				fechaAborto: {
					validators: {
						notEmpty: {
							message: 'Ingrese una fecha de aborto'
						}
					}
				}
			}
		}).on('success.form.bv', function(e){
			registrarAborto();
		});
		
		$("#selTipoAborto").val("1");
		
		var dpFechaAborto  = $('#divFechaAborto').datetimepicker({
			language : 'es',
            autoClose : true,
// 			minDate: $('#txtFechaIngreso').val(),
            format: 'DD/MM/YYYY',
            pickTime: false,
			useCurrent: true
        });

		dpFechaAborto.on("dp.change dp.show", function(e){
			$('#formParto').bootstrapValidator('revalidateField', 'fechaAborto');
			/*var fechaPag = $('#divPRentaManualFecPago').datetimepicker().data().date;
			$("#txtFechaPagoManual").val("");
			$("#txtFechaPagoManual").val(fechaPag);*/
		});
		
	});
	
	function registrarAborto(){
		
		var grabarFormParams = {
			'abortoBean' : formToObject( '#formAborto' )
		};
		
		var ruta = "";
		/*if ( $("#txtflagEdicion").val() == 1 ) {
			ruta = '${pageContext.request.contextPath}/editarParto';
		} else{
			ruta = '${pageContext.request.contextPath}/grabarAborto';
		}*/
		
		ruta = '${pageContext.request.contextPath}/grabarAborto';
		
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
					/*if ( $("#txtflagEdicion").val() == 1 ) {
						$("#mensajeTransaccion").html("Se modific&oacute; satisfactoriamente el abort de la vaca");
					}*/
					$("#divConfirmacionRegistroAborto").modal({
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
		$('#divRegistroAborto').modal("hide");
		location.href = '${pageContext.request.contextPath}/listarVacasAParir';
	}
	
	function validarNumeroLetra(e){
		var key = window.Event ? e.which : e.keyCode;
		return ( (key >= 48 && key <= 57) || (key==32 ) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) );
 	}
</script>

<div class="panel-heading" >
	<h3 class="panel-title" align="center" id="tituloAborto"></h3>
</div>

<div class="panel-body">
	<div class="row">
		<div class="col-sm-12">

			<form id="formAborto" name="formAborto" role="form" class="form-horizontal" method="post">
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">C&oacute;digo Vaca:</div>
					<input type="hidden" name="codigoVaca" id="txtCodigoAnimalAborto" />
					<input type="hidden" name="numeroDiasPrenez" id="txtNumeroDiasPrenezAborto" />
					<div class="col-sm-8" id="divCodigoVacaAborto" ></div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">Nombre Toro:</div>
					<div class="col-sm-8" id="divNombreToroAborto" ></div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-4" style="text-align:right;">N&uacute;mero Días Preñez:</label>
					<div class="col-sm-8" id="divNumeroDiasPrenezAborto" ></div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-4" style="text-align:right;">Edad al aborto (meses):</label>
					<div class="col-sm-8" id="divEdadMesesAborto" ></div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">Fecha Aborto:</div>
					<div class="col-sm-8">
						<div class="input-group date tamanoMaximo" id="divFechaAborto">
							<input name="fechaAborto" id="txtFechaAborto" readonly="yes" type="text" class="form-control tamanoMaximo txtFecha" ></input>
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
							class="btn btn-primary centro" onclick="cerraAborto()"
							title="Cerrar">Cerrar</button>
					</div>
					<div class="col-sm-4" style="text-align: center">
						<button id="btnLimpiar" type="button"
							class="btn btn-primary centro" onclick="limpiarFormularioAborto()"
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

<div id="divConfirmacionRegistroAborto" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Registro Satisfactorio</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center" id="mensajeTransaccion">Se registro satisfactoriamente el aborto de la vaca</p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">
						<input type="button" id="btnRegistro" class="btn btn-primary" onclick="aceptar()" value="Aceptar"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

