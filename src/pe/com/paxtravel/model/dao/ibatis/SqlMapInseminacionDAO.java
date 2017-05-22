package pe.com.paxtravel.model.dao.ibatis;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import pe.com.paxtravel.bean.EmpleadoBean;
import pe.com.paxtravel.bean.InseminacionBean;
import pe.com.paxtravel.bean.ProduccionBean;
import pe.com.paxtravel.model.dao.InseminacionDAO;
//import pe.com.paxtravel.model.dao.ProduccionDAO;

public class SqlMapInseminacionDAO extends SqlMapClientDaoSupport implements InseminacionDAO{
	
	@SuppressWarnings("unchecked")
	@Override
	public List<InseminacionBean> listaInseminacion(InseminacionBean inseminacionBean) {
		List<InseminacionBean> listaInseminacion = null;
		listaInseminacion = getSqlMapClientTemplate().queryForList("inseminacion.listaInseminacion", inseminacionBean);
		return listaInseminacion;
	}

	@Override
	public int registrarInseminacion(InseminacionBean inseminacionBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("inseminacion.insertarInseminacion", inseminacionBean);
		return 1;
	}
	
	public String obtenerCodigoInseminacion() {
		String codigo = (String)getSqlMapClientTemplate().queryForObject("inseminacion.obtenerCodigoInseminacion");
		return codigo;
	}

//	@SuppressWarnings("unchecked")
//	@Override
//	public List<InseminacionBean> buscarInseminacion(String codigoInseminacion) {
//		List<InseminacionBean> listaInseminacion = null;
//		listaInseminacion = getSqlMapClientTemplate().queryForList("inseminacion.buscarInseminacion", codigoInseminacion);
//		return listaInseminacion;
//	}

	@Override
	public int editarInseminacion(InseminacionBean inseminacionBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("inseminacion.editarInseminacion", inseminacionBean);
		return 1;
	}

	@Override
	public int eliminarInseminacion(InseminacionBean inseminacionBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("inseminacion.eliminarInseminacion", inseminacionBean);
		return 1;
	}

	@Override
	public InseminacionBean verDetalleInseminacion(InseminacionBean inseminacionBean) {
		InseminacionBean inseminacion = new InseminacionBean();
		inseminacion = (InseminacionBean) getSqlMapClientTemplate().queryForObject("inseminacion.verDetalleInseminacion", inseminacionBean);
		return inseminacion;
	}
	
}