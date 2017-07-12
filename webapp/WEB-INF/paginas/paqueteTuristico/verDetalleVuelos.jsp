<div class="panel-heading" >
	<h3 class="panel-title" align="center">Ticket Aereo</h3>
</div>

<div class="panel-body">
	<div class="row">
		<div class="col-sm-12">
			<div id="divListadoVuelos">
				<input type="hidden" id="hdnAerolinea" value="">
				
				<div class="col-sm-12">
					<table id ="tblDetalleVuelos" class="table table-bordered responsive" style="width:100%">
						<thead>
							<tr>
								<th width="10%" class="text-center">Opcion</td>															
								<th width="15%" class="text-center">Aerolinea</td>
								<th width="15%" class="text-center">Precio</td>
								<th width="15%" class="text-center">Consolidador</td>
								<th width="15%" class="text-center">Comision (%)</td>
																
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
					
				</div>
				
				<div class="row">&nbsp;</div>
				<div class="row">&nbsp;</div>
				

				<div class="form-group">
					<div class="col-sm-12" style="text-align: center">
						<button id="btnGuardarVuelo" type="button"
							class="btn btn-primary centro" onclick="aceptarVuelo();"
							title="Aceptar">Aceptar</button>
						&nbsp;	
						<button id="btnCerrarVuelo" type="button"
							class="btn btn-primary centro" onclick="cerrarVuelo();"
							title="Cerrar">Cerrar</button>
					</div>
				</div>
				
			</div>
		</div>
	</div>
</div>		