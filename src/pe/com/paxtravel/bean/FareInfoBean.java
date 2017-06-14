package pe.com.paxtravel.bean;

public class FareInfoBean {

	private String airlineCode;
	private String fare;
	private String href;
	private int idProveedor;
	private int idAerolinea;
	private String comision;
	
	private String nombreProveedor;
	private String destino;
	private String nombreAerolinea;
	private int idDestino;
	private double precio;
	private String url;
	
		
	
	
	public String getNombreAerolinea() {
		return nombreAerolinea;
	}
	public void setNombreAerolinea(String nombreAerolinea) {
		this.nombreAerolinea = nombreAerolinea;
	}
	public String getDestino() {
		return destino;
	}
	public void setDestino(String destino) {
		this.destino = destino;
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
	public String getComision() {
		return comision;
	}
	public void setComision(String comision) {
		this.comision = comision;
	}
	public String getNombreProveedor() {
		return nombreProveedor;
	}
	public void setNombreProveedor(String nombreProveedor) {
		this.nombreProveedor = nombreProveedor;
	}
	public String getAirlineCode() {
		return airlineCode;
	}
	public void setAirlineCode(String airlineCode) {
		this.airlineCode = airlineCode;
	}
	public String getFare() {
		return fare;
	}
	public void setFare(String fare) {
		this.fare = fare;
	}
	public String getHref() {
		return href;
	}
	public void setHref(String href) {
		this.href = href;
	}
	
	public String toString() {
		return this.href + "," + this.fare + "," + this.airlineCode + "," + this.nombreProveedor + "," + this.comision + "," + this.idAerolinea + "," + 
				this.idProveedor + "," + this.nombreAerolinea + "," + this.destino;
	}
	public int getIdDestino() {
		return idDestino;
	}
	public void setIdDestino(int idDestino) {
		this.idDestino = idDestino;
	}
	public double getPrecio() {
		return precio;
	}
	public void setPrecio(double precio) {
		this.precio = precio;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	
}
