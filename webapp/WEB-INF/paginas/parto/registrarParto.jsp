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
		
		$("#formParto").bootstrapValidator({
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields:{
				
				fechaParto: {
					validators: {
						notEmpty: {
							message: 'Ingrese una fecha de parto'
						}
					}
				},
				tipoParto: {
					validators: {
						notEmpty: {
							message: 'Seleccione un tipo de parto'
						}
					}
				}
			}
		}).on('success.form.bv', function(e){
			registrarParto();
		});
		
		$("#selTipoParto").val("1");
		
		var dpFechaParto  = $('#divFechaParto').datetimepicker({
			language : 'es',
            autoClose : true,
// 			minDate: $('#txtFechaIngreso').val(),
            format: 'DD/MM/YYYY',
            pickTime: false,
			useCurrent: true
        });

		dpFechaParto.on("dp.change dp.show", function(e){
			$('#formParto').bootstrapValidator('revalidateField', 'fechaParto');
		});
		
	});
	
	function registrarParto(){
		
		var grabarFormParams = {
			'partoBean' : formToObject( '#formParto' )
		};
		
		var ruta = "";
		if ( $("#txtflagEdicion").val() == 1 ) {
			ruta = '${pageContext.request.contextPath}/editarParto';
		} else{
			ruta = '${pageContext.request.contextPath}/grabarParto';
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
						$("#mensajeTransaccion").html("Se modific&oacute; satisfactoriamente el parto de la vaca");
					}
					$("#divConfirmacionRegistroParto").modal({
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

	function aceptarParto(){
		$('#divRegistroParto').modal("hide");
		
		$("#mdlConfirmaRegistroCrias").modal({
			backdrop: 'static',
			keyboard: false
		});
		
		//location.href = '${pageContext.request.contextPath}/listarParto';
	}
	
	
	function aceptaAbrirRegistrarCria(){
		$('#mdlConfirmaRegistroCrias').modal("hide");
				
		$.ajax({
			url: '${pageContext.request.contextPath}/abrirRegistrarCria',
			
			cache: false,
			async: true,
			type: 'POST',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				if (response.estado = "ok") {
					$("#codigoAnimalMadre").val( $("#txtCodigoAnimal").val() )
					$("#divCodigoMadre").html( $("#txtCodigoAnimal").val() );
					$("#divCodigoPadre").html( $("#txtCodigoToro").val() );
					$("#txtFechaNacimiento").val( response.dataJson.fechaActual );
					$("#titulo").val( response.dataJson.titulo );
					
					$("#divRegistroAnimal").modal({
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
	
	function validarNumeroLetra(e){
		var key = window.Event ? e.which : e.keyCode;
		return ( (key >= 48 && key <= 57) || (key==32 ) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) );
 	}
</script>

<div class="panel-heading" >
	<h3 class="panel-title" align="center" id="tituloParto"></h3>
</div>

<div class="panel-body">
	<div class="row">
		<div class="col-sm-12">

			<form id="formParto" name="formParto" role="form" class="form-horizontal" method="post">
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">C&oacute;digo Vaca:</div>
					<input type="hidden" name="codigoVaca" id="txtCodigoAnimal" />
					<input type="hidden" name="codigoToro" id="txtCodigoToro" />
					<input type="hidden" name="flagEdicion" id="txtflagEdicion" />
					<input type="hidden" name="numeroDiasPrenez" id="txtNumeroDiasPrenez" />
					<input type="hidden" name="codigoParto" id="txtCodigoParto" />
					<div class="col-sm-8" id="divCodigoVaca" ></div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">Nombre Toro:</div>
					<div class="col-sm-8" id="divNombreToro" ></div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-4" style="text-align:right;">N&uacute;mero Días Preñez:</label>
					<div class="col-sm-8" id="divNumeroDiasPrenez" ></div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-4" style="text-align:right;">Edad al parto (meses):</label>
					<div class="col-sm-8" id="divEdadMesesParto" ></div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">Fecha Parto:</div>
					<div class="col-sm-8">
						<div class="input-group date tamanoMaximo" id="divFechaParto">
							<input name="fechaParto" id="txtFechaParto" readonly="yes" type="text" class="form-control tamanoMaximo txtFecha" ></input>
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">N&uacute;mero de Cr&iacute;as:</div>
					<div class="col-sm-8">
						<input name="numeroCriasParto" id="txtNumeroCriasParto" type="text" class="form-control tamanoMaximo" ></input>
					</div>
				</div>
				
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">Tipo de Parto:</div>
					<div class="col-sm-8">
						<select name="tipoParto" id="selTipoParto" class="form-control tamanoMaximo"> 
							<option value="">---Seleccione---</option>
							<option value="1">Normal</option>
							<option value="2">Asistido</option>
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
							class="btn btn-primary centro" onclick="cerrarParto()"
							title="Cerrar">Cerrar</button>
					</div>
					<div class="col-sm-4" style="text-align: center">
						<button id="btnLimpiar" type="button"
							class="btn btn-primary centro" onclick="limpiarFormularioParto()"
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

<div id="divConfirmacionRegistroParto" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Registro Satisfactorio</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center" id="mensajeTransaccion">Se registro satisfactoriamente el parto de la vaca.</p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">
						<input type="button" id="btnRegistro" class="btn btn-primary" onclick="aceptarParto()" value="Aceptar" />
					</div>
				</div>
			</div>
		</div>
	</div>
</div>



