package pe.com.paxtravel.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import pe.com.paxtravel.bean.OrdenPlanificacionBean;
import pe.com.paxtravel.model.dao.OrdenPlanificacionDAO;



@Service
public class OrdenPlanificacionServiceImpl implements OrdenPlanificacionService{

	
	private OrdenPlanificacionDAO objDAO;

	

	public OrdenPlanificacionDAO getObjDAO() {
		return objDAO;
	}


	public void setObjDAO(OrdenPlanificacionDAO objDAO) {
		this.objDAO = objDAO;
	}



	@Override
	public List<OrdenPlanificacionBean> obtenerOrdenPlanificacion(OrdenPlanificacionBean objBean) {
		List<OrdenPlanificacionBean> ordenes = new ArrayList<OrdenPlanificacionBean>();
		ordenes = objDAO.obtenerOrdenPlanificacion(objBean);
		return ordenes;
	}
	
	
	
	
	
	
	
}
