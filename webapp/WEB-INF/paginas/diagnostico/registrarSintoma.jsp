<style>
	.txtFecha{
		background-color: #FFF !important;
	}
</style>
<script>
	
	$(document).ready(function(){
	
        $.ajaxSetup({
            scriptCharset: "utf-8",
            contentType: "application/json; charset=utf-8"
        });
        jQuery.support.cors = true;
		
		

        
	});
	
	function registrarSintoma(){
		
		var grabarFormParams = {
			'sintomaBean' : formToObject( '#formSintoma' )
		};
		
		$.ajax({
			url: '${pageContext.request.contextPath}/grabarSintoma',
			data: JSON.stringify(grabarFormParams),
			cache: false,
			async: true,
			type: 'POST',
			contentType : "application/json; charset=utf-8",
			dataType: 'json',
			success: function(response) {
				if (response.estado = "ok") {
					
					$("#divConfirmacionRegistroSintoma").modal({
						backdrop: 'static',
						keyboard: false
					});
					location.href= '${pageContext.request.contextPath}/abrirRegistrarDiagnostico';
				}
			},
			error: function(data, textStatus, errorThrown) {
			}
		});
		
	}
	
	function formToObject(formID) {
	    var formularioObject = {};
	    var formularioArray = $( formID ).serializeArray();
	    $.each(formularioArray, function(i, v) {
	        formularioObject[v.name] = v.value;
	    });
	    return formularioObject;
	}

	function aceptar(){
		$('#divRegistroControl').modal("hide");
		location.href = '${pageContext.request.contextPath}/listarControlAnimal';
	}
	
	function validarNumeroLetra(e){
		var key = window.Event ? e.which : e.keyCode;
		return ( (key >= 48 && key <= 57) || (key==32 ) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) );
 	}
</script>

<div class="panel-heading" >
	<h3 class="panel-title" align="center" id="titulo"></h3>
</div>

<div class="panel-body">
	<div class="row">
		<div class="col-sm-12">

			<form id="formControl" name="formControl" role="form" class="form-horizontal" method="post">
				
				<div class="form-group">
					<div class="col-sm-4" style="text-align:right; font-weight:bold">Sintoma:</div>
					<div class="col-sm-6" id="divCodigoAnimalEdicion">
						<input name="sintoma" id="txtSintoma" type="text" class="form-control tamanoMaximo" ></input>
					</div>
					<div class="col-sm-2"></div>
				</div>
				
				<div class="row">&nbsp;</div>

				<div class="form-group">
					<div class="col-sm-4" style="text-align: center">
						<button id="btnCerrar" type="button"
							class="btn btn-primary centro" onclick="cerraControlAnimal()"
							title="Cerrar">Cerrar</button>
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

<div id="divConfirmacionRegistroSintoma" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="panel panel-info">
			<div class="panel-heading"> <strong>Registro Satisfactorio</strong></div>
			<div class="panel-body">
				<div class="modal-body"> <p class="text-center" id="mensajeTransaccion">Se registro satisfactoriamente el sintoma</p></div>
				<div class="modal-footer">
					<div class="col-sm-12" align="center">
						<input type="button" id="btnRegistro" class="btn btn-primary" onclick="aceptar()" value="Aceptar"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

