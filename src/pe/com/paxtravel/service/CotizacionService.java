package pe.com.paxtravel.service;

import java.util.List;

import pe.com.paxtravel.bean.CiudadBean;
import pe.com.paxtravel.bean.ClienteBean;
import pe.com.paxtravel.bean.CotizacionBean;
import pe.com.paxtravel.bean.CotizacionDetaHabitacionBean;
import pe.com.paxtravel.bean.CotizacionDetalleBean;
import pe.com.paxtravel.bean.CotizacionDetalleTicketVueloBean;
import pe.com.paxtravel.bean.CotizacionDetalleDestinosBean;
import pe.com.paxtravel.bean.CotizacionServicioBean;
import pe.com.paxtravel.bean.ExpedienteLogBean;
import pe.com.paxtravel.bean.FareInfoBean;
import pe.com.paxtravel.bean.HotelHabitacionBean;
import pe.com.paxtravel.bean.MotivoViajeBean;
import pe.com.paxtravel.bean.OrdenPlanificacionBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.PaqueteResumeBean;
import pe.com.paxtravel.bean.ServicioAdicionalBean;
import pe.com.paxtravel.tree.data.PaqueteManagerBean;

public interface CotizacionService {

	public List<CotizacionBean> listarCotizacion(CotizacionBean cotizacionBean);

	public String generarNumeroCotizacion();

	public List<CiudadBean> listarCiudad(CiudadBean ciudadBean);

	public List<PaisBean> listarPais(PaisBean paisBean);

	public int registrarCotizacion(CotizacionBean cotizacionBean);

	public int registrarMotivo(MotivoViajeBean motivoViajeBean);

	public int registrarHabitacion(HotelHabitacionBean hotelHabitacionBean);

	public int registrarServicio(ServicioAdicionalBean servicioAdicionalBean);

	public int registrarCotizacionTicket(CotizacionBean cotizacionBean);

	public int registrarCotizacionDetalleTicket(
			CotizacionDetalleBean cotizacionDetalleBean);

	public List<ClienteBean> obtenerNombreCliente(ClienteBean clienteBean);

	public FareInfoBean getConsolidador(FareInfoBean fareInfoBean);

	public int registrarConsolidador(
			CotizacionDetalleTicketVueloBean fareInfoBean);

	public List<PaqueteManagerBean> listarPaquete(PaqueteManagerBean paqueteBean);

	public List<PaqueteManagerBean> listarPaqueteDestino(
			PaqueteManagerBean paqueteBean);

	List<FareInfoBean> listarTickets(String cadenaVuelo);

	List<CotizacionServicioBean> listarCotizacionServicio(
			CotizacionServicioBean cotizacionServicioBean);

	List<CotizacionServicioBean> obtenerCotizacionServicio(
			CotizacionServicioBean cotizacionServicioBean);

	int actualizarCotizacion(CotizacionBean cotizacionBean);

	public CotizacionBean obtenerCotizacion(CotizacionBean cotizacionBean);

	public PaqueteResumeBean obtenerPaquete(PaqueteResumeBean paqueteResumenBean);

	public List<PaqueteResumeBean> listarPaqueteDetail(PaqueteResumeBean p);

	public int registrarExpedienteLog(ExpedienteLogBean expedienteLogBean);

	public List<CotizacionDetalleBean> listarDestinosDetail(
			CotizacionDetalleBean cotizacionDetalleBean);

	public OrdenPlanificacionBean minorCostTicket(
			List<FareInfoBean> listaTickets);

	public CotizacionBean obtenerCotizacionPorId(int cotizacionId);

	public List<CotizacionDetalleDestinosBean> listarCotizacionPaqueteDestinos(
			int cotizacionId);

	public List<CotizacionDetalleDestinosBean> listarCotizacionTicketDestinos(
			int cotizacionId);

	public int actualizarCotizacionRechazo(CotizacionBean cotizacionBean);
	
	List<CotizacionDetaHabitacionBean> listarCotizacionDetaHabitacion(CotizacionDetaHabitacionBean cotizacionDetaHabitacionBean);

}
