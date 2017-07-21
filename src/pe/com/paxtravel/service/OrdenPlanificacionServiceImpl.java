package pe.com.paxtravel.service;

import java.util.ArrayList;
import java.util.List;
import pe.com.paxtravel.bean.CiudadBean;
import pe.com.paxtravel.bean.ClienteBean;
import pe.com.paxtravel.bean.FareInfoBean;
import pe.com.paxtravel.bean.HotelHabitacionBean;
import pe.com.paxtravel.bean.MotivoViajeBean;
import pe.com.paxtravel.bean.OrdenDestinoBean;
import pe.com.paxtravel.bean.OrdenPlanificacionBean;
import pe.com.paxtravel.bean.OrdenServicioBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.ServicioAdicionalBean;
import pe.com.paxtravel.model.dao.OrdenPlanificacionDAO;

public class OrdenPlanificacionServiceImpl implements OrdenPlanificacionService {

	private OrdenPlanificacionDAO objDAO;

	public OrdenPlanificacionDAO getObjDAO() {
		return objDAO;
	}

	public void setObjDAO(OrdenPlanificacionDAO objDAO) {
		this.objDAO = objDAO;
	}

	@Override
	public List<OrdenPlanificacionBean> obtenerOrdenDestinoPrograma(
			OrdenPlanificacionBean objBean) {
		List<OrdenPlanificacionBean> ordenes = new ArrayList<OrdenPlanificacionBean>();
		ordenes = objDAO.obtenerOrdenDestinoPrograma(objBean);
		return ordenes;
	}
	
	@Override
	public List<OrdenDestinoBean> obtenerOrdenDestinoVerifica(OrdenDestinoBean ordenDestinoBean){
		List<OrdenDestinoBean> ordenes = new ArrayList<OrdenDestinoBean>();
		ordenes = objDAO.obtenerOrdenDestinoVerifica(ordenDestinoBean);
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
	public int registrarOrdenDestinoOrigen(OrdenDestinoBean ordenDestinoBean){
		return objDAO.registrarOrdenDestinoOrigen(ordenDestinoBean);
	}

	@Override
	public int registrarServicio(ServicioAdicionalBean servicioAdicionalBean) {
		return objDAO.registrarServicio(servicioAdicionalBean);
	}

	@Override
	public OrdenPlanificacionBean obtenerOrden(
			OrdenPlanificacionBean ordenPlanificacionBean) {
		return objDAO.obtenerOrden(ordenPlanificacionBean);
	}

	@Override
	public int registrarOrdenDestino(OrdenDestinoBean ordenDestinoBean) {
		return objDAO.registrarOrdenDestino(ordenDestinoBean);
	}

	@Override
	public int actualizarOrden(OrdenPlanificacionBean ordenPlanificacionBean) {
		return objDAO.actualizarOrden(ordenPlanificacionBean);
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
		List<OrdenPlanificacionBean> listaOrden = new ArrayList<OrdenPlanificacionBean>();
		listaOrden = objDAO.listaOrdenPlanificacion(ordenPlanificacionBean);
		return listaOrden;
	}

	@Override
	public int registrarOrdenPlanificacion(
			OrdenPlanificacionBean ordenPlanificacionBean) {
		return objDAO.registrarOrdenPlanificacion(ordenPlanificacionBean);
	}

	@Override
	public int registrarOrdenTicket(
			OrdenPlanificacionBean ordenPlanificacionBean) {
		return objDAO.registrarOrdenTicket(ordenPlanificacionBean);
	}

	@Override
	public int registrarHabitacion(HotelHabitacionBean hotelHabitacionBean) {
		return objDAO.registrarHabitacion(hotelHabitacionBean);
	}

	@Override
	public List<ClienteBean> obtenerNombreCliente(ClienteBean clienteBean) {
		List<ClienteBean> cliente = new ArrayList<ClienteBean>();
		cliente = objDAO.obtenerNombreCliente(clienteBean);
		return cliente;
	}

	@Override
	public FareInfoBean getConsolidador(FareInfoBean fareInfoBean) {
		FareInfoBean fib = new FareInfoBean();
		fib = objDAO.getConsolidador(fareInfoBean);
		return fib;
	}

	@Override
	public List<OrdenServicioBean> listarOrdenServicio(
			OrdenServicioBean ordenServicioBean) {
		List<OrdenServicioBean> lista = new ArrayList<OrdenServicioBean>();
		lista = objDAO.listarOrdenServicio(ordenServicioBean);
		return lista;
	}

	////////////////////////////extras\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
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
    public List<OrdenPlanificacionBean> obtenerOrdenServicio(OrdenPlanificacionBean objBean) {
        List<OrdenPlanificacionBean> ordenes = new ArrayList<OrdenPlanificacionBean>();
        ordenes = objDAO.obtenerOrdenServicio(objBean);
        return ordenes;
    }

}
