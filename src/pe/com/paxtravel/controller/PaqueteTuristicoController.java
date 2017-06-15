package pe.com.paxtravel.controller;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//import pe.gob.sunat.framework.uti

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import org.apache.commons.beanutils.BeanUtils;
import net.sf.sojo.interchange.json.JsonSerializer;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.method.annotation.ExceptionHandlerMethodResolver;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import pe.com.paxtravel.bean.AnimalBean;
import pe.com.paxtravel.bean.CiudadBean;
import pe.com.paxtravel.bean.CotizacionBean;
import pe.com.paxtravel.bean.CotizacionServicioBean;
import pe.com.paxtravel.bean.EmpleadoBean;
import pe.com.paxtravel.bean.FareInfoBean;
import pe.com.paxtravel.bean.HotelBean;
import pe.com.paxtravel.bean.HotelHabitacionBean;
import pe.com.paxtravel.bean.InseminacionBean;
import pe.com.paxtravel.bean.OrdenPlanificacionBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.PaqueteTuristicoBean;
import pe.com.paxtravel.bean.PaqueteTuristicoDestinoBean;
import pe.com.paxtravel.bean.PaqueteTuristicoDestinoHotelBean;
import pe.com.paxtravel.bean.PaqueteTuristicoDestinoTourBean;
import pe.com.paxtravel.bean.PaqueteTuristicoTicketBean;
import pe.com.paxtravel.bean.ProduccionBean;
import pe.com.paxtravel.bean.TourBean;
import pe.com.paxtravel.service.AnimalService;
import pe.com.paxtravel.service.CotizacionService;
import pe.com.paxtravel.service.EmpleadoService;
import pe.com.paxtravel.service.InseminacionService;
import pe.com.paxtravel.service.OrdenPlanificacionService;
import pe.com.paxtravel.service.PaqueteTuristicoService;
//import pe.com.paxtravel.service.ProduccionService;
import pe.com.paxtravel.util.ControllerUtil;
import pe.com.paxtravel.util.DataJsonBean;
import pe.com.paxtravel.util.Utils;
import pe.gob.sunat.framework.spring.util.conversion.SojoUtil;

@Controller
public class PaqueteTuristicoController {

	@Autowired
	private PaqueteTuristicoService paqueteTuristicoService;
	
	@Autowired
	private CotizacionService cotizacionService;
	
	@Autowired
	private OrdenPlanificacionService ordenPlanificacionService;
		
	private String jsonView;

	public String getJsonView() {
		return jsonView;
	}

	public void setJsonView(String jsonView) {
		this.jsonView = jsonView;
	}
	
	@RequestMapping( value = "/verTours", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView verTours(HttpServletRequest request, HttpServletResponse response){
		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {
			modelAndView = new ModelAndView();
			int idDestino = Integer.parseInt(request.getParameter("idDestino"));
			System.out.println("IdDestino : " + idDestino);
			List<TourBean> listaTour = new ArrayList<TourBean>();
			TourBean tour = new TourBean();
			tour.setIdDestinoCiudad(idDestino);
			listaTour = paqueteTuristicoService.listarTour(tour);
			
			if(listaTour != null){
				System.out.println("Total Tour :" + listaTour.size());
				mapa.put("listaTour", listaTour);
			}
			else {
				mapa.put("listaTour", null);
			}
			
			dataJSON.setRespuesta("ok", null, mapa);
			
			
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}
	
	@RequestMapping( value = "/verVuelos", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView verDetalleVuelos(HttpServletRequest request, HttpServletResponse response){
		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {
			modelAndView = new ModelAndView();
	        String cadenaVuelo = request.getParameter("cadenaVuelo");
	        
	        List<FareInfoBean> fareInfoDetaList = new ArrayList<FareInfoBean>();
	        System.out.println("Cadena Vuelo :" +cadenaVuelo);
	        fareInfoDetaList = cotizacionService.listarTickets(cadenaVuelo);
	       
	        /*
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
			
			List<FareInfoBean> fareInfoList = null;
			List<FareInfoBean> fareInfoDetaList = null;
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
					
					FareInfoBean o = cotizacionService.getConsolidador(item);
					
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
			
			//conn.disconnect();
			  */
			 
			System.out.println("Total Vuelos : " + fareInfoDetaList.size());
			mapa.put("listaVuelos", fareInfoDetaList);
			
			dataJSON.setRespuesta("ok", null, mapa);
	        
	        
		}
		catch(Exception e){
			System.out.println(e.getMessage());
		}
		
		return ControllerUtil.handleJSONResponse(dataJSON, response);
		
	}
	
	@RequestMapping( value = "/obtenerDatosTipoHabitacion", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView obtenerDatosTipoHabitacion(HttpServletRequest request, HttpServletResponse response){
		System.out.println("Entro a obtenerDatosTipoHabitacion");
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {
			int idHotel = Integer.parseInt(request.getParameter("idhotel"));
			String idTipo = request.getParameter("idtipo").toString();
			List<HotelHabitacionBean> listaTipoHabitacion = new ArrayList<HotelHabitacionBean>();
			HotelHabitacionBean tipoHabitacion = new HotelHabitacionBean();
			
			tipoHabitacion.setIdHotel(idHotel);
			
			if(!idTipo.equals("")){
				tipoHabitacion.setIdTipoHabitacion(Integer.parseInt(idTipo));
			}
			
			listaTipoHabitacion = paqueteTuristicoService.obtenerTipoHabitacion(tipoHabitacion);
			System.out.println("Total Tipos Habitacion :" + listaTipoHabitacion.size());
				
			if(listaTipoHabitacion.size() >0){
				mapa.put("status","1");	
				mapa.put("idHotelHabitacion",listaTipoHabitacion.get(0).getIdHotelHabitacion());
				mapa.put("idTipoHabitacion", listaTipoHabitacion.get(0).getIdTipoHabitacion());
				mapa.put("nomTipoHabitacion", listaTipoHabitacion.get(0).getNomTipoHabitacion());
				mapa.put("precio", listaTipoHabitacion.get(0).getPrecio());
				
			}
			else 
			{
				mapa.put("status","0");
				mapa.put("idHotelHabitacion","");
				mapa.put("idTipoHabitacion", "");
				mapa.put("nomTipoHabitacion", "");
				mapa.put("precio", "");
			}
				
			
			dataJSON.setRespuesta("ok", null, mapa);
			
		}
		catch(Exception e){
			System.out.println(e.getMessage());
		}
		
		return ControllerUtil.handleJSONResponse(dataJSON, response);
		
	}

	@RequestMapping( value = "/verTiposHabitacion", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView verTiposHabitacion(HttpServletRequest request, HttpServletResponse response){
		System.out.println("Entro a verTiposHabitacion");
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {
			int idHotel = Integer.parseInt(request.getParameter("idhotel"));
			List<HotelHabitacionBean> listaTipoHabitacion = new ArrayList<HotelHabitacionBean>();
			HotelHabitacionBean tipoHabitacion = new HotelHabitacionBean();
			
			tipoHabitacion.setIdHotel(idHotel);
			
			listaTipoHabitacion = paqueteTuristicoService.listarTipoHabitacion(tipoHabitacion);
			
			if(listaTipoHabitacion != null){
				System.out.println("Total Tipos Habitacion :" + listaTipoHabitacion.size());
				mapa.put("listaTipoHabitacion", listaTipoHabitacion);
			}
			else {
				mapa.put("listaTipoHabitacion", null);
			}
			
			
			dataJSON.setRespuesta("ok", null, mapa);
			
		}
		catch(Exception e){
			System.out.println(e.getMessage());
		}
		
		return ControllerUtil.handleJSONResponse(dataJSON, response);
		
	}
	
	@RequestMapping( value = "/verHoteles", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView verHoteles(HttpServletRequest request, HttpServletResponse response){
		System.out.println("Entro a verHoteles");
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		
		try {
			int idDestino = Integer.parseInt(request.getParameter("iddestino"));
			
			String tipo = request.getParameter("tipo").toString();
			String categoria = request.getParameter("categoria").toString();
			
			
			System.out.println("IdDestino : " + idDestino);
			System.out.println("Tipo :" + tipo);
			System.out.println("Categoria :" + categoria);
			
			List<HotelBean> listaHotel = new ArrayList<HotelBean>();
			HotelBean hotel = new HotelBean();
			hotel.setIdDestino(idDestino);
			
			if(!tipo.equals("")){
				System.out.println("Validacion Tipo");
				hotel.setIdTipoAlojamiento(Integer.parseInt(tipo));
			}
			
			if(!categoria.equals("")){
				System.out.println("Validacion Categoria");
				hotel.setIdCategoriaAlojamiento(Integer.parseInt(categoria));
			}
			
			
			listaHotel = paqueteTuristicoService.listarHotel(hotel);
			
			if(listaHotel != null){
				System.out.println("Total Hoteles :" + listaHotel.size());
				mapa.put("listaHotel", listaHotel);
			}
			else {
				mapa.put("listaHotel", null);
			}
			
			dataJSON.setRespuesta("ok", null, mapa);
			
			
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		return ControllerUtil.handleJSONResponse(dataJSON, response);
		
	}
	
	@RequestMapping( value = "/obtenerOrdenPlanificacion", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView obtenerOrdenPlanificacion(HttpServletRequest request, HttpServletResponse response){
		System.out.println("Entro a metodo");
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		
		try {
			OrdenPlanificacionBean orden = new OrdenPlanificacionBean();
			OrdenPlanificacionBean ordenmotivo = new OrdenPlanificacionBean();
			List<OrdenPlanificacionBean> listaOrdenPlanificacion = new ArrayList<OrdenPlanificacionBean>();
			List<OrdenPlanificacionBean> listaOrdenMotivo = new ArrayList<OrdenPlanificacionBean>();
			String nuOrden = request.getParameter("nuorden");
			orden.setNuOrden(nuOrden);
			System.out.println("Orden : " + nuOrden);
			listaOrdenPlanificacion = ordenPlanificacionService.obtenerOrdenPlanificacion(orden);
			System.out.println("Size Orden :" + listaOrdenPlanificacion.size());
			int idorden = 0;
			String motivo = "";
			if(listaOrdenPlanificacion.size() > 0){
				mapa.put("idestado",listaOrdenPlanificacion.get(0).getIdEstado());
				mapa.put("descripcion",listaOrdenPlanificacion.get(0).getDescripcion());
				mapa.put("observacion",listaOrdenPlanificacion.get(0).getObservacion());
				mapa.put("presupuestomin", listaOrdenPlanificacion.get(0).getImPresupuestoMinimo());
				mapa.put("presupuestomax", listaOrdenPlanificacion.get(0).getImPresupuestoMaximo());
				mapa.put("cliente",listaOrdenPlanificacion.get(0).getNomCliente());
				mapa.put("fechaorden", listaOrdenPlanificacion.get(0).getFeOrder());
				mapa.put("fechapartida", listaOrdenPlanificacion.get(0).getFePartida());
				mapa.put("fecharetorno",listaOrdenPlanificacion.get(0).getFeRetorno());
				mapa.put("nuaultos", listaOrdenPlanificacion.get(0).getNuAdultos());
				mapa.put("nuninos", listaOrdenPlanificacion.get(0).getNuNinos());
				mapa.put("tipoPrograma", listaOrdenPlanificacion.get(0).getIdTipoPrograma());
				mapa.put("mensaje","");
				mapa.put("status", "1");
				
				idorden = listaOrdenPlanificacion.get(0).getIdOrden();
				mapa.put("idorden", idorden);
				ordenmotivo.setIdOrden(idorden);
				listaOrdenMotivo = ordenPlanificacionService.obtenerOrdenMotivo(ordenmotivo);
				
				mapa.put("listaOrdenMotivo", listaOrdenMotivo);
				
				for(int i = 0;i<listaOrdenMotivo.size();i++){
					if(i == listaOrdenMotivo.size() -1)
						motivo += listaOrdenMotivo.get(i).getNomMotivo();
					else
						motivo += listaOrdenMotivo.get(i).getNomMotivo() + " - ";
				}
				
				mapa.put("motivo", motivo);
				
			}
			else {
				mapa.put("idestado", "");
				mapa.put("descripcion", "");
				mapa.put("observacion", "");
				mapa.put("presupuestomin", "");
				mapa.put("presupuestomax", "");
				mapa.put("cliente", "");
				mapa.put("fechaorden", "");
				mapa.put("fechapartida", "");
				mapa.put("fecharetorno","");
				mapa.put("nuaultos", "");
				mapa.put("nuninos", "");
				mapa.put("status", "0");
				mapa.put("mensaje", "No existe orden de planificacion");
				mapa.put("idorden", "");
				mapa.put("tipoPrograma", "0");
				mapa.put("listaOrdenMotivo", null);
				mapa.put("motivo",motivo);
			}
			
			 dataJSON.setRespuesta("ok", null, mapa);
			
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		return ControllerUtil.handleJSONResponse(dataJSON, response);
		
	}
	
	@RequestMapping( value = "/obtenerOrdenDestino", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView obtenerOrdenDestino(HttpServletRequest request, HttpServletResponse response){
		System.out.println("Entro a orden destino");
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		try {
			OrdenPlanificacionBean orden = new OrdenPlanificacionBean();
			OrdenPlanificacionBean ordenServicio = new OrdenPlanificacionBean();
			List<OrdenPlanificacionBean> listaOrdenDestino = new ArrayList<OrdenPlanificacionBean>();
			List<OrdenPlanificacionBean> listaOrdenServicio = new ArrayList<OrdenPlanificacionBean>();
			List<OrdenPlanificacionBean> listaOrden = new ArrayList<OrdenPlanificacionBean>();
			String nuOrden = request.getParameter("nuorden");
			
			String idPaquete = "";
			String busqueda = "";
			String tipoPrograma = "";
			String fechaPartida = "";
			int idCotizacion = 0;
			String nuCotizacion = "";
			
			if(request.getParameter("idpaquete") != null)
				idPaquete = request.getParameter("idpaquete").toString();
			
			if(request.getParameter("busInteligente") != null)
				busqueda = request.getParameter("busInteligente").toString();
			
			if(request.getParameter("tipoPrograma") != null)
				tipoPrograma = request.getParameter("tipoPrograma").toString();
			
			
			System.out.println("IdPaquete :" + idPaquete);
			System.out.println("Busqueda :" + busqueda);
			System.out.println("TipoPrograma :" + tipoPrograma);
			System.out.println("nuOrden :" + nuOrden);
			
			orden.setNuOrden(nuOrden);
			System.out.println("Asignando Num Orden :" + orden.getNuOrden());
			
			listaOrden = ordenPlanificacionService.obtenerOrdenPlanificacion(orden);
			System.out.println("Lista de Ordenes :" + listaOrden.size());
			if(listaOrden.size() > 0){
				idCotizacion = listaOrden.get(0).getIdCotiza();	
				fechaPartida = listaOrden.get(0).getFePartida();
				nuCotizacion = listaOrden.get(0).getNuCotizacion();
			}
			
			System.out.println("Id Cotizacion:" + idCotizacion);
			System.out.println("Fecha Partida:" + fechaPartida);
			System.out.println("Numero Cotizacion:" + nuCotizacion);
			
			if(!idPaquete.equals(""))
				orden.setIdPaquete(Integer.parseInt(idPaquete));
			else
				orden.setIdPaquete(0);
			
			System.out.println("Haciendo la verificacion del tipo de busqueda");
			//Hacer la busqueda inteligente y registrar el paquete
			if(busqueda.equals("1")) {
				System.out.println("Busqueda Inteligente");
				orden.setIdTipoPrograma(Integer.parseInt(tipoPrograma));
				
				System.out.println("Tipo Programa :" + orden.getIdTipoPrograma());
				//Nodo 1 leer los destinos de la orden que se encuentran en ciudad por tipo de programa
				listaOrdenDestino = ordenPlanificacionService.obtenerOrdenDestinoPrograma(orden);
				
				System.out.println("Total Destinos Programa :" + listaOrdenDestino.size());
				
				//Verificar si tienes los servicios de ticket , Tour y hotel
				List<CotizacionServicioBean> listaCotizacionServicio = new ArrayList<CotizacionServicioBean>();
				CotizacionServicioBean cotizacionServicioBean = new CotizacionServicioBean();
			    boolean tieneTicket = false;
			    boolean tieneTour = false;
			    boolean tieneHotel = false;
			    int contTickets = 0;
			    int contTours = 0;
			    int contHoteles = 0;
				
				cotizacionServicioBean.setIdCotiza(nuCotizacion);
				
				//Verifica tiene tour
				cotizacionServicioBean.setIdServicio(3);
				listaCotizacionServicio = cotizacionService.listarCotizacionServicio(cotizacionServicioBean);
				System.out.println("Total Servicios Cotizacion :" + listaCotizacionServicio.size());
				if(listaCotizacionServicio.size() > 0 ){
					tieneTour = true;
				}
				System.out.println("Tiene Tour :" + tieneTour);
					
				//Verifica tiene ticket
				cotizacionServicioBean.setIdServicio(2);
				listaCotizacionServicio = cotizacionService.listarCotizacionServicio(cotizacionServicioBean);
				if(listaCotizacionServicio.size() > 0 ){
					tieneTicket = true;
				}
				System.out.println("Tiene Ticket :" + tieneTicket);
				
					
				//Verifica tiene hotel
				cotizacionServicioBean.setIdServicio(6);
				listaCotizacionServicio = cotizacionService.listarCotizacionServicio(cotizacionServicioBean);
				if(listaCotizacionServicio.size() > 0 ){
					tieneHotel = true;
				}
				System.out.println("Tiene Hotel :" + tieneHotel);
					
				List<HotelHabitacionBean> listaHotel = new ArrayList<HotelHabitacionBean>();
				List<HotelHabitacionBean> listaHabitaciones = new ArrayList<HotelHabitacionBean>();
				HotelHabitacionBean hotel = new HotelHabitacionBean();
				List<TourBean> listaTour = new ArrayList<TourBean>();
				TourBean tour = new TourBean();
				int idHotel = 0;
				double subtotal = 0;
				String habitaciones = "";
				String filaHabitacion = "";
				int dias = 0;
				Date fechaDate = new Date();
				fechaPartida = Utils.stringToStringyyyyMMdd(fechaPartida);
				System.out.println("Fecha Partida a Convertir :" + fechaPartida);
				//fechaDate = Utils.stringToDate(fechaPartida,4);
				SimpleDateFormat parseador = new SimpleDateFormat("yyyy-MM-dd");
				fechaDate = parseador.parse(fechaPartida);
				System.out.println("Fecha Partida formateada:" + fechaDate);
				List<FareInfoBean> listaTickets = new ArrayList<FareInfoBean>();
				String cadenaVuelo = "";
				double precioMenor = 0d;
				
				for(OrdenPlanificacionBean bean : listaOrdenDestino){
					fechaDate = Utils.sumarDiasAFecha(fechaDate, dias);
					bean.setFePartidaDestino(parseador.format(fechaDate).toString());
					System.out.println("Fecha Parseada :" + parseador.format(fechaDate));
					System.out.println("Id Destino : " +bean.getIdDestino() + " Fecha partida :" +  bean.getFePartidaDestino());
					dias = bean.getNuDias();
					
					//Inicializar variables de hotel
					bean.setIdHotel(0);
					bean.setIdTipoAlojamiento(0);
					bean.setIdCategoriaAlojamiento(0);
					bean.setNomHotel("");
					bean.setHabitaciones("");
					bean.setNomTipoAlojamiento("");
					bean.setNomCatAlojamiento("");
					bean.setIdProveedorHotel(0);
					bean.setTotalHotel(0);
					//Inicializar variables de vuelo
					bean.setIdAerolinea(0);
					bean.setIdProveedorAerolinea(0);
					bean.setPrecioAerolinea(0);
					bean.setUrlAerolinea("");
					bean.setNombreAerolinea("");
					bean.setComision(0);
					
					//Obtener Hotel y sus habitaciones si tiene el servicio de hotel
					if(tieneHotel == true){
						hotel.setIdCotiza(String.valueOf(idCotizacion));
						hotel.setIdDestino(bean.getIdDestino());
						listaHotel = paqueteTuristicoService.obtenerHotelBusqueda(hotel);
						
						System.out.println("Destino : " + hotel.getIdDestino() + " Total Hoteles :" + listaHotel.size());
						if(listaHotel.size()>0){
							contHoteles = listaHotel.size();
							idHotel = listaHotel.get(0).getIdHotel();
							subtotal = listaHotel.get(0).getSubtotal();
							hotel.setIdHotel(idHotel);
							bean.setIdHotel(idHotel);
							bean.setTotalHotel(subtotal);
							//Obtener las habitaciones del hotel 
							listaHabitaciones = paqueteTuristicoService.listarDetalleHotelBusqueda(hotel);
							
							filaHabitacion = "";
							habitaciones = "";
							for(HotelHabitacionBean hotelHabitacion : listaHabitaciones)
							{
								bean.setIdTipoAlojamiento(hotelHabitacion.getIdTipoAlojamiento());
								bean.setIdCategoriaAlojamiento(hotelHabitacion.getIdCategoriaAlojamiento());
								bean.setNomHotel(hotelHabitacion.getNomHotel());
								bean.setNomTipoAlojamiento(hotelHabitacion.getNomTipo());
								bean.setNomCatAlojamiento(hotelHabitacion.getNomCategoria());
								
								filaHabitacion = String.valueOf(hotelHabitacion.getIdHotelHabitacion()) + "-" ;
								filaHabitacion += String.valueOf(hotelHabitacion.getIdTipo()) + "-";
								filaHabitacion += String.valueOf(hotelHabitacion.getPrecio()) + "-";
								filaHabitacion += String.valueOf(hotelHabitacion.getCantidad());
								habitaciones += filaHabitacion + "|";
								
							}
							
							bean.setHabitaciones(habitaciones);
							
						}
						else {
							bean.setHabitaciones("");
						}
						
						
					}
					else {
						bean.setHabitaciones("");
					}
					
					//Obtener tour si tiene tour
					if(tieneTour == true){
						System.out.println("Verificando si tiene tours disponibles");
						tour.setIdDestinoCiudad(bean.getIdDestino());
						listaTour = paqueteTuristicoService.listaTourBusqueda(tour);
						System.out.println("Total Tour :" + listaTour.size() + " Destino :" + bean.getIdDestino());
						if(listaTour.size() > 0){
							contTours = listaTour.size();
							bean.setIdTour(listaTour.get(0).getIdTour());
							bean.setNomTour(listaTour.get(0).getDescripcion());
							bean.setPreAdultoTour(listaTour.get(0).getPrecioAdulto());
							bean.setPreNinoTour(listaTour.get(0).getPrecioNino());
							bean.setDiasTour(listaTour.get(0).getDuracion());
							bean.setSubtotalTour(bean.getPreAdultoTour() * bean.getNuAdultos() + bean.getPreNinoTour() * bean.getNuNinos()) ;
						}
						
					}
					
					if(tieneTicket == true){
						cadenaVuelo = bean.getIsoOrigen() + "," + bean.getIsoDestino() + "," + bean.getFePartidaDestino() + "," + bean.getIdDestino();
						System.out.println("Cadena Vuelo :" + cadenaVuelo);
						
						listaTickets = cotizacionService.listarTickets(cadenaVuelo);
						
						//Obtener el ticket que tiene el menor precio si es que hay mas de uno
						if(listaTickets.size() > 0) {
							//Obtener el que tiene menor precio
							contTickets = listaTickets.size();
							precioMenor = Double.parseDouble(listaTickets.get(0).getFare());
							bean.setIdAerolinea(listaTickets.get(0).getIdAerolinea());
							bean.setIdProveedorAerolinea(listaTickets.get(0).getIdProveedor());
							bean.setPrecioAerolinea(precioMenor);
							bean.setNombreAerolinea(listaTickets.get(0).getNombreAerolinea());
							bean.setComision(Integer.parseInt(listaTickets.get(0).getComision()));
							
							for(FareInfoBean info : listaTickets) {
								
								if(Double.parseDouble(info.getFare()) < precioMenor) {
									precioMenor = Double.parseDouble(info.getFare());
									bean.setIdAerolinea(info.getIdAerolinea());
									bean.setIdProveedorAerolinea(info.getIdProveedor());
									bean.setPrecioAerolinea(precioMenor);
									bean.setNombreAerolinea(info.getNombreAerolinea());
									bean.setComision(Integer.parseInt(info.getComision()));
								}
								
							}
						}
						
					}
					
				}
				
				System.out.println("Size Orden Destino :" + listaOrdenDestino.size());
				if(listaOrdenDestino.size() > 0){
					mapa.put("listaOrdenDestino", listaOrdenDestino);
					mapa.put("status", "1");
				}
				else {
					mapa.put("listaOrdenDestino", null);
					mapa.put("status", "0");
				}
				
				int cumple = 1;
				
				if(tieneHotel == true && contHoteles == 0)
					cumple = 0;
				else if(tieneTour == true && contTours == 0)
					cumple = 0;
				else if(tieneTicket == true && contTickets == 0)
					cumple = 0;
					
				mapa.put("cumple",cumple);	
					
			}
			
			else {
				System.out.println("Busqueda No Inteligente");
				listaOrdenDestino = ordenPlanificacionService.obtenerOrdenDestino(orden);
				
				//Asignando fechas de partida para todos los destinos
				int dias = 0;
				Date fechaDate = new Date();
				fechaPartida = Utils.stringToStringyyyyMMdd(fechaPartida);
				System.out.println("Fecha Partida a Convertir :" + fechaPartida);
				//fechaDate = Utils.stringToDate(fechaPartida,4);
				SimpleDateFormat parseador = new SimpleDateFormat("yyyy-MM-dd");
				fechaDate = parseador.parse(fechaPartida);
				System.out.println("Fecha Partida formateada:" + fechaDate);
				for(OrdenPlanificacionBean ordenDestinoBean : listaOrdenDestino){
					ordenDestinoBean.setHabitaciones("");
					fechaDate = Utils.sumarDiasAFecha(fechaDate, dias);
					ordenDestinoBean.setFePartidaDestino(parseador.format(fechaDate).toString());
					System.out.println("Fecha Parseada :" + parseador.format(fechaDate));
					System.out.println("Id Destino : " +ordenDestinoBean.getIdDestino() + " Fecha partida :" +  ordenDestinoBean.getFePartidaDestino());
					dias = ordenDestinoBean.getNuDias();
				}
				
				System.out.println("Size Orden Destino :" + listaOrdenDestino.size());
				if(listaOrdenDestino.size() > 0){
					mapa.put("listaOrdenDestino", listaOrdenDestino);
					mapa.put("status", "1");
				}
				else {
					mapa.put("listaOrdenDestino", null);
					mapa.put("status", "0");
				}
				
				mapa.put("cumple",0);	
			}
			
			ordenServicio.setNuOrden(nuOrden);
			listaOrdenServicio = ordenPlanificacionService.obtenerOrdenServicio(ordenServicio);
			System.out.println("Size Orden Servicio :" + listaOrdenServicio.size());
			if(listaOrdenServicio.size()  > 0){
				mapa.put("listaOrdenServicio", listaOrdenServicio);
				mapa.put("statusServicio", "1");
			}
			else {
				mapa.put("listaOrdenServicio", null);
				mapa.put("statusServicio", "0");
			}
			
			dataJSON.setRespuesta("ok", null, mapa);
		}
		catch(Exception e){
			System.out.println(e.getMessage());
		}
		
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}
	
	@RequestMapping( value = "/listarPaqueteTuristico", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView listarPaqueteTuristico(HttpServletRequest request, HttpServletResponse response){
	
		System.out.println("Entro a listar Paquete turistico");
		
		ModelAndView modelAndView = null;
		HashMap<String, Object> mapa = new HashMap<String, Object>();

		List<PaqueteTuristicoBean> listarPaqueteTuristico = new ArrayList<PaqueteTuristicoBean>();
		PaqueteTuristicoBean paqueteTuristicoBean = new PaqueteTuristicoBean();
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		
		boolean flag = false;
		DataJsonBean dataJSON = new DataJsonBean();

		try {
			modelAndView = new ModelAndView();
			
			String botonBuscar = (request.getParameter("btnBuscar"))!=null?request.getParameter("btnBuscar"):"";
			
			mapa.put("titulo", "INSEMINACION");
			
			if("1".equals(botonBuscar)){
				Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
				Map<String, Object> paqueteBeanMap = (Map<String, Object>) parametrosRequest.get("paqueteBean");
				// inserta en el bean todos los valores del mapa (property vs keys)
				BeanUtils.populate(paqueteTuristicoBean, paqueteBeanMap);
				
				
				if (!"".equals(paqueteTuristicoBean.getFeInicio()) ) {
					String fechaini = Utils.stringToStringyyyyMMdd(paqueteTuristicoBean.getFeInicio());
					paqueteTuristicoBean.setFeInicio(fechaini);
				}
				
				if (!"".equals(paqueteTuristicoBean.getFeFin())) {
					String fechafin = Utils.stringToStringyyyyMMdd(paqueteTuristicoBean.getFeFin());
					paqueteTuristicoBean.setFeFin(fechafin);
				}
				
				//System.out.print("Numero Orden : " + paqueteTuristicoBean.getIdOrden());
				System.out.println("Cliente : " + paqueteTuristicoBean.getCliente());
				System.out.println("Tipo Busqueda : " + paqueteTuristicoBean.getTipoBusqueda());
				
				
				if(paqueteTuristicoBean.getTipoBusqueda() == 1)
				   paqueteTuristicoBean.setNumDocCliente(paqueteTuristicoBean.getCliente());
				else if(paqueteTuristicoBean.getTipoBusqueda() == 2)
					paqueteTuristicoBean.setNoCliente("%" + paqueteTuristicoBean.getCliente() + "%");
				
				
				listarPaqueteTuristico = paqueteTuristicoService.listarPaqueteTuristico(paqueteTuristicoBean);
				
				System.out.println("size:... " + listarPaqueteTuristico.size());
				
				
				mapa.put("listaPaqueteTuristico",  listarPaqueteTuristico);
				
				dataJSON.setRespuesta("ok", null, mapa);
				flag = true; 
				
			} else {
				
				listarPaqueteTuristico = paqueteTuristicoService.listarPaqueteTuristico(paqueteTuristicoBean);
				
				System.out.println("size:... " + listarPaqueteTuristico.size());
				
				modelAndView.addObject("listaPaqueteTuristico", SojoUtil.toJson(listarPaqueteTuristico) );
//				mapa.put("fechaInseminacion", sdf.format( new Date() ));
//				modelAndView.addObject("mapaDatos", mapa);
				modelAndView.setViewName("paqueteTuristico/listarPaqueteTuristico");
				
			}
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		if (flag) {
			return ControllerUtil.handleJSONResponse(dataJSON, response);
		} else {
			return modelAndView;
		}
	}
	
	
	//cargarFormRegistrarPaqueteTuristico
		@RequestMapping( value = "/cargarFormRegistrarPaqueteTuristico", method ={RequestMethod.GET, RequestMethod.POST} )
		public ModelAndView cargarFormRegistrarPaqueteTuristico(HttpServletRequest request, HttpServletResponse response){
			
			ModelAndView modelAndView = null;
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			Map<String, Object> mapaDatos = new HashMap<String, Object>();
			
			DataJsonBean dataJSON = new DataJsonBean();
			
			try {
				modelAndView = new ModelAndView();
				List<CiudadBean> listaCiudad = new ArrayList<CiudadBean>();
				List<PaisBean> listaPais = new ArrayList<PaisBean>();
				List<PaqueteTuristicoDestinoHotelBean> listaDetalleHotel = new ArrayList<PaqueteTuristicoDestinoHotelBean>();
				PaqueteTuristicoDestinoHotelBean detalleHotel = new PaqueteTuristicoDestinoHotelBean();
				
				String idPaquete = "";
				String idOrden = "";
				String nuOrden = "";
				
				if(request.getParameter("idpaquete") != null)
					idPaquete = request.getParameter("idpaquete").toString();
				
				if(request.getParameter("idorden") != null)
					idOrden = request.getParameter("idorden").toString();
				
				if(request.getParameter("nuOrden") != null)	
					nuOrden = request.getParameter("nuOrden").toString();
				
				System.out.println("idPaquete :" + idPaquete);
				System.out.println("idOrden :" + idOrden);
				System.out.println("nuOrden :" + nuOrden);
				
				String idEstado = "";
				String descripcion = "";
				String comentario = "";
				String observacion = "";
				String presupuestomin = "";
				String presupuestomax = "";
				String cliente = "";
				String fechaorden = "";
				String fechapartida = "";
				String fecharetorno = "";
				String nuaultos = "";
				String nuninos = "";
				String motivo = "";
				String nombrePaquete = "";
				String idEstadoPaquete = "";
				String modo = "0";
				double totalGasto = 0d;
				double totalTour = 0d;
				double totalTicket = 0d;
				double totalHotel = 0d;
				String tipoPrograma = "0";
				
				//Cargando los datos del paquete cuando se va modificar
				if(!idPaquete.equals("")){
					
					modo = "1";
					//Obtener los datos de la orden asociada;
					List<OrdenPlanificacionBean> listaOrden = new ArrayList<OrdenPlanificacionBean>();
					OrdenPlanificacionBean orden = new OrdenPlanificacionBean();
					List<OrdenPlanificacionBean> listaOrdenMotivo = new ArrayList<OrdenPlanificacionBean>();
					
					orden.setIdOrden(Integer.parseInt(idOrden));
					orden.setNuOrden(nuOrden);
					listaOrden = ordenPlanificacionService.obtenerOrdenPlanificacion(orden);
					
					int totalOrden = 0;
					if(listaOrden != null)
						totalOrden = listaOrden.size();
					
					if(totalOrden > 0){
						System.out.println("Total Orden :" + totalOrden);
						idEstado = String.valueOf(listaOrden.get(0).getIdEstado());
						descripcion = listaOrden.get(0).getDescripcion();
						comentario = listaOrden.get(0).getObservacion();
						presupuestomin = listaOrden.get(0).getImPresupuestoMinimo().toString();
						presupuestomax = listaOrden.get(0).getImPresupuestoMaximo().toString();
						cliente = listaOrden.get(0).getNomCliente();
						fechaorden = listaOrden.get(0).getFeOrder();
						fechapartida = listaOrden.get(0).getFePartida();
						fecharetorno = listaOrden.get(0).getFeRetorno();
						nuaultos = String.valueOf(listaOrden.get(0).getNuAdultos());
						nuninos = String.valueOf(listaOrden.get(0).getNuNinos());
						tipoPrograma = String.valueOf(listaOrden.get(0).getIdTipoPrograma());
						mapaDatos.put("mensaje","");
						mapaDatos.put("status", "1");
						
						listaOrdenMotivo = ordenPlanificacionService.obtenerOrdenMotivo(orden);
						
						System.out.println("Total motivos :" + listaOrdenMotivo.size());
						
						for(int i = 0;i<listaOrdenMotivo.size();i++){
							if(i == listaOrdenMotivo.size() -1)
								motivo += listaOrdenMotivo.get(i).getNomMotivo();
							else
								motivo += listaOrdenMotivo.get(i).getNomMotivo() + " - ";
						}
						
						mapaDatos.put("listaOrdenMotivo", listaOrdenMotivo);
					}
					else {
						idEstado = "";
						descripcion= "";
						comentario = "";
						observacion="";
						presupuestomin = "";
						presupuestomax = "";
						cliente = "";
						fechaorden = "";
						fechapartida = "";
						fecharetorno = "";
						nuaultos = "";
						nuninos = "";
						motivo = "";
						tipoPrograma = "0";
						mapaDatos.put("mensaje","");
						mapaDatos.put("status", "0");
						
					}
					
					//Cargando los datos del paquete turistico la cabecera
					PaqueteTuristicoBean paqueteTuristicoBean = new PaqueteTuristicoBean();
					paqueteTuristicoBean.setIdPaquete(Integer.parseInt(idPaquete));
					detalleHotel.setIdPaquete(Integer.parseInt(idPaquete));
					
					List<PaqueteTuristicoBean> listaPaqueteTuristicoBean = new ArrayList<PaqueteTuristicoBean>();
					listaPaqueteTuristicoBean = paqueteTuristicoService.obtenerPaqueteTuristico(paqueteTuristicoBean);
					
					if(listaPaqueteTuristicoBean.size() > 0){
						nombrePaquete = listaPaqueteTuristicoBean.get(0).getNombre();
						idEstadoPaquete = String.valueOf(listaPaqueteTuristicoBean.get(0).getIdEstado());
						observacion = listaPaqueteTuristicoBean.get(0).getObservacion();
						totalGasto = listaPaqueteTuristicoBean.get(0).getTotalGasto();
						totalTour = listaPaqueteTuristicoBean.get(0).getTotalTour();
						totalTicket = listaPaqueteTuristicoBean.get(0).getTotalTicket();
						totalHotel = listaPaqueteTuristicoBean.get(0).getTotalHotel();
					}
					else {
						nombrePaquete = "";
						idEstadoPaquete = "";
						observacion = "";
					}
					
					//cargando detalle hotel
					listaDetalleHotel = paqueteTuristicoService.obtenerDetalleHotelPaquete(detalleHotel);
					
					
					
				
				}
				
				
				System.out.println("Total Hoteles :" + listaDetalleHotel.size());
			
				mapaDatos.put("titulo", "REGISTRAR PAQUETE TURISTICO");
				mapaDatos.put("idEstadoPaquete",idEstadoPaquete);
				mapaDatos.put("listaDetalleHotel", listaDetalleHotel);
				modelAndView.addObject("modo",modo);
				//modelAndView.addObject("numeroCotizacion", cotizacionService.generarNumeroCotizacion()+"");
				modelAndView.addObject("titulo", "REGISTRAR PAQUETE TURISTICO");			
				modelAndView.addObject("mapaDatos", mapaDatos);
				modelAndView.addObject("fechaCotizacion", Utils.dateUtilToStringDDMMYYYY( new Date() )) ;
				modelAndView.addObject("fecha", Utils.dateUtilToStringDDMMYYYY( new Date() )) ;
				modelAndView.addObject("idPaquete",idPaquete);
				modelAndView.addObject("idOrden",idOrden);
				modelAndView.addObject("nuOrden",nuOrden);
				modelAndView.addObject("idEstado",idEstado);
				modelAndView.addObject("descripcion",descripcion);
				modelAndView.addObject("observacion",observacion);
				modelAndView.addObject("comentario",comentario);
				modelAndView.addObject("presupuestomin", presupuestomin);
				modelAndView.addObject("presupuestomax", presupuestomax);
				modelAndView.addObject("cliente",cliente);
				modelAndView.addObject("fechaorden", fechaorden);
				modelAndView.addObject("fechapartida", fechapartida);
				modelAndView.addObject("fecharetorno",fecharetorno);
				modelAndView.addObject("nuaultos", nuaultos);
				modelAndView.addObject("nuninos", nuninos);
				modelAndView.addObject("motivoViaje", motivo);
				modelAndView.addObject("nombrePaquete",nombrePaquete);
				modelAndView.addObject("totalTour",totalTour);
				modelAndView.addObject("totalTicket",totalTicket);
				modelAndView.addObject("totalHotel",totalHotel);
				modelAndView.addObject("totalGasto",totalGasto);
				
				
				
				System.out.println("Datos ok");
				
				//dataJSON.setRespuesta("ok", null, mapaDatos);
				
				modelAndView.setViewName("paqueteTuristico/registrarPaqueteTuristico");
				
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
			return modelAndView;
		}
		
		
		
		
		@SuppressWarnings("unchecked")
		@RequestMapping( value = "/grabarTransaccionPaqTuristico" )
		public ModelAndView grabarTransaccionPaqTuristico(HttpServletRequest request, HttpServletResponse response){
			
			ModelAndView modelAndView = null;
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			Map<String, Object> mapa = new HashMap<String, Object>();
			//System.out.println("Ingresando al controller");
			DataJsonBean dataJSON = new DataJsonBean();

			try {
				
				System.out.println(" grabarTransaccionPaqTuristico " );
				
				modelAndView = new ModelAndView();
				//HttpSession session = request.getSession();
				//String usuario = (String) session.getAttribute("idUsuario");
				String modo = "";
				
				if(request.getParameter("modo") != null)
				   modo = request.getParameter("modo").toString();
							
					Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
					Map<String, Object> paqueteTuristicoBeanMap = (Map<String, Object>) parametrosRequest.get("paqueteTuristicoBean");
					PaqueteTuristicoBean objbean = new PaqueteTuristicoBean();
					OrdenPlanificacionBean ordenPlanificacionBean = new OrdenPlanificacionBean();
					
					BeanUtils.populate(objbean, paqueteTuristicoBeanMap);
					
					System.out.println(" Inicio bean ");
					
					System.out.println(" bean: " + objbean.toString());
					
					System.out.println("Id Paquete :" + objbean.getIdPaquete());
					
				
					//System.out.println(estado);
					
					objbean.setNombre(objbean.getNombre());
					//objbean.setIdEstado(1);				
					objbean.setObservacion(objbean.getObservacion());					
					objbean.setIdOrden(objbean.getIdOrden());
					
					ordenPlanificacionBean.setIdOrden(objbean.getIdOrden());
					
					if(objbean.getObservacion().equals(""))
						objbean.setObservacion(objbean.getComentario());
					
					
					System.out.println(" fechas ini... ");
					
					if ( objbean.getFecha() != null && !objbean.getFecha().equals("") ) {
						objbean.setFecha( Utils.stringToStringyyyyMMdd (objbean.getFecha()));					
					} else {
						objbean.setFecha( null );
					}
					
					
					
					if ( objbean.getFeInicio() != null && !objbean.getFeInicio().equals("") ) {
						objbean.setFeInicio(Utils.stringToStringyyyyMMdd(objbean.getFeInicio()));
					}
					
					
					if ( objbean.getFeFin() != null && !objbean.getFeFin().equals("") ) {
						objbean.setFeFin(Utils.stringToStringyyyyMMdd(objbean.getFeFin()));
					}
					
					System.out.println(" fechas fin... ");
										
					objbean.setIdTrabajador(1);
					objbean.setNuNinos(objbean.getNuNinos());
					objbean.setNuAdultos(objbean.getNuAdultos());
					
					objbean.setIdMoneda(1);
					objbean.setImMin(objbean.getImMin());
					objbean.setImMax(objbean.getImMax());	
					
					//System.out.println(objbean);
					
					System.out.println(" enviar a grabar... ");
					
					System.out.println(" objeto: " + objbean.toString());
					
					int registro = 0;
					
					
					
					
					System.out.println(" registro index " + registro);
					
					String destinos = request.getParameter("destinos").toString();
					String tours = request.getParameter("tours").toString();
					String tickets = request.getParameter("tickets").toString();
					String hoteles = request.getParameter("hoteles").toString();
					  
					System.out.println("Modo :" + modo);
					System.out.println("Id Paquete : " + objbean.getIdPaquete());
					//Eliminando detalle si se va modificar
					if(modo.equals("1")){
						
						registro = paqueteTuristicoService.actualizaPaqueteTuristico(objbean);
						
						registro = objbean.getIdPaquete();
						
						paqueteTuristicoService.eliminaDetallePaqueteTuristico(objbean);
					}
					else {
						registro = paqueteTuristicoService.GrabarPaqueteTuristico(objbean);
						
					}
					
					//Registrando destinos
					
					System.out.println("Inicio Registrar destinos");
					
					if(!destinos.equals("")) {
						
						String ultimoCaracterDestino = destinos.substring(destinos.length()-1);
						
						if(ultimoCaracterDestino.equals(";")){
							destinos = destinos.substring(0, destinos.length() -1);
						}
						
						String[] listaDestinos = destinos.split(";");
						List<PaqueteTuristicoDestinoBean> listaPaqueteTuristicoDestino = new ArrayList<PaqueteTuristicoDestinoBean>();
						PaqueteTuristicoDestinoBean paqueteTuristicoDestino = new PaqueteTuristicoDestinoBean();
						
						String[] destino ;
						int paqueteDestino = 0; 
						
						for(int i = 0;i<listaDestinos.length;i++){
							
							destino = listaDestinos[i].split(",");
							
							if(Integer.parseInt(destino[0].toString()) > 0){

								paqueteTuristicoDestino.setIdPaqueteTuristico(registro);
								paqueteTuristicoDestino.setIdDestinoCiudad(Integer.parseInt(destino[0].toString()));
								paqueteTuristicoDestino.setItem(Integer.parseInt(destino[1].toString()));
								paqueteTuristicoDestino.setNuDias(Integer.parseInt(destino[2].toString()));
								
								paqueteDestino = paqueteTuristicoService.RegistrarPaqueteTuristicoDestino(paqueteTuristicoDestino);
							}
							
						}
					}
					
					System.out.println("Fin Registar Destinos");
					
					System.out.println("Inicio Registrar tours");
					//Registrando tours por destino
					if(!tours.equals("")){
						
						String ultimoCaracterTour = tours.substring(tours.length()-1);
						
						
						if(ultimoCaracterTour.equals(";")){
							tours = tours.substring(0, tours.length() -1);
						}
						
						String[] listaTours = tours.split(";");
						PaqueteTuristicoDestinoTourBean paqueteTuristicoDestinoTour = new PaqueteTuristicoDestinoTourBean();
						String[] tour ;
						int idPaqueteDestinoTour = 0;
						
						for(int i = 0;i<listaTours.length;i++){
							tour = listaTours[i].split(",");
							
							if(Integer.parseInt(tour[0].toString()) > 0){
								paqueteTuristicoDestinoTour.setIdPaquete(registro);
								paqueteTuristicoDestinoTour.setIdTour(Integer.parseInt(tour[0].toString()));
								paqueteTuristicoDestinoTour.setDescripcion(tour[1].toString());
								paqueteTuristicoDestinoTour.setNuPersonas(Integer.parseInt(tour[2].toString()));
								paqueteTuristicoDestinoTour.setImPrecioAdulto(Double.parseDouble(tour[3].toString()));
								paqueteTuristicoDestinoTour.setImPrecioNino(Double.parseDouble(tour[4].toString()));
								paqueteTuristicoDestinoTour.setIdDestino(Integer.parseInt(tour[5].toString()));
								
								idPaqueteDestinoTour = paqueteTuristicoService.RegistrarPaqueteTuristicoDestinoTour(paqueteTuristicoDestinoTour);
							}
							
						
						}
						
					}
					
					System.out.println("Fin registrar tours");
					
					System.out.println("Inicio registrar tickets");
					//Registrando tickets
					if(!tickets.equals("")){
						String ultimoCaracterTicket = tickets.substring(tickets.length()-1);
						
						
						if(ultimoCaracterTicket.equals(";")){
							tickets = tickets.substring(0, tickets.length() -1);
						}
						
						String[] listaTickets = tickets.split(";");
						String[] ticket ;
						int idPaqueteDestinoTicket = 0;
						PaqueteTuristicoTicketBean paqueteTuristicoTicketBean = new PaqueteTuristicoTicketBean();
						
						System.out.println("Recorrer tickets");
						for(int i = 0;i<listaTickets.length;i++){
							ticket = listaTickets[i].split(",");
							//System.out.println("IdPaquete :" + registro);
							
							//System.out.println("Proveedor : " + ticket[0].toString());
						//	System.out.println("Aerolinea : " + ticket[1].toString());
							//System.out.println("Precio : " + ticket[2].toString());
							//System.out.println("Url : " + ticket[3].toString());
							//System.out.println("Destino : " + ticket[3].toString());
							//System.out.println("Adultos : " + ticket[4].toString());
						//	System.out.println("Ninos : " + ticket[5].toString());
						//	System.out.println("Tipo : " + ticket[6].toString());
							
							if(Integer.parseInt(ticket[0].toString()) > 0){
								paqueteTuristicoTicketBean.setIdPaqueteTuristico(registro);							
								paqueteTuristicoTicketBean.setIdProveedor(Integer.parseInt(ticket[0].toString()));
								paqueteTuristicoTicketBean.setIdAerolinea(Integer.parseInt(ticket[1].toString()));
								paqueteTuristicoTicketBean.setImPrecio(Double.parseDouble(ticket[2].toString()));
								//paqueteTuristicoTicketBean.setUrlTicket(ticket[3].toString());
								paqueteTuristicoTicketBean.setIdDestino(Integer.parseInt(ticket[3].toString()));
								paqueteTuristicoTicketBean.setNuAdultos(Integer.parseInt(ticket[4].toString()));
								paqueteTuristicoTicketBean.setNuNinos(Integer.parseInt(ticket[5].toString()));
								paqueteTuristicoTicketBean.setTipoTicket(ticket[6].toString());
								
								//System.out.println("Registrando Ticket Destino :" + ticket[3].toString());
								
								idPaqueteDestinoTicket = paqueteTuristicoService.RegistrarPaqueteTuristicoTicket(paqueteTuristicoTicketBean);
								
							}
							
						
						}
						
						
					}
					System.out.println("Fin Registrar Tickets");
					
					
					System.out.println("Inicio Registrar Hoteles");
					if(!hoteles.equals("")){
						String ultimoCaracterHotel = hoteles.substring(hoteles.length()-1);
				        
						if(ultimoCaracterHotel.equals(";")){
							hoteles = hoteles.substring(0, hoteles.length() -1);
						}
						
						String[] listaHoteles = hoteles.split(";");
						String[] hotel ;
						int idPaqueteDestinoHotel = 0;
						PaqueteTuristicoDestinoHotelBean paqueteTuristicoDestinoHotelBean = new PaqueteTuristicoDestinoHotelBean();
						
						String detalle = "";
						System.out.println("Id Paquete :" + registro);
						System.out.println("Inicio Recorriendo Hoteles");
						for(int i = 0;i<listaHoteles.length;i++){
							
							hotel = listaHoteles[i].split(",");
							
							
							paqueteTuristicoDestinoHotelBean.setIdPaquete(registro);
							paqueteTuristicoDestinoHotelBean.setIdDestino(Integer.parseInt(hotel[0].toString()));
							paqueteTuristicoDestinoHotelBean.setIdHotel(Integer.parseInt(hotel[1].toString()));
							paqueteTuristicoDestinoHotelBean.setIdProveedor(Integer.parseInt(hotel[2].toString()));
							paqueteTuristicoDestinoHotelBean.setIdTipoAlojamiento(Integer.parseInt(hotel[3].toString()));
							paqueteTuristicoDestinoHotelBean.setIdCategoriaAlojamiento(Integer.parseInt(hotel[4].toString()));
							paqueteTuristicoDestinoHotelBean.setNuAdultos(Integer.parseInt(hotel[6].toString()));
							paqueteTuristicoDestinoHotelBean.setNiNinos(Integer.parseInt(hotel[7].toString()));
							
							detalle = hotel[8];
							
							
							//System.out.println("Variables Asignadas");
							
							if(!detalle.equals("")){
								String ultimoCaracter = detalle.substring(detalle.length()-1);
						        System.out.println(ultimoCaracter);
								
								if(ultimoCaracter.trim().equals("|")){
									//System.out.println("Encontro");
									detalle = detalle.substring(0, detalle.length() -1);
								}
								
								detalle = detalle.replace("|", ";");
								detalle = detalle.replace("-", ",");
								
								//System.out.println("Detalle :" + detalle);
								
								
								String[] listaHabitaciones = detalle.split(";");
								String[] habitacion;
								
								//System.out.println("Item 1 :" + listaHabitaciones[0].toString());
								
								//System.out.println("Total habitaciones " + listaHabitaciones.length);
								
								//System.out.println("Iniciando Recorrido Habitaciones");
								
								for(int j = 0;j<listaHabitaciones.length;j++){
									
									//System.out.println("Habitacion :" + listaHabitaciones[j].toString());
									
									habitacion = listaHabitaciones[j].split(",");
									
									//System.out.println("Hotel Habitacion :" + habitacion[0].toString());
									//System.out.println("Precio Habitacion :" + habitacion[2].toString());
									//System.out.println("Cantidad Habitacion :" + habitacion[3].toString());
									
									
									paqueteTuristicoDestinoHotelBean.setIdHotelHabitacion(Integer.parseInt(habitacion[0].toString()));
									paqueteTuristicoDestinoHotelBean.setImPrecio(Double.parseDouble(habitacion[2].toString()));
									paqueteTuristicoDestinoHotelBean.setCantidad(Integer.parseInt(habitacion[3].toString()));
									
									paqueteTuristicoService.RegistrarPaqueteTuristicoDestinoHotel(paqueteTuristicoDestinoHotelBean);
									
									
									
								}
								//System.out.println("Fin Recorrido Habitaciones");
							
							}
							
								
							
							
						}
						
						
					}
					
					System.out.println("Actualiza estado de la orden y cotizacion");
					System.out.println("Id Estado :" + objbean.getIdEstado());
					System.out.println("Id Orden :" + objbean.getIdOrden());
					
					if(objbean.getIdEstado() == 5) {
						//Actualizando la orden a finalizado
						ordenPlanificacionBean.setIdEstado(5);
						ordenPlanificacionService.actualizarEstadoOrden(ordenPlanificacionBean);
						
						//Actualizar la cotizacion
						List<OrdenPlanificacionBean> listaOrden = new ArrayList<OrdenPlanificacionBean>();
						listaOrden = ordenPlanificacionService.obtenerOrdenPlanificacion(ordenPlanificacionBean);
						int idCotizacion = 0;
						if(listaOrden.size() >0)
							idCotizacion = listaOrden.get(0).getIdCotiza();
						
						CotizacionBean cotizacionBean = new CotizacionBean();
						cotizacionBean.setIdCotizacion(idCotizacion);
						cotizacionBean.setIdEstado(5);
						
						cotizacionService.actualizarCotizacion(cotizacionBean);
						
						
					}
					else {
						//Actualizar Orden de Planificacion
						ordenPlanificacionBean.setIdEstado(8);
						ordenPlanificacionService.actualizarEstadoOrden(ordenPlanificacionBean);
						
					}
					
					
					
					System.out.println("Fin Registrar Hoteles");
				
					dataJSON.setRespuesta("ok", null, mapa);
					
					
					
			} catch (Exception e) {
				
				System.out.println(" excepcion... ");
				
				System.out.println(e.getMessage());
				
				dataJSON.setRespuesta("error", null, mapa);
				
				
			}
			
			return ControllerUtil.handleJSONResponse(dataJSON, response);
			
		}
	
	
}
