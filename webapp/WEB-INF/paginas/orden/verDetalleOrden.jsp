<div class="panel-heading" >
	<h3 class="panel-title" align="center" id="tituloCotizacion">Detalle Reserva</h3>
</div>

<div class="panel-body">
	<div class="row">
		<div class="col-sm-12">

			<div class="form-group">
				<div style="display:none">
				<span id="idReservaDetalle"></span>
				</div>
				<div class="col-sm-5" style="text-align:right; font-weight:bold">N&uacute;mero Reserva:</div>
				<div class="col-sm-7" id="divNumReservaDetalle" ></div>
			</div>
			
			<div class="row">&nbsp;</div>
			
			<div class="form-group">
				<div class="col-sm-5" style="text-align:right; font-weight:bold">N&uacute;mero Cotizaci&oacute;n:</div>
				<div class="col-sm-7" id="divNumCotizaDetalle"></div>
			</div>
			
			<div class="row">&nbsp;</div>
			
			<div class="form-group">
				<div class="col-sm-5" style="text-align:right; font-weight:bold">Fecha Cotizaci&oacute;n:</div>
				<div class="col-sm-7" id="divFechaCotizaDetalle"></div>
			</div>
			
			<div class="row">&nbsp;</div>
			
			<div class="form-group">
				<div class="col-sm-5" style="text-align:right; font-weight:bold">Nombre Cliente:</div>
				<div class="col-sm-7" id="divClienteDetalle"></div>
			</div>
			
			<div class="row">&nbsp;</div>
			
			<div class="form-group">
				<div class="col-sm-5" style="text-align:right; font-weight:bold">Precio Cotizaci&oacute;n:</div>
				<div class="col-sm-7" id="divPrecioDetalle"></div>
			</div>					
			
			<div class="row">&nbsp;</div>

			<div class="form-group">
			
				<div id="dosBotonesDetalle">
					<div class="col-sm-6" style="text-align: center">
						<button id="btnCerrar" type="button"
							class="btn btn-primary centro" onclick="cerraVerDetalle()"
							title="Cerrar">Cerrar</button>
					</div>
					
					<div class="col-sm-6" style="text-align: center">
						<button id="btnCerrar" type="button"
							class="btn btn-primary centro" onclick="enviarReservaCliente()"
							title="Cerrar">Enviar Reserva</button>
					</div>
				</div>
				<div id="unBotonDetalle">
					<div class="col-sm-12" style="text-align: center">
						<button id="btnCerrar" type="button"
							class="btn btn-primary centro" onclick="cerraVerDetalle()"
							title="Cerrar">Cerrar</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
