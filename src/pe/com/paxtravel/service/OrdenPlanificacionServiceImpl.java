package pe.com.paxtravel.service;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Service;

import pe.com.paxtravel.bean.CiudadBean;
import pe.com.paxtravel.bean.HotelHabitacionBean;
import pe.com.paxtravel.bean.MotivoViajeBean;
import pe.com.paxtravel.bean.OrdenDestinoBean;
import pe.com.paxtravel.bean.OrdenPlanificacionBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.ServicioAdicionalBean;
import pe.com.paxtravel.model.dao.OrdenPlanificacionDAO;

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

	@Override
	public List<OrdenPlanificacionBean> obtenerOrdenMotivo(OrdenPlanificacionBean objBean) {
		List<OrdenPlanificacionBean> ordenes = new ArrayList<OrdenPlanificacionBean>();
		ordenes = objDAO.obtenerOrdenMotivo(objBean);
		return ordenes;
	}
	
	@Override
	public List<OrdenPlanificacionBean> obtenerOrdenDestino(OrdenPlanificacionBean objBean) {
		List<OrdenPlanificacionBean> ordenes = new ArrayList<OrdenPlanificacionBean>();
		ordenes = objDAO.obtenerOrdenDestino(objBean);
		return ordenes;
	}
	
	@Override
	public List<OrdenPlanificacionBean> obtenerOrdenDestinoPrograma(OrdenPlanificacionBean objBean){
		List<OrdenPlanificacionBean> ordenes = new ArrayList<OrdenPlanificacionBean>();
		ordenes = objDAO.obtenerOrdenDestinoPrograma(objBean);
		return ordenes;
	}
	
	@Override
	public List<OrdenPlanificacionBean> obtenerOrdenServicio(OrdenPlanificacionBean objBean) {
		List<OrdenPlanificacionBean> ordenes = new ArrayList<OrdenPlanificacionBean>();
		ordenes = objDAO.obtenerOrdenServicio(objBean);
		return ordenes;
	}
	
	@Override
	public String generarNumeroOrden() {
		return objDAO.generarNumeroOrden();
	}
	
	@Override
	public int registrarMotivo(MotivoViajeBean motivoViajeBean) {
		return objDAO.registrarMotivo(motivoViajeBean);
	}

	@Override
	public int registrarServicio(ServicioAdicionalBean servicioAdicionalBean) {
		return objDAO.registrarServicio(servicioAdicionalBean);
	}

	@Override
	public int registrarOrdenDestino(OrdenDestinoBean ordenDestinoBean) {
		return objDAO.registrarOrdenDestino(ordenDestinoBean);
	}

	@Override
	public int actualizarEstadoOrden(OrdenPlanificacionBean objBean){
		return objDAO.actualizarEstadoOrden(objBean);
	}
	
	@Override
	public List<CiudadBean> listarCiudad(CiudadBean ciudadBean) {
		List<CiudadBean> listaCiudad = new ArrayList<CiudadBean>();
		listaCiudad = objDAO.listaCiudad(ciudadBean);
		return listaCiudad;
	}

    @Override
    public List<PaisBean> listarPais(PaisBean paisBean) {
        List<PaisBean> listaPais = new ArrayList<PaisBean>();
        listaPais = objDAO.listaPais(paisBean);
        return listaPais;
    }


	@Override
	public List<OrdenPlanificacionBean> listarOrdenPlanificacion(
			OrdenPlanificacionBean ordenPlanificacionBean) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public int GrabarOrdenPlanificacion(
			OrdenPlanificacionBean ordenPlanificacionBean) {
		// TODO Auto-generated method stub
		return 0;
	}

	
	
	
}
