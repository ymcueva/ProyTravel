package pe.com.paxtravel.model.dao.ibatis;


import java.util.ArrayList;
import java.util.List;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import pe.com.paxtravel.bean.OrdenPlanificacionBean;
import pe.com.paxtravel.model.dao.OrdenPlanificacionDAO;



//public class SqlMapCotizacionDAO extends SqlMapClientDaoSupport implements CotizacionDAO{
public class SqlMapOrdenPlanificacionDAO extends SqlMapClientDaoSupport implements OrdenPlanificacionDAO{

	
	@SuppressWarnings("unchecked")
	@Override
	public List<OrdenPlanificacionBean> obtenerOrdenPlanificacion(OrdenPlanificacionBean objbean){
		List<OrdenPlanificacionBean> ordenes = new ArrayList<OrdenPlanificacionBean>();
		ordenes = getSqlMapClientTemplate().queryForList("ordenPlanificacion.obtenerOrdenPlanificacion", objbean);
		return ordenes;
	}

	
	
	
}
