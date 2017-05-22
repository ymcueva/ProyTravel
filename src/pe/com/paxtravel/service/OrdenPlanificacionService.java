package pe.com.paxtravel.service;

import java.util.List;

import pe.com.paxtravel.bean.OrdenPlanificacionBean;


public interface OrdenPlanificacionService {
	
	public List<OrdenPlanificacionBean> obtenerOrdenPlanificacion(OrdenPlanificacionBean objBean);

}
