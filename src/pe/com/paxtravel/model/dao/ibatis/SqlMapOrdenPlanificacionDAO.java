package pe.com.paxtravel.model.dao.ibatis;

import java.util.ArrayList;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import pe.com.paxtravel.bean.CiudadBean;
import pe.com.paxtravel.bean.MotivoViajeBean;
import pe.com.paxtravel.bean.OrdenDestinoBean;
import pe.com.paxtravel.bean.OrdenPlanificacionBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.ServicioAdicionalBean;
import pe.com.paxtravel.model.dao.OrdenPlanificacionDAO;

//public class SqlMapCotizacionDAO extends SqlMapClientDaoSupport implements CotizacionDAO{
public class SqlMapOrdenPlanificacionDAO extends SqlMapClientDaoSupport implements OrdenPlanificacionDAO{

	
	@SuppressWarnings("unchecked")
	@Override
	public List<OrdenPlanificacionBean> listarOrdenPlanificacion(OrdenPlanificacionBean ordenPlanificacionBean){
		List<OrdenPlanificacionBean> ordenes = new ArrayList<OrdenPlanificacionBean>();
		ordenes = getSqlMapClientTemplate().queryForList("ordenplanificacion.listarOrdenPlanificacion", ordenPlanificacionBean);
		return ordenes;
	}
	
	@Override
	public String generarNumeroOrden() {
		String numeroOrden = "";
		numeroOrden = (String) getSqlMapClientTemplate().queryForObject("ordenplanificacion.obtenerNumeroOrden");
		return numeroOrden;
	}

	public int GrabarOrdenPlanificacion(OrdenPlanificacionBean ordenPlanificacionBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).insert("ordenplanificacion.insertarOrdenPlanificacion", ordenPlanificacionBean);
		return 1;
	}


	@Override
	public int registrarMotivo(MotivoViajeBean motivoViajeBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("ordenplanificacion.insertarMotivoViaje", motivoViajeBean);
		return 1;
	}

	@Override
	public int registrarServicio(ServicioAdicionalBean servicioAdicionalBean){
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("ordenplanificacion.insertarServicioAdicional", servicioAdicionalBean);
		return 1;
	}

	@Override
	public int registrarOrdenDestino(OrdenDestinoBean ordenDestinoBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("ordenplanificacion.insertarOrdenDestino", ordenDestinoBean);
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
		List<CiudadBean> listaPais = null;
		listaPais = getSqlMapClientTemplate().queryForList("ordenplanificacion.listarPais", ciudadBean);
		return listaPais;
	}
	
}
