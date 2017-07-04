package pe.com.paxtravel.bean;

public class CotizacionServicioBean {

	private String idCotiza;
	private int idServicio;
	private String nomServicio;
	private String descripcion;
	public String getIdCotiza() {
		return idCotiza;
	}
	public void setIdCotiza(String idCotiza) {
		this.idCotiza = idCotiza;
	}
	public int getIdServicio() {
		return idServicio;
	}
	public void setIdServicio(int idServicio) {
		this.idServicio = idServicio;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getNomServicio() {
		return nomServicio;
	}
	public void setNomServicio(String nomServicio) {
		this.nomServicio = nomServicio;
	}
	
}
