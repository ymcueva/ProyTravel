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
		
		
		$("#formControl").bootstrapValidator({
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields:{
				diagnosttico: {
					validators: {
						notEmpty: {
							message: 'Seleccione diagnostico para el control del animal'
						}
					}
				},
				fechaControl: {
					validators: {
						notEmpty: {
							message: 'Ingrese una fecha de Control de Animal'
						}
					}
				},
				codigoAnimal: {
					validators: {
						notEmpty: {
							message: 'Ingrese un codigo de animal'
						}
					}
				},
				edad: {
					validators: {
						notEmpty: {
							message: 'Seleccione un m&eacute;todo de reproducci&oacute;n'
						}
					}
				},
				perimetroToraxico: {
					validators: {
						notEmpty: {
							message: 'Ingrese el per&iacute;metro tor&aacute;xico del animal'
						}
					}
				},
				peso: {
					validators: {
						notEmpty: {
							message: 'Ingrese el peso del animal'
						}
					}
				},
				altura: {
					validators: {
						notEmpty: {
							message: 'Ingrese la altura del animal'
						}
					}
				}
			}
		}).on('success.form.bv', function(e){
			registrarControl();
		});
		
		$("#selDiagnostico").val("1");
		
		var dpFechaControl  = $('#divFechaControl').datetimepicker({
			language : 'es',
            autoClose : true,
            format: 'DD/MM/YYYY',
			
            pickTime: false,
			useCurrent: false
        });

		dpFechaControl.on("dp.change dp.show", function(e){
			$('#formControl').bootstrapValidator('revalidateField', 'fechaControl');
		});

        
	});
	
	function registrarControl(){
		
		var grabarFormParams = {
			'controlAnimalBean' : formToObject( '#formControl' )
		};
		
		var ruta = "";
		if ( $("#txtflagEdicion").val() == 1 ) {
			ruta = '${pageContext.request.contextPath}/editarControlAnimal';
		} else{ 
			ruta = '${pageContext.request.contextPath}/grabarControlAnimal';
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
						$("#mensajeTransaccion").html("Se modific&oacute; satisfactoriamente el control del animal de la vaca");
					}
					$("#divConfirmacionRegistroControlAnimal").modal({
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
		$('#divRegistroControl').modal("hide");
		location.href = '${pageContext.request.contextPath}/listarControlAnimal';
	}
	
	function validarNumeroLetra(e){
		var key = window.Event ? e.which : e.keyCode;
		return ( (key >= 48 && key <= 57) || (key==32 ) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) );
 	}
</script>

<div class="panel-heading" >
	<h3 class="panel-title" align="center" id="titulo"></h3>
</div>

<div class="panel-body">
	<div class="row">
		<div class="col-sm-12">

			<form id="formControl" name="formControl" role="form" class="form-horizontal" method="post">
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">C&oacute;digo Animal:</div>
					
					<input type="hidden" name="flagEdicion" id="txtflagEdicion" />
					<input type="hidden" name="codigoControlAnimal" id="txtCodigoControlAnimal" />
					<div class="col-sm-6" id="divCodigoAnimalEdicion">
						<input name="codigoAnimal" id="txtCodigoAnimalControl" type="text" class="form-control tamanoMaximo" ></input>
					</div>
					<div class="col-sm-2"></div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">Edad:</div>
					<div class="col-sm-6" id="divEdadEdicion">
						<input name="edad" id="txtEdadControl" type="text" class="form-control tamanoMaximo" ></input>
					</div>
					<div class="col-sm-2"></div>
				</div>

				
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">Fecha Control:</div>
					<div class="col-sm-6">
						<div class="input-group date tamanoMaximo" id="divFechaControl">
							<input name="fechaControl" id="txtFechaControl" readonly="yes" type="text" class="form-control tamanoMaximo txtFecha" ></input>
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</div>
					<div class="col-sm-2"></div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">Per&iacute;metro Tor&aacute;xico:</div>
					<div class="col-sm-6">
						<input name="perimetroToraxico" id="txtPerimetroToraxico" type="text" class="form-control tamanoMaximo" ></input>
					</div>
					<div class="col-sm-2"></div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">Peso:</div>
					<div class="col-sm-6">
						<input name="peso" id="txtPeso" type="text" class="form-control tamanoMaximo" ></input>
					</div>
					<div class="col-sm-2"></div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">Altura:</div>
					<div class="col-sm-6">
						<input name="altura" id="txtAltura" type="text" class="form-control tamanoMaximo" ></input>
					</div>
					<div class="col-sm-2"></div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-4" style="text-align:right;">Requiere Diagn&oacute;stico:</label>
					<div class="col-sm-8" style="text-align: left">
						<select name="flagDiagnostico" id="selFlagDiagnostico" class="form-control tamanoMaximo"> 
							<option value="">---Seleccione---</option>
							<option value="1">Si</option>
							<option value="2">No</option>
						</select>
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
							class="btn btn-primary centro" onclick="cerraControlAnimal()"
							title="Cerrar">Cerrar</button>
					</div>
					<div class="col-sm-4" style="text-align: center">
						<button id="btnLimpiar" type="button"
							class="btn btn-primary centro" onclick="limpiarFormularioControlAnimal()"
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

<div id="divConfirmacionRegistroControlAnimal" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Registro Satisfactorio</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center" id="mensajeTransaccion">Se registro satisfactoriamente el control del animal</p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">
						<input type="button" id="btnRegistro" class="btn btn-primary" onclick="aceptar()" value="Aceptar"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

