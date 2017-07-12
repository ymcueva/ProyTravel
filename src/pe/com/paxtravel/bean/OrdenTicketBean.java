package pe.com.paxtravel.bean;

public class OrdenTicketBean {
	private int idDetalle;
	private int idAerolinea;
	private double precio;
	private int idProveedor;
	private int idDestino;
	private String nomAerolinea;
	private String url;
	private int comision;
	public int getIdDetalle() {
		return idDetalle;
	}
	public void setIdDetalle(int idDetalle) {
		this.idDetalle = idDetalle;
	}
	
}
