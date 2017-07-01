package pe.com.paxtravel.model.dao.ibatis;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import pe.com.paxtravel.bean.CotizacionBean;
import pe.com.paxtravel.bean.ReservaBean;
import pe.com.paxtravel.bean.ReservaPasajeroDetalleBean;
import pe.com.paxtravel.model.dao.ReservaDAO;

public class SqlMapReservaDAO extends SqlMapClientDaoSupport implements ReservaDAO{
	

	@Override
	public List<ReservaBean> listaReserva(ReservaBean reservaBean) {
		List<ReservaBean> listaReserva = null;
		listaReserva = getSqlMapClientTemplate().queryForList("reserva.listarReserva", reservaBean);
		return listaReserva;
	}

	@Override
	public List<ReservaBean> obtenerCotizacion(ReservaBean reservaBean) {
		List<ReservaBean> listaCotizacion= null;
		listaCotizacion = getSqlMapClientTemplate().queryForList("reserva.obtenerCotizacion", reservaBean);
		return listaCotizacion;
	}
	
	@Override
	public List<ReservaBean> obtenerTicketAereoCotizacion(ReservaBean reservaBean) {
		List<ReservaBean> listaCotizacion= null;
		listaCotizacion = getSqlMapClientTemplate().queryForList("reserva.listarTicketAereoCotizacion", reservaBean);
		return listaCotizacion;
	}
	
	@Override
	public String generarNumeroReserva() {
		String numeroReserva = "";
		numeroReserva = (String) getSqlMapClientTemplate().queryForObject("reserva.obtenerNumeroReserva");
		return numeroReserva;
	}
	
	@Override
	public int registrarReserva(ReservaBean reservaBean) {
		//new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("cotizacion.insertarCotizacion", cotizacionBean);
		System.out.println( "Iniciando Ibatis..." );
		System.out.println( "Id:" + getSqlMapClientTemplate().insert("reserva.insertarReserva", reservaBean) );
		System.out.println( "BeanId: " + reservaBean.getIdReserva());
		return reservaBean.getIdReserva();
	}

	@Override
	public ReservaBean obtenerReserva(ReservaBean reservaBean) {
		return (ReservaBean) getSqlMapClientTemplate().queryForObject("reserva.getReservaResume", reservaBean);
	}

	@Override
	public int actualizarEstadoReserva(ReservaBean reservaBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("reserva.actualizarEstadoReserva", reservaBean);
		return 1;
	}
	
	@Override
	public int registrarReservaPasajero(ReservaPasajeroDetalleBean reservaPasajeroDetalleBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("reserva.insertarReservaPasajero", reservaPasajeroDetalleBean);
		return 1;
	}
	
	@Override
	public List<ReservaBean> listarPaqueteCotizacion(ReservaBean reservaBean) {
		List<ReservaBean> listaCotizacion= null;
		listaCotizacion = getSqlMapClientTemplate().queryForList("reserva.listarPaqueteCotizacion", reservaBean);
		return listaCotizacion;
	}
		

}