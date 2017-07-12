package pe.com.paxtravel.bean;

public class CotizacionDetalleTicketVueloBean {

	private int idCotizaDeta;
	private String idCotiza;
	private int idAerolinea;
	private double imPrecio;
	private int idProveedor;
	private String urlShop;
	
	private double imComision;
	private int nuComision;
	private int idDestino;
	private int idOrigen;
	private String fePartida;
	private String feRetorno;
	
	public CotizacionDetalleTicketVueloBean(){
		
	}
	
	
	
	public CotizacionDetalleTicketVueloBean(int idCotizaDeta, String idCotiza,
			int idAerolinea, double imPrecio, int idProveedor, String urlShop,
			double imComision, int nuComision, int idDestino, int idOrigen,
			String fePartida, String feRetorno) {
		super();
		this.idCotizaDeta = idCotizaDeta;
		this.idCotiza = idCotiza;
		this.idAerolinea = idAerolinea;
		this.imPrecio = imPrecio;
		this.idProveedor = idProveedor;
		this.urlShop = urlShop;
		this.imComision = imComision;
		this.nuComision = nuComision;
		this.idDestino = idDestino;
		this.idOrigen = idOrigen;
		this.fePartida = fePartida;
		this.feRetorno = feRetorno;
	}



	public double getImComision() {
		return imComision;
	}



	public void setImComision(double imComision) {
		this.imComision = imComision;
	}



	public int getNuComision() {
		return nuComision;
	}



	public void setNuComision(int nuComision) {
		this.nuComision = nuComision;
	}



	public int getIdDestino() {
		return idDestino;
	}



	public void setIdDestino(int idDestino) {
		this.idDestino = idDestino;
	}



	public int getIdOrigen() {
		return idOrigen;
	}



	public void setIdOrigen(int idOrigen) {
		this.idOrigen = idOrigen;
	}



	public String getFePartida() {
		return fePartida;
	}



	public void setFePartida(String fePartida) {
		this.fePartida = fePartida;
	}



	public String getFeRetorno() {
		return feRetorno;
	}



	public void setFeRetorno(String feRetorno) {
		this.feRetorno = feRetorno;
	}



	public double getImPrecio() {
		return imPrecio;
	}
	public void setImPrecio(double imPrecio) {
		this.imPrecio = imPrecio;
	}	
	public int getIdCotizaDeta() {
		return idCotizaDeta;
	}
	public void setIdCotizaDeta(int idCotizaDeta) {
		this.idCotizaDeta = idCotizaDeta;
	}
	public String getIdCotiza() {
		return idCotiza;
	}
	public void setIdCotiza(String idCotiza) {
		this.idCotiza = idCotiza;
	}
	public int getIdAerolinea() {
		return idAerolinea;
	}
	public void setIdAerolinea(int idAerolinea) {
		this.idAerolinea = idAerolinea;
	}
	public int getIdProveedor() {
		return idProveedor;
	}
	public void setIdProveedor(int idProveedor) {
		this.idProveedor = idProveedor;
	}
	public String getUrlShop() {
		return urlShop;
	}
	public void setUrlShop(String urlShop) {
		this.urlShop = urlShop;
	}
	
	
	
	
}
