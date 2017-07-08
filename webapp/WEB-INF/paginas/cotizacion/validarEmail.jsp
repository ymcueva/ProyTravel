
<style>
	.txtFecha{
		background-color: #FFF !important;
	}
</style>
<script>
	
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


