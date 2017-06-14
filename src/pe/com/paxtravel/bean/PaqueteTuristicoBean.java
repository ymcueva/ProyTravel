package pe.com.paxtravel.bean;


public class PaqueteTuristicoBean {
	

	private int numeroFila;
	private int idPaquete;
	private String nombre;
	private int idEstado;
	private String observacion;
	private int idOrden;
	private String fecha;
	private String feInicio;
	private String feFin;
	private int idTrabajador;
	private int nuNinos;
	private int nuAdultos;
	private int idMoneda;
	private Double imMin;
	private Double imMax;
	private String noEstado;
	private String noCliente;
	private String fechRango;
	private String numDocCliente;
	private String cliente;
	private int tipoBusqueda;
	private String nuOrden;
	private double totalGasto;
	private double totalTour;
	private double totalTicket;
	private double totalHotel;
	private String comentario;
	
	public int getNumeroFila() {
		return numeroFila;
	}
	public void setNumeroFila(int numeroFila) {
		this.numeroFila = numeroFila;
	}
	public int getIdPaquete() {
		return idPaquete;
	}
	public void setIdPaquete(int idPaquete) {
		this.idPaquete = idPaquete;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public int getIdEstado() {
		return idEstado;
	}
	public void setIdEstado(int idEstado) {
		this.idEstado = idEstado;
	}
	public String getObservacion() {
		return observacion;
	}
	public void setObservacion(String observacion) {
		this.observacion = observacion;
	}
	public int getIdOrden() {
		return idOrden;
	}
	public void setIdOrden(int idOrden) {
		this.idOrden = idOrden;
	}
	public String getFecha() {
		return fecha;
	}
	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
	public String getFeInicio() {
		return feInicio;
	}
	public void setFeInicio(String feInicio) {
		this.feInicio = feInicio;
	}
	public String getFeFin() {
		return feFin;
	}
	public void setFeFin(String feFin) {
		this.feFin = feFin;
	}
	public int getIdTrabajador() {
		return idTrabajador;
	}
	public void setIdTrabajador(int idTrabajador) {
		this.idTrabajador = idTrabajador;
	}
	public int getNuNinos() {
		return nuNinos;
	}
	public void setNuNinos(int nuNinos) {
		this.nuNinos = nuNinos;
	}
	public int getNuAdultos() {
		return nuAdultos;
	}
	public void setNuAdultos(int nuAdultos) {
		this.nuAdultos = nuAdultos;
	}
	public int getIdMoneda() {
		return idMoneda;
	}
	public void setIdMoneda(int idMoneda) {
		this.idMoneda = idMoneda;
	}
	public Double getImMin() {
		return imMin;
	}
	
	public String getNoEstado(){
		return noEstado;
	}
	
	public String getNoCliente(){
		return noCliente;
	}
	
	public String getFechRango(){
		return fechRango;
	}
	
	public String getNumDocCliente(){
		return numDocCliente;
	}
	
	public String getCliente() {
		return cliente;
	}
	
	public int getTipoBusqueda() {
		return tipoBusqueda;
	}
	
	public void setImMin(Double imMin) {
		this.imMin = imMin;
	}
	public Double getImMax() {
		return imMax;
	}
	public void setImMax(Double imMax) {
		this.imMax = imMax;
	}
	public void setNoEstado(String noEstado) {
		this.noEstado = noEstado;
	}
	
	public void setNoCliente(String noCliente) {
		this.noCliente = noCliente;
	}
	
	public void setFechRango(String fechRango) {
		this.fechRango = fechRango;
	}
	
	public void setNumDocCliente(String numDocCliente) {
		this.numDocCliente = numDocCliente;
	}
	
	public void setCliente(String cliente) {
	   this.cliente = cliente;
	}
	
	public void setTipoBusqueda(int tipobusqueda) {
		this.tipoBusqueda = tipobusqueda;
	
	}
	
	public String toString(){
		return  "PaqueteTuristicoBean [idPaquete=" + idPaquete+ " ," +
				"nombre=" + nombre+ " ," +
				"idEstado=" + idEstado+ " ," +
				"observacion=" + observacion+ " ," +
				"idOrden=" + idOrden+ " ," +
				"fecha=" + fecha+ " ," +
				"feInicio=" + feInicio+ " ," +
				"feFin=" + feFin+ " ," +
				"idTrabajador=" + idTrabajador+ " ," +
				"nuNinos=" + nuNinos+ " ," +
				"nuAdultos=" + nuAdultos+ " ," +
				"idMoneda=" + idMoneda+ " ," +
				"imMin=" + imMin+ " ," +
				"imMax=" + imMax + " ," +
				"noEstado=" + noEstado + " ," +
				"Cliente=" + noCliente + " ," +
				"FechRango=" + fechRango +  " ," +
				"NuOrden=" + nuOrden + "]";
	}
	public String getNuOrden() {
		return nuOrden;
	}
	public void setNuOrden(String nuOrden) {
		this.nuOrden = nuOrden;
	}
	public double getTotalGasto() {
		return totalGasto;
	}
	public void setTotalGasto(double totalGasto) {
		this.totalGasto = totalGasto;
	}
	public double getTotalTour() {
		return totalTour;
	}
	public void setTotalTour(double totalTour) {
		this.totalTour = totalTour;
	}
	public double getTotalTicket() {
		return totalTicket;
	}
	public void setTotalTicket(double totalTicket) {
		this.totalTicket = totalTicket;
	}
	public double getTotalHotel() {
		return totalHotel;
	}
	public void setTotalHotel(double totalHotel) {
		this.totalHotel = totalHotel;
	}
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
	
}
