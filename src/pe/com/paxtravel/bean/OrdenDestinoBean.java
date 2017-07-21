package pe.com.paxtravel.bean;

public class OrdenDestinoBean {
	
	private int idDetalle;
	private int idOrden;
	private int destino;	
	private int origen;
	private int cantidadNino;
	private int cantidadAdulto;
	private int nudias;
	private String fechaPartida;
	private String fechaRetorno;
	private int ruta;
	private int tiIda;
	private Integer vuelta;
	
	
	public int getIdDetalle() {
		return idDetalle;
	}
	public void setIdDetalle(int idDetalle) {
		this.idDetalle = idDetalle;
	}
	public int getIdOrden() {
		return idOrden;
	}
	public void setIdOrden(int idOrden) {
		this.idOrden = idOrden;
	}
	public int getDestino() {
		return destino;
	}
	public void setDestino(int destino) {
		this.destino = destino;
	}
	public int getCantidadNino() {
		return cantidadNino;
	}
	public void setCantidadNino(int cantidadNino) {
		this.cantidadNino = cantidadNino;
	}
	public int getCantidadAdulto() {
		return cantidadAdulto;
	}
	public void setCantidadAdulto(int cantidadAdulto) {
		this.cantidadAdulto = cantidadAdulto;
	}
	public int getNudias() {
		return nudias;
	}
	public void setNudias(int nudias) {
		this.nudias = nudias;
	}
	public String getFechaPartida() {
		return fechaPartida;
	}
	public void setFechaPartida(String fechaPartida) {
		this.fechaPartida = fechaPartida;
	}
	public String getFechaRetorno() {
		return fechaRetorno;
	}
	public void setFechaRetorno(String fechaRetorno) {
		this.fechaRetorno = fechaRetorno;
	}
	public int getRuta() {
		return ruta;
	}
	public void setRuta(int ruta) {
		this.ruta = ruta;
	}
	public int getTiIda() {
		return tiIda;
	}
	public void setTiIda(int tiIda) {
		this.tiIda = tiIda;
	}
	public Integer getVuelta() {
		return vuelta;
	}
	public void setVuelta(Integer vuelta) {
		this.vuelta = vuelta;
	}
	public int getOrigen() {
		return origen;
	}
	public void setOrigen(int origen) {
		this.origen = origen;
	}
	
}
