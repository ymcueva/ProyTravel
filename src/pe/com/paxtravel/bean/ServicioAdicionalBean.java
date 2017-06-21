package pe.com.paxtravel.bean;

public class ServicioAdicionalBean {

	private String numeroCotizacion;
	private String nomServicio;
	private String numeroOrden;
	private int idOrden;
	private int codigoServicio;

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

	public int getCodigoServicio() {
		return codigoServicio;
	}

	public void setCodigoServicio(int codigoServicio) {
		this.codigoServicio = codigoServicio;
	}

	public int getIdOrden() {
		return idOrden;
	}

	public void setIdOrden(int idOrden) {
		this.idOrden = idOrden;
	}

	public String getNomServicio() {
		return nomServicio;
	}

	public void setNomServicio(String nomServicio) {
		this.nomServicio = nomServicio;
	}
	
}