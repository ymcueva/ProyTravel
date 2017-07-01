package pe.com.paxtravel.model.dao;

import java.util.List;

import pe.com.paxtravel.bean.ReservaBean;
import pe.com.paxtravel.bean.ReservaPasajeroDetalleBean;

public interface ReservaDAO {
	
	List<ReservaBean> listaReserva(ReservaBean reservaBean);
	
	List<ReservaBean> obtenerCotizacion(ReservaBean reservaBean);
	
	List<ReservaBean> obtenerTicketAereoCotizacion(ReservaBean reservaBean);
	
	String generarNumeroReserva();

	int registrarReserva(ReservaBean reservaBean);
	
	ReservaBean obtenerReserva(ReservaBean reservaBean);
	
	int actualizarEstadoReserva(ReservaBean reservaBean);
	
	int registrarReservaPasajero(ReservaPasajeroDetalleBean reservaPasajeroDetalleBean);
	
	List<ReservaBean> listarPaqueteCotizacion(ReservaBean reservaBean);
	
}
