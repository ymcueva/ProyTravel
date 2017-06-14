package pe.com.paxtravel.model.dao;

import java.util.List;

import pe.com.paxtravel.bean.CiudadBean;
import pe.com.paxtravel.bean.MotivoViajeBean;
import pe.com.paxtravel.bean.OrdenDestinoBean;
import pe.com.paxtravel.bean.OrdenPlanificacionBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.ServicioAdicionalBean;

public interface OrdenPlanificacionDAO {
	
	public List<OrdenPlanificacionBean> listarOrdenPlanificacion(OrdenPlanificacionBean ordenPlanificacionBean);

	public int GrabarOrdenPlanificacion(OrdenPlanificacionBean ordenPlanificacionBean);
	
	public List<OrdenPlanificacionBean> obtenerOrdenPlanificacion(OrdenPlanificacionBean objBean);
	public List<OrdenPlanificacionBean> obtenerOrdenMotivo(OrdenPlanificacionBean objBean);
	public List<OrdenPlanificacionBean> obtenerOrdenDestino(OrdenPlanificacionBean objBean);
	public List<OrdenPlanificacionBean> obtenerOrdenServicio(OrdenPlanificacionBean objBean);

	public int registrarServicio(ServicioAdicionalBean servicioAdicionalBean);

	public int registrarMotivo(MotivoViajeBean motivoViajeBean);

	public String generarNumeroOrden();

	public int registrarOrdenDestino(OrdenDestinoBean ordenDestinoBean);

	public List<PaisBean> listaPais(PaisBean paisBean);

	public List<CiudadBean> listaCiudad(CiudadBean ciudadBean);
	
	int actualizarEstadoOrden(OrdenPlanificacionBean ordenPlanificacionBean);
	
	List<OrdenPlanificacionBean> obtenerOrdenDestinoPrograma(OrdenPlanificacionBean objBean);

}
