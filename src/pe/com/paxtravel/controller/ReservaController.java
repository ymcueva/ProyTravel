package pe.com.paxtravel.controller;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.validation.ValidatorHandler;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.mysql.jdbc.Util;

import pe.com.paxtravel.bean.AnimalBean;
import pe.com.paxtravel.bean.CotizacionBean;
import pe.com.paxtravel.bean.CotizacionDetalleBean;
import pe.com.paxtravel.bean.ExpedienteLogBean;
import pe.com.paxtravel.bean.MotivoViajeBean;
import pe.com.paxtravel.bean.ReservaBean;
import pe.com.paxtravel.bean.ReservaPasajeroDetalleBean;
import pe.com.paxtravel.service.CotizacionService;
import pe.com.paxtravel.service.ReservaService;
import pe.com.paxtravel.util.ControllerUtil;
import pe.com.paxtravel.util.DataJsonBean;
import pe.com.paxtravel.util.Utils;
import pe.gob.sunat.framework.spring.util.conversion.SojoUtil;
//import pe.gob.sunat.framework.uti
//import org.apache.commons.beanutils.BeanUtils;
//import pe.com.paxtravel.service.ProduccionService;

@Controller
public class ReservaController {

	@Autowired
	private ReservaService reservaService;
	
	@Autowired
	private CotizacionService cotizacionService;

	private String jsonView;

	public String getJsonView() {
		return jsonView;
	}

	public void setJsonView(String jsonView) {
		this.jsonView = jsonView;
	}
	
	@RequestMapping( value = "/admin/listarReserva", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView listarAdminReserva(HttpServletRequest request, HttpServletResponse response){
	
		ModelAndView modelAndView = null;
		HashMap<String, Object> mapa = new HashMap<String, Object>();

		List<ReservaBean> listarReserva = new ArrayList<ReservaBean>();
		ReservaBean reservaBean = new ReservaBean();
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		
		boolean flag = false;
		DataJsonBean dataJSON = new DataJsonBean();

		try {
			modelAndView = new ModelAndView();
			
			String botonBuscar = (request.getParameter("btnBuscar"))!=null?request.getParameter("btnBuscar"):"";
			
			mapa.put("titulo", "RESERVA");
			
			if("1".equals(botonBuscar)){
				Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
				Map<String, Object> paqueteBeanMap = (Map<String, Object>) parametrosRequest.get("reservaBean");
//				// inserta en el bean todos los valores del mapa (property vs keys)
				BeanUtils.populate(reservaBean, paqueteBeanMap);
				
				if (!"".equals(reservaBean.getFechaInicio() ) ) {
					String fechaini = Utils.stringToStringyyyyMMdd(reservaBean.getFechaInicio());
					reservaBean.setFechaInicio(fechaini);
				}
				
				if (!"".equals(reservaBean.getFechaFin())) {
					String fechafin = Utils.stringToStringyyyyMMdd(reservaBean.getFechaFin());
					reservaBean.setFechaFin(fechafin);
				}
				
				if(reservaBean.getTipoBusqueda() == 1)
					reservaBean.setNumeroDocumento(reservaBean.getCliente());
				else if(reservaBean.getTipoBusqueda() == 2)
					reservaBean.setCliente("%" + reservaBean.getCliente() + "%");
				
				listarReserva = reservaService.listarReserva(reservaBean);
				
				mapa.put("listaReserva",  listarReserva);
				
				dataJSON.setRespuesta("ok", null, mapa);
				flag = true; 
				
			} else {
				
				listarReserva = reservaService.listarReserva(reservaBean);
//				
				modelAndView.addObject("listaReserva", SojoUtil.toJson(listarReserva) );
//				modelAndView.addObject("mapaDatos", mapa);
				modelAndView.setViewName("reserva/admin/listarReserva");
				
				
			}
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		if (flag) {
			return ControllerUtil.handleJSONResponse(dataJSON, response);
		} else {
			return modelAndView;
		}
	}
	
	
	@RequestMapping( value = "/cargarFormAnularReserva", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView cargarFormAnularReserva(HttpServletRequest request, HttpServletResponse response){

		Map<String, Object> mapa = new HashMap<String, Object>();
		//DataJsonBean dataJSON = new DataJsonBean();
		ModelAndView modelAndView = null;
		
		try {
			
			modelAndView = new ModelAndView();

			List<ReservaBean> obtenerCotizacion = new ArrayList<ReservaBean>();
			List<ReservaBean> listaTicketAereo = new ArrayList<ReservaBean>();
			List<ReservaBean> listaPaqueteTuristico = new ArrayList<ReservaBean>();
			
			ReservaBean reservaBean = new ReservaBean();			
			
			if ( request.getParameter("idReserva") != null ) {
				
				int idReserva = Integer.valueOf(request.getParameter("idReserva"));
			
				reservaBean.setNumeroCotizacion("");
				reservaBean.setIdReserva(idReserva);
				
				obtenerCotizacion = reservaService.obtenerCotizacion(reservaBean);
	
				mapa.put("titulo", "Cliente");
				
		        if (obtenerCotizacion.size() > 0){
		        	//String idEstadoCotizacion = obtenerCotizacion.get(0).getIdEstadoCotizacion();
		        	String numeroCotizacion= obtenerCotizacion.get(0).getNumeroCotizacion();
		        	String numeroReserva= obtenerCotizacion.get(0).getNumeroReserva();
		        	String idEstadoReserva = obtenerCotizacion.get(0).getIdEstadoReserva();
		        	
		        	mapa.put("numeroReserva", numeroReserva);
		        	mapa.put("numeroCotizacion", numeroCotizacion);
		        	
		        	System.out.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
		        	System.out.println("Estado Reserva: " + idEstadoReserva);
		        	
			        if ( idEstadoReserva.equals("14") ) {
			        	
			        	mapa.put("flagCotiEncontrada", "1");
			        	mapa.put("flagEstadoCotizacion", "1");
			        	
			        	System.out.println("La reserva se encuentra anulada");
			        	
			        } else {
			        	
			        	System.out.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			        	System.out.println("Se encontro la reserva: " + numeroReserva);
			        	
			        	String fechaReserva = obtenerCotizacion.get(0).getFechaReserva();
			        	SimpleDateFormat formateador = new SimpleDateFormat("dd/MM/yyyy");
			        	String fechaActual = formateador.format(new Date());
			        	
			            String anio = fechaReserva.substring(0, 4);
			            String mes = fechaReserva.substring(5, 7);
			            String dia = fechaReserva.substring(8 ,10);
			            fechaReserva = dia + "/" + mes + "/" + anio;
			        	
			        	int resultadoFecha = compararFechasConDate(fechaActual, fechaReserva);
			        	
			        	System.out.println("Se compara fechas: " + fechaReserva + "(fecha reserva)" + "/" + fechaActual + "(fecha sistema)");
			        	
			        	if ( resultadoFecha != 1 ){
			        		
			        		mapa.put("flagFechaValida", "0");
			        		//mapa.put("numeroCotizacion", numeroCotizacion);
			        		
			        	} else {
			        		
			        		System.out.println("La fecha fue validada");
				        	
			        		mapa.put("flagFechaValida", "1");			        						        	
				        	
					        mapa.put("nombreCliente", obtenerCotizacion.get(0).getCliente());
					        mapa.put("documentoCliente", obtenerCotizacion.get(0).getNumeroDocumento());
					        mapa.put("direccionCliente", obtenerCotizacion.get(0).getDireccion());
					        mapa.put("telefonoCliente", obtenerCotizacion.get(0).getTelefonoCliente());
					        mapa.put("fechaCotizacion", obtenerCotizacion.get(0).getFechaCotizacion());
					        mapa.put("tipoCotizacion", obtenerCotizacion.get(0).getNombreTipoCotizacion());
					        mapa.put("estadoCotizacion", obtenerCotizacion.get(0).getEstadoCotizacion());
					        mapa.put("estadoReserva", obtenerCotizacion.get(0).getNombreEstadoReserva());
					        mapa.put("numeroAdultos", obtenerCotizacion.get(0).getNumeroAdultos());
					        mapa.put("numeroNinos", obtenerCotizacion.get(0).getNumeroNinos());
					        
					        mapa.put("numeroPasajeros", (Integer.parseInt(obtenerCotizacion.get(0).getNumeroAdultos()) + Integer.parseInt(obtenerCotizacion.get(0).getNumeroNinos())));
					        mapa.put("precioCotizacion", obtenerCotizacion.get(0).getPrecioCotizacion());
					        mapa.put("idCotizacion", obtenerCotizacion.get(0).getIdCotizacion());
					        mapa.put("idCliente", obtenerCotizacion.get(0).getIdCliente());
					        mapa.put("idTipoCotizacion", obtenerCotizacion.get(0).getIdTipoCotizacion());
					        mapa.put("status", "1");
					        mapa.put("idReserva", idReserva);
				        
				        	mapa.put("flagCotiEncontrada", "");
				        	mapa.put("flagEstadoCotizacion", "");			
				        	
				        	reservaBean.setNumeroCotizacion(numeroCotizacion);
	
					        listaTicketAereo = reservaService.obtenerTicketAereoCotizacion(reservaBean);
					        listaPaqueteTuristico = reservaService.listarPaqueteCotizacion(reservaBean);
					        
							mapa.put("listaTicketAereo", SojoUtil
									.toJson(listaTicketAereo));
							
							mapa.put("listaPaqueteTuristico", SojoUtil
									.toJson(listaPaqueteTuristico));
							
							mapa.put("fechaReserva", fechaReserva);
			        	}
			        }
	
		        } else {
		        	
		        	mapa.put("status", "0");
		        	mapa.put("nombreCliente", "");
			        mapa.put("idCliente", "" );
			        mapa.put("mensajeCliente", "No se encontro el cliente. ");
			        
			        mapa.put("numeroReserva", "");
			        mapa.put("numeroCotizacion", "");
			        mapa.put("flagCotiEncontrada", "2");
			        mapa.put("flagFechaValida", "");
			        
		        }

			}												
			
	        //dataJSON.setRespuesta("ok", null, mapa);
			modelAndView.addObject("reservaBean", mapa);

		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		
		modelAndView.addObject("titulo", "ANULAR RESERVA");
		modelAndView.addObject("fechaAnularReserva", Utils.dateUtilToStringDDMMYYYY( new Date() )) ;
		modelAndView.setViewName("reserva/admin/registrarReserva");
		
		//return ControllerUtil.handleJSONResponse(dataJSON, response);
		return modelAndView;
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/admin/anularReserva")
	public ModelAndView anularReserva(HttpServletRequest request, HttpServletResponse response) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		String status = "ok";

		try {
			
			System.out.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");			
			System.out.println("Iniciando anulacion de reserva");

			Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
			
			Map<String, Object> reservaBeanMap = (Map<String, Object>) parametrosRequest.get("reservaBean");
			
			reservaBeanMap.remove("reservaPenalidad[]");

			ReservaBean reservaBean = new ReservaBean();
			BeanUtils.populate(reservaBean, reservaBeanMap);											
			
			System.out.println( "actualizar reserva..... " + reservaService.actualizarReserva(reservaBean) );
			
			System.out.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			
			int idReserva = reservaBean.getIdReserva();
			
			mapa.put("idReserva", idReserva);

			// Obtenemos los penalidades aplicadas por get
			String reservaPenalidad = request.getParameter("reservaPenalidad");
				
			if (reservaPenalidad.length() > 0) {
		
				reservaPenalidad = reservaPenalidad.substring(0, reservaPenalidad.length() - 1);		
				System.out.println("Penalidades: " + reservaPenalidad);
		
				String penalidad[] = reservaPenalidad.split(",");
				
				System.out.println("Cantidad de Penalidades: " + penalidad.length);
				
				ReservaBean oReservaPenalidad = null;
						
				if (penalidad.length > 0) {
					
					for (int i = 0; i < penalidad.length; i++) {		
						
						System.out.println("penalidad " + i + ": " + penalidad[i]);	
						
						String itemMotivo[] = penalidad[i].toString().split("-");
						
						if ( itemMotivo[0] != null && itemMotivo[1] != null ) {
							
							oReservaPenalidad = new ReservaBean();							
							oReservaPenalidad.setIdReserva(idReserva);
							oReservaPenalidad.setIdTipoPenalidad(Integer.parseInt(itemMotivo[0]));
							oReservaPenalidad.setPcPenalidad(Double.parseDouble(itemMotivo[1]));
							oReservaPenalidad.setImPenalidad(0);
							reservaService.registrarReservaPenalidad(oReservaPenalidad);
							
						}						
					}
					
				}
		
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		dataJSON.setRespuesta(status, null, mapa);
		
		return ControllerUtil.handleJSONResponse(dataJSON, response);
		
	}
		
		
	
	
	
	
	@RequestMapping( value = "/listarReserva", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView listarPaqueteTuristico(HttpServletRequest request, HttpServletResponse response){
	
		ModelAndView modelAndView = null;
		HashMap<String, Object> mapa = new HashMap<String, Object>();

		List<ReservaBean> listarReserva = new ArrayList<ReservaBean>();
		ReservaBean reservaBean = new ReservaBean();
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		
		boolean flag = false;
		DataJsonBean dataJSON = new DataJsonBean();

		try {
			modelAndView = new ModelAndView();
			
			String botonBuscar = (request.getParameter("btnBuscar"))!=null?request.getParameter("btnBuscar"):"";
			
			mapa.put("titulo", "RESERVA");
			
			if("1".equals(botonBuscar)){
				Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
				Map<String, Object> paqueteBeanMap = (Map<String, Object>) parametrosRequest.get("reservaBean");
//				// inserta en el bean todos los valores del mapa (property vs keys)
				BeanUtils.populate(reservaBean, paqueteBeanMap);
				
				if (!"".equals(reservaBean.getFechaInicio() ) ) {
					String fechaini = Utils.stringToStringyyyyMMdd(reservaBean.getFechaInicio());
					reservaBean.setFechaInicio(fechaini);
				}
				
				if (!"".equals(reservaBean.getFechaFin())) {
					String fechafin = Utils.stringToStringyyyyMMdd(reservaBean.getFechaFin());
					reservaBean.setFechaFin(fechafin);
				}
				
				if(reservaBean.getTipoBusqueda() == 1)
					reservaBean.setNumeroDocumento(reservaBean.getCliente());
				else if(reservaBean.getTipoBusqueda() == 2)
					reservaBean.setCliente("%" + reservaBean.getCliente() + "%");
				
				listarReserva = reservaService.listarReserva(reservaBean);
				
				mapa.put("listaReserva",  listarReserva);
				
				dataJSON.setRespuesta("ok", null, mapa);
				flag = true; 
				
			} else {
				
				listarReserva = reservaService.listarReserva(reservaBean);
//				
				modelAndView.addObject("listaReserva", SojoUtil.toJson(listarReserva) );
//				modelAndView.addObject("mapaDatos", mapa);
				modelAndView.setViewName("reserva/listarReserva");
				
				
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
	

	@RequestMapping( value = "/cargarFormRegistrarReserva", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView cargarFormRegistrarCotizacion(HttpServletRequest request, HttpServletResponse response){

		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapaDatos = new HashMap<String, Object>();
		List<AnimalBean> listaToro = new ArrayList<AnimalBean>();
		DataJsonBean dataJSON = new DataJsonBean();

		try {
			
			modelAndView = new ModelAndView();
//			List<CiudadBean> listaCiudad = new ArrayList<CiudadBean>();
//			List<PaisBean> listaPais = new ArrayList<PaisBean>();
//
//			CiudadBean ciudadBean = new CiudadBean();
//			PaisBean paisBean = new PaisBean();
//			ciudadBean.setIdPais(1);
//			listaCiudad = cotizacionService.listarCiudad(ciudadBean);
//			listaPais = cotizacionService.listarPais(paisBean);

			/* listaToro = animalService.listarToro();

			Map<String, Object> mapaListaToro = new HashMap<String, Object>();
			for (AnimalBean animalBean : listaToro) {
				mapaListaToro.put("codigo", animalBean.getCodigoAnimal());
				mapaListaToro.put("descripcion", animalBean.getNombreAnimal());
			}			
			mapa.put("codigoAnimal",(String) request.getParameter("codigoAnimal"));
			mapa.put("nombreAnimal",(String) request.getParameter("nombreAnimal"));
			mapa.put("listaToro", SojoUtil.toJson(mapaListaToro) );
			mapa.put("fechaActual", sdf.format( new Date() ));
			dataJSON.setRespuesta("ok", null, mapa);
			Map<String, Object> mapaDatos = new HashMap<String, Object>();
			mapaDatos.put("listTipoUsuario", listaTipoUsuario); */
			
			mapaDatos.put("titulo", "Registrar Cotizaci&oacute;n");			
			Map<String, Object> mapaListaCiudad = new HashMap<String, Object>();
			
//			for (CiudadBean ciudadBean1 : listaCiudad) {
//				mapaListaCiudad.put("idCiudad", ciudadBean1.getIdCiudad());
//				mapaListaCiudad.put("nomCiudad", ciudadBean1.getNomCiudad());
//			}

//			mapaDatos.put("listCiudad", listaCiudad);
//			mapaDatos.put("listPais", listaPais);

//			modelAndView.addObject("numeroCotizacion", cotizacionService.generarNumeroCotizacion()+"");
			modelAndView.addObject("titulo", "REGISTRAR RESERVA");
			modelAndView.addObject("mapaDatos", mapaDatos);
			modelAndView.addObject("fechaReserva", Utils.dateUtilToStringDDMMYYYY( new Date() )) ;
			modelAndView.setViewName("reserva/registrarReserva");

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return modelAndView;
	}
	
	
	@RequestMapping( value = "/obtenerCotizacion", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView obtenerCotizacion(HttpServletRequest request, HttpServletResponse response){

		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {

			List<ReservaBean> obtenerCotizacion = new ArrayList<ReservaBean>();
			List<ReservaBean> listaTicketAereo = new ArrayList<ReservaBean>();
			List<ReservaBean> listaPaqueteTuristico = new ArrayList<ReservaBean>();
			
			ReservaBean reservaBean = new ReservaBean();
			String numeroCotizacion = request.getParameter("numeroCotizacion");
			reservaBean.setNumeroCotizacion(numeroCotizacion);
			
			obtenerCotizacion = reservaService.obtenerCotizacion(reservaBean);

			mapa.put("titulo", "Cliente");
			String idTipoCotizacion = "";
			
	        if (obtenerCotizacion.size() > 0){
	        	String idCotizacion = obtenerCotizacion.get(0).getIdEstadoCotizacion();
	        	
		        if (! idCotizacion.equals("15")) {
		        	mapa.put("flagCotiEncontrada", "1");
		        	mapa.put("flagEstadoCotizacion", "1");
		        	mapa.put("numeroCotizacion", obtenerCotizacion.get(0).getNumeroCotizacion());
		        } else {

		        	String fechaCotizacion = obtenerCotizacion.get(0).getFechaCotizacion();
		        	SimpleDateFormat formateador = new SimpleDateFormat("dd/MM/yyyy");
		        	String fechaActual = formateador.format(new Date());
		        	
		            String anio = fechaCotizacion.substring(0, 4);
		            String mes = fechaCotizacion.substring(5, 7);
		            String dia = fechaCotizacion.substring(8 ,10);
		            fechaCotizacion = dia + "/" + mes + "/" + anio;
		        	
		        	int resultadoFecha = compararFechasConDate(fechaCotizacion, fechaActual);
		        	
		        	if (resultadoFecha != 1){
		        		
		        		mapa.put("flagFechaValida", "0");
		        		mapa.put("numeroCotizacion", numeroCotizacion);
		        	} else {
			        	
		        		mapa.put("flagFechaValida", "1");
		        		
			        	idTipoCotizacion = obtenerCotizacion.get(0).getIdTipoCotizacion() + "";
			        	
				        mapa.put("nombreCliente", obtenerCotizacion.get(0).getCliente());
				        mapa.put("documentoCliente", obtenerCotizacion.get(0).getNumeroDocumento());
				        mapa.put("direccionCliente", obtenerCotizacion.get(0).getDireccion());
				        mapa.put("telefonoCliente", obtenerCotizacion.get(0).getTelefonoCliente());
				        mapa.put("fechaCotizacion", obtenerCotizacion.get(0).getFechaCotizacion());
				        mapa.put("tipoCotizacion", obtenerCotizacion.get(0).getNombreTipoCotizacion());
				        mapa.put("estadoCotizacion", obtenerCotizacion.get(0).getEstadoCotizacion());
				        mapa.put("numeroAdultos", obtenerCotizacion.get(0).getNumeroAdultos());
				        mapa.put("numeroNinos", obtenerCotizacion.get(0).getNumeroNinos());
				        mapa.put("precioCotizacion", obtenerCotizacion.get(0).getPrecioCotizacion());
				        mapa.put("idCotizacion", obtenerCotizacion.get(0).getIdCotizacion());
				        mapa.put("idCliente", obtenerCotizacion.get(0).getIdCliente());
				        mapa.put("idTipoCotizacion", obtenerCotizacion.get(0).getIdTipoCotizacion());
				        mapa.put("status", "1");
			        
			        	mapa.put("flagCotiEncontrada", "");
			        	mapa.put("flagEstadoCotizacion", "");
			        	

				        listaTicketAereo = reservaService.obtenerTicketAereoCotizacion(reservaBean);
				        listaPaqueteTuristico = reservaService.listarPaqueteCotizacion(reservaBean);
				        
						mapa.put("listaTicketAereo", listaTicketAereo);
						mapa.put("listaPaqueteTuristico", listaPaqueteTuristico);
		        	}
		        }

	        } else {
	        	mapa.put("status", "0");
	        	mapa.put("nombreCliente", "");
		        mapa.put("idCliente", "" );
		        mapa.put("mensajeCliente", "No se encontro el cliente. ");
		        
		        mapa.put("numeroCotizacion", numeroCotizacion);
		        mapa.put("flagCotiEncontrada", "2");
		        mapa.put("flagFechaValida", "");
	        }


	        dataJSON.setRespuesta("ok", null, mapa);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}
	
	
	@RequestMapping( value = "/grabarReserva", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView grabarReserva(HttpServletRequest request, HttpServletResponse response){
		
		System.out.println("grabar paquete ...........................................");
		
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();		
		
		try {
			
			mapa.put("titulo", "Grabar Paquete");			
			
			String datosPasajeros = request.getParameter("datosPasajeros");
			String idCotizacion = request.getParameter("idCotizacion");
			ReservaBean reservaBean = new ReservaBean();
			
			Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
			Map<String, Object> reservaBeanMap = (Map<String, Object>) parametrosRequest.get("reservaBean");
			BeanUtils.populate(reservaBean, reservaBeanMap);
			
			String numeroReserva = reservaService.generarNumeroReserva();
			reservaBean.setNumeroReserva(numeroReserva);
			reservaBean.setIdCotizacion( Integer.parseInt( idCotizacion ) );
			reservaBean.setIdCliente( Integer.parseInt( request.getParameter("idCliente") ) );
			reservaBean.setIdTipoCotizacion( Integer.parseInt( request.getParameter("idTipoCotizacion") ) );
			reservaBean.setFechaReserva( Utils.dateUtilToStringYYYYMMDD( new Date() ) );
			reservaBean.setFechaRegistro( Utils.dateUtilToStringYYYYMMDD( new Date() ) );
			reservaBean.setIdUsuario(0);
			reservaBean.setEstadoCotizacion("12");
			
			int idReserva = reservaService.registrarReserva(reservaBean);
			
			// registrando a los pasajeros de la reserva
			if ( datosPasajeros.length() > 0 ) {

				String pasajeros[] = datosPasajeros.split(",");				
				String camposPasajeros[];
				if ( pasajeros.length > 0 ) {		
					
					System.out.println("cantidad de vuelos" + pasajeros.length);
				
					for (int i = 0; i < pasajeros.length; i++) {
						
						System.out.println("sString de detalle de pasajeros["+i+"]" + pasajeros[i]);
	
						camposPasajeros = pasajeros[i].split("_");
						
						ReservaPasajeroDetalleBean pasajeroDeta = new ReservaPasajeroDetalleBean();
						
						pasajeroDeta.setIdReserva(idReserva);
						pasajeroDeta.setTipoDocumento( camposPasajeros[0] );
						pasajeroDeta.setNumeroDocumento( camposPasajeros[1] );
						pasajeroDeta.setNombres( camposPasajeros[2] );
						pasajeroDeta.setApellidos( camposPasajeros[3] );
						pasajeroDeta.setFechaNacimiento( camposPasajeros[4] );
						pasajeroDeta.setIdParentesco( Integer.parseInt(camposPasajeros[5]) );
						
						int res = reservaService.registrarReservaPasajero(pasajeroDeta);
					}
				}												
			}
			
			// actualiza la cotización a estado Reservado - 11
			CotizacionBean cotizacionBean = new CotizacionBean();
			cotizacionBean.setIdEstado(11);
			cotizacionBean.setIdCotizacion( Integer.parseInt( idCotizacion ) );
			cotizacionService.actualizarCotizacion(cotizacionBean);
			
			// expediente - auditoria
			// registra en auditoria el cambio de estado en COTIZACION - Reservado
			ExpedienteLogBean expedienteLogBean = new ExpedienteLogBean();
			expedienteLogBean.setTiLog("COTIZA");
			expedienteLogBean.setIdTx( Integer.parseInt( idCotizacion ) );
			expedienteLogBean.setIdUser(0);
			expedienteLogBean.setIdEstado(11);
			expedienteLogBean.setDesLog("Cotizacion - Estado Reservado");
			cotizacionService.registrarExpedienteLog(expedienteLogBean);
			
			// registra en auditoria el cambio de estado en RESERVA - Confirmado
			expedienteLogBean.setTiLog("RESERVA");
			expedienteLogBean.setIdTx( idReserva );
			expedienteLogBean.setIdUser(0);
			expedienteLogBean.setIdEstado(12);
			expedienteLogBean.setDesLog("Reserva - Estado Confirmado");
			cotizacionService.registrarExpedienteLog(expedienteLogBean);

			mapa.put("numeroReserva", numeroReserva);
			
			dataJSON.setRespuesta("ok", null, mapa);
			
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}
	
	@RequestMapping( value = "/verDetalleReserva", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView verDetalleReserva(HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {
			ReservaBean o = new ReservaBean();
			int idReserva = Integer.parseInt( request.getParameter("idReserva") );
			o.setIdReserva(idReserva);
			o = reservaService.obtenerReserva(o);
	        mapa.put("titulo", "Detalle Reserva");
	        mapa.put("reserva", o);
	        dataJSON.setRespuesta("ok", null, mapa);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}
	
	@RequestMapping( value = "/buscarPasajero", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView buscarPasajero(HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {
			
			String numeroDocumento = request.getParameter("numeroDocumento");
			
			// actualiza la reserva a estado Emitido - 13
			ReservaBean reservaBean = new ReservaBean();
			reservaBean.setNumeroDocumentoPasajero(numeroDocumento);
			
			reservaBean = reservaService.buscarDocumentoXPasajero(reservaBean);
			
			if (reservaBean != null) {
				mapa.put("resultado", "1");
				mapa.put("nombresPasajero", reservaBean.getNombresPasajero());
				mapa.put("apellidosPasajero", reservaBean.getApellidosPasajero());
				mapa.put("fechaNacimiento", reservaBean.getFechaNacimiento());
				mapa.put("idParentesco", reservaBean.getIdParentesco());
			} else {
				mapa.put("resultado", "0");
			}
			
	        
	        dataJSON.setRespuesta("ok", null, mapa);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}
	
	
	@RequestMapping( value = "/enviarReservaCliente", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView enviarReservaCliente(HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {
			
			int idReserva = Integer.parseInt( request.getParameter("idReserva") );
			String numReserva = request.getParameter("numReserva");
			
			// actualiza la reserva a estado Emitido - 13
			ReservaBean reservaBean = new ReservaBean();
			reservaBean.setIdReserva( idReserva );
			reservaBean.setIdEstadoReserva("13");
			reservaBean.setNumeroReserva(numReserva);
			
			Integer validaCorreoCliente = Integer.parseInt(reservaService.validaCorreo(reservaBean) );
			if (validaCorreoCliente == 0) {
				
				mapa.put("flagValidaCorreo", "1");
				
			} else {
				
				reservaService.actualizarEstadoReserva(reservaBean);
				
				ExpedienteLogBean expedienteLogBean = new ExpedienteLogBean();
				 
				// registra en auditoria el cambio de estado en RESERVA - Emitido
				expedienteLogBean.setTiLog("RESERVA");
				expedienteLogBean.setIdTx( idReserva );
				expedienteLogBean.setIdUser(0);
				expedienteLogBean.setIdEstado(13);
				expedienteLogBean.setDesLog("Reserva - Estado Emitido");
				cotizacionService.registrarExpedienteLog(expedienteLogBean);
				
		        mapa.put("flagValidaCorreo", "0");
			}
			mapa.put("titulo", "Detalle Reserva");
	        mapa.put("numReserva", numReserva);
	        dataJSON.setRespuesta("ok", null, mapa);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}
	
	private int compararFechasConDate(String fecha1, String fechaActual) {
		System.out.println("Parametro String Fecha 1 = " + fecha1 + "\n"
				+ "Parametro String fechaActual = " + fechaActual + "\n");
		int resultado = 0;
		try {
			/** Obtenemos las fechas enviadas en el formato a comparar */
			SimpleDateFormat formateador = new SimpleDateFormat("dd/MM/yyyy");
			Date fechaDate1 = formateador.parse(fecha1);
			Date fechaDate2 = formateador.parse(fechaActual);

			System.out.println("Parametro Date Fecha 1 = " + fechaDate1 + "\n"
					+ "Parametro Date fechaActual = " + fechaDate2 + "\n");

			if (fechaDate1.before(fechaDate2)) {
				// "La Fecha 1 es menor "
				resultado = 1;;
			} else {
				if (fechaDate2.before(fechaDate1)) {
					//"La Fecha 1 es Mayor "
					resultado = 0;
				} else {
					// "Las Fechas Son iguales "
					resultado = 1;
				}
			}
		} catch (ParseException e) {
			System.out.println("Se Produjo un Error!!!  " + e.getMessage());
		}
		return resultado;
	}
	
}
