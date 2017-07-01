package pe.com.paxtravel.service;

import java.util.List;

import pe.com.paxtravel.bean.CotizacionBean;
import pe.com.paxtravel.bean.ReservaBean;
import pe.com.paxtravel.bean.ReservaPasajeroDetalleBean;

public interface ReservaService {

	public List<ReservaBean> listarReserva(ReservaBean reservaBean);
	
	public List<ReservaBean> obtenerCotizacion(ReservaBean reservaBean);
	
	public List<ReservaBean> obtenerTicketAereoCotizacion(ReservaBean reservaBean);

	public String generarNumeroReserva();
	
	public int registrarReserva(ReservaBean reservaBean);
	
	public ReservaBean obtenerReserva(ReservaBean reservaBean);

	int actualizarEstadoReserva(ReservaBean reservaBean);
	
	int registrarReservaPasajero(ReservaPasajeroDetalleBean reservaPasajeroDetalleBean);

	public List<ReservaBean> listarPaqueteCotizacion(ReservaBean reservaBean);
	
}
