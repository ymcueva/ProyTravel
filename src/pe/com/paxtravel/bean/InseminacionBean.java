package pe.com.paxtravel.bean;

import java.util.Date;

public class InseminacionBean {

	private int numeroFila;

	private String codigoInseminacion;
	
	private String fechaInseminacion;
	
	private String tipoInseminacion;

	private String codigoVaca;
	
	private String codigoToro;
	
	private String nombreVaca;
	
	private String nombreToro;
	
	private String observacion;

	private String estadoInseminacion;
	
	private int diasInseminado;

	private String usuario;

	private String tipoBusqueda;

	public int getNumeroFila() {
		return numeroFila;
	}

	public void setNumeroFila(int numeroFila) {
		this.numeroFila = numeroFila;
	}

	public String getCodigoInseminacion() {
		return codigoInseminacion;
	}

	public void setCodigoInseminacion(String codigoInseminacion) {
		this.codigoInseminacion = codigoInseminacion;
	}
	
	public String getFechaInseminacion() {
		return fechaInseminacion;
	}

	public void setFechaInseminacion(String fechaInseminacion) {
		this.fechaInseminacion = fechaInseminacion;
	}

	public String getTipoInseminacion() {
		return tipoInseminacion;
	}

	public void setTipoInseminacion(String tipoInseminacion) {
		this.tipoInseminacion = tipoInseminacion;
	}
	
	public String getCodigoVaca() {
		return codigoVaca;
	}

	public void setCodigoVaca(String codigoVaca) {
		this.codigoVaca = codigoVaca;
	}

	public String getCodigoToro() {
		return codigoToro;
	}

	public void setCodigoToro(String codigoToro) {
		this.codigoToro = codigoToro;
	}

	public String getNombreVaca() {
		return nombreVaca;
	}

	public void setNombreVaca(String nombreVaca) {
		this.nombreVaca = nombreVaca;
	}

	public String getNombreToro() {
		return nombreToro;
	}

	public void setNombreToro(String nombreToro) {
		this.nombreToro = nombreToro;
	}

	public String getObservacion() {
		return observacion;
	}

	public void setObservacion(String observacion) {
		this.observacion = observacion;
	}

	public String getEstadoInseminacion() {
		return estadoInseminacion;
	}

	public void setEstadoInseminacion(String estadoInseminacion) {
		this.estadoInseminacion = estadoInseminacion;
	}

	public int getDiasInseminado() {
		return diasInseminado;
	}

	public void setDiasInseminado(int diasInseminado) {
		this.diasInseminado = diasInseminado;
	}

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public String getTipoBusqueda() {
		return tipoBusqueda;
	}

	public void setTipoBusqueda(String tipoBusqueda) {
		this.tipoBusqueda = tipoBusqueda;
	}

}
