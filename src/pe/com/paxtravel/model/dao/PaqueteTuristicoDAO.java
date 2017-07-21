package pe.com.paxtravel.model.dao;

import java.util.List;

import pe.com.paxtravel.bean.HotelBean;
import pe.com.paxtravel.bean.HotelHabitacionBean;
import pe.com.paxtravel.bean.OrdenDestinoBean;
import pe.com.paxtravel.bean.PaqueteTuristicoBean;
import pe.com.paxtravel.bean.PaqueteTuristicoDestinoBean;
import pe.com.paxtravel.bean.PaqueteTuristicoDestinoHotelBean;
import pe.com.paxtravel.bean.PaqueteTuristicoDestinoTourBean;
import pe.com.paxtravel.bean.PaqueteTuristicoTicketBean;
import pe.com.paxtravel.bean.TourBean;

public interface PaqueteTuristicoDAO {
	
	List<PaqueteTuristicoBean> listaPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	
	int GrabarPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	
	String obtenerCodigoPaqTuristico();
	
	List<TourBean> listaTour(TourBean tourBean);
	
	List<HotelBean> listaHotel(HotelBean hotelBean);
	
	List<HotelBean> listaHotelCotizacion(HotelBean hotelBean);
	
	List<HotelHabitacionBean> listaTipoHabitacion(HotelHabitacionBean hotelHabitacionBean);
	
	List<HotelHabitacionBean> obtenerTipoHabitacion(HotelHabitacionBean hotelHabitacionBean);
	
	int RegistrarPaqueteTuristicoDestino(PaqueteTuristicoDestinoBean paqueteTuristicoDestinoBean);
	
	int RegistrarPaqueteTuristicoDestinoTour(PaqueteTuristicoDestinoTourBean paqueteTuristicoDestinoTourBean);
	
	int RegistrarPaqueteTuristicoTicket(PaqueteTuristicoTicketBean paqueteTuristicoTicketBean);
	
	int RegistrarPaqueteTuristicoDestinoHotel(PaqueteTuristicoDestinoHotelBean paqueteTuristicoDestinoHotelBean);
	
	List<PaqueteTuristicoBean> obtenerPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	
	List<PaqueteTuristicoDestinoHotelBean> obtenerDetalleHotelPaquete(PaqueteTuristicoDestinoHotelBean paqueteTuristicoDestinoHotelBean);
	
	int eliminaDestinoPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	int eliminaDestinoHotelPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	int eliminaDestinoTourPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	int eliminaDestinoTicketPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	
	int actualizaPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	
	int actualizaOrdenDestino(OrdenDestinoBean ordenDestinoBean);
	
	List<HotelHabitacionBean> obtenerHotelBusqueda(HotelHabitacionBean hotelHabitacionBean);
	
	List<HotelHabitacionBean> obtenerHotelBusquedaOrden(HotelHabitacionBean hotelHabitacionBean);
	
	
	List<HotelHabitacionBean> listarDetalleHotelBusqueda(HotelHabitacionBean hotelHabitacionBean);
	

	List<HotelHabitacionBean> listarDetalleHotelBusquedaOrden(HotelHabitacionBean hotelHabitacionBean);
	
	List<TourBean> listaTourBusqueda(TourBean tourBean);
	
	int actualizarEstadoPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	
	
}
