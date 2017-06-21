package pe.com.paxtravel.bean;

public class OrdenDestinoBean {
	
	private int idDetalle;
	private int idorden;
	private int destino;	
	private int cantidadNino;
	private int cantidadAdulto;
	private int nudias;
	private String fechaPartida;
	private String fechaRetorno;
	private int ruta;
	private int tiIda;
	public int getIdDetalle() {
		return idDetalle;
	}
	public void setIdDetalle(int idDetalle) {
		this.idDetalle = idDetalle;
	}
	public int getIdorden() {
		return idorden;
	}
	public void setIdorden(int idorden) {
		this.idorden = idorden;
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
	
}
