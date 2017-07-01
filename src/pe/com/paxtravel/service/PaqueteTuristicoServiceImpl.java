package pe.com.paxtravel.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import pe.com.paxtravel.bean.HotelBean;
import pe.com.paxtravel.bean.HotelHabitacionBean;
import pe.com.paxtravel.bean.PaqueteTuristicoBean;
import pe.com.paxtravel.bean.PaqueteTuristicoDestinoBean;
import pe.com.paxtravel.bean.PaqueteTuristicoDestinoHotelBean;
import pe.com.paxtravel.bean.PaqueteTuristicoDestinoTourBean;
import pe.com.paxtravel.bean.PaqueteTuristicoTicketBean;
import pe.com.paxtravel.bean.TourBean;
import pe.com.paxtravel.model.dao.PaqueteTuristicoDAO;

@Service
public class PaqueteTuristicoServiceImpl implements PaqueteTuristicoService {

	private PaqueteTuristicoDAO paqueteTuristicoDAO;

	public PaqueteTuristicoDAO getPaqueteTuristicoDAO() {
		return paqueteTuristicoDAO;
	}

	public void setPaqueteTuristicoDAO(PaqueteTuristicoDAO paqueteTuristicoDAO) {
		this.paqueteTuristicoDAO = paqueteTuristicoDAO;
	}

	@Override
	public List<PaqueteTuristicoBean> listarPaqueteTuristico(
			PaqueteTuristicoBean paqueteTuristicoBean) {
		List<PaqueteTuristicoBean> listaPaquete = new ArrayList<PaqueteTuristicoBean>();
		listaPaquete = paqueteTuristicoDAO
				.listaPaqueteTuristico(paqueteTuristicoBean);
		return listaPaquete;
	}

	@Override
	public List<PaqueteTuristicoBean> obtenerPaqueteTuristico(
			PaqueteTuristicoBean paqueteTuristicoBean) {
		List<PaqueteTuristicoBean> listaPaquete = new ArrayList<PaqueteTuristicoBean>();
		listaPaquete = paqueteTuristicoDAO
				.obtenerPaqueteTuristico(paqueteTuristicoBean);
		return listaPaquete;
	}

	@Override
	public List<PaqueteTuristicoDestinoHotelBean> obtenerDetalleHotelPaquete(
			PaqueteTuristicoDestinoHotelBean paqueteTuristicoDestinoHotelBean) {
		List<PaqueteTuristicoDestinoHotelBean> lista = new ArrayList<PaqueteTuristicoDestinoHotelBean>();
		lista = paqueteTuristicoDAO
				.obtenerDetalleHotelPaquete(paqueteTuristicoDestinoHotelBean);
		return lista;
	}

	@Override
	public List<HotelHabitacionBean> listarTipoHabitacion(
			HotelHabitacionBean hotelHabitacionBean) {
		List<HotelHabitacionBean> listaHotelHabitacion = new ArrayList<HotelHabitacionBean>();
		listaHotelHabitacion = paqueteTuristicoDAO
				.listaTipoHabitacion(hotelHabitacionBean);
		return listaHotelHabitacion;
	}

	@Override
	public List<HotelHabitacionBean> obtenerHotelBusqueda(
			HotelHabitacionBean hotelHabitacionBean) {
		List<HotelHabitacionBean> listaHotelHabitacion = new ArrayList<HotelHabitacionBean>();
		listaHotelHabitacion = paqueteTuristicoDAO
				.obtenerHotelBusqueda(hotelHabitacionBean);
		return listaHotelHabitacion;
	}

	@Override
	public List<HotelHabitacionBean> listarDetalleHotelBusqueda(
			HotelHabitacionBean hotelHabitacionBean) {
		List<HotelHabitacionBean> listaHotelHabitacion = new ArrayList<HotelHabitacionBean>();
		listaHotelHabitacion = paqueteTuristicoDAO
				.listarDetalleHotelBusqueda(hotelHabitacionBean);
		return listaHotelHabitacion;
	}

	@Override
	public List<HotelHabitacionBean> obtenerTipoHabitacion(
			HotelHabitacionBean hotelHabitacionBean) {
		List<HotelHabitacionBean> listaHotelHabitacion = new ArrayList<HotelHabitacionBean>();
		listaHotelHabitacion = paqueteTuristicoDAO
				.obtenerTipoHabitacion(hotelHabitacionBean);
		return listaHotelHabitacion;
	}

	@Override
	public int GrabarPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean) {
		return paqueteTuristicoDAO.GrabarPaqueteTuristico(paqueteTuristicoBean);
	}

	@Override
	public int RegistrarPaqueteTuristicoDestino(
			PaqueteTuristicoDestinoBean paqueteTuristicoDestinoBean) {
		return paqueteTuristicoDAO
				.RegistrarPaqueteTuristicoDestino(paqueteTuristicoDestinoBean);
	}

	@Override
	public int RegistrarPaqueteTuristicoDestinoTour(
			PaqueteTuristicoDestinoTourBean paqueteTuristicoDestinoTourBean) {
		return paqueteTuristicoDAO
				.RegistrarPaqueteTuristicoDestinoTour(paqueteTuristicoDestinoTourBean);
	}

	@Override
	public int RegistrarPaqueteTuristicoTicket(
			PaqueteTuristicoTicketBean paqueteTuristicoTicketBean) {
		return paqueteTuristicoDAO
				.RegistrarPaqueteTuristicoTicket(paqueteTuristicoTicketBean);
	}

	@Override
	public int actualizaPaqueteTuristico(
			PaqueteTuristicoBean paqueteTuristicoBean) {
		return paqueteTuristicoDAO
				.actualizaPaqueteTuristico(paqueteTuristicoBean);
	}

	@Override
	public int RegistrarPaqueteTuristicoDestinoHotel(
			PaqueteTuristicoDestinoHotelBean paqueteTuristicoDestinoHotelBean) {
		return paqueteTuristicoDAO
				.RegistrarPaqueteTuristicoDestinoHotel(paqueteTuristicoDestinoHotelBean);
	}

	@Override
	public void eliminaDetallePaqueteTuristico(
			PaqueteTuristicoBean paqueteTuristicoBean) {

		paqueteTuristicoDAO
				.eliminaDestinoPaqueteTuristico(paqueteTuristicoBean);

		paqueteTuristicoDAO
				.eliminaDestinoHotelPaqueteTuristico(paqueteTuristicoBean);

		paqueteTuristicoDAO
				.eliminaDestinoTourPaqueteTuristico(paqueteTuristicoBean);

		paqueteTuristicoDAO
				.eliminaDestinoTicketPaqueteTuristico(paqueteTuristicoBean);

	}

	@Override
	public String obtenerCodigoPaqTuristico() {
		return (String) paqueteTuristicoDAO.obtenerCodigoPaqTuristico();
	}

	@Override
	public List<TourBean> listarTour(TourBean tourBean) {
		List<TourBean> listaTour = new ArrayList<TourBean>();
		listaTour = paqueteTuristicoDAO.listaTour(tourBean);
		return listaTour;
	}

	@Override
	public List<TourBean> listaTourBusqueda(TourBean tourBean) {
		List<TourBean> listaTour = new ArrayList<TourBean>();
		listaTour = paqueteTuristicoDAO.listaTourBusqueda(tourBean);
		return listaTour;
	}

	@Override
	public List<HotelBean> listarHotel(HotelBean hotelBean) {
		List<HotelBean> listaHotel = new ArrayList<HotelBean>();
		listaHotel = paqueteTuristicoDAO.listaHotel(hotelBean);
		return listaHotel;
	}

	@Override
	public int actualizarEstadoPaqueteTuristico(
			PaqueteTuristicoBean paqueteTuristicoBean) {
		return paqueteTuristicoDAO
				.actualizarEstadoPaqueteTuristico(paqueteTuristicoBean);
	}

}
