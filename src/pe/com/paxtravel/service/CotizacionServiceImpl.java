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
	public List<CotizacionServicioBean> listarCotizacionServicio(CotizacionServicioBean cotizacionServicioBean){
		List<CotizacionServicioBean> lista = new ArrayList<CotizacionServicioBean>();
		lista = cotizacionDAO.listarCotizacionServicio(cotizacionServicioBean);
		return lista;
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
	public int actualizarCotizacion(CotizacionBean cotizacionBean){
		return cotizacionDAO.actualizarCotizacion(cotizacionBean);
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
	
	@Override
	public List<FareInfoBean> listarTickets(String cadenaVuelo){
		
		List<FareInfoBean> fareInfoList = null;
		List<FareInfoBean> fareInfoDetaList = null;
		
		
		try {
		
		String[] vuelo = cadenaVuelo.split("-");
        String origen = vuelo[0];
        String destino = vuelo[1];
        String fechaPartida = vuelo[2];
        
        System.out.println("origen? " + origen);
        System.out.println("destino? " + destino);
        System.out.println("fechaPartida? " + fechaPartida);
        
        URL url = new URL("http://api.decom.pe/public/reserveAir/search");
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setDoOutput(true);
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-Type", "application/json");
		
		String input = "{\"origin\":\"" + origen + "\",\"destination\":\"" + destino + "\",\"date\":\"" + fechaPartida + "\"}";
		OutputStream os = conn.getOutputStream();
		os.write(input.getBytes());
		os.flush();
		
		if (conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
			throw new RuntimeException("Failed : HTTP error code : "
				+ conn.getResponseCode());
		}

		BufferedReader br = new BufferedReader(new InputStreamReader(
				(conn.getInputStream())));
		
		String output;
		System.out.println("Output from Server .... \n");
		
		boolean encontro = false;
		while ((output = br.readLine()) != null) {
			final Gson gson = new Gson();
			final Type listaFareInfo = new TypeToken<List<FareInfoBean>>(){}.getType();
			fareInfoList = gson.fromJson(output, listaFareInfo);
			fareInfoDetaList = new ArrayList<FareInfoBean>();
			
			for ( FareInfoBean item: fareInfoList ) {
				System.out.println("airlineCode? " + item.getAirlineCode());
				System.out.println("fare? " + item.getFare());
				System.out.println("href? " + item.getHref());
				System.out.println("item? " + item.toString());
				item.setDestino(destino);
				
				//consulta los consolidadores y la mayor comision:
				
				FareInfoBean o = getConsolidador(item);
				
				if(o != null){
					item.setComision(o.getComision());
					item.setNombreProveedor(o.getNombreProveedor());
					item.setNombreAerolinea(o.getNombreAerolinea());
					item.setIdProveedor(o.getIdProveedor());
					item.setIdAerolinea(o.getIdAerolinea());
					item.setPrecio(Double.parseDouble(item.getFare()));
					encontro = true;
				}
				else {
					item.setComision("");
					item.setNombreProveedor("");
					item.setNombreAerolinea("");
					item.setIdProveedor(0);
					item.setIdAerolinea(0);
					item.setPrecio(0);
					encontro = false;
				}
				
				
				System.out.println("item comision? " + item.getComision());
				System.out.println("item proveedor? " + item.getNombreProveedor());
				System.out.println("item aerolinea? " + item.getNombreAerolinea());
				
				
				System.out.println("fareinfobean toString? " + item.toString());
				
				if(encontro == true)
					fareInfoDetaList.add(item);
				
				System.out.println("Lista Agregada");
				
			}
			
		}
		
		System.out.println("Total Vuelos : " + fareInfoDetaList.size());
		
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		return fareInfoDetaList;
		
	}

	@Override
	public CotizacionBean cotizacion(CotizacionBean cotizacionBean) {
		return cotizacionDAO.cotizacion(cotizacionBean);
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
