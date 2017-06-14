package pe.com.paxtravel.model.dao.ibatis;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import pe.com.paxtravel.bean.CotizacionBean;
import pe.com.paxtravel.bean.HotelBean;
import pe.com.paxtravel.bean.HotelHabitacionBean;
import pe.com.paxtravel.bean.PaqueteTuristicoBean;
import pe.com.paxtravel.bean.PaqueteTuristicoDestinoBean;
import pe.com.paxtravel.bean.PaqueteTuristicoDestinoHotelBean;
import pe.com.paxtravel.bean.PaqueteTuristicoDestinoTourBean;
import pe.com.paxtravel.bean.PaqueteTuristicoTicketBean;
import pe.com.paxtravel.bean.TourBean;
import pe.com.paxtravel.model.dao.PaqueteTuristicoDAO;

public class SqlMapPaqueteTuristicoDAO extends SqlMapClientDaoSupport implements PaqueteTuristicoDAO {

	
	@SuppressWarnings("unchecked")
	@Override
	public List<PaqueteTuristicoBean> listaPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean) {
		List<PaqueteTuristicoBean> listaPaquete = null;
		listaPaquete = getSqlMapClientTemplate().queryForList("paqueteturistico.listarPaqueteTuristico", paqueteTuristicoBean);
		return listaPaquete;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PaqueteTuristicoBean> obtenerPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean){
		List<PaqueteTuristicoBean> listaPaquete = null;
		listaPaquete = getSqlMapClientTemplate().queryForList("paqueteturistico.obtenerPaqueteTuristico", paqueteTuristicoBean);
		return listaPaquete;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<TourBean> listaTour(TourBean tourBean) {
		List<TourBean> listaTour = null;
		listaTour = getSqlMapClientTemplate().queryForList("paqueteturistico.listarTour", tourBean);
		return listaTour;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<TourBean> listaTourBusqueda(TourBean tourBean) {
		List<TourBean> listaTour = null;
		listaTour = getSqlMapClientTemplate().queryForList("paqueteturistico.listarTourBusqueda", tourBean);
		return listaTour;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<HotelBean> listaHotel(HotelBean hotelBean) {
		List<HotelBean> listaHotel = null;
		listaHotel = getSqlMapClientTemplate().queryForList("paqueteturistico.listarHoteles", hotelBean);
		return listaHotel;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<HotelHabitacionBean> listaTipoHabitacion(HotelHabitacionBean hotelHabitacionBean)
	{
		List<HotelHabitacionBean> listaHotelHabitacion = null;
		listaHotelHabitacion = getSqlMapClientTemplate().queryForList("paqueteturistico.listarTipoHabitacion", hotelHabitacionBean);
		return listaHotelHabitacion;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<HotelHabitacionBean> obtenerHotelBusqueda(HotelHabitacionBean hotelHabitacionBean){
		List<HotelHabitacionBean> listaHotelHabitacion = null;
		listaHotelHabitacion = getSqlMapClientTemplate().queryForList("paqueteturistico.obtenerHotelBusqueda", hotelHabitacionBean);
		return listaHotelHabitacion;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<HotelHabitacionBean> listarDetalleHotelBusqueda(HotelHabitacionBean hotelHabitacionBean){
		List<HotelHabitacionBean> listaHotelHabitacion = null;
		listaHotelHabitacion = getSqlMapClientTemplate().queryForList("paqueteturistico.listarDetalleHotelBusqueda", hotelHabitacionBean);
		return listaHotelHabitacion;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<HotelHabitacionBean> obtenerTipoHabitacion(HotelHabitacionBean hotelHabitacionBean)
	{
		List<HotelHabitacionBean> listaHotelHabitacion = null;
		listaHotelHabitacion = getSqlMapClientTemplate().queryForList("paqueteturistico.obtenerDatosTipoHabitacion", hotelHabitacionBean);
		return listaHotelHabitacion;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PaqueteTuristicoDestinoHotelBean> obtenerDetalleHotelPaquete(PaqueteTuristicoDestinoHotelBean paqueteTuristicoDestinoHotelBean){
		List<PaqueteTuristicoDestinoHotelBean> lista = null;
		lista = getSqlMapClientTemplate().queryForList("paqueteturistico.listarDetalleHotel", paqueteTuristicoDestinoHotelBean);
		return lista;
	}

	
	@Override
	public int GrabarPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean) {
		//new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).insert("paqueteturistico.insertarPaqueteTuristico", paqueteTuristicoBean);
		getSqlMapClientTemplate().insert("paqueteturistico.insertarPaqueteTuristico", paqueteTuristicoBean);
		return paqueteTuristicoBean.getIdPaquete();
	}
	
	@Override
	public int RegistrarPaqueteTuristicoDestino(PaqueteTuristicoDestinoBean paqueteTuristicoDestinoBean){
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).insert("paqueteturistico.insertarPaqueteTuristicoDestino", paqueteTuristicoDestinoBean);
		return 1;
	}
	
	@Override
	public int actualizaPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean){
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("paqueteturistico.actualizaPaqueteTuristico", paqueteTuristicoBean);
		return 1;
	}
	
	@Override
	public int RegistrarPaqueteTuristicoDestinoTour(PaqueteTuristicoDestinoTourBean paqueteTuristicoDestinoTourBean){
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).insert("paqueteturistico.insertarPaqueteTuristicoDestinoTour", paqueteTuristicoDestinoTourBean);
		return 1;
	}
	
	@Override
	public int eliminaDestinoPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean){
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).delete("paqueteturistico.eliminaPaqueteDestino", paqueteTuristicoBean);
		
		return 1;
		
	}
	
	@Override
	public int eliminaDestinoHotelPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean){
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).delete("paqueteturistico.eliminaPaqueteDestinoHotel", paqueteTuristicoBean);
		
		return 1;
		
	}
	
	@Override
	public int eliminaDestinoTourPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean){
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).delete("paqueteturistico.eliminaPaqueteDestinoTour", paqueteTuristicoBean);
		
		return 1;
		
	}
	
	@Override
	public int eliminaDestinoTicketPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean){
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).delete("paqueteturistico.eliminaPaqueteDestinoTicket", paqueteTuristicoBean);
		
		return 1;
		
	}
	
	@Override
	public int RegistrarPaqueteTuristicoTicket(PaqueteTuristicoTicketBean paqueteTuristicoTicketBean){
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).insert("paqueteturistico.insertarPaqueteTuristicoTicket", paqueteTuristicoTicketBean);
		return 1;
	}
	
	@Override
	public int RegistrarPaqueteTuristicoDestinoHotel(PaqueteTuristicoDestinoHotelBean paqueteTuristicoDestinoHotelBean){
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).insert("paqueteturistico.insertarPaqueteTuristicoDestinoHotel", paqueteTuristicoDestinoHotelBean);
		return 1;
	}
	
	
	public String obtenerCodigoPaqTuristico() {
		String codigo = (String)getSqlMapClientTemplate().queryForObject("paqueteturistico.obtenerCodigoInseminacion");
		return codigo;
	}

	
	

}
