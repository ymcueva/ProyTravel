package pe.com.paxtravel.bean;

public class ProcesarPagoBean {

	private int tipoTarjeta;
	private String numeroTarjeta;
	private int codigoSeguridad;

	private int idCliente;
	private int idCotiza;
	private double imPrecio;
	private int idPaquete;
	private String emailCliente;
	private String mes;
	private String anio;

	public int getTipoTarjeta() {
		return tipoTarjeta;
	}

	public void setTipoTarjeta(int tipoTarjeta) {
		this.tipoTarjeta = tipoTarjeta;
	}

	public String getNumeroTarjeta() {
		return numeroTarjeta;
	}

	public void setNumeroTarjeta(String numeroTarjeta) {
		this.numeroTarjeta = numeroTarjeta;
	}

	public int getCodigoSeguridad() {
		return codigoSeguridad;
	}

	public void setCodigoSeguridad(int codigoSeguridad) {
		this.codigoSeguridad = codigoSeguridad;
	}

	public int getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(int idCliente) {
		this.idCliente = idCliente;
	}

	public int getIdCotiza() {
		return idCotiza;
	}

	public void setIdCotiza(int idCotiza) {
		this.idCotiza = idCotiza;
	}

	public double getImPrecio() {
		return imPrecio;
	}

	public void setImPrecio(double imPrecio) {
		this.imPrecio = imPrecio;
	}

	public int getIdPaquete() {
		return idPaquete;
	}

	public void setIdPaquete(int idPaquete) {
		this.idPaquete = idPaquete;
	}

	public String getEmailCliente() {
		return emailCliente;
	}

	public void setEmailCliente(String emailCliente) {
		this.emailCliente = emailCliente;
	}

	public String getMes() {
		return mes;
	}

	public void setMes(String mes) {
		this.mes = mes;
	}

	public String getAnio() {
		return anio;
	}

	public void setAnio(String anio) {
		this.anio = anio;
	}

}
