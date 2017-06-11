package pe.com.paxtravel.service;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.apache.commons.collections.CollectionUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pe.com.paxtravel.bean.CiudadBean;
import pe.com.paxtravel.bean.ClienteBean;
import pe.com.paxtravel.bean.CotizacionBean;
import pe.com.paxtravel.bean.CotizacionDetalleBean;
import pe.com.paxtravel.bean.CotizacionDetalleTicketVueloBean;
import pe.com.paxtravel.bean.EmpleadoBean;
import pe.com.paxtravel.bean.FareInfoBean;
import pe.com.paxtravel.bean.HotelHabitacionBean;
import pe.com.paxtravel.bean.MotivoViajeBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.ProduccionBean;
import pe.com.paxtravel.bean.ServicioAdicionalBean;
import pe.com.paxtravel.model.dao.CotizacionDAO;
import pe.com.paxtravel.model.dao.EmpleadoDAO;
import pe.com.paxtravel.tree.data.PaqueteManagerBean;
import pe.com.paxtravel.util.ExcelUtil;

@Service
public class CotizacionServiceImpl implements CotizacionService {

	private CotizacionDAO cotizacionDAO;
	
	public CotizacionDAO getCotizacionDAO() {
		return cotizacionDAO;
	}

	public void setCotizacionDAO(CotizacionDAO cotizacionDAO) {
		this.cotizacionDAO = cotizacionDAO;
	}

	@Override
	public List<CotizacionBean> listarCotizacion(CotizacionBean cotizacionBean) {
		List<CotizacionBean> listaCotizacion = new ArrayList<CotizacionBean>();
		listaCotizacion = cotizacionDAO.listaCotizacion(cotizacionBean);
		return listaCotizacion;
	}

	@Override
	public String generarNumeroCotizacion() {
		return cotizacionDAO.generarNumeroCotizacion();
	}
	
	@Override
	public List<CiudadBean> listarCiudad(CiudadBean ciudadBean) {
		List<CiudadBean> listaCiudad = new ArrayList<CiudadBean>();
		listaCiudad = cotizacionDAO.listaCiudad(ciudadBean);
		return listaCiudad;
	}

	@Override
	public List<PaisBean> listarPais(PaisBean paisBean) {
		List<PaisBean> listaPais = new ArrayList<PaisBean>();
		listaPais = cotizacionDAO.listaPais(paisBean);
		return listaPais;
	}
	
	@Override
	public int registrarCotizacion(CotizacionBean cotizacionBean) {
		return cotizacionDAO.registrarCotizacion(cotizacionBean);
	}
	
	@Override
	public int registrarMotivo(MotivoViajeBean motivoViajeBean) {
		return cotizacionDAO.registrarMotivo(motivoViajeBean);
	}
	
	@Override
	public int registrarHabitacion(HotelHabitacionBean hotelHabitacionBean) {
		return cotizacionDAO.registrarHabitacion(hotelHabitacionBean);
	}

	@Override
	public int registrarServicio(ServicioAdicionalBean servicioAdicionalBean) {
		return cotizacionDAO.registrarServicio(servicioAdicionalBean);
	}
	
	@Override
	public int registrarCotizacionTicket(CotizacionBean cotizacionBean) {
		return cotizacionDAO.registrarCotizacionTicket(cotizacionBean);
	}
	
	@Override
	public int registrarCotizacionDetalleTicket(CotizacionDetalleBean cotizacionDetalleBean) {
		return cotizacionDAO.registrarCotizacionDetalleTicket(cotizacionDetalleBean);
	}
	
	@Override
	public List<ClienteBean> obtenerNombreCliente(ClienteBean clienteBean) {
		List<ClienteBean> cliente = new ArrayList<ClienteBean>();
		cliente = cotizacionDAO.obtenerNombreCliente(clienteBean);
		return cliente;
	}
	
	
	@Override
	public FareInfoBean getConsolidador(FareInfoBean fareInfoBean) {
		FareInfoBean o = new FareInfoBean();
		o = cotizacionDAO.getConsolidador(fareInfoBean);
		return o;
	}
	
	@Override
	public int registrarConsolidador(CotizacionDetalleTicketVueloBean fareInfoBean){
		return cotizacionDAO.registrarConsolidador(fareInfoBean); 
	}
	
	@Override
	public List<PaqueteManagerBean> listarPaquete(PaqueteManagerBean p){		
		List<PaqueteManagerBean> listaPaquete = new ArrayList<PaqueteManagerBean>();
		listaPaquete = cotizacionDAO.listarPaquete(p);
		return listaPaquete;
	}
		
	@Override
	public List<PaqueteManagerBean> listarPaqueteDestino(PaqueteManagerBean p){
		List<PaqueteManagerBean> listaPaquete = new ArrayList<PaqueteManagerBean>();
		listaPaquete = cotizacionDAO.listarPaqueteDestino(p);
		return listaPaquete;
	}
	
	
//	@Override
//	public void exportarExcel(List<EmpleadoBean> lista, OutputStream outputStream) throws Exception {
//		
//		ExcelUtil excel = new ExcelUtil();
//		
//		List<String> header = new ArrayList<String>();
//		
//		header.add("Usuario");
//		header.add("Nombre");
//		header.add("Paterno");
//		header.add("Materno");
//		header.add("Fecha Nacimiento");
//		excel.xlsInitLibro("Lista-empleados");
//		
//		//estilos para la hoja de excel
//		HSSFCellStyle _styleCenter = excel.getStyleNegritaCenter();
//		HSSFCellStyle _styleBloque = excel.getStyleBloque();
//		
//		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
//		
//		excel.xlsBloque(header, null, 4);
//		int k = 0;
//		if (CollectionUtils.isNotEmpty(lista)) {
//
//			//columna
//			
//			EmpleadoBean item = null;
//
//			for (int i = 0; i < lista.size(); i++) {
//
//				item = lista.get(i);
//
//				// crear nueva fila
//				excel.xlsRow();
//
//				// crear celdas en la columna k
//				k = 1;
//
//				// Nombre del Extranjero
//				excel.xlsCell(k++, item.getUsername());
//
//				// Apellido Paterno
//				excel.xlsCell(k++, item.getNombre());
//
//				// Apellido Materno
//				excel.xlsCell(k++, item.getPaterno());
//
//				// Nacionalidad
//				excel.xlsCell(k++, item.getMaterno());
//
//				// Fecha
//				excel.xlsCell(k++, item.getFechaNacimiento(), _styleCenter);
//
//			}
//			
//		} else {
//			excel.xlsRow();
//			k = 1;
//			excel.xlsCell(k++, "No se encontraron resultados para la b\u00FAsqueda", _styleBloque);
//			excel.xlsRow();
//			excel.xlsRow();
//			excel.xlsRow();
//		}
//		
//		excel.xlsGetWbLibro().write(outputStream);
//			
//	}
	
}
