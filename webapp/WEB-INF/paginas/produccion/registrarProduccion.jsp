<script>
	
	$(document).ready(function(){
	
        $.ajaxSetup({
            scriptCharset: "utf-8",
            contentType: "application/json; charset=utf-8"
        });
        jQuery.support.cors = true;
		
		
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
	
	function limpiarProduccion(){
		$('#formProduccion').bootstrapValidator('resetForm', true);
	}
	
	function cerrarProduccion(){
		$('#formProduccion').bootstrapValidator('resetForm', true);
		$('#divProduccion').modal('hide');
	}
	
	
	function continuaRegistro(){
		
		/*$("#divModalPopupCodigoAnimalInvalido").modal({
			backdrop: 'static',
			keyboard: false
		});
		
		return false;*/
		
		$('#divProduccion').modal('hide');
		
		$.ajax({
			url: '${pageContext.request.contextPath}/cargarDatosSessionProduccion',
			data: $('#formProduccion').serialize(),
			cache: false,
			async: true,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				if (response.estado = "ok") {
					var turno = response.dataJson.turno;
					if (turno==1) turno = "Mañana";
					else if (turno==2) turno = "Tarde";
					else if (turno==3) turno = "Noche";
					
					$("#divFechaOrdeno").html(response.dataJson.fechaOrdeno);
					$("#divTurno").html(turno);
					$("#divCodigoAnimal").html(response.dataJson.codigoAnimal);
					$("#divCantidadProducida").html(response.dataJson.cantidadProducida);
					$("#divProduccionFin").modal({
						backdrop: 'static',
						keyboard: false
					});
				}
			},
				error: function(data, textStatus, errorThrown) {
				}
		});
		
		$('#formProduccion').bootstrapValidator('resetForm', true);
		
	}
	

</script>

<div class="panel-heading" >
	<h3 class="panel-title" align="center">Registrar Producci&oacute;n Diaria</h3>
</div>

<div class="panel-body">
	<div class="row">
		<div class="col-sm-12">

			<form id="formProduccion" role="form" class="form-horizontal"
				method="post">
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">Fecha:</div>
					<div class="col-sm-8" id="divFechaOrdenoProduccion" ></div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">Turno:</div>
					<div class="col-sm-8">
						<select name="turno" id="selTurno" class="form-control tamanoMaximo">
							<option value="1">Mañana</option> 
							<option value="2">Tarde</option>
							<option value="3">Noche</option>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-4" style="text-align:right;">Código Animal:</label>
					<div class="col-sm-8" style="text-align: left">
						<input id="txtCod_Ani" name="codigoAnimal" type="text" class="form-control">
					</div>
				</div>

				<div class="row">&nbsp;</div>

				<div class="form-group">
					<div class="col-sm-4" style="text-align: center">
						<button id="btnCerrar" type="button"
							class="btn btn-primary centro" onclick="cerrarProduccion()"
							title="Cerrar">Cerrar</button>
					</div>
					<div class="col-sm-4" style="text-align: center">
						<button id="btnLimpiar" type="button"
							class="btn btn-primary centro" onclick="limpiarProduccion()"
							title="Limpiar">Limpiar</button>
					</div>
					<div class="col-sm-4" style="text-align: center">
						<button id="btnContinuar" class="btn btn-primary" 
							title="Continuar">Continuar</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>


<div id="divModalPopupCodigoAnimalInvalido" class="modal fade" tabindex="-1" role="dialog" >
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="panel panel-warning">
				<div class="panel-heading">Mensaje</div>
				<div class="panel-body">
					<div class="modal-body">
						Debe ingresar unc&oacute;digo de animal v&aacute;lido.
					</div>
					<div class="text-center">
						<button id="btnPopupAceptarParamMin" type="button" class="btn btn-primary">Aceptar</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div> 
