package pe.com.paxtravel.service;

import java.util.List;

import pe.com.paxtravel.bean.CiudadBean;
import pe.com.paxtravel.bean.ClienteBean;
import pe.com.paxtravel.bean.CotizacionBean;
import pe.com.paxtravel.bean.CotizacionDetalleBean;
import pe.com.paxtravel.bean.FareInfoBean;
import pe.com.paxtravel.bean.HotelHabitacionBean;
import pe.com.paxtravel.bean.MotivoViajeBean;
import pe.com.paxtravel.bean.OrdenDestinoBean;
import pe.com.paxtravel.bean.OrdenPlanificacionBean;
import pe.com.paxtravel.bean.OrdenServicioBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.ServicioAdicionalBean;


public interface OrdenPlanificacionService {
	
	public List<OrdenPlanificacionBean> listarOrdenPlanificacion(OrdenPlanificacionBean ordenPlanificacionBean);
	
	public String generarNumeroOrden();
	
	public List<PaisBean> listarPais(PaisBean paisBean);
	
	public List<CiudadBean> listarCiudad(CiudadBean ciudadBean);
	
	public int registrarOrdenPlanificacion(OrdenPlanificacionBean ordenPlanificacionBean);
	
	public int registrarOrdenTicket(OrdenPlanificacionBean ordenPlanificacionBean);
	
	public int registrarMotivo(MotivoViajeBean motivoViajeBean);

	public int registrarServicio(ServicioAdicionalBean servicioAdicionalBean);
	
	public int registrarHabitacion(HotelHabitacionBean hotelHabitacionBean);
	
	public int registrarOrdenDestino(OrdenDestinoBean ordenDestinoBean);
	
	List<ClienteBean> obtenerNombreCliente(ClienteBean clienteBean);
	
	FareInfoBean getConsolidador(FareInfoBean fareInfoBean);
	
	public List<OrdenServicioBean> listarOrdenServicio(OrdenServicioBean ordenServicioBean);

	public int actualizarOrden(OrdenPlanificacionBean ordenPlanificacionBean);
	
	OrdenPlanificacionBean obtenerOrden(OrdenPlanificacionBean ordenPlanificacionBean);
		
	List<OrdenPlanificacionBean> obtenerOrdenDestinoPrograma(OrdenPlanificacionBean objBean);
	
	////////////////////////////extras\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    List<OrdenPlanificacionBean> obtenerOrdenPlanificacion(OrdenPlanificacionBean objBean);
    public List<OrdenPlanificacionBean> obtenerOrdenMotivo(OrdenPlanificacionBean objBean);
    public List<OrdenPlanificacionBean> obtenerOrdenDestino(OrdenPlanificacionBean objBean);
    public List<OrdenPlanificacionBean> obtenerOrdenServicio(OrdenPlanificacionBean objBean);
    public List<OrdenDestinoBean> obtenerOrdenDestinoVerifica(OrdenDestinoBean ordenDestinoBean);
    
    int registrarOrdenDestinoOrigen(OrdenDestinoBean ordenDestinoBean);

}
