<script>

	function retornar(){
		$('#formProduccion').bootstrapValidator('resetForm', true);
		$('#divProduccionFin').modal('hide');
		$("#divProduccion").modal({
			backdrop: 'static',
			keyboard: false
		});
	}
	
	function cerrar(){
		$('#formProduccion').bootstrapValidator('resetForm', true);
		$('#divProduccionFin').modal('hide');
	}
	
	function registrarProduccionFin(){

		$.ajax({
			url: '${pageContext.request.contextPath}/registrarProduccionFinal',
 			data: $('#formProduccionFin').serialize(),
			cache: false,
			async: false,
			type: 'GET',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				
				if(response.dataJson.resultado == 1){
					$("#divConfirmacionNuevoRegistro").modal({
						backdrop: 'static',
						keyboard: false
					});
				}
				return false;
			}, error: function(data, textStatus, errorThrown) {
				alert("error: " + data.responseText);
				return false;
			}
		});
	}
	
	function aceptar(){
		$("#divConfirmacionNuevoRegistro").modal("hide");
		$("#divProduccionFin").modal("hide");
		location.href = '${pageContext.request.contextPath}/listarProduccion';
	}
	
	
	
</script>

<div class="panel-heading">
	<h3 class="panel-title" align="center">Registrar Producci&oacute;n Diaria</h3>
</div>

<div class="panel-body">
	<div class="row">
		<div class="col-sm-12">

			<form id="formProduccionFin" class="form-horizontal" method="POST">
				<div class="form-group">
					<div class="col-sm-4">Fecha Ordeño:</div> 
					<div class="col-sm-8" id="divFechaOrdeno"></div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-4">Turno:</div> 
					<div class="col-sm-8" id="divTurno"></div>
				</div>

				<div class="form-group">
					<div class="col-sm-4">CódigoAnimal:</div> 
					<div class="col-sm-8" id="divCodigoAnimal"></div>
				</div>

				<div class="form-group">
					<div class="col-sm-4">Cantidad Producida:</div> 
					<div class="col-sm-8" id="divCantidadProducida"></div>
				</div>

				<div class="row">&nbsp;</div>

				<div class="form-group">
				
					<div class="col-sm-4" style="text-align: center">
						<button id="btnCerrar" type="button"
							class="btn btn-primary centro" onclick="cerrar()" title="Cerrar">Cerrar</button>
					</div>
					
					<div class="col-sm-4" style="text-align: center">
						<button id="btnRetornar" type="button"
							class="btn btn-primary centro" onclick="retornar()" title="Retornar">Retornar</button>
					</div>
					<div class="col-sm-4" style="text-align: center">
						<input type="button" id="btnRegistrar" class="btn btn-primary" onclick="registrarProduccionFin()" value="Registrar">
					</div>
				</div>
			</form>
		</div>
	</div>
</div>


<div id="divConfirmacionNuevoRegistro" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Registro Satisfactorio</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center">Se registro satisfactoriamente la producción del animal</p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">
						<input type="button" id="btnRegistro" class="btn btn-primary" onclick="aceptar()" value="Aceptar"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
