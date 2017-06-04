package pe.com.paxtravel.model.dao.ibatis;

import java.util.ArrayList;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import pe.com.paxtravel.bean.CotizacionBean;
import pe.com.paxtravel.bean.OrdenPlanificacionBean;
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
	/*
	@SuppressWarnings("unchecked")
	public List<CotizacionBean> obtenerDataCotizacion(OrdenPlanificacionBean ordenPlanificacionBean){
		List<CotizacionBean> ordenes = new ArrayList<CotizacionBean>();
		ordenes = getSqlMapClientTemplate().queryForList("ordenPlanificacion.listarOrdenPlanificacion", ordenPlanificacionBean);
		return ordenes;
	}*/

	public int GrabarOrdenPlanificacion(OrdenPlanificacionBean ordenPlanificacionBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).insert("ordenplanificacion.insertarOrdenPlanificacion", ordenPlanificacionBean);
		return 1;
	}	
	
}
