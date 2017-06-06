package pe.com.paxtravel.bean;


public class OrdenPlanificacionBean {
	
	
	private int idOrden;
	private int idCotiza;	
	private String nuOrden;	
	private String observacion;
	private int idTrabajador;
	private String descripcion;
	private String feOrder;
	private int autorizacion;
	private Double imPresupuestoMinimo;
	private Double imPresupuestoMaximo;
	private int idCliente;
	private int idEstado;
	private int idMoneda;
	private String feInicio;
	private String feFin;
	private int nuAdultos;
	private int nuNinos;
	
	
	public int getNuAdultos() {
		return nuAdultos;
	}
	public void setNuAdultos(int nuAdultos) {
		this.nuAdultos = nuAdultos;
	}
	public int getNuNinos() {
		return nuNinos;
	}
	public void setNuNinos(int nuNinos) {
		this.nuNinos = nuNinos;
	}
	public int getIdOrden() {
		return idOrden;
	}
	public void setIdOrden(int idOrden) {
		this.idOrden = idOrden;
	}
	public int getIdCotiza() {
		return idCotiza;
	}
	public void setIdCotiza(int idCotiza) {
		this.idCotiza = idCotiza;
	}
	public String getNuOrden() {
		return nuOrden;
	}
	public void setNuOrden(String nuOrden) {
		this.nuOrden = nuOrden;
	}
	public String getObservacion() {
		return observacion;
	}
	public void setObservacion(String observacion) {
		this.observacion = observacion;
	}
	public int getIdTrabajador() {
		return idTrabajador;
	}
	public void setIdTrabajador(int idTrabajador) {
		this.idTrabajador = idTrabajador;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getFeOrder() {
		return feOrder;
	}
	public void setFeOrder(String feOrder) {
		this.feOrder = feOrder;
	}
	public int getAutorizacion() {
		return autorizacion;
	}
	public void setAutorizacion(int autorizacion) {
		this.autorizacion = autorizacion;
	}
	public Double getImPresupuestoMinimo() {
		return imPresupuestoMinimo;
	}
	public void setImPresupuestoMinimo(Double imPresupuestoMinimo) {
		this.imPresupuestoMinimo = imPresupuestoMinimo;
	}
	public Double getImPresupuestoMaximo() {
		return imPresupuestoMaximo;
	}
	public void setImPresupuestoMaximo(Double imPresupuestoMaximo) {
		this.imPresupuestoMaximo = imPresupuestoMaximo;
	}
	public int getIdCliente() {
		return idCliente;
	}
	public void setIdCliente(int idCliente) {
		this.idCliente = idCliente;
	}
	public int getIdEstado() {
		return idEstado;
	}
	public void setIdEstado(int idEstado) {
		this.idEstado = idEstado;
	}
	public int getIdMoneda() {
		return idMoneda;
	}
	public void setIdMoneda(int idMoneda) {
		this.idMoneda = idMoneda;
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
}
