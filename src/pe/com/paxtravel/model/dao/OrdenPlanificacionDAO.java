package pe.com.paxtravel.model.dao;

import java.util.List;

import pe.com.paxtravel.bean.OrdenPlanificacionBean;



public interface OrdenPlanificacionDAO {
	
	
	List<OrdenPlanificacionBean> obtenerOrdenPlanificacion(OrdenPlanificacionBean objBean);

}
