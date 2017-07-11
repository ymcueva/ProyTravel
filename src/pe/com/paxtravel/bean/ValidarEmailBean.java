package pe.com.paxtravel.bean;

public class ValidarEmailBean {

	private String email;
	private int idCotizacion;
	private int idCliente;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getIdCotizacion() {
		return idCotizacion;
	}

	public void setIdCotizacion(int idCotizacion) {
		this.idCotizacion = idCotizacion;
	}

	public int getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(int idCliente) {
		this.idCliente = idCliente;
	}

	@Override
	public String toString() {
		return "ValidarEmailBean [email=" + email + ", idCotizacion="
				+ idCotizacion + ", idCliente=" + idCliente + "]";
	}

}
