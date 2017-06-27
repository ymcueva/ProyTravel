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
		
		System.out.println("*****************************************************************************");
		System.out.println("listarTickets");
		
		List<FareInfoBean> fareInfoList = null;
		List<FareInfoBean> fareInfoDetaList = null;
		
		try {
		
		String[] vuelo = cadenaVuelo.split(",");
        String origen = vuelo[0];
        String destino = vuelo[1];
        String fechaPartida = vuelo[2];
        int idDestino = Integer.parseInt(vuelo[3]);
        
        /* System.out.println("origen? " + origen);
        System.out.println("destino? " + destino);
        System.out.println("fechaPartida? " + fechaPartida);
        System.out.println("idDestino? " + idDestino); */
        
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
		//System.out.println("Output from Server .... \n");
		
		boolean encontro = false;
		
		while ((output = br.readLine()) != null) {
			
			final Gson gson = new Gson();
			final Type listaFareInfo = new TypeToken<List<FareInfoBean>>(){}.getType();
			fareInfoList = gson.fromJson(output, listaFareInfo);
			fareInfoDetaList = new ArrayList<FareInfoBean>();
			
			for ( FareInfoBean item: fareInfoList ) {
				
				/* System.out.println("airlineCode? " + item.getAirlineCode());
				System.out.println("fare? " + item.getFare());
				System.out.println("href? " + item.getHref());
				System.out.println("item? " + item.toString()); */
				
				item.setDestino(destino);
				item.setIdDestino(idDestino);
				
				//consulta los consolidadores y la mayor comision:
				
				System.out.println("codigo Aerolinea");
				System.out.println(item.getAirlineCode());
				System.out.println("id Destino");
				System.out.println(item.getIdDestino());
				
				FareInfoBean fareInfoBean = getConsolidador(item);
				
				if ( fareInfoBean != null ) {
				
					fareInfoBean.getComision();
					fareInfoBean.getNombreProveedor();
					fareInfoBean.getNombreAerolinea();
					fareInfoBean.getIdProveedor();
					fareInfoBean.getIdAerolinea();
					
					System.out.println("fareInfoBean ? getComision " + fareInfoBean.getComision());
					System.out.println("fareInfoBean ? getNombreProveedor " + fareInfoBean.getNombreProveedor());
					System.out.println("fareInfoBean ? getNombreAerolinea " + fareInfoBean.getNombreAerolinea());
					System.out.println("fareInfoBean ? getIdProveedor " + fareInfoBean.getIdProveedor());
					System.out.println("fareInfoBean ? getIdAerolinea " + fareInfoBean.getIdAerolinea());
					
					/* pad.comision,
				    p.nombre as proveedor,
				    a.nombre as aerolinea,
				    p.id_proveedor,
				    a.id_aerolinea  					
					<result property="comision"		    column="comision" />
					<result property="nombreProveedor" 		    column="proveedor" />
					<result property="nombreAerolinea" 		    column="aerolinea" />	
					<result property="idProveedor" 		    column="id_proveedor" />
					<result property="idAerolinea" 		    column="id_aerolinea" /> */
					
					if( fareInfoBean != null ) {						
						item.setComision(fareInfoBean.getComision());
						item.setNombreProveedor(fareInfoBean.getNombreProveedor());
						item.setNombreAerolinea(fareInfoBean.getNombreAerolinea());
						item.setIdProveedor(fareInfoBean.getIdProveedor());
						item.setIdAerolinea(fareInfoBean.getIdAerolinea());
						item.setPrecio(Double.parseDouble(item.getFare()));						
						encontro = true;						
						System.out.println("item comision? " + item.getComision());
						System.out.println("item proveedor? " + item.getNombreProveedor());
						System.out.println("item aerolinea? " + item.getNombreAerolinea());
						System.out.println("fareinfobean toString? " + item.toString());						
					} else {
						item.setComision("");
						item.setNombreProveedor("");
						item.setNombreAerolinea("");
						item.setIdProveedor(0);
						item.setIdAerolinea(0);
						item.setPrecio(0);
						encontro = false;
					}
					
					if( encontro ) {
						fareInfoDetaList.add(item);
						System.out.println("Encontro el consolidador: lista Agregada");
					}
					
				}
				
			}
			
		}
		
		System.out.println("Total Vuelos : " + fareInfoDetaList.size());
		
		}
		catch(Exception e) {
			System.out.println("*****************************************************************************");
			System.out.println("error listarTickets");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		
		return fareInfoDetaList;
		
	}

	@Override
	public OrdenPlanificacionBean minorCostTicket(List<FareInfoBean> listaTickets) {
		
		System.out.println("*****************************************************************************");
		System.out.println("minorCostTicket");
		
		double precioMenor = 0d;		
		OrdenPlanificacionBean ordenPlanificacionBean = null;
		
		System.out.println("cantidad de Vuelos:");
		System.out.println(listaTickets.size());
		
		if( listaTickets.size() > 0 ) {
			//Obtener el que tiene menor precio
			
			precioMenor = Double.parseDouble(listaTickets.get(0).getFare());
			
			ordenPlanificacionBean = new OrdenPlanificacionBean();
			ordenPlanificacionBean.setIdAerolinea(listaTickets.get(0).getIdAerolinea());
			ordenPlanificacionBean.setIdProveedorAerolinea(listaTickets.get(0).getIdProveedor());
			ordenPlanificacionBean.setPrecioAerolinea(precioMenor);
			ordenPlanificacionBean.setNombreAerolinea(listaTickets.get(0).getNombreAerolinea());
			ordenPlanificacionBean.setComision(Integer.parseInt(listaTickets.get(0).getComision()));
			ordenPlanificacionBean.setUrlShop(listaTickets.get(0).getUrl());
			
			for(FareInfoBean info : listaTickets) {
				
				if(Double.parseDouble(info.getFare()) < precioMenor) {
					precioMenor = Double.parseDouble(info.getFare());
					ordenPlanificacionBean.setIdAerolinea(info.getIdAerolinea());
					ordenPlanificacionBean.setIdProveedorAerolinea(info.getIdProveedor());
					ordenPlanificacionBean.setPrecioAerolinea(precioMenor);
					ordenPlanificacionBean.setNombreAerolinea(info.getNombreAerolinea());
					ordenPlanificacionBean.setComision(Integer.parseInt(info.getComision()));
					ordenPlanificacionBean.setUrlShop(info.getUrl());
				}
				
			}
		}
		
		System.out.println("return ordenPlanificacionBean");
		System.out.println("setIdAerolinea?" + ordenPlanificacionBean);
		System.out.println("setIdProveedorAerolinea?" + ordenPlanificacionBean);
		System.out.println("setPrecioAerolinea?" + ordenPlanificacionBean);
		System.out.println("setNombreAerolinea?" + ordenPlanificacionBean);
		System.out.println("setComision?" + ordenPlanificacionBean);
		System.out.println("setUrlShop?" + ordenPlanificacionBean);
		System.out.println("?" + ordenPlanificacionBean);
		
		return ordenPlanificacionBean;
	}
	
	
	@Override
	public CotizacionBean obtenerCotizacion(CotizacionBean cotizacionBean) {
		return cotizacionDAO.obtenerCotizacion(cotizacionBean);
	}
	
	@Override
	public PaqueteResumeBean obtenerPaquete(PaqueteResumeBean paqueteResumeBean) {
		return cotizacionDAO.obtenerPaquete(paqueteResumeBean);
	}
	
	@Override
	public List<PaqueteResumeBean> listarPaqueteDetail(PaqueteResumeBean p) {
		List<PaqueteResumeBean> listaPaquete = new ArrayList<PaqueteResumeBean>();
		listaPaquete = cotizacionDAO.listarPaqueteDetail(p);
		return listaPaquete;
	}
	
	@Override
	public int registrarExpedienteLog(ExpedienteLogBean expedienteLogBean) {
		return cotizacionDAO.registrarExpedienteLog(expedienteLogBean);
	}
	
	@Override
	public List<CotizacionDetalleBean> listarDestinosDetail(CotizacionDetalleBean cotizacionDetalleBean) {
		return cotizacionDAO.listarDestinosDetail(cotizacionDetalleBean);
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
