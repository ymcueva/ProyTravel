package pe.com.paxtravel.bean;

public class RechazarCotizacionBean {

	private int idCotiza;
	private int idPaquete;
	private String observacion;

	public int getIdCotiza() {
		return idCotiza;
	}

	public void setIdCotiza(int idCotiza) {
		this.idCotiza = idCotiza;
	}

	public int getIdPaquete() {
		return idPaquete;
	}

	public void setIdPaquete(int idPaquete) {
		this.idPaquete = idPaquete;
	}

	public String getObservacion() {
		return observacion;
	}

	public void setObservacion(String observacion) {
		this.observacion = observacion;
	}

	@Override
	public String toString() {
		return "RechazarCotizacionBean [idCotiza=" + idCotiza + ", idPaquete="
				+ idPaquete + ", observacion=" + observacion + "]";
	}

}
