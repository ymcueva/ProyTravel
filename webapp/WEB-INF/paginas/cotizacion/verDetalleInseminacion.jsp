<div class="panel-heading" >
	<h3 class="panel-title" align="center" id="tituloCotizacion"></h3>
</div>

<div class="panel-body">
	<div class="row">
		<div class="col-sm-12">

			<div class="form-group">
				<div class="col-sm-5" style="text-align:right; font-weight:bold">N&uacute;mero Cotizaci&oacute;n:</div>
				<div class="col-sm-7" id="divCodigo" ></div>
			</div>
			
			<div class="row">&nbsp;</div>
			
			<div class="form-group">
				<div class="col-sm-5" style="text-align:right; font-weight:bold">Estado:</div>
				<div class="col-sm-7" id="divEstado"></div>
			</div>
			
			<div class="row">&nbsp;</div>
			
			<div class="form-group">
				<div class="col-sm-5" style="text-align:right; font-weight:bold">Fecha:</div>
				<div class="col-sm-7" id="divFecha"></div>
			</div>
			
			<div class="row">&nbsp;</div>
			
			<div class="form-group">
				<div class="col-sm-5" style="text-align:right; font-weight:bold">Tipo:</div>
				<div class="col-sm-7" id="divTipo"></div>
			</div>
			
			<div class="row">&nbsp;</div>
			
			<div class="form-group">
				<div class="col-sm-5" style="text-align:right; font-weight:bold">Cliente:</div>
				<div class="col-sm-7" id="divCliente"></div>
			</div>					
			
			<div class="row">&nbsp;</div>
			
			<div class="form-group">
				<div class="col-sm-5" style="text-align:right; font-weight:bold">Destinos:</div>
				<div class="col-sm-7" id="divDestinos"></div>
			</div>
			
			<div class="row">&nbsp;</div>
			
			<div class="form-group">
				<div class="col-sm-5" style="text-align:right; font-weight:bold">Motivos:</div>
				<div class="col-sm-7" id="divMotivos"></div>
			</div>
			
			<div class="row">&nbsp;</div>
			
			<div class="form-group">
				<div class="col-sm-5" style="text-align:right; font-weight:bold">Servicios:</div>
				<div class="col-sm-7" id="divServicios"></div>
			</div>
			
			<div id="divBotonCotizacionBuscar" style="display: none;">	
				<div class="row">&nbsp;</div>		
				<div class="form-group">
					<div class="col-sm-12" style="text-align: center">
						<button id="btnBuscar" type="button"
							class="btn btn-primary centro" onclick="buscarPaquete()"
							title="Buscar">Buscar Paquetes</button>
					</div>					
				</div>
				<div class="row">&nbsp;</div>	
			</div>
			
			<div id="divInfoDetalleCotizacion" style="display: none;">	
				<div class="row">&nbsp;</div>		
				<div class="form-group">
					<div class="col-sm-12" style="text-align: center" id="infoDetalleCotizacion">
						<div style="border: 1px solid blue; padding: 1% ">	
							<div class="col-sm-12" style="text-align:center; font-weight:bold" id="divMsgResultado"></div>
							<div class="col-sm-12" style="text-align:center; font-weight:bold" id="divMsgResultadoRegistro"></div>							
							<button id="btnGuardarPaquete" type="button"
								class="btn btn-primary centro" onclick="guardarPaquete()"
								title="Guardar Paquete">Guardar Paquete</button>															
						</div>
					</div>					
				</div>
			</div>			
			
			<div id="divBotonCotizacionEnviar" style="display: none;">	
				<div class="row">&nbsp;</div>
				<div class="col-sm-12" style="text-align: center">
					<div class="col-sm-12" style="text-align:center; font-weight:bold" id="divMsgResultadoEnviar"></div>
					<button id="btnEnviarCotizacion" type="button"
						class="btn btn-primary centro" onclick="enviarCotizacion()"
						title="Enviar">Enviar</button>
				</div>
			</div>
			
			<div class="row">&nbsp;</div>

			<div class="form-group">
				<div class="col-sm-12" style="text-align: center">
					<button id="btnCerrar" type="button"
						class="btn btn-primary centro" onclick="cerraVerDetalle()"
						title="Cerrar">Cerrar</button>
				</div>
			</div>
		</div>
	</div>
</div>
