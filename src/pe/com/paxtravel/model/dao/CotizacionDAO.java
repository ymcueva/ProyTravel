package pe.com.paxtravel.model.dao;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

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
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.PaqueteResumeBean;
import pe.com.paxtravel.bean.ServicioAdicionalBean;
import pe.com.paxtravel.tree.data.PaqueteManagerBean;

public interface CotizacionDAO {

	List<CotizacionBean> listaCotizacion(CotizacionBean cotizacionBean);

	String generarNumeroCotizacion();

	List<CiudadBean> listaCiudad(CiudadBean ciudadBean);

	List<PaisBean> listaPais(PaisBean paisBean);

	int registrarCotizacion(CotizacionBean cotizacionBean);

	int registrarCotizacionTicket(CotizacionBean cotizacionBean);

	int registrarMotivo(MotivoViajeBean motivoViajeBean);

	int registrarHabitacion(HotelHabitacionBean hotelHabitacionBean);

	int registrarServicio(ServicioAdicionalBean servicioAdicionalBean);

	int registrarCotizacionDetalleTicket(
			CotizacionDetalleBean cotizacionDetalleBean);

	List<ClienteBean> obtenerNombreCliente(ClienteBean clienteBean);

	FareInfoBean getConsolidador(FareInfoBean fareInfoBean);

	int registrarConsolidador(CotizacionDetalleTicketVueloBean fareInfoBean);

	List<PaqueteManagerBean> listarPaquete(PaqueteManagerBean paqueteBean);

	List<PaqueteManagerBean> listarPaqueteDestino(PaqueteManagerBean paqueteBean);

	List<CotizacionServicioBean> listarCotizacionServicio(
			CotizacionServicioBean cotizacionServicioBean);

	List<CotizacionServicioBean> obtenerCotizacionServicio(
			CotizacionServicioBean cotizacionServicioBean);

	int actualizarCotizacion(CotizacionBean cotizacionBean);

	CotizacionBean obtenerCotizacion(CotizacionBean cotizacionBean);

	PaqueteResumeBean obtenerPaquete(PaqueteResumeBean p);

	List<PaqueteResumeBean> listarPaqueteDetail(PaqueteResumeBean p);

	int registrarExpedienteLog(ExpedienteLogBean expedienteLogBean);

	List<CotizacionDetalleBean> listarDestinosDetail(
			CotizacionDetalleBean cotizacionDetalleBean);

	CotizacionBean obtenerCotizacionPorId(int cotizacionId);

	List<CotizacionDetalleDestinosBean> listarCotizacionPaqueteDestinos(
			int cotizacionId);

	List<CotizacionDetalleDestinosBean> listarCotizacionTicketDestinos(
			int cotizacionId);

	public int actualizarCotizacionRechazo(CotizacionBean cotizacionBean);
	
	List<CotizacionDetaHabitacionBean> listarCotizacionDetaHabitacion(CotizacionDetaHabitacionBean cotizacionDetaHabitacionBean);

}
