package pe.com.paxtravel.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;


import org.apache.commons.collections.CollectionUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import pe.com.paxtravel.bean.CiudadBean;
import pe.com.paxtravel.bean.ClienteBean;
import pe.com.paxtravel.bean.CotizacionBean;
import pe.com.paxtravel.bean.CotizacionDetalleBean;
import pe.com.paxtravel.bean.CotizacionDetalleTicketVueloBean;
import pe.com.paxtravel.bean.CotizacionServicioBean;
import pe.com.paxtravel.bean.EmpleadoBean;
import pe.com.paxtravel.bean.ExpedienteLogBean;
import pe.com.paxtravel.bean.FareInfoBean;
import pe.com.paxtravel.bean.HotelHabitacionBean;
import pe.com.paxtravel.bean.MotivoViajeBean;
import pe.com.paxtravel.bean.OrdenPlanificacionBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.PaqueteResumeBean;
import pe.com.paxtravel.bean.ProduccionBean;
import pe.com.paxtravel.bean.ReservaBean;
import pe.com.paxtravel.bean.ReservaPasajeroDetalleBean;
import pe.com.paxtravel.bean.ServicioAdicionalBean;
import pe.com.paxtravel.model.dao.CotizacionDAO;
import pe.com.paxtravel.model.dao.EmpleadoDAO;
import pe.com.paxtravel.model.dao.ReservaDAO;
import pe.com.paxtravel.tree.data.PaqueteManagerBean;
import pe.com.paxtravel.util.ExcelUtil;

@Service
public class ReservaServiceImpl implements ReservaService {

	private ReservaDAO reservaDAO;
	
	public ReservaDAO getReservaDAO() {
		return reservaDAO;
	}

	public void setReservaDAO(ReservaDAO reservaDAO) {
		this.reservaDAO = reservaDAO;
	}

	@Override
	public List<ReservaBean> listarReserva(ReservaBean reservaBean) {
		List<ReservaBean> listaReserva = new ArrayList<ReservaBean>();
		listaReserva = reservaDAO.listaReserva(reservaBean);
		return listaReserva;
	}

	@Override
	public List<ReservaBean> obtenerCotizacion(ReservaBean reservaBean) {
		List<ReservaBean> listaReserva = new ArrayList<ReservaBean>();
		listaReserva = reservaDAO.obtenerCotizacion(reservaBean);
		return listaReserva;
	}

	@Override
	public List<ReservaBean> obtenerTicketAereoCotizacion(
			ReservaBean reservaBean) {
		List<ReservaBean> listaReserva = new ArrayList<ReservaBean>();
		listaReserva = reservaDAO.obtenerTicketAereoCotizacion(reservaBean);
		return listaReserva;
	}
	
	@Override
	public String generarNumeroReserva() {
		return reservaDAO.generarNumeroReserva();
	}
	
	@Override
	public int registrarReserva(ReservaBean reservaBean) {
		return reservaDAO.registrarReserva(reservaBean);
	}

	@Override
	public ReservaBean obtenerReserva(ReservaBean reservaBean) {
		return reservaDAO.obtenerReserva(reservaBean);
	}

	@Override
	public int actualizarEstadoReserva(ReservaBean reservaBean) {
		return reservaDAO.actualizarEstadoReserva(reservaBean);
	}

	@Override
	public int registrarReservaPasajero(
			ReservaPasajeroDetalleBean reservaPasajeroDetalleBean) {
		return reservaDAO.registrarReservaPasajero(reservaPasajeroDetalleBean);
	}

	@Override
	public List<ReservaBean> listarPaqueteCotizacion(ReservaBean reservaBean) {
		List<ReservaBean> listaPaqueteCotizacion = new ArrayList<ReservaBean>();
		listaPaqueteCotizacion = reservaDAO.listarPaqueteCotizacion(reservaBean);
		return listaPaqueteCotizacion;
	}
	
}
