package pe.com.paxtravel.bean;

public class HotelBean {
	private int idHotel;
	private int idProveedor;
	private String descripcion;
	private int idTipoAlojamiento;
	private int idCategoriaAlojamiento;
	private int idDestino;
	private String nomTipo;
	private String nomCategoria;
	private double precio;
	private String direccion;
	private String referencia;
	
	
	public int getIdHotel() {
		return idHotel;
	}
	public void setIdHotel(int idHotel) {
		this.idHotel = idHotel;
	}
	public int getIdProveedor() {
		return idProveedor;
	}
	public void setIdProveedor(int idProveedor) {
		this.idProveedor = idProveedor;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public int getIdTipoAlojamiento() {
		return idTipoAlojamiento;
	}
	public void setIdTipoAlojamiento(int idTipoAlojamiento) {
		this.idTipoAlojamiento = idTipoAlojamiento;
	}
	public int getIdCategoriaAlojamiento() {
		return idCategoriaAlojamiento;
	}
	public void setIdCategoriaAlojamiento(int idCategoriaAlojamiento) {
		this.idCategoriaAlojamiento = idCategoriaAlojamiento;
	}
	public int getIdDestino() {
		return idDestino;
	}
	public void setIdDestino(int idDestino) {
		this.idDestino = idDestino;
	}
	public String getNomTipo() {
		return nomTipo;
	}
	public void setNomTipo(String nomTipo) {
		this.nomTipo = nomTipo;
	}
	public String getNomCategoria() {
		return nomCategoria;
	}
	public void setNomCategoria(String nomCategoria) {
		this.nomCategoria = nomCategoria;
	}
	public double getPrecio() {
		return precio;
	}
	public void setPrecio(double precio) {
		this.precio = precio;
	}
	public String getDireccion() {
		return direccion;
	}
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	public String getReferencia() {
		return referencia;
	}
	public void setReferencia(String referencia) {
		this.referencia = referencia;
	}
}
