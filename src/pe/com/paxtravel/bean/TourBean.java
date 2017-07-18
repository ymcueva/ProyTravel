package pe.com.paxtravel.bean;

public class TourBean {
	private int idTour;
	private int idDestinoCiudad;
	private int idProveedor;
	private String descripcion;
	private String itinerario;
	private String servicios;
	private int duracion;
	private String tipoTour;
	private double precioAdulto;
	private double precioNino;
	private int flagServicios;
	private String referencia;
	
	
	public int getIdTour() {
		return idTour;
	}
	public void setIdTour(int idTour) {
		this.idTour = idTour;
	}
	public int getIdDestinoCiudad() {
		return idDestinoCiudad;
	}
	public void setIdDestinoCiudad(int idDestinoCiudad) {
		this.idDestinoCiudad = idDestinoCiudad;
	}
	public int getIdProveedor() {
		return idProveedor;
	}
	public void setIdProveedor(int idProveedor) {
		this.idProveedor = idProveedor;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getItinerario() {
		return itinerario;
	}
	public void setItinerario(String itinerario) {
		this.itinerario = itinerario;
	}
	public String getServicios() {
		return servicios;
	}
	public void setServicios(String servicios) {
		this.servicios = servicios;
	}
	public int getDuracion() {
		return duracion;
	}
	public void setDuracion(int duracion) {
		this.duracion = duracion;
	}
	public String getTipoTour() {
		return tipoTour;
	}
	public void setTipoTour(String tipoTour) {
		this.tipoTour = tipoTour;
	}
	public double getPrecioAdulto() {
		return precioAdulto;
	}
	public void setPrecioAdulto(double precioAdulto) {
		this.precioAdulto = precioAdulto;
	}
	public double getPrecioNino() {
		return precioNino;
	}
	public void setPrecioNino(double precioNino) {
		this.precioNino = precioNino;
	}
	public int getFlagServicios() {
		return flagServicios;
	}
	public void setFlagServicios(int flagServicios) {
		this.flagServicios = flagServicios;
	}
	public String getReferencia() {
		return referencia;
	}
	public void setReferencia(String referencia) {
		this.referencia = referencia;
	}
}
