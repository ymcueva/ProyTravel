package pe.com.paxtravel.bean;

public class MotivoViajeBean {

	private int idOrden;
	private String numeroCotizacion;
	private String numeroOrden;
	private int codigoMotivo;
	private String nomMotivo;

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
	

	public int getIdOrden() {
		return idOrden;
	}

	public void setIdOrden(int idOrden) {
		this.idOrden = idOrden;
	}

	public int getCodigoMotivo() {
		return codigoMotivo;
	}

	public void setCodigoMotivo(int codigoMotivo) {
		this.codigoMotivo = codigoMotivo;
	}

	public String getNomMotivo() {
		return nomMotivo;
	}

	public void setNomMotivo(String nomMotivo) {
		this.nomMotivo = nomMotivo;
	}
	
}