 package pe.com.paxtravel.service;

import java.util.List;

import pe.com.paxtravel.bean.HotelBean;
import pe.com.paxtravel.bean.HotelHabitacionBean;
import pe.com.paxtravel.bean.PaqueteTuristicoBean;
import pe.com.paxtravel.bean.PaqueteTuristicoDestinoBean;
import pe.com.paxtravel.bean.PaqueteTuristicoDestinoHotelBean;
import pe.com.paxtravel.bean.PaqueteTuristicoDestinoTourBean;
import pe.com.paxtravel.bean.PaqueteTuristicoTicketBean;
import pe.com.paxtravel.bean.TourBean;

public interface PaqueteTuristicoService {

	
	public List<PaqueteTuristicoBean> listarPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	
    public int GrabarPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	
	public String obtenerCodigoPaqTuristico();
	
	List<TourBean> listarTour(TourBean tourBean);
	
	List<HotelBean> listarHotel(HotelBean hotelBean);
	
	List<HotelBean> listarHotelCotizacion(HotelBean hotelBean);
	
	List<HotelHabitacionBean> listarTipoHabitacion(HotelHabitacionBean hotelHabitacionBean);
	
	List<HotelHabitacionBean> obtenerTipoHabitacion(HotelHabitacionBean hotelHabitacionBean);
	
	int RegistrarPaqueteTuristicoDestino(PaqueteTuristicoDestinoBean paqueteTuristicoDestinoBean);
	
	int RegistrarPaqueteTuristicoDestinoTour(PaqueteTuristicoDestinoTourBean paqueteTuristicoDestinoTourBean);
	
	int RegistrarPaqueteTuristicoTicket(PaqueteTuristicoTicketBean paqueteTuristicoTicketBean);
	
	int RegistrarPaqueteTuristicoDestinoHotel(PaqueteTuristicoDestinoHotelBean paqueteTuristicoDestinoHotelBean);
	
	List<PaqueteTuristicoBean> obtenerPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	
	List<PaqueteTuristicoDestinoHotelBean> obtenerDetalleHotelPaquete(PaqueteTuristicoDestinoHotelBean paqueteTuristicoDestinoHotelBean);
	
	void eliminaDetallePaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	
	int actualizaPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	
	List<HotelHabitacionBean> obtenerHotelBusqueda(HotelHabitacionBean hotelHabitacionBean);
	
	List<HotelHabitacionBean> obtenerHotelBusquedaOrden(HotelHabitacionBean hotelHabitacionBean);
	
	
	List<HotelHabitacionBean> listarDetalleHotelBusqueda(HotelHabitacionBean hotelHabitacionBean);
	
	List<HotelHabitacionBean> listarDetalleHotelBusquedaOrden(HotelHabitacionBean hotelHabitacionBean);
	
	
	List<TourBean> listaTourBusqueda(TourBean tourBean);
	
	int actualizarEstadoPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	
	
}
