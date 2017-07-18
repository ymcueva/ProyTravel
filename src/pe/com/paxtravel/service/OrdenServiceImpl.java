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
import pe.com.paxtravel.bean.OrdenBean;
import pe.com.paxtravel.bean.OrdenPlanificacionBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.PaqueteResumeBean;
import pe.com.paxtravel.bean.ProduccionBean;
import pe.com.paxtravel.bean.ReservaBean;
import pe.com.paxtravel.bean.ReservaPasajeroDetalleBean;
import pe.com.paxtravel.bean.ServicioAdicionalBean;
import pe.com.paxtravel.model.dao.CotizacionDAO;
import pe.com.paxtravel.model.dao.EmpleadoDAO;
import pe.com.paxtravel.model.dao.OrdenDAO;
import pe.com.paxtravel.model.dao.ReservaDAO;
import pe.com.paxtravel.tree.data.PaqueteManagerBean;
import pe.com.paxtravel.util.ExcelUtil;

@Service
public class OrdenServiceImpl implements OrdenService {

	private OrdenDAO ordenDAO;

	public OrdenDAO getOrdenDAO() {
		return ordenDAO;
	}
	
	public void setOrdenDAO(OrdenDAO ordenDAO) {
		this.ordenDAO = ordenDAO;
	}

	@Override
	public List<OrdenBean> listarOrden(OrdenBean ordenBean) {
		List<OrdenBean> listaOrden = new ArrayList<OrdenBean>();
		listaOrden = ordenDAO.listaOrden(ordenBean);
		return listaOrden;
	}

	@Override
	public String generarNumeroOrden() {
		return ordenDAO.generarNumeroOrden();
	}

	@Override
	public int registrarOrden(OrdenBean ordenBean) {
		return ordenDAO.registrarOrden(ordenBean);
	}
	
	@Override
	public int registrarDestino(OrdenBean ordenBean) {
		return ordenDAO.registrarDestino(ordenBean);
	}
	
	@Override
	public int registrarServicio(OrdenBean ordenBean) {
		return ordenDAO.registrarServicio(ordenBean);
	}
	
	@Override
	public int registrarMotivo(OrdenBean ordenBean) {
		return ordenDAO.registrarMotivo(ordenBean);
	}

	@Override
	public OrdenBean obtenerOrdenDetalle(OrdenBean ordenBean) {
		return ordenDAO.obtenerOrdenDetalle(ordenBean);
	}

	@Override
	public List<OrdenBean> listarMotivoViajeDetalle(OrdenBean ordenBean) {
		return ordenDAO.listarMotivoViajeDetalle(ordenBean);
	}

	@Override
	public List<OrdenBean> listarServicioDetalle(OrdenBean ordenBean) {
		return ordenDAO.listarServicioDetalle(ordenBean);
	}
	
}
