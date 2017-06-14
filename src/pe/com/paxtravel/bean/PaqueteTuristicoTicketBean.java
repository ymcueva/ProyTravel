package pe.com.paxtravel.bean;

public class PaqueteTuristicoTicketBean {
	
	private int idPaqueteTicket;
	private int idPaqueteTuristico;
	private int idProveedor;
	private int idAerolinea;
	private double imPrecio;
	private String urlTicket;
	private int idDestino;
	private int nuAdultos;
	private int nuNinos;
	private String tipoTicket;
	
	public int getIdPaqueteTicket() {
		return idPaqueteTicket;
	}
	public void setIdPaqueteTicket(int idPaqueteTicket) {
		this.idPaqueteTicket = idPaqueteTicket;
	}
	public int getIdPaqueteTuristico() {
		return idPaqueteTuristico;
	}
	public void setIdPaqueteTuristico(int idPaqueteTuristico) {
		this.idPaqueteTuristico = idPaqueteTuristico;
	}
	public int getIdProveedor() {
		return idProveedor;
	}
	public void setIdProveedor(int idProveedor) {
		this.idProveedor = idProveedor;
	}
	public int getIdAerolinea() {
		return idAerolinea;
	}
	public void setIdAerolinea(int idAerolinea) {
		this.idAerolinea = idAerolinea;
	}
	public double getImPrecio() {
		return imPrecio;
	}
	public void setImPrecio(double imPrecio) {
		this.imPrecio = imPrecio;
	}
	public String getUrlTicket() {
		return urlTicket;
	}
	public void setUrlTicket(String urlTicket) {
		this.urlTicket = urlTicket;
	}
	public int getIdDestino() {
		return idDestino;
	}
	public void setIdDestino(int idDestino) {
		this.idDestino = idDestino;
	}
	public int getNuAdultos() {
		return nuAdultos;
	}
	public void setNuAdultos(int nuAdultos) {
		this.nuAdultos = nuAdultos;
	}
	public int getNuNinos() {
		return nuNinos;
	}
	public void setNuNinos(int nuNinos) {
		this.nuNinos = nuNinos;
	}
	public String getTipoTicket() {
		return tipoTicket;
	}
	public void setTipoTicket(String tipoTicket) {
		this.tipoTicket = tipoTicket;
	}
	

}
