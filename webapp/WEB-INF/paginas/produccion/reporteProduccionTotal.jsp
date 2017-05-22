<script>
	
	$(document).ready(function(){
        $.ajaxSetup({
            scriptCharset: "utf-8",
            contentType: "application/json; charset=utf-8"
        });
        jQuery.support.cors = true;
	});
	
	function limpiarProduccion(){
		$('#formProduccion').bootstrapValidator('resetForm', true);
	}
	
	function cerrarProduccionTotal(){		
		$('#divReporteProduccionDiaria').modal('hide');
	}
	
	function detalleProduccionDiariaPorVaca(){
		
		$.ajax({
			url: '${pageContext.request.contextPath}/detalleProduccionDiariaPorVaca',
			cache: false,
			async: true,
			type: 'POST',
			contentType: "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {

				if (response.estado = "ok") {
					
					$("#divReporteProduccionDiaria").modal("hide");
					construirTablaProduccionDiariaPorVaca(response.dataJson.listaProduccionDiariaPorVaca);
					$("#divReporteProduccionDiariaPorVaca").modal({
						backdrop: 'static',
						keyboard: false
					});
				}
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
	}
	
	
 	function construirTablaProduccionDiariaPorVaca( dataGrilla ){
		
 		var table = $('#tblProduccionDiariaPorVaca').dataTable({
            data: dataGrilla,
            ordering: false,
            bDestroy: true,
            searching: false,
            paging: true,
            bScrollAutoCss: true,
            bStateSave: false,
            bAutoWidth: false,
            info: false,
            bScrollCollapse: false,
            pagingType: "full_numbers",
            pageLength: 5,
            responsive: true,
            bLengthChange: false,
			
            fnDrawCallback: function(oSettings) {
                if (oSettings.fnRecordsTotal() == 0) {
                    $('#tblProduccionDiariaPorVaca_paginate').addClass('hiddenDiv');
                } else {
                    $('#tblProduccionDiariaPorVaca_paginate').removeClass('hiddenDiv');
                }
            },
			
            fnRowCallback: function (nRow, aData, iDisplayIndex) {
				$(nRow).attr('id', aData[5]);
				$(nRow).attr('align', 'center');
				$(nRow).attr('rowClasses','tableOddRow');
                return nRow;
            },
			language: {
                url: "/a/resources/bootstrap/3.3.2/plugins/datatables-1.10.7/plug-ins/1.10.7/i18n/Spanish.json"
			},
			columns: [
				{data: "numeroFila"},
				{data: "codigoAnimal"},
				{data: "nombreAnimal"},
				{data: "cantidadProducida"}
			]
        });
 	}
	
</script>

<div class="panel-heading" >
	<h3 class="panel-title" align="center">Producci&oacute;n Diaria</h3>
</div>

<div class="panel-body">
	<div class="row">
		<div class="col-sm-12">

			<form id="formProduccion" role="form" class="form-horizontal"
				method="post">
				
				<div class="form-group">
					<div class="col-sm-6" style="text-align:right; font-weight:bold">Cantidad Total de Produc&oacute;n de leche:</div>
					<div class="col-sm-6" id="divCantidadTotal" ></div>
					<input type="hidden" name="fechaOrdenoTotal" id="txtFechaOrdenoTotal" />
				</div>
				
				<div class="form-group">
					<div class="col-sm-6" style="text-align:right; font-weight:bold">Ordeñador:</div>
					<div class="col-sm-6" style="text-align: left" id="divOrdenador"></div>
				</div>

				<div class="form-group">
					<label class="col-sm-6" style="text-align:right;">Vaca m&aacute;s productiva en el d&iacute;a:</label>
					<div class="col-sm-6" style="text-align: left" id="divVacaMasProd"></div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-6" style="text-align:right;">Vaca menos productiva en el d&iacute;a:</label>
					<div class="col-sm-6" style="text-align: left" id="divVacaMenosProd" > </div>
				</div>

				<div class="form-group">
					<label class="col-sm-6" style="text-align:right;">Detalle de producci&oacute;n por vaca:</label>
					<div class="col-sm-6" style="text-align: left" id="divVacaMenosProd" > 
						<a href="javascript:;" onclick="detalleProduccionDiariaPorVaca()">Ver Detalle</a>
					</div>
				</div>
				
				<div class="row">&nbsp;</div>

				<div class="form-group">
					<div class="col-sm-4" >&nbsp;</div>
					<div class="col-sm-4" style="text-align: center">
						<button id="btnCerrar" type="button"
							class="btn btn-primary centro" onclick="cerrarProduccionTotal()"
							title="Cerrar">Cerrar</button>
					</div>
					<div class="col-sm-4" >&nbsp;</div>
				</div>
			</form>
		</div>
	</div>
</div>