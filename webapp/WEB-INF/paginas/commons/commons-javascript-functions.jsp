
		function generarTamanioPagina( pagConForm ) {
	        if ( pagConForm != null && pagConForm != '' ) {
	            return parseInt( pagConForm );
	        }   
	    	// default
	        return 10;
	    }


		function handleErrorJson( data  ) {
			
			// si no viene data
			if ( data == null ) {
				showMensajeError( 'Mensaje', 'Respuesta JSON no seteada');
				return true;
			}
			
			// si no viene estado
			if ( data.estado == null ) {
				showMensajeError( 'Mensaje', 'Atributo estado de respuesta JSON no seteado');
				return true;
			}
			
			// si viene error de aplicacion
		    if ( data.estado != 'ok' ) {
		    	showMensajeError( 'Mensaje', ( ' ' + data.msg  ) );
		        return true;
		    }

			return false;
		}
		
	    function showMensajeExito( titulo, mensaje, functionAceptar ) {
			return showMensaje( titulo, mensaje, functionAceptar, 'exito' );		 
	    }    
		
	    function showMensajeError( titulo, mensaje, functionAceptar ) {
			return showMensaje( titulo, mensaje, functionAceptar, 'error' );    	 
	    }
	    
	    function showMensajeAlert( titulo, mensaje, functionAceptar ) {
			return showMensaje( titulo, mensaje, functionAceptar, 'alert' );    	 
	    }  	

	    function showMensaje( titulo, mensaje, functionAceptar, tipoMensaje ) {
			if ( tipoMensaje == 'exito' || tipoMensaje == 'success' ) {
				$( '#divPopupPanelClass' ).prop( 'class', 'panel panel-success' );
			} else if ( tipoMensaje == 'error' || tipoMensaje == 'danger' ) {
				$( '#divPopupPanelClass' ).prop( 'class', 'panel panel-danger' );
			} else if ( tipoMensaje == 'alert' || tipoMensaje == 'warning' ) {
				$( '#divPopupPanelClass' ).prop( 'class', 'panel panel-warning' );
			} else {
				$( '#divPopupPanelClass' ).prop( 'class', 'panel panel-default' );
			}
		
			if ( $( '#divModalPopup' ).length ) {
				// si se tiene el div de popup
				$( '#divPopupTitulo' ).html( titulo );
				$( '#divPopupMensaje' ).html( mensaje );
				$( '#divModalPopup' ).modal({ keyboard: false })	
				$( '#btnPopupAceptar' ).unbind('click');
				if ( functionAceptar != null ) {
					$( '#btnPopupAceptar' ).on('click', functionAceptar); 
				}
			} else {
				// sino imprimir un simple alert
				alert( mensaje );
			}  		
	    }