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
import pe.com.paxtravel.bean.EmpleadoBean;
import pe.com.paxtravel.bean.FareInfoBean;
import pe.com.paxtravel.bean.InseminacionBean;
import pe.com.paxtravel.bean.OrdenPlanificacionBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.PaqueteTuristicoBean;
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
						encontro = true;
					}
					else {
						item.setComision("");
						item.setNombreProveedor("");
						item.setNombreAerolinea("");
						item.setIdProveedor(0);
						item.setIdAerolinea(0);
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
			System.out.println("Total Vuelos : " + fareInfoDetaList.size());
			mapa.put("listaVuelos", fareInfoDetaList);
			
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
			String idOrden = request.getParameter("idorden");
			String idDestino = request.getParameter("iddestino");
			
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
				mapa.put("mensaje","");
				mapa.put("status", "1");
				
				idorden = listaOrdenPlanificacion.get(0).getIdOrden();
				mapa.put("idorden", idorden);
				ordenmotivo.setIdOrden(idorden);
				listaOrdenMotivo = ordenPlanificacionService.obtenerOrdenMotivo(ordenmotivo);
				
				mapa.put("listaOrdenMotivo", listaOrdenMotivo);
				
				
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
				mapa.put("mensaje", "No existe orden de planificaci�n");
				mapa.put("idorden", "");
				mapa.put("listaOrdenMotivo", null);
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
		try {
			OrdenPlanificacionBean orden = new OrdenPlanificacionBean();
			OrdenPlanificacionBean ordenServicio = new OrdenPlanificacionBean();
			List<OrdenPlanificacionBean> listaOrdenDestino = new ArrayList<OrdenPlanificacionBean>();
			List<OrdenPlanificacionBean> listaOrdenServicio = new ArrayList<OrdenPlanificacionBean>();
			String nuOrden = request.getParameter("nuorden");
			orden.setNuOrden(nuOrden);
			listaOrdenDestino = ordenPlanificacionService.obtenerOrdenDestino(orden);
			System.out.println("Size Orden Destino :" + listaOrdenDestino.size());
			if(listaOrdenDestino.size() > 0){
				mapa.put("listaOrdenDestino", listaOrdenDestino);
				mapa.put("status", "1");
			}
			else {
				mapa.put("listaOrdenDestino", null);
				mapa.put("status", "0");
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
			
				mapaDatos.put("titulo", "REGISTRAR PAQUETE TURISTICO");
				
				Map<String, Object> mapaListaCiudad = new HashMap<String, Object>();
				for (CiudadBean ciudadBean1 : listaCiudad) {
					mapaListaCiudad.put("idCiudad", ciudadBean1.getIdCiudad());
					mapaListaCiudad.put("nomCiudad", ciudadBean1.getNomCiudad());
				}
				
				mapaDatos.put("listCiudad", listaCiudad);
				mapaDatos.put("listPais", listaPais);
				
				//modelAndView.addObject("numeroCotizacion", cotizacionService.generarNumeroCotizacion()+"");
				modelAndView.addObject("titulo", "REGISTRAR PAQUETE TURISTICO");			
				modelAndView.addObject("mapaDatos", mapaDatos);
				modelAndView.addObject("fechaCotizacion", Utils.dateUtilToStringDDMMYYYY( new Date() )) ;
				modelAndView.addObject("fecha", Utils.dateUtilToStringDDMMYYYY( new Date() )) ;
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
				
							
					Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
					Map<String, Object> paqueteTuristicoBeanMap = (Map<String, Object>) parametrosRequest.get("paqueteTuristicoBean");
					PaqueteTuristicoBean objbean = new PaqueteTuristicoBean();
					
					BeanUtils.populate(objbean, paqueteTuristicoBeanMap);
					
					System.out.println(" Inicio bean ");
					
					System.out.println(" bean: " + objbean.toString());
					
					
					
				
					//System.out.println(estado);
					
					objbean.setNombre(objbean.getNombre());
					objbean.setIdEstado(1);				
					objbean.setObservacion(objbean.getObservacion());					
					objbean.setIdOrden(objbean.getIdOrden());
					
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
						objbean.setFeFin(Utils.stringToStringddMMyyyy(objbean.getFeFin()));
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
					
					int registro = paqueteTuristicoService.GrabarPaqueteTuristico(objbean);
		
					System.out.println(" registro index " + registro);									
				
					dataJSON.setRespuesta("ok", null, mapa);
					
					
					
			} catch (Exception e) {
				
				System.out.println(" excepcion... ");
				
				System.out.println(e.getMessage());
				
				dataJSON.setRespuesta("error", null, mapa);
				
				
			}
			
			return ControllerUtil.handleJSONResponse(dataJSON, response);
			
		}
	
	
}
