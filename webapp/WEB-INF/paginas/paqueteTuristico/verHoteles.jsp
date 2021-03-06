<div class="panel-heading" >
	<h3 class="panel-title" align="center">Hotel</h3>
</div>

<div class="panel-body" id="popupHoteles">
	<div class="row">
		<div class="col-sm-12">
			<input type="hidden" id="hdnHotelHabitacion" value="">
			<input type="hidden" id="hdnIdTipoHabitacion" value="">
			<input type="hidden" id="hdnNomTipoHabitacion" value="">
			<input type="hidden" id="hdnPrecio" value="">
			<input type="hidden" id="hdnDiasHotel" value="0">
			<input type="hidden" id="hdnNumHabitaciones" value="0">
			
			
			<div class="col-sm-12" id="divConfiguracion">
				<div class="panel panel-primary">
					<div class="panel-heading">	<strong>Configuraci&oacute;n de Habitaciones</strong></div>
						<div class="panel-body">
									<div class="form-group">
								   		<label class="col-sm-4 control-label">Tipo Alojamiento:</label>
								   		<div class="col-sm-6">
											<input type="text" disabled="disabled" class="form-control" id="txtTipoAlojamiento"/>
										</div>	
		   							</div>
		   							<div class="row">&nbsp;</div>
		   							<div class="form-group">
								   		<label class="col-sm-4 control-label">Categor&iacute;a Alojamiento:</label>
								   		<div class="col-sm-6">
											<input type="text" disabled="disabled" class="form-control" id="txtCategoriaAlojamiento"/>
										</div>	
		   							</div>
		   							<div class="row">&nbsp;</div>	
		  							<div class="row">&nbsp;</div>
		   
										   <div id="divHabitacionesConfiguracion">
												<div class="col-sm-12">
													<table id ="tblHabitacionesConfiguracion" class="table table-bordered responsive" style="width:100%">
														<thead>
															<tr>																								
																<th width="10%" class="text-center">Nro</td>
																<th width="20%" class="text-center">Tipo Habitaci&oacute;n</td>
																<th width="15%" class="text-center">Cantidad</td>												
															</tr>
															<tbody>
															</tbody>
														</thead>
													</table>
													
												</div>
											</div>
							
						
							
		   					
						</div>
				</div>
			</div>	
		
			<div class="form-group">
				<label class="col-sm-4 control-label">Tipo Alojamiento:</label>																														
				<div class="col-sm-5">
					 <select name="idTipo" id="tipoAlojamiento" class="form-control"> 
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
				     <select name="idCategoria" id="categoriaAlojamiento" class="form-control"> 
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
		   <div class="form-group">
				<label class="col-sm-4 control-label">Tipo B&uacute;squeda:</label>																														
				<div class="col-sm-5">
				     <select name="idTipoBusqueda" id="tipobusqueda" class="form-control"> 
							<option value="">---Seleccione---</option>
							<option value="1">Descripci&oacute;n</option>
							<option value="2">Direcci&oacute;n</option>
							<option value="3">Referencia</option>																
					 </select>
				</div>
		   </div>
		   
		   <div class="row">&nbsp;</div>
		   
		   <div class="form-group">
		   		<label class="col-sm-4 control-label">Valor:</label>
		   		<div class="col-sm-6">
					<input type="text" class="form-control" name="valor" id="txtValorBusqueda"/>
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
								<th width="15%" class="text-center">Tipo</td>
								<th width="15%" class="text-center">Categoria</td>														
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
				<label class="col-sm-4 control-label">Tipo Habitacion:</label>																														
				<div class="col-sm-5">
					 <select name="idTipoHabitacion" id="tipoHabitacion" class="form-control"> 
												
					 </select>
				</div>
				<div class="col-sm-3">
				   <button id="btnAgregarHabitacion" type="button"
						class="btn btn-primary centro" onclick="agregarTipoHabitacion();"
						title="Agregar">Agregar</button>
				</div>
				
			</div>
			
			<div class="row">&nbsp;</div>
		   	
		   	<div class="form-group">
		   		<label class="col-sm-4 control-label">Cantidad:</label>
		   		<div class="col-sm-3">
					<input type="text" class="form-control" name="cantidad" id="txtCantidad" maxlength="2"/>
				</div>	
		   	</div>
		   	
		   	<div class="row">&nbsp;</div>
		    <div class="row">&nbsp;</div>
		    
		    <div id="divTipoHabitacion">
				<div class="col-sm-12">
					<table id ="tblTipoHabitacion" class="table table-bordered responsive" style="width:100%">
						<thead>
							<tr>														
								<th width="15%" class="text-center">Tipo Habitacion</td>
								<th width="15%" class="text-center">Cantidad</td>
								<th width="15%" class="text-center">Precio</td>
								<th width="15%" class="text-center">SubTotal</td>
								<th width="5%" class="text-center">Opcion</td>														
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
						class="btn btn-primary centro" onclick="aceptarHotel();"
						title="Cerrar">Aceptar</button>
					&nbsp;	
					<button id="btnCerrarHotel" type="button"
						class="btn btn-primary centro" onclick="cerrarHotel();"
						title="Cerrar">Cerrar</button>
				</div>
			</div>
		</div>
	</div>	
</div>	