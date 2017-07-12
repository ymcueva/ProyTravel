package pe.com.paxtravel.model.dao.ibatis;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import pe.com.paxtravel.bean.EmpleadoBean;
import pe.com.paxtravel.bean.ProduccionBean;
import pe.com.paxtravel.model.dao.EmpleadoDAO;

public class SqlMapEmpleadoDAO extends SqlMapClientDaoSupport implements EmpleadoDAO{
	
	@SuppressWarnings("unchecked")
	@Override
	public List<EmpleadoBean> listaEmpleado(EmpleadoBean empleadoBean){
		List<EmpleadoBean> listaEmpleado = null;
		listaEmpleado = getSqlMapClientTemplate().queryForList("empleado.listarEmpleado", empleadoBean);
		return listaEmpleado;
	}

	@Override
	public String generarCodigoEmpleado() {
		String codigoEmpleado = "";
		codigoEmpleado = (String) getSqlMapClientTemplate().queryForObject("empleado.obtenerCodigoEmpleado");
		return codigoEmpleado;
	}
	
	@Override
	public int registrarEmpleado(EmpleadoBean empleadoBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("empleado.insertarEmpleado", empleadoBean);
		return 1;
	}

}