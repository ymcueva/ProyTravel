package pe.com.paxtravel.model.dao.ibatis;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import pe.com.paxtravel.bean.CotizacionBean;
import pe.com.paxtravel.bean.OrdenBean;
import pe.com.paxtravel.bean.ReservaBean;
import pe.com.paxtravel.bean.ReservaPasajeroDetalleBean;
import pe.com.paxtravel.model.dao.OrdenDAO;
import pe.com.paxtravel.model.dao.ReservaDAO;

public class SqlMapOrdenDAO extends SqlMapClientDaoSupport implements OrdenDAO{
	
	@Override
	public List<OrdenBean> listaOrden(OrdenBean ordenBean) {
		List<OrdenBean> listaOrden = null;
		listaOrden = getSqlMapClientTemplate().queryForList("orden.obtenerOrden", ordenBean);
		return listaOrden;
	}

	@Override
	public String generarNumeroOrden() {
		String numeroOrden = "";
		numeroOrden = (String) getSqlMapClientTemplate().queryForObject("orden.obtenerNumeroOrden");
		return numeroOrden;
	}
	
	@Override
	public int registrarOrden(OrdenBean ordenBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).insert("orden.insertarOrden", ordenBean);
		return ordenBean.getIdOrden();
	}
	
	@Override
	public int registrarDestino(OrdenBean ordenBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).insert("orden.insertarDestino", ordenBean);
		return ordenBean.getIdOrden();
	}
	
	@Override
	public int registrarServicio(OrdenBean ordenBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).insert("orden.insertarServicio", ordenBean);
		return ordenBean.getIdOrden();
	}
	
	@Override
	public int registrarMotivo(OrdenBean ordenBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).insert("orden.insertarMotivo", ordenBean);
		return ordenBean.getIdOrden();
	}
	

}