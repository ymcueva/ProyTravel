package pe.com.paxtravel.bean;

import java.sql.Date;

public class OrdenBean {

	private int numeroFila;
	private int idOrden;
	private String numeroOrden;
	private String fechaOrden;
	private String descripcionOrden;
	private String idEstadoOrden;
	private String descripcionEstadoOrden;
	
	private int idDestinoPais;
	private String descripcionDestinoPais;
	private int idDestinoCiudad;
	private String descripcionDestinoCiudad;
	
	private String comentarioOrden;
	private String fechaPartida;
	private String fechaRetorno;
	private Double presupuestoMaximo;
	private int idTipoPaqueteTuristico;
	private Double descripcionTipoPaqueteTuristico;
	private int autorizacion;
	
	private int flagCantidadDias;
	private int numeroDias;
	
	
	
	public int getFlagCantidadDias() {
		return flagCantidadDias;
	}
	public void setFlagCantidadDias(int flagCantidadDias) {
		this.flagCantidadDias = flagCantidadDias;
	}
	public int getNumeroDias() {
		return numeroDias;
	}
	public void setNumeroDias(int numeroDias) {
		this.numeroDias = numeroDias;
	}
	private int idMotivo;
	private int idServicio;

	public int getIdServicio() {
		return idServicio;
	}
	public void setIdServicio(int idServicio) {
		this.idServicio = idServicio;
	}
	public int getIdMotivo() {
		return idMotivo;
	}
	public void setIdMotivo(int idMotivo) {
		this.idMotivo = idMotivo;
	}
	public int getIdOrden() {
		return idOrden;
	}
	public void setIdOrden(int idOrden) {
		this.idOrden = idOrden;
	}
	
	public String getComentarioOrden() {
		return comentarioOrden;
	}
	public void setComentarioOrden(String comentarioOrden) {
		this.comentarioOrden = comentarioOrden;
	}
	public String getFechaPartida() {
		return fechaPartida;
	}
	public void setFechaPartida(String fechaPartida) {
		this.fechaPartida = fechaPartida;
	}
	public String getFechaRetorno() {
		return fechaRetorno;
	}
	public void setFechaRetorno(String fechaRetorno) {
		this.fechaRetorno = fechaRetorno;
	}
	public Double getPresupuestoMaximo() {
		return presupuestoMaximo;
	}
	public void setPresupuestoMaximo(Double presupuestoMaximo) {
		this.presupuestoMaximo = presupuestoMaximo;
	}
	public int getIdTipoPaqueteTuristico() {
		return idTipoPaqueteTuristico;
	}
	public void setIdTipoPaqueteTuristico(int idTipoPaqueteTuristico) {
		this.idTipoPaqueteTuristico = idTipoPaqueteTuristico;
	}
	public Double getDescripcionTipoPaqueteTuristico() {
		return descripcionTipoPaqueteTuristico;
	}
	public void setDescripcionTipoPaqueteTuristico(
			Double descripcionTipoPaqueteTuristico) {
		this.descripcionTipoPaqueteTuristico = descripcionTipoPaqueteTuristico;
	}
	public int getAutorizacion() {
		return autorizacion;
	}
	public void setAutorizacion(int autorizacion) {
		this.autorizacion = autorizacion;
	}
	public int getIdDestinoPais() {
		return idDestinoPais;
	}
	public void setIdDestinoPais(int idDestinoPais) {
		this.idDestinoPais = idDestinoPais;
	}
	public String getDescripcionDestinoPais() {
		return descripcionDestinoPais;
	}
	public void setDescripcionDestinoPais(String descripcionDestinoPais) {
		this.descripcionDestinoPais = descripcionDestinoPais;
	}
	public int getIdDestinoCiudad() {
		return idDestinoCiudad;
	}
	public void setIdDestinoCiudad(int idDestinoCiudad) {
		this.idDestinoCiudad = idDestinoCiudad;
	}
	public String getDescripcionDestinoCiudad() {
		return descripcionDestinoCiudad;
	}
	public void setDescripcionDestinoCiudad(String descripcionDestinoCiudad) {
		this.descripcionDestinoCiudad = descripcionDestinoCiudad;
	}
	public int getNumeroFila() {
		return numeroFila;
	}
	public void setNumeroFila(int numeroFila) {
		this.numeroFila = numeroFila;
	}
	public String getNumeroOrden() {
		return numeroOrden;
	}
	public void setNumeroOrden(String numeroOrden) {
		this.numeroOrden = numeroOrden;
	}
	public String getFechaOrden() {
		return fechaOrden;
	}
	public void setFechaOrden(String fechaOrden) {
		this.fechaOrden = fechaOrden;
	}
	public String getDescripcionOrden() {
		return descripcionOrden;
	}
	public void setDescripcionOrden(String descripcionOrden) {
		this.descripcionOrden = descripcionOrden;
	}
	public String getIdEstadoOrden() {
		return idEstadoOrden;
	}
	public void setIdEstadoOrden(String idEstadoOrden) {
		this.idEstadoOrden = idEstadoOrden;
	}
	public String getDescripcionEstadoOrden() {
		return descripcionEstadoOrden;
	}
	public void setDescripcionEstadoOrden(String descripcionEstadoOrden) {
		this.descripcionEstadoOrden = descripcionEstadoOrden;
	}
	
	
	
	
	
	
}
