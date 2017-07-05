package pe.com.paxtravel.bean;

public class ReservaBean {
	
	private int numeroFila;
	private int idReserva;
	private String numeroReserva;
	
	private String fechaReserva;
	private String fechaInicio;
	private String fechaFin;
	private String idEstadoReserva;
	private String nombreEstadoReserva;
	private String comentarioReserva;
	
	public String getComentarioReserva() {
		return comentarioReserva;
	}
	public void setComentarioReserva(String comentarioReserva) {
		this.comentarioReserva = comentarioReserva;
	}
	public String getNombreEstadoReserva() {
		return nombreEstadoReserva;
	}
	public void setNombreEstadoReserva(String nombreEstadoReserva) {
		this.nombreEstadoReserva = nombreEstadoReserva;
	}
	private int tipoBusqueda;
	
	private String fechaRegistro;
	
	public String getFechaRegistro() {
		return fechaRegistro;
	}
	public void setFechaRegistro(String fechaRegistro) {
		this.fechaRegistro = fechaRegistro;
	}
	private int idUsuario;
	
	public int getIdUsuario() {
		return idUsuario;
	}
	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}
	//datos cliente
	private String cliente;
	private String direccion;
	private String telefonoCliente;
	private String tipoDocumento;
	private String numeroDocumento;
	
	//datos cotizacion
	private String fechaCotizacion;
	private String nombreTipoCotizacion;
	private String estadoCotizacion;
	private String nombreEstadoCotizacion;
	
	public String getNombreEstadoCotizacion() {
		return nombreEstadoCotizacion;
	}
	public void setNombreEstadoCotizacion(String nombreEstadoCotizacion) {
		this.nombreEstadoCotizacion = nombreEstadoCotizacion;
	}
	private String numeroAdultos;
	private String numeroNinos;
	private String numeroCotizacion;
	private String precioCotizacion;
	private int idCotizacion;
	private int idCliente;
	private int idTipoCotizacion;
	
	// datos de ticket aereo
	private int idCotizaDeta;
	private String ciudadOrigen;
	private String ciudadDestino;
	private String isoOrigen;
	private String isoDestino;
	private String idOrigen;
	private String idDestino;
	private String tiIda;
	private String tipoVuelo;
	private String fechaPartida;
	private String fechaRetorno;
	private String idEstadoCotizacion;
	
	
	
	public String getIdEstadoCotizacion() {
		return idEstadoCotizacion;
	}
	public void setIdEstadoCotizacion(String idEstadoCotizacion) {
		this.idEstadoCotizacion = idEstadoCotizacion;
	}
	//datos de paquete turistico
	private String idPaqueteTuristico;
	private String nombrePaqueteTuristico;
	private String precioPaquete;
	private String precioPaqueteCotiza;
	private String ciudadDestinoPaquete;
	private String servicioTour;
	private String servicioHotel;
	private String servicioAerolinea;
	
	//datos del pasajero
	private String numeroDocumentoPasajero;
	private String nombresPasajero;
	private String apellidosPasajero;
	
	
	public String getNombresPasajero() {
		return nombresPasajero;
	}
	public void setNombresPasajero(String nombresPasajero) {
		this.nombresPasajero = nombresPasajero;
	}
	public String getApellidosPasajero() {
		return apellidosPasajero;
	}
	public void setApellidosPasajero(String apellidosPasajero) {
		this.apellidosPasajero = apellidosPasajero;
	}
	public String getNumeroDocumentoPasajero() {
		return numeroDocumentoPasajero;
	}
	public void setNumeroDocumentoPasajero(String numeroDocumentoPasajero) {
		this.numeroDocumentoPasajero = numeroDocumentoPasajero;
	}
	public String getIdPaqueteTuristico() {
		return idPaqueteTuristico;
	}
	public void setIdPaqueteTuristico(String idPaqueteTuristico) {
		this.idPaqueteTuristico = idPaqueteTuristico;
	}
	public String getNombrePaqueteTuristico() {
		return nombrePaqueteTuristico;
	}
	public void setNombrePaqueteTuristico(String nombrePaqueteTuristico) {
		this.nombrePaqueteTuristico = nombrePaqueteTuristico;
	}
	public String getPrecioPaquete() {
		return precioPaquete;
	}
	public void setPrecioPaquete(String precioPaquete) {
		this.precioPaquete = precioPaquete;
	}
	public String getPrecioPaqueteCotiza() {
		return precioPaqueteCotiza;
	}
	public void setPrecioPaqueteCotiza(String precioPaqueteCotiza) {
		this.precioPaqueteCotiza = precioPaqueteCotiza;
	}
	public String getCiudadDestinoPaquete() {
		return ciudadDestinoPaquete;
	}
	public void setCiudadDestinoPaquete(String ciudadDestinoPaquete) {
		this.ciudadDestinoPaquete = ciudadDestinoPaquete;
	}
	public String getServicioTour() {
		return servicioTour;
	}
	public void setServicioTour(String servicioTour) {
		this.servicioTour = servicioTour;
	}
	public String getServicioHotel() {
		return servicioHotel;
	}
	public void setServicioHotel(String servicioHotel) {
		this.servicioHotel = servicioHotel;
	}
	public String getServicioAerolinea() {
		return servicioAerolinea;
	}
	public void setServicioAerolinea(String servicioAerolinea) {
		this.servicioAerolinea = servicioAerolinea;
	}
	public int getNumeroFila() {
		return numeroFila;
	}
	public void setNumeroFila(int numeroFila) {
		this.numeroFila = numeroFila;
	}
	public int getIdReserva() {
		return idReserva;
	}
	public void setIdReserva(int idReserva) {
		this.idReserva = idReserva;
	}
	public String getNumeroReserva() {
		return numeroReserva;
	}
	public void setNumeroReserva(String numeroReserva) {
		this.numeroReserva = numeroReserva;
	}
	public String getFechaReserva() {
		return fechaReserva;
	}
	public void setFechaReserva(String fechaReserva) {
		this.fechaReserva = fechaReserva;
	}
	public String getFechaInicio() {
		return fechaInicio;
	}
	public void setFechaInicio(String fechaInicio) {
		this.fechaInicio = fechaInicio;
	}
	public String getFechaFin() {
		return fechaFin;
	}
	public void setFechaFin(String fechaFin) {
		this.fechaFin = fechaFin;
	}
	
	
	public String getIdEstadoReserva() {
		return idEstadoReserva;
	}
	public void setIdEstadoReserva(String idEstadoReserva) {
		this.idEstadoReserva = idEstadoReserva;
	}
	public int getTipoBusqueda() {
		return tipoBusqueda;
	}
	public void setTipoBusqueda(int tipoBusqueda) {
		this.tipoBusqueda = tipoBusqueda;
	}
	public String getCliente() {
		return cliente;
	}
	public void setCliente(String cliente) {
		this.cliente = cliente;
	}
	public String getDireccion() {
		return direccion;
	}
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	public String getTelefonoCliente() {
		return telefonoCliente;
	}
	public void setTelefonoCliente(String telefonoCliente) {
		this.telefonoCliente = telefonoCliente;
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
	public String getFechaCotizacion() {
		return fechaCotizacion;
	}
	public void setFechaCotizacion(String fechaCotizacion) {
		this.fechaCotizacion = fechaCotizacion;
	}
	public String getNombreTipoCotizacion() {
		return nombreTipoCotizacion;
	}
	public void setNombreTipoCotizacion(String nombreTipoCotizacion) {
		this.nombreTipoCotizacion = nombreTipoCotizacion;
	}
	public String getEstadoCotizacion() {
		return estadoCotizacion;
	}
	public void setEstadoCotizacion(String estadoCotizacion) {
		this.estadoCotizacion = estadoCotizacion;
	}
	public String getNumeroAdultos() {
		return numeroAdultos;
	}
	public void setNumeroAdultos(String numeroAdultos) {
		this.numeroAdultos = numeroAdultos;
	}
	public String getNumeroNinos() {
		return numeroNinos;
	}
	public void setNumeroNinos(String numeroNinos) {
		this.numeroNinos = numeroNinos;
	}
	public String getNumeroCotizacion() {
		return numeroCotizacion;
	}
	public void setNumeroCotizacion(String numeroCotizacion) {
		this.numeroCotizacion = numeroCotizacion;
	}
	public String getPrecioCotizacion() {
		return precioCotizacion;
	}
	public void setPrecioCotizacion(String precioCotizacion) {
		this.precioCotizacion = precioCotizacion;
	}
	public int getIdCotizacion() {
		return idCotizacion;
	}
	public void setIdCotizacion(int idCotizacion) {
		this.idCotizacion = idCotizacion;
	}
	public int getIdCliente() {
		return idCliente;
	}
	public void setIdCliente(int idCliente) {
		this.idCliente = idCliente;
	}
	public int getIdTipoCotizacion() {
		return idTipoCotizacion;
	}
	public void setIdTipoCotizacion(int idTipoCotizacion) {
		this.idTipoCotizacion = idTipoCotizacion;
	}
	public int getIdCotizaDeta() {
		return idCotizaDeta;
	}
	public void setIdCotizaDeta(int idCotizaDeta) {
		this.idCotizaDeta = idCotizaDeta;
	}
	public String getCiudadOrigen() {
		return ciudadOrigen;
	}
	public void setCiudadOrigen(String ciudadOrigen) {
		this.ciudadOrigen = ciudadOrigen;
	}
	public String getCiudadDestino() {
		return ciudadDestino;
	}
	public void setCiudadDestino(String ciudadDestino) {
		this.ciudadDestino = ciudadDestino;
	}
	public String getIsoOrigen() {
		return isoOrigen;
	}
	public void setIsoOrigen(String isoOrigen) {
		this.isoOrigen = isoOrigen;
	}
	public String getIsoDestino() {
		return isoDestino;
	}
	public void setIsoDestino(String isoDestino) {
		this.isoDestino = isoDestino;
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
	public String getTiIda() {
		return tiIda;
	}
	public void setTiIda(String tiIda) {
		this.tiIda = tiIda;
	}
	public String getTipoVuelo() {
		return tipoVuelo;
	}
	public void setTipoVuelo(String tipoVuelo) {
		this.tipoVuelo = tipoVuelo;
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
	
	
	
}
