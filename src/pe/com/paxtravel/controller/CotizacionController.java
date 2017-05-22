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
import pe.com.paxtravel.bean.ClienteBean;
import pe.com.paxtravel.bean.CotizacionBean;
import pe.com.paxtravel.bean.CotizacionDetalleBean;
import pe.com.paxtravel.bean.CotizacionDetalleTicketVueloBean;
import pe.com.paxtravel.bean.EmpleadoBean;
import pe.com.paxtravel.bean.FareInfoBean;
import pe.com.paxtravel.bean.InseminacionBean;
import pe.com.paxtravel.bean.MotivoViajeBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.ProduccionBean;
import pe.com.paxtravel.bean.ServicioAdicionalBean;
import pe.com.paxtravel.service.AnimalService;
import pe.com.paxtravel.service.CotizacionService;
import pe.com.paxtravel.service.EmpleadoService;
import pe.com.paxtravel.service.InseminacionService;
//import pe.com.paxtravel.service.ProduccionService;
import pe.com.paxtravel.util.ControllerUtil;
import pe.com.paxtravel.util.DataJsonBean;
import pe.com.paxtravel.util.Utils;
import pe.gob.sunat.framework.spring.util.conversion.SojoUtil;

@Controller
public class CotizacionController {

	@Autowired
	private CotizacionService cotizacionService;
		
	private String jsonView;

	public String getJsonView() {
		return jsonView;
	}

	public void setJsonView(String jsonView) {
		this.jsonView = jsonView;
	}
	
	@RequestMapping( value = "/listarCotizacion", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView listarCotizacion(HttpServletRequest request, HttpServletResponse response){
		
		ModelAndView modelAndView = null;
		HashMap<String, Object> mapa = new HashMap<String, Object>();

		List<CotizacionBean> listarCotizacion = new ArrayList<CotizacionBean>();
		CotizacionBean cotizacionBean = new CotizacionBean();
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		
		boolean flag = false;
		DataJsonBean dataJSON = new DataJsonBean();

		try {
			modelAndView = new ModelAndView();
			
			String botonBuscar = (request.getParameter("btnBuscar"))!=null?request.getParameter("btnBuscar"):"";
			
			mapa.put("titulo", "");
			
			if("1".equals(botonBuscar)){
				
				Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
				Map<String, Object> cotizacionBeanMap = (Map<String, Object>) parametrosRequest.get("cotizacionBean");
				// inserta en el bean todos los valores del mapa (property vs keys)
				BeanUtils.populate(cotizacionBean, cotizacionBeanMap);
				
				if (!"".equals(cotizacionBean.getFechaCotizacion()) ) {
					String fechaCotizacion = Utils.stringToStringyyyyMMdd(cotizacionBean.getFechaCotizacion());
					cotizacionBean.setFechaCotizacion(fechaCotizacion);
				}

				listarCotizacion = cotizacionService.listarCotizacion(cotizacionBean);
				
				mapa.put("listaCotizacion",  listarCotizacion);
				
				dataJSON.setRespuesta("ok", null, mapa);
				flag = true;
				
			} else {
				listarCotizacion = cotizacionService.listarCotizacion(cotizacionBean);
				modelAndView.addObject("listaCotizacion", SojoUtil.toJson(listarCotizacion) );
//				mapa.put("fechaInseminacion", sdf.format( new Date() ));
//				modelAndView.addObject("mapaDatos", mapa);
				modelAndView.setViewName("cotizacion/listarCotizacion");
				
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
	
	@RequestMapping( value = "/cargarFormRegistrarCotizacion", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView cargarFormRegistrarCotizacion(HttpServletRequest request, HttpServletResponse response){
		
		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapaDatos = new HashMap<String, Object>();
		List<AnimalBean> listaToro = new ArrayList<AnimalBean>();
		DataJsonBean dataJSON = new DataJsonBean();

		try {
			modelAndView = new ModelAndView();
			List<CiudadBean> listaCiudad = new ArrayList<CiudadBean>();
			List<PaisBean> listaPais = new ArrayList<PaisBean>();

			CiudadBean ciudadBean = new CiudadBean();
			PaisBean paisBean = new PaisBean();			
			ciudadBean.setIdPais(1);			
			listaCiudad = cotizacionService.listarCiudad(ciudadBean);
			listaPais = cotizacionService.listarPais(paisBean);
			
			
			
			
			
//			listaToro = animalService.listarToro();
//			
//			Map<String, Object> mapaListaToro = new HashMap<String, Object>();
//			for (AnimalBean animalBean : listaToro) {
//				mapaListaToro.put("codigo", animalBean.getCodigoAnimal());
//				mapaListaToro.put("descripcion", animalBean.getNombreAnimal());
//			}
			
			mapaDatos.put("titulo", "Registrar Cotizaci&oacute;n");
//			mapa.put("codigoAnimal",(String) request.getParameter("codigoAnimal"));
//			mapa.put("nombreAnimal",(String) request.getParameter("nombreAnimal"));
//			mapa.put("listaToro", SojoUtil.toJson(mapaListaToro) );
//			mapa.put("fechaActual", sdf.format( new Date() ));
			
//			dataJSON.setRespuesta("ok", null, mapa);

			
//			Map<String, Object> mapaDatos = new HashMap<String, Object>();
//			mapaDatos.put("listTipoUsuario", listaTipoUsuario);
			
			Map<String, Object> mapaListaCiudad = new HashMap<String, Object>();
			for (CiudadBean ciudadBean1 : listaCiudad) {
				mapaListaCiudad.put("idCiudad", ciudadBean1.getIdCiudad());
				mapaListaCiudad.put("nomCiudad", ciudadBean1.getNomCiudad());
			}
			
			mapaDatos.put("listCiudad", listaCiudad);
			mapaDatos.put("listPais", listaPais);
			
			modelAndView.addObject("numeroCotizacion", cotizacionService.generarNumeroCotizacion()+"");
			modelAndView.addObject("titulo", "REGISTRAR COTIZACI&Oacute;N");			
			modelAndView.addObject("mapaDatos", mapaDatos);
			modelAndView.addObject("fechaCotizacion", Utils.dateUtilToStringDDMMYYYY( new Date() )) ;
			modelAndView.setViewName("cotizacion/registrarCotizacion");
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return modelAndView;
	}

	@RequestMapping( value = "/listarCiudad", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView listarCiudad(HttpServletRequest request, HttpServletResponse response){
		
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {
			
			List<CiudadBean> listaCiudad = new ArrayList<CiudadBean>();

			CiudadBean ciudadBean = new CiudadBean();
			int codigoPais = Integer.parseInt( request.getParameter("idPais") );
			ciudadBean.setIdPais( codigoPais );
			listaCiudad = cotizacionService.listarCiudad(ciudadBean);
			
	        mapa.put("titulo", "Detalle Inseminaci&oacute;n");
	        mapa.put("listaCiudad", listaCiudad);
	        
	        dataJSON.setRespuesta("ok", null, mapa);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}
	
	@RequestMapping( value = "/listarPaisDestino", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView listarPaisDestino(HttpServletRequest request, HttpServletResponse response){
		
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {
			
			List<PaisBean> lista = new ArrayList<PaisBean>();

			PaisBean bean = new PaisBean();
			int codigoPais = Integer.parseInt( request.getParameter("idPais") );
			bean.setIdPais( codigoPais );
			lista = cotizacionService.listarPais(bean);
			
	        mapa.put("titulo", "Lista de Paises disponible");
	        mapa.put("listaPais", lista);
	        
	        dataJSON.setRespuesta("ok", null, mapa);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}
	
	@RequestMapping( value = "/obtenerNombreCliente", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView obtenerNombreCliente(HttpServletRequest request, HttpServletResponse response){
		
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {
			
			List<ClienteBean> listaCliente = new ArrayList<ClienteBean>();

			ClienteBean clienteBean = new ClienteBean();
			String tipoDocumento = request.getParameter("tipoDocumento");
			String numeroDocumento = request.getParameter("numeroDocumento");
			
			clienteBean.setTipoDocumento(tipoDocumento);
			clienteBean.setNumeroDocumento(numeroDocumento);
			
			listaCliente = cotizacionService.obtenerNombreCliente(clienteBean);
			
			mapa.put("titulo", "Cliente");
			mapa.put("status", "0");
	        
	        if (listaCliente.size() > 0){
	        	
	        	int age = listaCliente.get(0).getAge();
	        	
	        	System.out.println(listaCliente.get(0).getNombre() + ": " + age);
	        	
	        	if ( age >= 18 ) {
			        mapa.put("nombreCliente", listaCliente.get(0).getNombre().toString().toUpperCase());
			        mapa.put("idCliente",  listaCliente.get(0).getIdCliente());
			        mapa.put("status", "1");
	        	} else {
	        		mapa.put("nombreCliente", "");
			        mapa.put("idCliente", "" );
			        mapa.put("mensajeCliente", "El cliente "+ listaCliente.get(0).getNombre()  +" es menor de edad ("+ age +"). Debe seleccionar un cliente mayor de edad.");
	        	}
	        	
	        } else {
	        	
	        	mapa.put("nombreCliente", "");
		        mapa.put("idCliente", "" );
		        mapa.put("mensajeCliente", "No se encontro el cliente. ");
		        
	        }
	        
	        dataJSON.setRespuesta("ok", null, mapa);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping( value = "/grabarCotiPaquete" )
	public ModelAndView grabarCotiPaquete(HttpServletRequest request, HttpServletResponse response){		
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapa = new HashMap<String, Object>();		
		DataJsonBean dataJSON = new DataJsonBean();
		String status = "error";
		
		try{					
			System.out.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("Iniciando grabarCotiPaquete");
			
			String idCliente = (request.getParameter("idCliente")==null?"":request.getParameter("idCliente"));
			
			Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
			Map<String, Object> cotizacionBeanMap = (Map<String, Object>) parametrosRequest.get("cotizacionBean");			
			
			// inserta en el bean todos los valores del mapa (property vs keys)
			cotizacionBeanMap.remove("motivoViajeCotiza[]");
			cotizacionBeanMap.remove("servicioAdicional[]");
			
			System.out.println("FechaCotizacion: " + cotizacionBeanMap.get("fechaCotizacion"));
			System.out.println("fechaSalida: " + cotizacionBeanMap.get("fechaSalida"));
			System.out.println("fechaRetorno: " + cotizacionBeanMap.get("fechaRetorno"));
			System.out.println("idTipoCotizacion: " + cotizacionBeanMap.get("idTipoCotizacion"));
			System.out.println("idOrigenPartida: " + cotizacionBeanMap.get("idOrigenPartida"));
			
			CotizacionBean cotizacionBean = new CotizacionBean();
			
			//idTipoCotizacion idOrigenPartida idTipoPrograma
			
			BeanUtils.populate(cotizacionBean, cotizacionBeanMap);
			
			cotizacionBean.setFechaCotizacion( Utils.stringToStringyyyyMMdd (cotizacionBean.getFechaCotizacion() ) );
			cotizacionBean.setIdCliente(Integer.parseInt(idCliente) );
			cotizacionBean.setNumeroCotizacion(cotizacionService.generarNumeroCotizacion());
			
			cotizacionBean.setFechaSalida( Utils.stringToStringyyyyMMdd (cotizacionBean.getFechaSalida() ) );
			cotizacionBean.setFechaRetorno( Utils.stringToStringyyyyMMdd (cotizacionBean.getFechaRetorno() ) );
			
			System.out.println("FechaCotizacion: " + cotizacionBean.getFechaCotizacion());
			System.out.println("fechaSalida: " + cotizacionBean.getFechaSalida());
			System.out.println("fechaRetorno: " + cotizacionBean.getFechaRetorno());
			System.out.println("idTipoCotizacion: " + cotizacionBean.getIdTipoCotizacion());
			System.out.println("idOrigenPartida: " + cotizacionBean.getIdOrigenPartida());
			
			int registro = cotizacionService.registrarCotizacion(cotizacionBean);
			
			System.out.println("grabarCotiPaquete: [Status:"+ registro +",Id:"+cotizacionBean.getIdCotizacion()+",Nro:"+cotizacionBean.getNumeroCotizacion()+"]");
			
			System.out.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");			
			System.out.println("Iniciando grabar Motivos");
			
			//Obtenemos los motivos del viaje para el historial por get
			String motivoViaje = request.getParameter("motivoViaje"); 
			
			//Si hay Motivos
			if ( motivoViaje.length()>0 ) {
			
				motivoViaje = motivoViaje.substring(0, motivoViaje.length()-1 );
				
				System.out.println("Motivos: " + motivoViaje);
				
				String motivo[] = motivoViaje.split(",");
				
				System.out.println("Cantidad de Motivos: " + motivo.length);
				
				MotivoViajeBean motivoViajeBean = new MotivoViajeBean();			
				motivoViajeBean.setNumeroCotizacion(cotizacionBean.getNumeroCotizacion());
				
				int m = 0;
				
				if (motivo.length > 0) {
					
					for (int i = 0; i < motivo.length; i++) {
						
						System.out.println("motivo"+i+": "+motivo[i]);
						
						m = Integer.parseInt( motivo[i] );
						motivoViajeBean.setCodigoMotivo(m);
						int res = cotizacionService.registrarMotivo(motivoViajeBean);
						System.out.println("registrarMotivo("+m+") " + res);
					}
				}	
			
			}
			
			System.out.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("Iniciando grabar Destinos");
			
			String datosDestino = request.getParameter("datosDestino");
			
			if ( datosDestino.length() > 0 ) {
			
				datosDestino = datosDestino.substring(0, datosDestino.length()-1 );
				System.out.println("Destinos: " + datosDestino);
				
				String destino[] = datosDestino.split(",");
				System.out.println("Cantidad de Destinos: " + destino.length);
				
				CotizacionDetalleBean cotizacionDetalleBean = new CotizacionDetalleBean();
				cotizacionDetalleBean.setNumeroCotizacion(cotizacionBean.getNumeroCotizacion());
				
				String g[];
				
				if (destino.length > 0){
					for (int i = 0; i < destino.length; i++) {
						
						g = destino[i].split("_");
						
						cotizacionDetalleBean.setOrigen( Integer.parseInt( g[0] ));
						cotizacionDetalleBean.setDestino( Integer.parseInt( g[1] ));
						
						int res = cotizacionService.registrarCotizacionDetalleTicket(cotizacionDetalleBean);
						
						System.out.println("registrarMotivo("+g[0] + "/" + g[1] +") " + res);
						
					}
				}
				
			}
			
			System.out.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("Iniciando grabar Servicios Adicionales");
			
			String servicioAdicional = request.getParameter("servAdicional");
			
			if ( servicioAdicional.length() > 0 ) {
			
				servicioAdicional = servicioAdicional.substring(0, servicioAdicional.length()-1 );
				System.out.println("Servicios Adicional: " + servicioAdicional);
				
				String servicio[] = servicioAdicional.split(",");
				System.out.println("Cantidad de servicios adicionales: " + servicio.length);
				
				ServicioAdicionalBean servicioAdicionalBean = new ServicioAdicionalBean();
				servicioAdicionalBean.setNumeroCotizacion(cotizacionBean.getNumeroCotizacion());
				
				int m = 0;
				if (servicio.length > 0) {
					for (int i = 0; i < servicio.length; i++) {
						m = Integer.parseInt( servicio[i] );
						servicioAdicionalBean.setCodigoServicio(m);
						int res = cotizacionService.registrarServicio(servicioAdicionalBean);
						
						System.out.println("registrar servicios adicionales("+servicio[i] +") " + res);
					}
				}
			
			}
			
			status = "ok";
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		
		dataJSON.setRespuesta(status, null, mapa);		
		return ControllerUtil.handleJSONResponse(dataJSON, response);	
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping( value = "/grabarTransaccionCotizacion" )
	public ModelAndView grabarTransaccionCotizacion(HttpServletRequest request, HttpServletResponse response){
		
		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapa = new HashMap<String, Object>();
		List<AnimalBean> listaToro = new ArrayList<AnimalBean>();
		DataJsonBean dataJSON = new DataJsonBean();				

		try {
			modelAndView = new ModelAndView();
			HttpSession session = request.getSession();
			String usuario = (String) session.getAttribute("idUsuario");
			
			String tipoCotizacion = (request.getParameter("tipoCotizacion")==null?"":request.getParameter("tipoCotizacion"));
			
			String idCliente = (request.getParameter("idCliente")==null?"":request.getParameter("idCliente"));
			
			if (tipoCotizacion.equals("")){
				
				Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
				Map<String, Object> cotizacionBeanMap = (Map<String, Object>) parametrosRequest.get("cotizacionBean");
				CotizacionBean cotizacionBean = new CotizacionBean();
				
				// inserta en el bean todos los valores del mapa (property vs keys)
				cotizacionBeanMap.remove("motivoViajeCotiza[]");
				cotizacionBeanMap.remove("servicioAdicional[]");
				
				BeanUtils.populate(cotizacionBean, cotizacionBeanMap);
				
				cotizacionBean.setFechaCotizacion( Utils.stringToStringyyyyMMdd (cotizacionBean.getFechaCotizacion() ) );
				cotizacionBean.setIdCliente(Integer.parseInt(idCliente) );
				cotizacionBean.setNumeroCotizacion(cotizacionService.generarNumeroCotizacion());
				
				int registro = cotizacionService.registrarCotizacion(cotizacionBean);
	
				// DATOS DE DESTINO
				String datosDestino = request.getParameter("datosDestino");				
				System.out.println("datosDestino?1 " + datosDestino);
				
				datosDestino = datosDestino.substring(0, datosDestino.length()-1 );
				System.out.println("datosDestino?2 " + datosDestino);
				
				String destino[] = datosDestino.split(",");
				CotizacionDetalleBean cotizacionDetalleBean = new CotizacionDetalleBean();
				cotizacionDetalleBean.setNumeroCotizacion(cotizacionBean.getNumeroCotizacion());
				
				String g[];
				if (destino.length > 0){
					for (int i = 0; i < destino.length; i++) {
						g = destino[i].split("_");
						
						cotizacionDetalleBean.setOrigen( Integer.parseInt( g[0] ));
						cotizacionDetalleBean.setDestino( Integer.parseInt( g[1] ));
						
						cotizacionService.registrarCotizacionDetalleTicket(cotizacionDetalleBean);
						
					}
				}
				
				String motivoViaje = request.getParameter("motivoViaje");
				String servicioAdicional = request.getParameter("servAdicional");
				// MOTIVO DE VIAJE 
				motivoViaje = motivoViaje.substring(0, motivoViaje.length()-1 );
				String motivo[] = motivoViaje.split(",");
				MotivoViajeBean motivoViajeBean = new MotivoViajeBean();
				motivoViajeBean.setNumeroCotizacion(cotizacionBean.getNumeroCotizacion());
				int m = 0;
				if (motivo.length > 0){
					for (int i = 0; i < motivo.length; i++) {
						m = Integer.parseInt( motivo[i] );
						motivoViajeBean.setCodigoMotivo(m);
						cotizacionService.registrarMotivo(motivoViajeBean);
					}
				}
				
				// SERVICIOS ADICIONALES
				servicioAdicional = servicioAdicional.substring(0, servicioAdicional.length()-1 );
				String servicio[] = servicioAdicional.split(",");
				ServicioAdicionalBean servicioAdicionalBean = new ServicioAdicionalBean();
				servicioAdicionalBean.setNumeroCotizacion(cotizacionBean.getNumeroCotizacion());
				
				m = 0;
				if (servicio.length > 0) {
					for (int i = 0; i < servicio.length; i++) {
						m = Integer.parseInt( servicio[i] );
						servicioAdicionalBean.setCodigoServicio(m);
						cotizacionService.registrarServicio(servicioAdicionalBean);
					}
				}
			} else if (tipoCotizacion.equals("2")){
				
				Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
				Map<String, Object> cotizacionBeanMap = (Map<String, Object>) parametrosRequest.get("cotizacionBean");
				CotizacionBean cotizacionBean = new CotizacionBean();
				
				// inserta en el bean todos los valores del mapa (property vs keys)
				cotizacionBeanMap.remove("motivoViajeCotiza[]");
				cotizacionBeanMap.remove("servicioAdicional[]");
				
				
				/* String datosVuelos = request.getParameter("datosVuelos");
				
				
				String flagIdaVuelta = request.getParameter("flagIdaVuelta");
				String flagIda = request.getParameter("flagIda");
				String flagRuta = request.getParameter("flagRuta");
				
				String[] datos = datosVuelos.split(";");
				
				int cantidadAdulto = 0;
				int cantidadNino= 0;
				String[] fila = null;
				CotizacionDetalleBean cotizacionDetalleBean = new CotizacionDetalleBean();
				cotizacionDetalleBean.setNumeroCotizacion((String)cotizacionBeanMap.get("numeroCotizacion"));
				for (int i = 0; i < datos.length; i++) {
					fila = datos[i].split(",");
					cotizacionDetalleBean.setFechaPartida(fila[0]);
					cotizacionDetalleBean.setFechaRetorno(fila[1]);
					cotizacionDetalleBean.setOrigen(Integer.parseInt( fila[2] ));
					cotizacionDetalleBean.setDestino(Integer.parseInt( fila[3] ));
					cotizacionDetalleBean.setCantidadAdulto(Integer.parseInt( fila[4] ));
					cotizacionDetalleBean.setCantidadNino( Integer.parseInt( fila[5] ));
					cotizacionDetalleBean.setIdaVuelta( Integer.parseInt( flagIdaVuelta) );
					cotizacionDetalleBean.setIda( Integer.parseInt( flagIda) );
					cotizacionDetalleBean.setRuta( Integer.parseInt(flagRuta) );
					
					cotizacionService.registrarCotizacionDetalleTicket(cotizacionDetalleBean);
				} */
				
				//BeanUtils.populate(cotizacionBean, cotizacionBeanMap);
				
				
				cotizacionBean.setNumeroCotizacion((String)cotizacionBeanMap.get("numeroCotizacion"));
				cotizacionBean.setFechaCotizacion( Utils.stringToStringyyyyMMdd ( (String)cotizacionBeanMap.get("fechaCotizacion")) );
				cotizacionBean.setDescripcion((String)cotizacionBeanMap.get("descripcion"));

				cotizacionBean.setCantidadNinos(0);
				cotizacionBean.setCantidadAdultos(0);
				
				cotizacionBean.setIdCliente(Integer.parseInt(idCliente) );
				int registro = cotizacionService.registrarCotizacionTicket(cotizacionBean);
				
				
			}
			
			dataJSON.setRespuesta("ok", null, mapa);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}
	
	
	
	
	
	
	@RequestMapping( value = "/verDetalleVuelos", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView verDetalleVuelos(HttpServletRequest request, HttpServletResponse response){
		
		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapa = new HashMap<String, Object>();
		
		//List<AnimalBean> listaToro = new ArrayList<AnimalBean>();
		//InseminacionBean inseminacionBean = new InseminacionBean();
		
		DataJsonBean dataJSON = new DataJsonBean();
		
		try {
			modelAndView = new ModelAndView();
	        String cadenaVuelo = request.getParameter("cadenaVuelo");
	        
	        System.out.println("cadenaVuelo? " + cadenaVuelo);
	        
	        //inseminacionBean.setCodigoInseminacion(codigoInseminacion);
	        //inseminacionBean = inseminacionService.verDetalleInseminacion(inseminacionBean);
	        
	        
	        String[] vuelo = cadenaVuelo.split("-");
	        
	        String origen = vuelo[0];
	        String destino = vuelo[1];
	        String fechaPartida = vuelo[2];
	        
	        String idOrigen = vuelo[3];
	        String idDestino = vuelo[4];
	        String nuCotizacion = vuelo[6];	        
	        
	        System.out.println("origen? " + origen);
	        System.out.println("destino? " + destino);
	        System.out.println("fechaPartida? " + fechaPartida);
	        
	        
	        //Grabamos detalle de ticket
	        
        	CotizacionDetalleBean cotizacionDetalleBean = new CotizacionDetalleBean();
        	
			cotizacionDetalleBean.setNumeroCotizacion( nuCotizacion );			
			cotizacionDetalleBean.setFechaPartida(fechaPartida);
			cotizacionDetalleBean.setFechaRetorno(fechaPartida);
			cotizacionDetalleBean.setOrigen(Integer.parseInt( idOrigen ));
			cotizacionDetalleBean.setDestino(Integer.parseInt( idDestino ));
			cotizacionDetalleBean.setCantidadAdulto(0);
			cotizacionDetalleBean.setCantidadNino(0);
			cotizacionDetalleBean.setIdaVuelta( 0 );
			cotizacionDetalleBean.setIda( 1 );
			cotizacionDetalleBean.setRuta( 0 );
			
			cotizacionService.registrarCotizacionDetalleTicket(cotizacionDetalleBean);
				
	        //API SABRE - searchAir
	        
	        URL url = new URL("http://api.decom.pe/public/reserveAir/search");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDoOutput(true);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/json");

			//String input = "{\"qty\":100,\"name\":\"iPad 4\"}";
			String input = "{\"origin\":\"" + origen + "\",\"destination\":\"" + destino + "\",\"date\":\"" + fechaPartida + "\"}";
			//,"\destination\":\"" + destino + "\", "date": "2016-10-30"

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
			
			while ((output = br.readLine()) != null) {
				
				System.out.println(output);
				
				final Gson gson = new Gson();
				
				final Type listaFareInfo = new TypeToken<List<FareInfoBean>>(){}.getType();
				
				//List<FareInfoBean> listaFareInfo = new ArrayList<FareInfoBean>();
				fareInfoList = gson.fromJson(output, listaFareInfo);
				fareInfoDetaList = new ArrayList<FareInfoBean>();
				
				for ( FareInfoBean item: fareInfoList ) {
					
					//fareInfoBean = new FareInfoBean();
					//fareInfoBean = item;
					
					System.out.println("airlineCode? " + item.getAirlineCode());
					System.out.println("fare? " + item.getFare());
					System.out.println("href? " + item.getHref());
					
					System.out.println("item? " + item.toString());
					
					item.setDestino(destino);// origen y destino(?)										
					
					//consulta los consolidadores y la mayor comision:
					
					FareInfoBean o = cotizacionService.getConsolidador(item);
					
					item.setComision(o.getComision());
					item.setNombreProveedor(o.getNombreProveedor());
					item.setNombreAerolinea(o.getNombreAerolinea());
					item.setIdProveedor(o.getIdProveedor());
					item.setIdAerolinea(o.getIdAerolinea());
					
					System.out.println("item comision? " + item.getComision());
					System.out.println("item proveedor? " + item.getNombreProveedor());
					System.out.println("item aerolinea? " + item.getNombreAerolinea());
					
					
					System.out.println("fareinfobean toString? " + item.toString());
					
					fareInfoDetaList.add(item);
					
					/* System.out.println("airlineCode? " + item.getAirlineCode());
					System.out.println("fare? " + item.getFare());
					System.out.println("href? " + item.getHref()); */
					
				}				
				
			}
			
			conn.disconnect();
	        
			
	        mapa.put("titulo", "Detalle Vuelos");
	        mapa.put("vuelosBean", fareInfoDetaList);
	        
	        //mapa.put("inseminacionBean", inseminacionBean);
	        
	        dataJSON.setRespuesta("ok", null, mapa);
	        
	        
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return ControllerUtil.handleJSONResponse(dataJSON, response);
		
	}
	
	
	
	
	@RequestMapping( value = "/grabarDetalleVuelos", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView grabarDetalleVuelos(HttpServletRequest request, HttpServletResponse response){
		
		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapa = new HashMap<String, Object>();
		
		//List<AnimalBean> listaToro = new ArrayList<AnimalBean>();
		//InseminacionBean inseminacionBean = new InseminacionBean();
		
		DataJsonBean dataJSON = new DataJsonBean();
		
		System.out.println("start grabarDetalleVuelos?");
		
		try {
			modelAndView = new ModelAndView();
			
		    //mapa.put("titulo", "Detalle Vuelos");
	        //mapa.put("vuelosBean", fareInfoDetaList);	        
	        //mapa.put("inseminacionBean", inseminacionBean);
		    
			int idCotizaDeta = 0;
			int idProveedor= Integer.parseInt(request.getParameter("idProveedor"));
			int idAerolinea= Integer.parseInt(request.getParameter("idAerolinea"));
			String fare = request.getParameter("fare");
			
			CotizacionBean cotizacionBean = new CotizacionBean();
			
			Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
			Map<String, Object> cotizacionBeanMap = (Map<String, Object>) parametrosRequest.get("cotizacionBean");
			// inserta en el bean todos los valores del mapa (property vs keys)
			BeanUtils.populate(cotizacionBean, cotizacionBeanMap);
			
		    
			CotizacionDetalleTicketVueloBean oBean = new CotizacionDetalleTicketVueloBean();
			
			oBean.setIdCotizaDeta(0);
		    oBean.setIdProveedor(idProveedor);
		    oBean.setIdAerolinea(idAerolinea);
		    oBean.setImPrecio(fare);
		    oBean.setIdCotiza(cotizacionBean.getNumeroCotizacion());
		    oBean.setUrlShop("");
		    
		    System.out.println("idProveedor? " + oBean.getIdProveedor() );
		    System.out.println("idAerolinea? " + oBean.getIdAerolinea() );
		    System.out.println("imPrecio? " + oBean.getImPrecio() );
		    System.out.println("idCotizacion? " + oBean.getIdCotiza() );
		    
		    cotizacionService.registrarConsolidador(oBean);
	        
	        dataJSON.setRespuesta("ok", null, mapa);
	        
	        
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return ControllerUtil.handleJSONResponse(dataJSON, response);
		
		
	}
	
	
//	
//	@RequestMapping( value = "/listarVacasAInseminar", method ={RequestMethod.GET, RequestMethod.POST} )
//	public ModelAndView listarVacasAInseminar(HttpServletRequest request, HttpServletResponse response){
//		
//		ModelAndView modelAndView = null;
//		Map<String, Object> mapa = new HashMap<String, Object>();
//		List<AnimalBean> listaVacasAInseminar = new ArrayList<AnimalBean>();
//		AnimalBean animalBean = new AnimalBean();
//
//		String botonBuscar = (request.getParameter("btnBuscar"))!=null?request.getParameter("btnBuscar"):"";
//		
//		boolean flag = false;
//		DataJsonBean dataJSON = new DataJsonBean();
//		
//		try {
//			
//			modelAndView = new ModelAndView();
//	        
//			
//			if("1".equals(botonBuscar)){
//				Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
//				Map<String, Object> animlalBeanMap = (Map<String, Object>) parametrosRequest.get("animalBean");
//				// inserta en el bean todos los valores del mapa (property vs keys)
//				BeanUtils.populate(animalBean, animlalBeanMap);
//				
//				listaVacasAInseminar = animalService.listarVacasAInseminar(animalBean);
//				mapa.put("listaVacasAInseminar",  listaVacasAInseminar);
//				dataJSON.setRespuesta("ok", null, mapa);
//				flag = true;
//			} else {
//				listaVacasAInseminar = animalService.listarVacasAInseminar(animalBean);
//				mapa.put("titulo", "LISTA DE VACAS A INSEMINAR");
//				
//				modelAndView.addObject("listaVacasAInseminar", SojoUtil.toJson(listaVacasAInseminar) );
//				modelAndView.addObject("mapaDatos", mapa);
//				modelAndView.setViewName("inseminacion/listarVacasAInseminar");
//			}
//			
//		} catch (Exception e) {
//			System.out.println(e.getMessage());
//		}
//		if (flag) {
//			return ControllerUtil.handleJSONResponse(dataJSON, response);
//		} else {
//			return modelAndView;
//		}
//	}
//	
	
//	
//	@RequestMapping( value = "/abrirEditarInseminacion", method ={RequestMethod.GET, RequestMethod.POST} )
//	public ModelAndView abrirEditarInseminacion(HttpServletRequest request, HttpServletResponse response){
//		
//		ModelAndView modelAndView = null;
//		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
//		Map<String, Object> mapa = new HashMap<String, Object>();
//		List<AnimalBean> listaToro = new ArrayList<AnimalBean>();
//		DataJsonBean dataJSON = new DataJsonBean();
//
//		List<InseminacionBean> listaInseminacion = new ArrayList<InseminacionBean>();
//		InseminacionBean inseminacionBean = new InseminacionBean();
//		
//		try {
//			modelAndView = new ModelAndView();
//	        String codigoInseminacion = request.getParameter("codInseminacion");
//	        
//	        inseminacionBean.setCodigoInseminacion(codigoInseminacion);
//	        listaInseminacion = inseminacionService.listarInseminacion(inseminacionBean);
//			
//	        mapa.put("titulo", "Editar Inseminaci&oacute;n");
//	        mapa.put("botonGrabar", "Editar");
//	        
//	        if (listaInseminacion != null){
//		        for (InseminacionBean inseminacionBean2 : listaInseminacion) {
//		        	String fechaInseminacion = Utils.stringToStringddMMyyyy(inseminacionBean2.getFechaInseminacion());
//		        	
//		        	mapa.put("codigoInseminacion", inseminacionBean2.getCodigoInseminacion() );
//		        	mapa.put("codigoVaca", inseminacionBean2.getCodigoVaca() );
//		        	mapa.put("nombreVaca", inseminacionBean2.getNombreVaca());
//		        	mapa.put("codigoToro", inseminacionBean2.getCodigoToro());
//		        	mapa.put("tipoInseminacion", inseminacionBean2.getTipoInseminacion());
//		        	mapa.put("fechaInseminacion", fechaInseminacion );
//		        	mapa.put("observacion", inseminacionBean2.getObservacion());
//		        	
//				}
//	        }
//			
//			dataJSON.setRespuesta("ok", null, mapa);
//
//		} catch (Exception e) {
//			System.out.println(e.getMessage());
//		}
//		return ControllerUtil.handleJSONResponse(dataJSON, response);
//	}
//

//	
//	
//	@SuppressWarnings("unchecked")
//	@RequestMapping( value = "/grabarInseminacion" )
//	public ModelAndView grabarInseminacion(HttpServletRequest request, HttpServletResponse response){
//		
//		ModelAndView modelAndView = null;
//		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
//		Map<String, Object> mapa = new HashMap<String, Object>();
//		List<AnimalBean> listaToro = new ArrayList<AnimalBean>();
//		DataJsonBean dataJSON = new DataJsonBean();
//
//		try {
//			modelAndView = new ModelAndView();
//			HttpSession session = request.getSession();
//			String usuario = (String) session.getAttribute("idUsuario");
//			
//			Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
//			Map<String, Object> inseminacionBeanMap = (Map<String, Object>) parametrosRequest.get("inseminacionBean");
//			InseminacionBean inseminacionBean = new InseminacionBean();
//			AnimalBean animalBean = new AnimalBean();
//			
//			// inserta en el bean todos los valores del mapa (property vs keys)
//			BeanUtils.populate(inseminacionBean, inseminacionBeanMap);
//	        String codigoInseminacion = inseminacionService.obtenerCodigoInseminacion();
//			inseminacionBean.setCodigoInseminacion(codigoInseminacion);
//			inseminacionBean.setFechaInseminacion( Utils.stringToStringyyyyMMdd (inseminacionBean.getFechaInseminacion()) );
//			inseminacionBean.setUsuario( usuario );
//
//			animalBean.setCodigoAnimal(inseminacionBean.getCodigoVaca());
//			animalBean.setEstadoProcesoEvolutivo("2");
//			
//			int registro = inseminacionService.registrarInseminacion(inseminacionBean);
//			int actualizaEstado = animalService.actualizaEstadoProcesoEvolutivo(animalBean);
//			
//			dataJSON.setRespuesta("ok", null, mapa);
//		} catch (Exception e) {
//			System.out.println(e.getMessage());
//		}
//		return ControllerUtil.handleJSONResponse(dataJSON, response);
//	}
//	
//	@SuppressWarnings("unchecked")
//	@RequestMapping( value = "/editarInseminacion" )
//	public ModelAndView editarInseminacion(HttpServletRequest request, HttpServletResponse response){
//		
//		ModelAndView modelAndView = null;
//		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
//		Map<String, Object> mapa = new HashMap<String, Object>();
//		DataJsonBean dataJSON = new DataJsonBean();
//
//		try {
//			modelAndView = new ModelAndView();
//			HttpSession session = request.getSession();
//
//			Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
//			Map<String, Object> inseminacionBeanMap = (Map<String, Object>) parametrosRequest.get("inseminacionBean");
//			InseminacionBean inseminacionBean = new InseminacionBean();
//			
//			// inserta en el bean todos los valores del mapa (property vs keys)
//			BeanUtils.populate(inseminacionBean, inseminacionBeanMap);
//			inseminacionBean.setFechaInseminacion( Utils.stringToStringyyyyMMdd (inseminacionBean.getFechaInseminacion()) );
//			inseminacionBean.setUsuario( session.getAttribute("idUsuario").toString() );
//
//			int registro = inseminacionService.editarInseminacion(inseminacionBean);
//			dataJSON.setRespuesta("ok", null, mapa);
//		} catch (Exception e) {
//			System.out.println(e.getMessage());
//		}
//		return ControllerUtil.handleJSONResponse(dataJSON, response);
//	}
//	
//	@SuppressWarnings("unchecked")
//	@RequestMapping( value = "/eliminarInseminacion" )
//	public ModelAndView eliminarInseminacion(HttpServletRequest request, HttpServletResponse response){
//		ModelAndView modelAndView = null;
//		InseminacionBean inseminacionBean = new InseminacionBean();		DataJsonBean dataJSON = new DataJsonBean();
//		Map<String, Object> mapa = new HashMap<String, Object>();
//		
//		try {
//			modelAndView = new ModelAndView();
//			HttpSession session = request.getSession();
//			
//			String codigoInseminacion = request.getParameter("codInseminacion");		
//			String codigoAnimal = request.getParameter("codAnimal");
//			inseminacionBean.setCodigoInseminacion(codigoInseminacion);
//			inseminacionBean.setUsuario( session.getAttribute("idUsuario").toString() );
//			inseminacionService.eliminarInseminacion(inseminacionBean);
//			
//			AnimalBean animalBean = new AnimalBean();
//			animalBean.setCodigoAnimal(codigoAnimal);
//			animalBean.setEstadoProcesoEvolutivo("1");
//			animalService.actualizaEstadoProcesoEvolutivo(animalBean);
//
//			dataJSON.setRespuesta("ok", null, mapa);
//		} catch (Exception e) {
//			System.out.println(e.getMessage());
//		}
//		return ControllerUtil.handleJSONResponse(dataJSON, response);
//	}

}









