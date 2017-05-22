package pe.com.paxtravel.bean;

public class CotizacionBean {

	private int numeroFila;
	private int idCotizacion;
	
	private String numeroCotizacion;
	private String fechaCotizacion;
	private String nombreCliente;
	private String documentoCliente;
	private String nombreEstadoCotizacion;
	private String codigoEstadoCotizacion;
	private String descripcion;
	private int tiempoMinimo;
	private int tiempoMaximo;
	private String fechaSalida;
	private String fechaRetorno;
	private String seguroViaje;
	
	private String boletoAvion;
	
	private String idOrigen;
	private String idDestino;
	
	private String[] motivoViaje;
	private String tipoAlojamiento;
	private String categoriaAlojamiento;
	private int cantidadAdultos;
	private int cantidadNinos;
	private Double presupuestoMinimo;
	private Double presupuestoMaximo;

	private String observacion;
	
	private int idCliente;
	private int idTipoCotizacion;
	private int idOrigenPartida;
	private int idTipoPrograma;
	
	public int getIdTipoPrograma() {
		return idTipoPrograma;
	}
	
	public void setIdTipoPrograma(int idTipoPrograma) {
		this.idTipoPrograma = idTipoPrograma;
	}
	
	public int getIdOrigenPartida() {
		return idOrigenPartida;
	}
	
	public void setIdOrigenPartida(int idOrigenPartida) {
		this.idOrigenPartida = idOrigenPartida;
	}
	
	
	public int getIdTipoCotizacion() {
		return idTipoCotizacion;
	}
	
	public void setIdTipoCotizacion(int idTipoCotizacion) {
		this.idTipoCotizacion = idTipoCotizacion;
	}

	public int getNumeroFila() {
		return numeroFila;
	}

	public void setNumeroFila(int numeroFila) {
		this.numeroFila = numeroFila;
	}

	public int getIdCotizacion() {
		return idCotizacion;
	}

	public void setIdCotizacion(int idCotizacion) {
		this.idCotizacion = idCotizacion;
	}

	public String getNumeroCotizacion() {
		return numeroCotizacion;
	}

	public void setNumeroCotizacion(String numeroCotizacion) {
		this.numeroCotizacion = numeroCotizacion;
	}

	public String getFechaCotizacion() {
		return fechaCotizacion;
	}

	public void setFechaCotizacion(String fechaCotizacion) {
		this.fechaCotizacion = fechaCotizacion;
	}

	public String getNombreCliente() {
		return nombreCliente;
	}

	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}

	public String getDocumentoCliente() {
		return documentoCliente;
	}

	public void setDocumentoCliente(String documentoCliente) {
		this.documentoCliente = documentoCliente;
	}

	public String getNombreEstadoCotizacion() {
		return nombreEstadoCotizacion;
	}

	public void setNombreEstadoCotizacion(String nombreEstadoCotizacion) {
		this.nombreEstadoCotizacion = nombreEstadoCotizacion;
	}

	public String getCodigoEstadoCotizacion() {
		return codigoEstadoCotizacion;
	}

	public void setCodigoEstadoCotizacion(String codigoEstadoCotizacion) {
		this.codigoEstadoCotizacion = codigoEstadoCotizacion;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public int getTiempoMinimo() {
		return tiempoMinimo;
	}

	public void setTiempoMinimo(int tiempoMinimo) {
		this.tiempoMinimo = tiempoMinimo;
	}

	public int getTiempoMaximo() {
		return tiempoMaximo;
	}

	public void setTiempoMaximo(int tiempoMaximo) {
		this.tiempoMaximo = tiempoMaximo;
	}

	public String getFechaSalida() {
		return fechaSalida;
	}

	public void setFechaSalida(String fechaSalida) {
		this.fechaSalida = fechaSalida;
	}

	public String getFechaRetorno() {
		return fechaRetorno;
	}

	public void setFechaRetorno(String fechaRetorno) {
		this.fechaRetorno = fechaRetorno;
	}

	public String getSeguroViaje() {
		return seguroViaje;
	}

	public void setSeguroViaje(String seguroViaje) {
		this.seguroViaje = seguroViaje;
	}

	public String getBoletoAvion() {
		return boletoAvion;
	}

	public void setBoletoAvion(String boletoAvion) {
		this.boletoAvion = boletoAvion;
	}

	public String getIdOrigen() {
		return idOrigen;
	}

	public void setIdOrigen(String idOrigen) {
		this.idOrigen = idOrigen;
	}

	public String getIdDestino() {
		return idDestino;
	}

	public void setIdDestino(String idDestino) {
		this.idDestino = idDestino;
	}

	public String[] getMotivoViaje() {
		return motivoViaje;
	}

	public void setMotivoViaje(String[] motivoViaje) {
		this.motivoViaje = motivoViaje;
	}

	public String getTipoAlojamiento() {
		return tipoAlojamiento;
	}

	public void setTipoAlojamiento(String tipoAlojamiento) {
		this.tipoAlojamiento = tipoAlojamiento;
	}

	public String getCategoriaAlojamiento() {
		return categoriaAlojamiento;
	}

	public void setCategoriaAlojamiento(String categoriaAlojamiento) {
		this.categoriaAlojamiento = categoriaAlojamiento;
	}

	public int getCantidadAdultos() {
		return cantidadAdultos;
	}

	public void setCantidadAdultos(int cantidadAdultos) {
		this.cantidadAdultos = cantidadAdultos;
	}

	public int getCantidadNinos() {
		return cantidadNinos;
	}

	public void setCantidadNinos(int cantidadNinos) {
		this.cantidadNinos = cantidadNinos;
	}

	public Double getPresupuestoMinimo() {
		return presupuestoMinimo;
	}

	public void setPresupuestoMinimo(Double presupuestoMinimo) {
		this.presupuestoMinimo = presupuestoMinimo;
	}

	public Double getPresupuestoMaximo() {
		return presupuestoMaximo;
	}

	public void setPresupuestoMaximo(Double presupuestoMaximo) {
		this.presupuestoMaximo = presupuestoMaximo;
	}

	public String getObservacion() {
		return observacion;
	}

	public void setObservacion(String observacion) {
		this.observacion = observacion;
	}

	public int getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(int idCliente) {
		this.idCliente = idCliente;
	}


}
