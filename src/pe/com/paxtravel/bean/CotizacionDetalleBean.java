package pe.com.paxtravel.bean;

public class CotizacionDetalleBean {
	
	private String numeroCotizacion;
	
	private int origen;
	
	private int destino;

	private int cantidadNino;
	
	private int cantidadAdulto;
	
	private int idaVuelta;
	
	private int ida;
	
	private String fechaPartida;
	
	private String fechaRetorno;
	
	private int ruta;

	public String getNumeroCotizacion() {
		return numeroCotizacion;
	}

	public void setNumeroCotizacion(String numeroCotizacion) {
		this.numeroCotizacion = numeroCotizacion;
	}

	public int getOrigen() {
		return origen;
	}

	public void setOrigen(int origen) {
		this.origen = origen;
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

	public int getIdaVuelta() {
		return idaVuelta;
	}

	public void setIdaVuelta(int idaVuelta) {
		this.idaVuelta = idaVuelta;
	}

	public int getIda() {
		return ida;
	}

	public void setIda(int ida) {
		this.ida = ida;
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

	
}
