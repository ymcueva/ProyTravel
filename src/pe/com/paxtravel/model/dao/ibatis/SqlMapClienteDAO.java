package pe.com.paxtravel.model.dao.ibatis;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import pe.com.paxtravel.bean.ClienteBean;
import pe.com.paxtravel.model.dao.ClienteDAO;

public class SqlMapClienteDAO extends SqlMapClientDaoSupport implements ClienteDAO{
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ClienteBean> listaCliente(ClienteBean clienteBean){
		List<ClienteBean> lista = null;
		lista = getSqlMapClientTemplate().queryForList("cliente.listarCliente", clienteBean);
		return lista;
	}

	@Override
	public ClienteBean obtenerCliente(int idCliente) {
		return (ClienteBean) getSqlMapClientTemplate().queryForObject(
				"cliente.obtenerCliente", idCliente);
	}

//	private static class CiudadMapper implements
//			ParameterizedRowMapper<CiudadBean> {
//
//		public CiudadBean mapRow(ResultSet rs, int rowNum) throws SQLException {
//			CiudadBean ciudad = new CiudadBean();
//
//			ciudad.setIdCiudad(rs.getInt(""))
//			
//			pers.setIdPersona(rs.getInt("idPersona"));
//			pers.setIdUsers(rs.getInt("idUsers"));
//			pers.setNombre(rs.getString("nombre"));
//			pers.setApellidos(rs.getString("apellidos"));
//			pers.setNacimiento(rs.getString("nacimiento"));
//			pers.setLocalidad(rs.getString("localidad"));
//			pers.setDireccion(rs.getString("direccion"));
//			pers.setEmail(rs.getString("email"));
//			pers.setCp(rs.getInt("cp"));
//
//			return pers;
//		}
//
//	}

}
