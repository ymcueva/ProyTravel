package pe.com.paxtravel.model.dao.ibatis;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import pe.com.paxtravel.bean.UsuarioBean;
import pe.com.paxtravel.model.dao.LoginDAO;

public class SqlMapLoginDAO extends SqlMapClientDaoSupport implements LoginDAO{

	@Override
	public UsuarioBean obtenerLogin(UsuarioBean usuarioBean) {
		return (UsuarioBean) getSqlMapClientTemplate().queryForObject("usuario.obtenerLogin", usuarioBean);
	}
	
}