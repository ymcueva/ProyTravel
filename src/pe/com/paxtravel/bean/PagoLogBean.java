package pe.com.paxtravel.bean;

public class PagoLogBean {

	private int idPago;
	private int idCliente;
	private int idCotiza;
	private String nuOperacion;
	private String stOperacion;
	private String deMensaje;
	private double imPrecio;
	private String feIns;
	private int idPaquete;

	public int getIdPago() {
		return idPago;
	}

	public void setIdPago(int idPago) {
		this.idPago = idPago;
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

	public String getNuOperacion() {
		return nuOperacion;
	}

	public void setNuOperacion(String nuOperacion) {
		this.nuOperacion = nuOperacion;
	}

	public String getStOperacion() {
		return stOperacion;
	}

	public void setStOperacion(String stOperacion) {
		this.stOperacion = stOperacion;
	}

	public String getDeMensaje() {
		return deMensaje;
	}

	public void setDeMensaje(String deMensaje) {
		this.deMensaje = deMensaje;
	}

	public double getImPrecio() {
		return imPrecio;
	}

	public void setImPrecio(double imPrecio) {
		this.imPrecio = imPrecio;
	}

	public String getFeIns() {
		return feIns;
	}

	public void setFeIns(String feIns) {
		this.feIns = feIns;
	}

	public int getIdPaquete() {
		return idPaquete;
	}

	public void setIdPaquete(int idPaquete) {
		this.idPaquete = idPaquete;
	}

	@Override
	public String toString() {
		return "PagoLogBean [idPago=" + idPago + ", idCliente=" + idCliente
				+ ", idCotiza=" + idCotiza + ", nuOperacion=" + nuOperacion
				+ ", stOperacion=" + stOperacion + ", deMensaje=" + deMensaje
				+ ", imPrecio=" + imPrecio + ", feIns=" + feIns
				+ ", idPaquete=" + idPaquete + "]";
	}

}
