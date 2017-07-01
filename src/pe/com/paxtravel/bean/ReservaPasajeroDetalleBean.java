package pe.com.paxtravel.bean;

public class ReservaPasajeroDetalleBean {
	
	private int idReserva;
	private String tipoDocumento;
	private String numeroDocumento;
	private String nombres;
	private String apellidos;
	private String fechaNacimiento;
	private int idParentesco;
	
	public int getIdReserva() {
		return idReserva;
	}
	public void setIdReserva(int idReserva) {
		this.idReserva = idReserva;
	}
	public String getTipoDocumento() {
		return tipoDocumento;
	}
	public void setTipoDocumento(String tipoDocumento) {
		this.tipoDocumento = tipoDocumento;
	}
	public String getNumeroDocumento() {
		return numeroDocumento;
	}
	public void setNumeroDocumento(String numeroDocumento) {
		this.numeroDocumento = numeroDocumento;
	}
	public String getNombres() {
		return nombres;
	}
	public void setNombres(String nombres) {
		this.nombres = nombres;
	}
	public String getApellidos() {
		return apellidos;
	}
	public void setApellidos(String apellidos) {
		this.apellidos = apellidos;
	}
	public String getFechaNacimiento() {
		return fechaNacimiento;
	}
	public void setFechaNacimiento(String fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}
	public int getIdParentesco() {
		return idParentesco;
	}
	public void setIdParentesco(int idParentesco) {
		this.idParentesco = idParentesco;
	}
	
}
