package pe.com.paxtravel.model.dao.ibatis;

import java.util.ArrayList;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import pe.com.paxtravel.bean.CiudadBean;
import pe.com.paxtravel.bean.ClienteBean;
import pe.com.paxtravel.bean.CotizacionServicioBean;
import pe.com.paxtravel.bean.FareInfoBean;
import pe.com.paxtravel.bean.HotelHabitacionBean;
import pe.com.paxtravel.bean.MotivoViajeBean;
import pe.com.paxtravel.bean.OrdenDestinoBean;
import pe.com.paxtravel.bean.OrdenPlanificacionBean;
import pe.com.paxtravel.bean.OrdenServicioBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.ServicioAdicionalBean;
import pe.com.paxtravel.model.dao.OrdenPlanificacionDAO;

//public class SqlMapCotizacionDAO extends SqlMapClientDaoSupport implements CotizacionDAO{
public class SqlMapOrdenPlanificacionDAO extends SqlMapClientDaoSupport
		implements OrdenPlanificacionDAO {

	@SuppressWarnings("unchecked")
	@Override
	public List<OrdenPlanificacionBean> obtenerOrdenDestinoPrograma(OrdenPlanificacionBean objBean) {
		List<OrdenPlanificacionBean> ordenes = new ArrayList<OrdenPlanificacionBean>();
		ordenes = getSqlMapClientTemplate().queryForList("ordenplanificacion.obtenerOrdenDestinoPrograma", objBean);
		return ordenes;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<OrdenDestinoBean> obtenerOrdenDestinoVerifica(OrdenDestinoBean objBean) {
		List<OrdenDestinoBean> ordenes = new ArrayList<OrdenDestinoBean>();
		ordenes = getSqlMapClientTemplate().queryForList("ordenplanificacion.obtenerOrdenDestinoVerifica", objBean);
		return ordenes;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OrdenPlanificacionBean> listaOrdenPlanificacion(OrdenPlanificacionBean ordenPlanificacionBean) {
		List<OrdenPlanificacionBean> ordenes = new ArrayList<OrdenPlanificacionBean>();
		ordenes = getSqlMapClientTemplate().queryForList("ordenplanificacion.listarOrdenPlanificacion",
				ordenPlanificacionBean);
		return ordenes;
	}

	@Override
	public OrdenPlanificacionBean obtenerOrden(OrdenPlanificacionBean ordenPlanificacionBean) {
		return (OrdenPlanificacionBean) getSqlMapClientTemplate().queryForObject("ordenplanificacion.orderResume",
						ordenPlanificacionBean);
	}

	@Override
	public String generarNumeroOrden() {
		String numeroOrden = "";
		numeroOrden = (String) getSqlMapClientTemplate().queryForObject("ordenplanificacion.obtenerNumeroOrden");
		return numeroOrden;
	}

	@Override
	public int registrarMotivo(MotivoViajeBean motivoViajeBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("ordenplanificacion.insertarMotivoViaje",
						motivoViajeBean);
		return 1;
	}
	
	@Override
	public int registrarOrdenDestinoOrigen(OrdenDestinoBean ordenDestinoBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).insert("ordenplanificacion.insertarOrdenDestinoOrigen",
				ordenDestinoBean);
		return 1;
	}

	@Override
	public int registrarServicio(ServicioAdicionalBean servicioAdicionalBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("ordenplanificacion.insertarServicioAdicional",
						servicioAdicionalBean);
		return 1;
	}

	@Override
	public int registrarOrdenDestino(OrdenDestinoBean ordenDestinoBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("ordenplanificacion.insertarOrdenDestino",
						ordenDestinoBean);
		return 1;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PaisBean> listaPais(PaisBean paisBean) {
		List<PaisBean> listaPais = null;
		listaPais = getSqlMapClientTemplate().queryForList("ordenplanificacion.listarPais", paisBean);
		return listaPais;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<CiudadBean> listaCiudad(CiudadBean ciudadBean) {
		List<CiudadBean> listaciudad = null;
		listaciudad = getSqlMapClientTemplate().queryForList("ordenplanificacion.listarCiudad", ciudadBean);
		return listaciudad;
	}

	@Override
	public int registrarOrdenPlanificacion(OrdenPlanificacionBean ordenPlanificacionBean) {
		System.out.println("op ibatis");
		System.out.println("Id:"
				+ getSqlMapClientTemplate().insert("ordenplanificacion.insertarOrdenPlanificacion",	ordenPlanificacionBean));
		System.out.println("BeanId: " + ordenPlanificacionBean.getIdOrden());
		return ordenPlanificacionBean.getIdOrden();
	}

	@Override
	public int registrarHabitacion(HotelHabitacionBean hotelHabitacionBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient())
				.update("ordenplanificacion.insertarHabitacionHotel",
						hotelHabitacionBean);
		return 1;
	}

	@Override
	public int actualizarOrden(OrdenPlanificacionBean ordenPlanificacionBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient())
				.update("ordenplanificacion.actualizarEstadoOrden",
						ordenPlanificacionBean);
		return 1;
	}

	@Override
	public int registrarOrdenTicket(
			OrdenPlanificacionBean ordenPlanificacionBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient())
				.update("ordenplanificacion.insertarOrdenTicket",
						ordenPlanificacionBean);
		return 1;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ClienteBean> obtenerNombreCliente(ClienteBean clienteBean) {
		List<ClienteBean> cliente = new ArrayList<ClienteBean>();
		cliente = getSqlMapClientTemplate().queryForList(
				"ordenplanificacion.obtenerNombreCliente", clienteBean);
		return cliente;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OrdenServicioBean> listarOrdenServicio(OrdenServicioBean ordenServicioBean) {
		List<OrdenServicioBean> lista = null;
		lista = getSqlMapClientTemplate().queryForList(
				"ordenplanificacion.listarOrdenServicio", ordenServicioBean);
		return lista;
	}

	@Override
	public FareInfoBean getConsolidador(FareInfoBean fareInfoBean) {
		return (FareInfoBean) getSqlMapClientTemplate().queryForObject(
				"ordenplanificacion.getConsolidador", fareInfoBean);
	}

	////////////////////////////extras\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	@SuppressWarnings("unchecked")
	@Override
	public List<OrdenPlanificacionBean> obtenerOrdenPlanificacion(OrdenPlanificacionBean objBean) {
		List<OrdenPlanificacionBean> ordenes = new ArrayList<OrdenPlanificacionBean>();
		ordenes = getSqlMapClientTemplate().queryForList(
				"ordenplanificacion.obtenerOrdenPlanificacion", objBean);
		return ordenes;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OrdenPlanificacionBean> obtenerOrdenMotivo(OrdenPlanificacionBean objBean) {
		List<OrdenPlanificacionBean> ordenes = new ArrayList<OrdenPlanificacionBean>();
		ordenes = getSqlMapClientTemplate().queryForList(
				"ordenplanificacion.obtenerOrdenMotivo", objBean);
		return ordenes;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OrdenPlanificacionBean> obtenerOrdenDestino(OrdenPlanificacionBean objBean) {
		List<OrdenPlanificacionBean> ordenes = new ArrayList<OrdenPlanificacionBean>();
		ordenes = getSqlMapClientTemplate().queryForList(
				"ordenplanificacion.obtenerOrdenDestino", objBean);
		return ordenes;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<OrdenPlanificacionBean> obtenerOrdenServicio(OrdenPlanificacionBean objBean) {
		List<OrdenPlanificacionBean> ordenes = new ArrayList<OrdenPlanificacionBean>();
		ordenes = getSqlMapClientTemplate().queryForList("ordenplanificacion.obtenerOrdenServicio", objBean);
		return ordenes;
	}

}
