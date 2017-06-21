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

	private String nombreCliente;
	private int idMotivo;
	private String nomMotivo;
	private int idDetalle;
	private String nomDestino;
	private String nomOrigen;
	private String idaVuelta;
	private int nuDias;
	private int idServicio;
	private String nomServicio;
	private String fePartida;
	private String feRetorno;
	private int nuAdultos;
	private int nuNinos;
	private int idOrigen;
	private int idDestino;
	private int idTipoPrograma;
	private int idPaquete;
	private String fePartidaDestino;
	private int idHotel;
	private double totalHotel;
	private int idTipoAlojamiento;
	private int idCategoriaAlojamiento;
	private String nomHotel;
	private String nomTipoAlojamiento;
	private String nomCatAlojamiento;
	private String habitaciones;
	private int idProveedorHotel;
	
	private int idTour;
	private String nomStat;
	private String nomTour;
	private double preAdultoTour;
	private double preNinoTour;
	private int diasTour;
	private double subtotalTour;
	private int idAerolinea;
	private int idProveedorAerolinea;
	private double precioAerolinea;
	private String nombreAerolinea;
	private int comision;
	private String urlAerolinea;
	
	private String isoOrigen;
	private String isoDestino;
	private int tiIda;
	private int nuPersonastour;
	private String nuCotizacion;
	
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
	
	public String getNombreCliente(){
		return nombreCliente;
	}
	
	public int getIdMotivo() {
		return idMotivo;
	}
	
	public String getNomMotivo() {
		return nomMotivo;
	}
	
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	
	public void setIdMotivo(int idMotivo) {
		this.idMotivo = idMotivo;
	}
	
	public void setNomMotivo(String nomMotivo) {
		this.nomMotivo = nomMotivo;
	}
	public int getIdDetalle() {
		return idDetalle;
	}
	public void setIdDetalle(int idDetalle) {
		this.idDetalle = idDetalle;
	}
	public int getNuDias() {
		return nuDias;
	}
	public void setNuDias(int nuDias) {
		this.nuDias = nuDias;
	}
	public String getNomDestino() {
		return nomDestino;
	}
	public void setNomDestino(String nomDestino) {
		this.nomDestino = nomDestino;
	}
	public int getIdServicio() {
		return idServicio;
	}
	public void setIdServicio(int idServicio) {
		this.idServicio = idServicio;
	}
	public String getNomServicio() {
		return nomServicio;
	}
	public void setNomServicio(String nomServicio) {
		this.nomServicio = nomServicio;
	}
	public String getFePartida() {
		return fePartida;
	}
	public void setFePartida(String fePartida) {
		this.fePartida = fePartida;
	}
	public String getFeRetorno() {
		return feRetorno;
	}
	public void setFeRetorno(String feRetorno) {
		this.feRetorno = feRetorno;
	}

	public String getNomOrigen() {
		return nomOrigen;
	}
	public void setNomOrigen(String nomOrigen) {
		this.nomOrigen = nomOrigen;
	}
	public String getIdaVuelta() {
		return idaVuelta;
	}
	public void setIdaVuelta(String idaVuelta) {
		this.idaVuelta = idaVuelta;
	}
	public int getIdOrigen() {
		return idOrigen;
	}
	public void setIdOrigen(int idOrigen) {
		this.idOrigen = idOrigen;
	}
	public int getIdDestino() {
		return idDestino;
	}
	public void setIdDestino(int idDestino) {
		this.idDestino = idDestino;
	}
	public int getIdTipoPrograma() {
		return idTipoPrograma;
	}
	public void setIdTipoPrograma(int idTipoPrograma) {
		this.idTipoPrograma = idTipoPrograma;
	}
	public int getIdPaquete() {
		return idPaquete;
	}
	public void setIdPaquete(int idPaquete) {
		this.idPaquete = idPaquete;
	}
	public String getFePartidaDestino() {
		return fePartidaDestino;
	}
	public void setFePartidaDestino(String fePartidaDestino) {
		this.fePartidaDestino = fePartidaDestino;
	}
	public int getIdHotel() {
		return idHotel;
	}
	public void setIdHotel(int idHotel) {
		this.idHotel = idHotel;
	}
	public double getTotalHotel() {
		return totalHotel;
	}
	public void setTotalHotel(double totalHotel) {
		this.totalHotel = totalHotel;
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
	public String getNomHotel() {
		return nomHotel;
	}
	public void setNomHotel(String nomHotel) {
		this.nomHotel = nomHotel;
	}
	public String getNomTipoAlojamiento() {
		return nomTipoAlojamiento;
	}
	public void setNomTipoAlojamiento(String nomTipoAlojamiento) {
		this.nomTipoAlojamiento = nomTipoAlojamiento;
	}
	public String getNomCatAlojamiento() {
		return nomCatAlojamiento;
	}
	public void setNomCatAlojamiento(String nomCatAlojamiento) {
		this.nomCatAlojamiento = nomCatAlojamiento;
	}
	public String getHabitaciones() {
		return habitaciones;
	}
	public void setHabitaciones(String habitaciones) {
		this.habitaciones = habitaciones;
	}
	public int getIdTour() {
		return idTour;
	}
	public void setIdTour(int idTour) {
		this.idTour = idTour;
	}
	public String getNomTour() {
		return nomTour;
	}
	public void setNomTour(String nomTour) {
		this.nomTour = nomTour;
	}
	public double getPreAdultoTour() {
		return preAdultoTour;
	}
	public void setPreAdultoTour(double preAdultoTour) {
		this.preAdultoTour = preAdultoTour;
	}
	public double getPreNinoTour() {
		return preNinoTour;
	}
	public void setPreNinoTour(double preNinoTour) {
		this.preNinoTour = preNinoTour;
	}
	public int getDiasTour() {
		return diasTour;
	}
	public void setDiasTour(int diasTour) {
		this.diasTour = diasTour;
	}
	public double getSubtotalTour() {
		return subtotalTour;
	}
	public void setSubtotalTour(double subtotalTour) {
		this.subtotalTour = subtotalTour;
	}
	public int getIdAerolinea() {
		return idAerolinea;
	}
	public void setIdAerolinea(int idAerolinea) {
		this.idAerolinea = idAerolinea;
	}
	public int getIdProveedorAerolinea() {
		return idProveedorAerolinea;
	}
	public void setIdProveedorAerolinea(int idProveedorAerolinea) {
		this.idProveedorAerolinea = idProveedorAerolinea;
	}
	public double getPrecioAerolinea() {
		return precioAerolinea;
	}
	public void setPrecioAerolinea(double precioAerolinea) {
		this.precioAerolinea = precioAerolinea;
	}
	public String getNombreAerolinea() {
		return nombreAerolinea;
	}
	public void setNombreAerolinea(String nombreAerolinea) {
		this.nombreAerolinea = nombreAerolinea;
	}
	public int getComision() {
		return comision;
	}
	public void setComision(int comision) {
		this.comision = comision;
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
	public int getTiIda() {
		return tiIda;
	}
	public void setTiIda(int tiIda) {
		this.tiIda = tiIda;
	}
	public int getNuPersonastour() {
		return nuPersonastour;
	}
	public void setNuPersonastour(int nuPersonastour) {
		this.nuPersonastour = nuPersonastour;
	}
	public String getUrlAerolinea() {
		return urlAerolinea;
	}
	public void setUrlAerolinea(String urlAerolinea) {
		this.urlAerolinea = urlAerolinea;
	}
	public String getNuCotizacion() {
		return nuCotizacion;
	}
	public void setNuCotizacion(String nuCotizacion) {
		this.nuCotizacion = nuCotizacion;
	}
	public int getIdProveedorHotel() {
		return idProveedorHotel;
	}
	public void setIdProveedorHotel(int idProveedorHotel) {
		this.idProveedorHotel = idProveedorHotel;
	}
	public String getNomStat() {
		return nomStat;
	}
	public void setNomStat(String nomStat) {
		this.nomStat = nomStat;
	}

}
