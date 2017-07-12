<div class="panel-heading" >
	<h3 class="panel-title" align="center">Tour</h3>
</div>

<div class="panel-body">
	<div class="row">
		<div class="col-sm-12">
			<div id="divListadoTours">
			    <input type="hidden" id="hdnTour" value="">
				<div class="col-sm-12">
					<table id ="tblTours" class="table table-bordered responsive" style="width:100%">
						<thead>
							<tr>
								<th width="10%" class="text-center">Opcion</td>															
								<th width="10%" class="text-center">Item</td>
								<th width="25%" class="text-center">Descripcion</td>
								<th width="15%" class="text-center">Duracion Horas</td>
								<th width="15%" class="text-center">Precio Adulto</td>
								<th width="15%" class="text-center">Precio Ni�o</td>
																
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
					
				</div>
				
				<div class="row">&nbsp;</div>
				<div class="row">&nbsp;</div>
				
				<div class="form-group">
					<div class="col-sm-2" style="text-align:right; font-weight:bold">Itinerario:</div>
						<div class="col-sm-9" id="divItinerario">
							<textarea class="form-control" name="itinerario" id="txtItinerario" onkeypress="return validarNumeroLetra(event)" rows="3" cols="98"  placeholder="Itinerario"/></textarea>
					     </div>
				</div>
				
				<div class="row">&nbsp;</div>
				<div class="row">&nbsp;</div>
				
				
				<div class="form-group">
					<div class="col-sm-2" style="text-align:right; font-weight:bold">Servicios:</div>
						<div class="col-sm-9" id="divServicios">
							<textarea class="form-control" name="servicios" id="txtServicios" onkeypress="return validarNumeroLetra(event)" rows="3" cols="98"  placeholder="Itinerario"/></textarea>
					     </div>
				</div>
				
				<div class="row">&nbsp;</div>
				<div class="row">&nbsp;</div>
				

				<div class="form-group">
					<div class="col-sm-12" style="text-align: center">
						<button id="btnGuardarTour" type="button"
							class="btn btn-primary centro" onclick="aceptarTour();"
							title="Aceptar">Aceptar</button>
						&nbsp;	
						<button id="btnCerrarTour" type="button"
							class="btn btn-primary centro" onclick="cerrarTour();"
							title="Cerrar">Cerrar</button>
					</div>
				</div>
				
			</div>
		</div>
	</div>
</div>		