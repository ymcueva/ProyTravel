package pe.com.paxtravel.model.dao.ibatis;

import java.util.ArrayList;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import pe.com.paxtravel.bean.CiudadBean;
import pe.com.paxtravel.bean.ClienteBean;
import pe.com.paxtravel.bean.CotizacionBean;
import pe.com.paxtravel.bean.CotizacionDetalleBean;
import pe.com.paxtravel.bean.CotizacionDetalleTicketVueloBean;
import pe.com.paxtravel.bean.CotizacionServicioBean;
import pe.com.paxtravel.bean.EmpleadoBean;
import pe.com.paxtravel.bean.FareInfoBean;
import pe.com.paxtravel.bean.HotelHabitacionBean;
import pe.com.paxtravel.bean.InseminacionBean;
import pe.com.paxtravel.bean.MotivoViajeBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.PaqueteResumeBean;
import pe.com.paxtravel.bean.ProduccionBean;
import pe.com.paxtravel.bean.ServicioAdicionalBean;
import pe.com.paxtravel.model.dao.CotizacionDAO;
import pe.com.paxtravel.model.dao.EmpleadoDAO;
import pe.com.paxtravel.tree.data.PaqueteManagerBean;

public class SqlMapCotizacionDAO extends SqlMapClientDaoSupport implements CotizacionDAO{
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CotizacionBean> listaCotizacion(CotizacionBean cotizacionBean){
		List<CotizacionBean> listaCotizacion = null;
		listaCotizacion = getSqlMapClientTemplate().queryForList("cotizacion.listarCotizacion", cotizacionBean);
		return listaCotizacion;
	}

	@Override
	public String generarNumeroCotizacion() {
		String numeroCotizacion = "";
		numeroCotizacion = (String) getSqlMapClientTemplate().queryForObject("cotizacion.obtenerNumeroCotizacion");
		return numeroCotizacion;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CiudadBean> listaCiudad(CiudadBean ciudadBean){
		List<CiudadBean> listaCiudad = null;
		listaCiudad = getSqlMapClientTemplate().queryForList("cotizacion.listarCiudad", ciudadBean);
		return listaCiudad;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PaisBean> listaPais(PaisBean paisBean){
		List<PaisBean> listaPais = null;
		listaPais = getSqlMapClientTemplate().queryForList("cotizacion.listarPais", paisBean);
		return listaPais;
	}
	
	
	
	@Override
	public int registrarCotizacion(CotizacionBean cotizacionBean) {
		//new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("cotizacion.insertarCotizacion", cotizacionBean);
		System.out.println( "Iniciando Ibatis..." );
		System.out.println( "Id:" + getSqlMapClientTemplate().insert("cotizacion.insertarCotizacion", cotizacionBean) );
		System.out.println( "BeanId: " + cotizacionBean.getIdCotizacion());
		return cotizacionBean.getIdCotizacion();
	}
	
	@Override
	public int registrarMotivo(MotivoViajeBean motivoViajeBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("cotizacion.insertarMotivoViaje", motivoViajeBean);
		return 1;
	}
	
	@Override
	public int registrarHabitacion(HotelHabitacionBean hotelHabitacionBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("cotizacion.insertarHabitacionHotel", hotelHabitacionBean);
		return 1;
	}

	@Override
	public int registrarServicio(ServicioAdicionalBean servicioAdicionalBean){
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("cotizacion.insertarServicioAdicional", servicioAdicionalBean);
		return 1;
	}

	@Override
	public int registrarCotizacionTicket(CotizacionBean cotizacionBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("cotizacion.insertarCotizacionTicket", cotizacionBean);
		return 1;
	}

	@Override
	public int registrarCotizacionDetalleTicket(CotizacionDetalleBean cotizacionDetalleBean){
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("cotizacion.insertarCotizacionDetalleTicket", cotizacionDetalleBean);
		return 1;
	}
//

	@SuppressWarnings("unchecked")
	@Override
	public List<ClienteBean> obtenerNombreCliente(ClienteBean clienteBean){
		List<ClienteBean> cliente = new ArrayList<ClienteBean>();
		cliente = getSqlMapClientTemplate().queryForList("cotizacion.obtenerNombreCliente", clienteBean);
		return cliente;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CotizacionServicioBean> listarCotizacionServicio(CotizacionServicioBean cotizacionServicioBean) {
		List<CotizacionServicioBean> lista = null;
		lista = getSqlMapClientTemplate().queryForList("cotizacion.listarCotizacionServicio", cotizacionServicioBean);
		return lista;
	}
	
	@Override
	public FareInfoBean getConsolidador(FareInfoBean fareInfoBean) {		
		return (FareInfoBean) getSqlMapClientTemplate().queryForObject("cotizacion.getConsolidador", fareInfoBean);		
	}
	
	@Override
	public int registrarConsolidador(CotizacionDetalleTicketVueloBean fareInfoBean){
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("cotizacion.insertarCotizacionDetalleTicketVueloTab2", fareInfoBean);
		return 1;
	}
	
	@Override
	public int actualizarCotizacion(CotizacionBean cotizacionBean){
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("cotizacion.actualizarEstadoCotizacion", cotizacionBean);
		return 1;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PaqueteManagerBean> listarPaquete(PaqueteManagerBean p){
		List<PaqueteManagerBean> listaPaquete = null;
		listaPaquete = getSqlMapClientTemplate().queryForList("cotizacion.listarPaquete", p);
		return listaPaquete;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PaqueteManagerBean> listarPaqueteDestino(PaqueteManagerBean p){
		List<PaqueteManagerBean> listaPaqueteDestino = null;
		listaPaqueteDestino = getSqlMapClientTemplate().queryForList("cotizacion.listarPaqueteDestinos", p);
		return listaPaqueteDestino;
	}

	@Override
	public CotizacionBean obtenerCotizacion(CotizacionBean cotizacionBean) {
		return (CotizacionBean) getSqlMapClientTemplate().queryForObject("cotizacion.getCotizacionResume", cotizacionBean);
	}
	
	@Override
	public PaqueteResumeBean obtenerPaquete(PaqueteResumeBean paquete) {
		return (PaqueteResumeBean) getSqlMapClientTemplate().queryForObject("cotizacion.getPaqueteResume", paquete);
	}
	
}