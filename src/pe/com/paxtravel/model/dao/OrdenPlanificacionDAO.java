package pe.com.paxtravel.model.dao;

import java.util.List;

import pe.com.paxtravel.bean.CiudadBean;
import pe.com.paxtravel.bean.MotivoViajeBean;
import pe.com.paxtravel.bean.OrdenDestinoBean;
import pe.com.paxtravel.bean.OrdenPlanificacionBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.ServicioAdicionalBean;

public interface OrdenPlanificacionDAO {
	
	List<OrdenPlanificacionBean> listarOrdenPlanificacion(OrdenPlanificacionBean ordenPlanificacionBean);

	public int GrabarOrdenPlanificacion(OrdenPlanificacionBean ordenPlanificacionBean);
	
	public int registrarServicio(ServicioAdicionalBean servicioAdicionalBean);

	public int registrarMotivo(MotivoViajeBean motivoViajeBean);

	String generarNumeroOrden();

	public int registrarOrdenDestino(OrdenDestinoBean ordenDestinoBean);

	List<PaisBean> listaPais(PaisBean paisBean);

	List<CiudadBean> listaCiudad(CiudadBean ciudadBean);

}
