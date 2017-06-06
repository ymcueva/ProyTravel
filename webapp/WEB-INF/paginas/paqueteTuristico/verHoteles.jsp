<div class="panel-heading" >
	<h3 class="panel-title" align="center">Hotel</h3>
</div>

<div class="panel-body">
	<div class="row">
		<div class="col-sm-12">
			<div class="form-group">
				<label class="col-sm-4 control-label">Tipo Alojamiento:</label>																														
				<div class="col-sm-5">
					 <select name="tipoAlojamiento" id="tipoAlojamiento" class="form-control"> 
							<option value="">---Seleccione---</option>
							<option value="1">Hotel</option>
							<option value="2">Hostal</option>
							<option value="3">Casa</option>															
					 </select>
				</div>
				<div class="col-sm-3">
				   <button id="btnBuscarHotel" type="button"
						class="btn btn-primary centro"
						title="Buscar">Buscar</button>
				</div>
				
			</div>
			<div class="row">&nbsp;</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">Categoria Alojamiento:</label>																														
				<div class="col-sm-5">
				     <select name="categoriaAlojamiento" id="categoriaAlojamiento" class="form-control"> 
							<option value="">---Seleccione---</option>
							<option value="1">1 Estrella</option>
							<option value="2">2 Estrellas</option>
							<option value="3">3 Estrellas</option>
							<option value="4">4 Estrellas</option>
							<option value="5">5 Estrellas</option>
							<option value="6">Estandard</option>
							<option value="7">Premium</option>
																							
					 </select>
				</div>
		   </div>
		   
		   <div class="row">&nbsp;</div>
		   <div class="row">&nbsp;</div>
		   
		   <div id="divHoteles">
				<div class="col-sm-12">
					<table id ="tblHoteles" class="table table-bordered responsive" style="width:100%">
						<thead>
							<tr>
																
								<th width="5%" class="text-center"></td>		
								<th width="15%" class="text-center">Descripcion</td>
								<th width="15%" class="text-center">Costo</td>
								<th width="15%" class="text-center">Estadia</td>
								<th width="15%" class="text-center">Nro Personas</td>														
							</tr>
							<tbody>
							</tbody>
						</thead>
					</table>
					
				</div>
			</div>
		   
		   <div class="row">&nbsp;</div>
		   <div class="row">&nbsp;</div>

			<div class="form-group">
				<div class="col-sm-12" style="text-align: center">
					<button id="btnAceptarHotel" type="button"
						class="btn btn-primary centro"
						title="Cerrar">Aceptar</button>
					&nbsp;	
					<button id="btnCerrarHotel" type="button"
						class="btn btn-primary centro"
						title="Cerrar">Cerrar</button>
				</div>
			</div>
		</div>
	</div>	
</div>	