package pe.com.paxtravel.bean;

public class AuthorizeNetBean {

	private String numeroOperacion;
	private String estadoOperacion;
	private String mensajeProcesador;

	public String getNumeroOperacion() {
		return numeroOperacion;
	}

	public void setNumeroOperacion(String numeroOperacion) {
		this.numeroOperacion = numeroOperacion;
	}

	public String getEstadoOperacion() {
		return estadoOperacion;
	}

	public void setEstadoOperacion(String estadoOperacion) {
		this.estadoOperacion = estadoOperacion;
	}

	public String getMensajeProcesador() {
		return mensajeProcesador;
	}

	public void setMensajeProcesador(String mensajeProcesador) {
		this.mensajeProcesador = mensajeProcesador;
	}

	@Override
	public String toString() {
		return "AuthorizeNetBean [numeroOperacion=" + numeroOperacion
				+ ", estadoOperacion=" + estadoOperacion
				+ ", mensajeProcesador=" + mensajeProcesador + "]";
	}

}
