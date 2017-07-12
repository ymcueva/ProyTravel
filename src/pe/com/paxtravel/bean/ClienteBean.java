package pe.com.paxtravel.bean;

public class ClienteBean {

	private int idCliente;
	private String numeroDocumento;
	private String tipoDocumento;
	private String codigo;
	private String paterno;
	private String materno;
	private String nombre;
	private String dni;
	private String ciudad;
	private String direccion;
	private String telefono;
	private String email;
	private String estado;
	private int age;
	private int tipoDocu;
	private String apellidos;
	private String fechaNacimiento;
	private boolean emailValidado;

	public ClienteBean() {
		super();
	}

	public ClienteBean(int idCliente, boolean emailValidado) {
		super();
		this.idCliente = idCliente;
		this.emailValidado = emailValidado;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public int getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(int idCliente) {
		this.idCliente = idCliente;
	}

	public String getNumeroDocumento() {
		return numeroDocumento;
	}

	public void setNumeroDocumento(String numeroDocumento) {
		this.numeroDocumento = numeroDocumento;
	}

	public String getTipoDocumento() {
		return tipoDocumento;
	}

	public void setTipoDocumento(String tipoDocumento) {
		this.tipoDocumento = tipoDocumento;
	}

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public String getPaterno() {
		return paterno;
	}

	public void setPaterno(String paterno) {
		this.paterno = paterno;
	}

	public String getMaterno() {
		return materno;
	}

	public void setMaterno(String materno) {
		this.materno = materno;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getDni() {
		return dni;
	}

	public void setDni(String dni) {
		this.dni = dni;
	}

	public String getCiudad() {
		return ciudad;
	}

	public void setCiudad(String ciudad) {
		this.ciudad = ciudad;
	}

	public String getDireccion() {
		return direccion;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public int getTipoDocu() {
		return tipoDocu;
	}

	public void setTipoDocu(int tipoDocu) {
		this.tipoDocu = tipoDocu;
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

	public boolean isEmailValidado() {
		return emailValidado;
	}

	public void setEmailValidado(boolean emailValidado) {
		this.emailValidado = emailValidado;
	}

	@Override
	public String toString() {
		return "ClienteBean [idCliente=" + idCliente + ", numeroDocumento="
				+ numeroDocumento + ", email=" + email + ", emailValidado="
				+ emailValidado + "]";
	}

}
