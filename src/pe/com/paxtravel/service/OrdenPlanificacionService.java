package pe.com.paxtravel.service;

import java.util.List;

import pe.com.paxtravel.bean.OrdenPlanificacionBean;


public interface OrdenPlanificacionService {
	
	public List<OrdenPlanificacionBean> listarOrdenPlanificacion(OrdenPlanificacionBean ordenPlanificacionBean);
	
	int GrabarOrdenPlanificacion(OrdenPlanificacionBean ordenPlanificacionBean);

}
