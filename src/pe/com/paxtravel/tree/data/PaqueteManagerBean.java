package pe.com.paxtravel.tree.data;

import java.util.ArrayList;
import java.util.List;

import pe.com.paxtravel.bean.CotizacionDetalleBean;

public class PaqueteManagerBean {
	
	private int idPaquete; 
	private String nomPaquete; 
	private String comentario; 
	private double imPrecio;
	private double imPrecioMax;
	private double imPrecioMin;	
	private int idEstado;
	private int idTipoPaquete;
	private int idDestinoCiudad;
	private String nomCiudad;
	private int nuDias;	
	private String tiPresupuestoValue;	
	private List<CotizacionDetalleBean> list;
	
	private String nomAerolinea;
	private String codeAerolinea;
	private String nomProveedor;
	private String nomHotel;
	private String nomCategoriaAlojamiento;
	private String nomTipoAlojamiento;
	private String desAlojamiento;
	
	private int idHotelHabitacion;
	private int idCategoriaAlojamiento;
	private int idTipoAlojamiento;  
	private int idHotel;
	private int idPaqueteDestino;
	private int idPaqueteDestinoHotel;
	private int idPaqueteTicket;
	private int idProveedor;
	private int idPaqueteDestinoTour;
	private int idTour;
	private String desTour;
	private double imPrecioAdulto;
	private double imPrecioNino;
	
	private String tiDestinos;
	private String tiTours;
	private String tiHotel;
	private String tiTicket;
	
	private int nuDestinos;
	
	private int perServicio;
	
	
	
	
	public int getPerServicio() {
		return perServicio;
	}

	public void setPerServicio(int perServicio) {
		this.perServicio = perServicio;
	}

	public int getNuDestinos() {
		return nuDestinos;
	}

	public void setNuDestinos(int nuDestinos) {
		this.nuDestinos = nuDestinos;
	}

	public String getTiDestinos() {
		return tiDestinos;
	}

	public void setTiDestinos(String tiDestinos) {
		this.tiDestinos = tiDestinos;
	}

	public String getTiTours() {
		return tiTours;
	}

	public void setTiTours(String tiTours) {
		this.tiTours = tiTours;
	}

	public String getTiHotel() {
		return tiHotel;
	}

	public void setTiHotel(String tiHotel) {
		this.tiHotel = tiHotel;
	}

	public String getTiTicket() {
		return tiTicket;
	}

	public void setTiTicket(String tiTicket) {
		this.tiTicket = tiTicket;
	}

	public String getNomAerolinea() {
		return nomAerolinea;
	}

	public void setNomAerolinea(String nomAerolinea) {
		this.nomAerolinea = nomAerolinea;
	}

	public String getCodeAerolinea() {
		return codeAerolinea;
	}

	public void setCodeAerolinea(String codeAerolinea) {
		this.codeAerolinea = codeAerolinea;
	}

	public String getNomProveedor() {
		return nomProveedor;
	}

	public void setNomProveedor(String nomProveedor) {
		this.nomProveedor = nomProveedor;
	}

	public String getNomHotel() {
		return nomHotel;
	}

	public void setNomHotel(String nomHotel) {
		this.nomHotel = nomHotel;
	}

	public String getNomCategoriaAlojamiento() {
		return nomCategoriaAlojamiento;
	}

	public void setNomCategoriaAlojamiento(String nomCategoriaAlojamiento) {
		this.nomCategoriaAlojamiento = nomCategoriaAlojamiento;
	}

	public String getNomTipoAlojamiento() {
		return nomTipoAlojamiento;
	}

	public void setNomTipoAlojamiento(String nomTipoAlojamiento) {
		this.nomTipoAlojamiento = nomTipoAlojamiento;
	}

	public String getDesAlojamiento() {
		return desAlojamiento;
	}

	public void setDesAlojamiento(String desAlojamiento) {
		this.desAlojamiento = desAlojamiento;
	}

	public int getIdHotelHabitacion() {
		return idHotelHabitacion;
	}

	public void setIdHotelHabitacion(int idHotelHabitacion) {
		this.idHotelHabitacion = idHotelHabitacion;
	}

	public int getIdCategoriaAlojamiento() {
		return idCategoriaAlojamiento;
	}

	public void setIdCategoriaAlojamiento(int idCategoriaAlojamiento) {
		this.idCategoriaAlojamiento = idCategoriaAlojamiento;
	}

	public int getIdTipoAlojamiento() {
		return idTipoAlojamiento;
	}

	public void setIdTipoAlojamiento(int idTipoAlojamiento) {
		this.idTipoAlojamiento = idTipoAlojamiento;
	}

	public int getIdHotel() {
		return idHotel;
	}

	public void setIdHotel(int idHotel) {
		this.idHotel = idHotel;
	}

	public int getIdPaqueteDestino() {
		return idPaqueteDestino;
	}

	public void setIdPaqueteDestino(int idPaqueteDestino) {
		this.idPaqueteDestino = idPaqueteDestino;
	}

	public int getIdPaqueteDestinoHotel() {
		return idPaqueteDestinoHotel;
	}

	public void setIdPaqueteDestinoHotel(int idPaqueteDestinoHotel) {
		this.idPaqueteDestinoHotel = idPaqueteDestinoHotel;
	}

	public int getIdPaqueteTicket() {
		return idPaqueteTicket;
	}

	public void setIdPaqueteTicket(int idPaqueteTicket) {
		this.idPaqueteTicket = idPaqueteTicket;
	}

	public int getIdProveedor() {
		return idProveedor;
	}

	public void setIdProveedor(int idProveedor) {
		this.idProveedor = idProveedor;
	}

	public int getIdPaqueteDestinoTour() {
		return idPaqueteDestinoTour;
	}

	public void setIdPaqueteDestinoTour(int idPaqueteDestinoTour) {
		this.idPaqueteDestinoTour = idPaqueteDestinoTour;
	}

	public int getIdTour() {
		return idTour;
	}

	public void setIdTour(int idTour) {
		this.idTour = idTour;
	}

	public String getDesTour() {
		return desTour;
	}

	public void setDesTour(String desTour) {
		this.desTour = desTour;
	}

	public double getImPrecioAdulto() {
		return imPrecioAdulto;
	}

	public void setImPrecioAdulto(double imPrecioAdulto) {
		this.imPrecioAdulto = imPrecioAdulto;
	}

	public double getImPrecioNino() {
		return imPrecioNino;
	}

	public void setImPrecioNino(double imPrecioNino) {
		this.imPrecioNino = imPrecioNino;
	}

	public List<CotizacionDetalleBean> getList() {
		return list;
	}

	public void setList(List<CotizacionDetalleBean> list) {
		this.list = list;
	}

	public String getTiPresupuestoValue() {
		return tiPresupuestoValue;
	}

	public void setTiPresupuestoValue(String tiPresupuestoValue) {
		this.tiPresupuestoValue = tiPresupuestoValue;
	}

	public double getImPrecioMax() {
		return imPrecioMax;
	}

	public void setImPrecioMax(double imPrecioMax) {
		this.imPrecioMax = imPrecioMax;
	}

	public double getImPrecioMin() {
		return imPrecioMin;
	}

	public void setImPrecioMin(double imPrecioMin) {
		this.imPrecioMin = imPrecioMin;
	}

	public double getImPrecioMaxAlto() {
		return getImPrecio();
	}
	
	public double getImPrecioMinAlto() {
		return getImPrecioMaxMedio()+1;
	}
			
	public double getImPrecioMaxMedio() {
		return Math.ceil(getImPrecio() * 0.5 + getImPrecioMaxBajo()/2 - 1);
	}	
	
	public double getImPrecioMinMedio() {
		return getImPrecioMaxBajo()+1;
	}	
	
	public double getImPrecioMaxBajo() {
		return Math.ceil(getImPrecio()/2);
	}		
	
	public double getImPrecioMinBajo() {
		return 1;
	}	
	public int getIdPaquete() {
		return idPaquete;
	}
	public void setIdPaquete(int idPaquete) {
		this.idPaquete = idPaquete;
	}
	public String getNomPaquete() {
		return nomPaquete;
	}
	public void setNomPaquete(String nomPaquete) {
		this.nomPaquete = nomPaquete;
	}
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
	public double getImPrecio() {
		return imPrecio;
	}
	public void setImPrecio(double imPrecio) {
		this.imPrecio = imPrecio;
	}
	public int getIdEstado() {
		return idEstado;
	}
	public void setIdEstado(int idEstado) {
		this.idEstado = idEstado;
	}
	public int getIdTipoPaquete() {
		return idTipoPaquete;
	}
	public void setIdTipoPaquete(int idTipoPaquete) {
		this.idTipoPaquete = idTipoPaquete;
	}
	public int getIdDestinoCiudad() {
		return idDestinoCiudad;
	}
	public void setIdDestinoCiudad(int idDestinoCiudad) {
		this.idDestinoCiudad = idDestinoCiudad;
	}
	public String getNomCiudad() {
		return nomCiudad;
	}
	public void setNomCiudad(String nomCiudad) {
		this.nomCiudad = nomCiudad;
	}
	public int getNuDias() {
		return nuDias;
	}
	public void setNuDias(int nuDias) {
		this.nuDias = nuDias;
	}
		
}