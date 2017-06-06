package pe.com.paxtravel.service;

import java.util.List;

import pe.com.paxtravel.bean.CiudadBean;
import pe.com.paxtravel.bean.CotizacionBean;
import pe.com.paxtravel.bean.CotizacionDetalleBean;
import pe.com.paxtravel.bean.HotelHabitacionBean;
import pe.com.paxtravel.bean.MotivoViajeBean;
import pe.com.paxtravel.bean.OrdenDestinoBean;
import pe.com.paxtravel.bean.OrdenPlanificacionBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.ServicioAdicionalBean;


public interface OrdenPlanificacionService {
	
	List<OrdenPlanificacionBean> obtenerOrdenPlanificacion(OrdenPlanificacionBean objBean);
	public List<OrdenPlanificacionBean> obtenerOrdenMotivo(OrdenPlanificacionBean objBean);
	public List<OrdenPlanificacionBean> obtenerOrdenDestino(OrdenPlanificacionBean objBean);
	public List<OrdenPlanificacionBean> obtenerOrdenServicio(OrdenPlanificacionBean objBean);
	
    public List<OrdenPlanificacionBean> listarOrdenPlanificacion(OrdenPlanificacionBean ordenPlanificacionBean);    
        
    public int GrabarOrdenPlanificacion(OrdenPlanificacionBean ordenPlanificacionBean);
    
    public String generarNumeroOrden();
        
    public int registrarMotivo(MotivoViajeBean motivoViajeBean);
    
    public int registrarServicio(ServicioAdicionalBean servicioAdicionalBean);

	public int registrarOrdenDestino(OrdenDestinoBean ordenDestinoBean);
	
	public List<CiudadBean> listarCiudad(CiudadBean ciudadBean);
	
	public List<PaisBean> listarPais(PaisBean paisBean);
}
