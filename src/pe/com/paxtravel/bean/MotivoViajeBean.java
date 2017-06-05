package pe.com.paxtravel.bean;

public class MotivoViajeBean {

	private String numeroCotizacion;
	private String numeroOrden;
	private int codigoMotivo;

	public String getNumeroOrden() {
		return numeroOrden;
	}

	public void setNumeroOrden(String numeroOrden) {
		this.numeroOrden = numeroOrden;
	}

	public String getNumeroCotizacion() {
		return numeroCotizacion;
	}

	public void setNumeroCotizacion(String numeroCotizacion) {
		this.numeroCotizacion = numeroCotizacion;
	}
	
	

	public int getCodigoMotivo() {
		return codigoMotivo;
	}

	public void setCodigoMotivo(int codigoMotivo) {
		this.codigoMotivo = codigoMotivo;
	}
	
}