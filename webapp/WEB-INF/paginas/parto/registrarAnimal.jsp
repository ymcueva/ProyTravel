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
		
		inicia();
		
		$("#formAnimal").bootstrapValidator({
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields:{
				fechaNacimiento: {
					validators: {
						notEmpty: {
							message: 'Ingrese una fecha de aborto'
						}
					}
				}
			}
		}).on('success.form.bv', function(e){
			registrarAnimal();
		});
		
		$("#selEstadoAnimal").val("1");
		
		
		
	});
	
	function inicia(){
		
		var dpFechaNacimiento  = $('#divFechaNacimiento').datetimepicker({
			language : 'es',
            autoClose : true,
// 			minDate: $('#txtFechaIngreso').val(),
            format: 'DD/MM/YYYY',
            pickTime: false,
			useCurrent: true
        });

		dpFechaNacimiento.on("dp.change dp.show", function(e){
			$('#formAnimal').bootstrapValidator('revalidateField', 'fechaNacimiento');
		});
	}
	
	function registrarAnimal(){
		
		var grabarFormParams = {
			'animalBean' : formToObject( '#formAnimal' )
		};
		
		$.ajax({
			url: '${pageContext.request.contextPath}/grabarAnimal',
			data: JSON.stringify(grabarFormParams),
			cache: false,
			async: true,
			type: 'POST',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				if (response.estado = "ok") {
					
					$("#divConfirmacionRegistroAnimal").modal({
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
		$('#divRegistroAnimal').modal("hide");
		location.href = '${pageContext.request.contextPath}/listarParto';
	}
	
	function validarNumeroLetra(e){
		var key = window.Event ? e.which : e.keyCode;
		return ( (key >= 48 && key <= 57) || (key==32 ) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) );
 	}
</script>

<div class="panel-heading" >
	<h3 class="panel-title" align="center" id="titulo">Registro de Cr&iacute;as</h3>
</div>

<div class="panel-body">
	<div class="row">
		<div class="col-sm-12">

			<form id="formAnimal" name="formAnimal" role="form" class="form-horizontal" method="post">
	
				<div class="form-group">
					<div class="col-sm-2" style="text-align:right; font-weight:bold">C&oacute;digo Padre:</div>
					<div class="col-sm-4" >
						<input name="codigoAnimalMadre" id="txtCodigoAnimalMadre" type="hidden" ></input>
						<div class="col-sm-8" id="divCodigoPadre"></div>
					</div>
					
					<div class="col-sm-2" style="text-align:right; font-weight:bold">C&oacute;digo Madre:</div>
					<div class="col-sm-4" >
						<div class="col-sm-8" id="divCodigoMadre"></div>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-2" style="text-align:right; font-weight:bold">C&oacute;digo Animal:</div>
					<div class="col-sm-4" >
						<input name="codigoAnimal" id="txtCodigoAnimal" type="text" class="form-control tamanoMaximo" ></input>
					</div>
					
					<div class="col-sm-2" style="text-align:right; font-weight:bold">Nombre Animal:</div>
					<div class="col-sm-4" >
						<input name="nombreAnimal" id="txtNombreAnimal" type="text" class="form-control tamanoMaximo" ></input>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-2" style="text-align:right; font-weight:bold">Fecha Nacimiento:</div>
					<div class="col-sm-4" >
						<div class="input-group date tamanoMaximo" id="divFechaNacimiento">
							<input name="fechaNacimiento" id="txtFechaNacimiento" readonly="yes" type="text" class="form-control tamanoMaximo txtFecha" ></input>
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</div>
					
					<div class="col-sm-2" style="text-align:right; font-weight:bold">Estado:</div>
					<div class="col-sm-4" >
						<select name="estadoAnimal" id="selEstadoAnimal" class="form-control tamanoMaximo"> 
							<option value="">---Seleccione---</option>
							<option value="1">Activo</option>
							<option value="2">Inactivo</option>
						</select>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-2" style="text-align:right; font-weight:bold">Raza:</div>
					<div class="col-sm-4" >
						<select name="tipoRaza" id="selTipoRaza" class="form-control tamanoMaximo"> 
							<option value="">---Seleccione---</option>
							<option value="1">Holsteing</option>
							<option value="2">Brown Swis</option>
						</select>
					</div>
					
					<div class="col-sm-2" style="text-align:right; font-weight:bold">Peso (Kg.):</div>
					<div class="col-sm-4" >
						<input name="peso" id="txtPesoAnimal" type="text" class="form-control tamanoMaximo" ></input>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-2" style="text-align:right; font-weight:bold">Sexo:</div>
					<div class="col-sm-4" >
						<select name="tipoSexo" id="selTipoSexo" class="form-control tamanoMaximo"> 
							<option value="">---Seleccione---</option>
							<option value="H">Hembra</option>
							<option value="M">Macho</option>
						</select>
					</div>
					<div class="col-sm-2" style="text-align:right; font-weight:bold">Observaciones:</div>
					<div class="col-sm-4" id="divNombreAnimal">
						<textarea name="observacion" id="txtObservacion" onkeypress="return validarNumeroLetra(event)" rows="4" cols="35" value="s" /></textarea>
					</div>
				</div>

				<div class="row">&nbsp;</div>

				<div class="form-group">
					<div class="col-sm-4" style="text-align: center">
						<button id="btnCerrar" type="button"
							class="btn btn-primary centro" onclick="cerrarAnimal()"
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

<div id="divConfirmacionRegistroAnimal" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Registro Satisfactorio</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center" id="mensajeTransaccion">Se registro satisfactoriamente las cr&iacute;as de la vaca</p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">
						<input type="button" id="btnRegistro" class="btn btn-primary" onclick="aceptar()" value="Aceptar"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>