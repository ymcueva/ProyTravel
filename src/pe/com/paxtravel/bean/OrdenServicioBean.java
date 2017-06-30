package pe.com.paxtravel.bean;

public class OrdenServicioBean {
	private String idOrden;
	private int idServicio;
	private String descripcion;
	
	public String getIdOrden() {
		return idOrden;
	}
	public void setIdOrden(String idOrden) {
		this.idOrden = idOrden;
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
}
