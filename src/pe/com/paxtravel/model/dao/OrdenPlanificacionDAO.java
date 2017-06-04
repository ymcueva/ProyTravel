package pe.com.paxtravel.model.dao;

import java.util.List;

import pe.com.paxtravel.bean.OrdenPlanificacionBean;

public interface OrdenPlanificacionDAO {
	
	List<OrdenPlanificacionBean> listarOrdenPlanificacion(OrdenPlanificacionBean ordenPlanificacionBean);

	int GrabarOrdenPlanificacion(OrdenPlanificacionBean ordenPlanificacionBean);
}
