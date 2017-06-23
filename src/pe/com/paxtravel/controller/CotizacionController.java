package pe.com.paxtravel.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
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
import pe.com.paxtravel.bean.ExpedienteLogBean;
import pe.com.paxtravel.bean.FareInfoBean;
import pe.com.paxtravel.bean.HotelHabitacionBean;
import pe.com.paxtravel.bean.InseminacionBean;
import pe.com.paxtravel.bean.MotivoViajeBean;
import pe.com.paxtravel.bean.OrdenPlanificacionBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.PaqueteResumeBean;
import pe.com.paxtravel.bean.ProduccionBean;
import pe.com.paxtravel.bean.ServicioAdicionalBean;
import pe.com.paxtravel.service.AnimalService;
import pe.com.paxtravel.service.CotizacionService;
import pe.com.paxtravel.service.EmpleadoService;
import pe.com.paxtravel.service.InseminacionService;
import pe.com.paxtravel.tree.data.CSVUtils;
import pe.com.paxtravel.tree.data.PaqueteManagerBean;
import pe.com.paxtravel.tree.decision.DataManager;
import pe.com.paxtravel.tree.decision.DataManagerTest2;
import pe.com.paxtravel.tree.decision.TableManager;
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
	
	@RequestMapping( value = "/verDetalleCotizacion", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView verDetalleCotizacion(HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {
			CotizacionBean o = new CotizacionBean();
			int idCotizacion = Integer.parseInt( request.getParameter("idCotizacion") );
			o.setIdCotizacion(idCotizacion);
			o = cotizacionService.obtenerCotizacion(o);
	        mapa.put("titulo", "Detalle Cotizaci&oacute;n");
	        mapa.put("cotizacion", o);
	        dataJSON.setRespuesta("ok", null, mapa);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
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

		System.out.println("Bienvenido a listar cotizacion 22");

		try {
			modelAndView = new ModelAndView();

			String botonBuscar = (request.getParameter("btnBuscar"))!=null?request.getParameter("btnBuscar"):"";

			mapa.put("titulo", "");

			System.out.println("boton: " + botonBuscar);

			if("1".equals(botonBuscar)){
				
				System.out.println("Ingreso....");

				Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
				Map<String, Object> cotizacionBeanMap = (Map<String, Object>) parametrosRequest.get("cotizacionBean");
				
				//"numeroCotizacion":"","codigoEstadoCotizacion":"1","fechaCotizacion":"14/06/2017","tipoBusqueda":"1","nombreCliente"
				
				System.out.println("[cotizacionBeanMap]");
				
				System.out.println("numeroCotizacion: " + cotizacionBeanMap.get("numeroCotizacion") );
				System.out.println("codigoEstadoCotizacion: " + cotizacionBeanMap.get("codigoEstadoCotizacion") );
				System.out.println("fechaCotizacion: " + cotizacionBeanMap.get("fechaCotizacion") );
				System.out.println("tipoBusqueda: " + cotizacionBeanMap.get("tipoBusqueda") );
				System.out.println("nombreCliente: " + cotizacionBeanMap.get("nombreCliente") );
				
				// inserta en el bean todos los valores del mapa (property vs keys)
				BeanUtils.populate(cotizacionBean, cotizacionBeanMap);
				
				System.out.println("[cotizacionBean]");
				
				System.out.println("numeroCotizacion: " + cotizacionBean.getNumeroCotizacion() );
				System.out.println("codigoEstadoCotizacion: " + cotizacionBean.getCodigoEstadoCotizacion() );
				System.out.println("fechaCotizacion: " + cotizacionBean.getFechaCotizacion() );
				System.out.println("tipoBusqueda: " + cotizacionBean.getTipoBusqueda() );
				System.out.println("nombreCliente: " + cotizacionBean.getNombreCliente() );

				if (!"".equals(cotizacionBean.getFechaCotizacion()) ) {					
					String fechaCotizacion = Utils.stringToStringyyyyMMdd(cotizacionBean.getFechaCotizacion());
					cotizacionBean.setFechaCotizacion(fechaCotizacion);					
				}
				
				if (cotizacionBean.getTipoBusqueda() == 1) {
					cotizacionBean.setDocumentoCliente(cotizacionBean.getNombreCliente());
					cotizacionBean.setNombreCliente("");
				} else if (cotizacionBean.getTipoBusqueda() == 2) {
					cotizacionBean.setDocumentoCliente("");
					cotizacionBean.setNombreCliente("%" + cotizacionBean.getNombreCliente() + "%");
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

			System.out.println("fin: ");

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		System.out.println("......................... ");

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
			cotizacionBean.setIdEstado(4);

			System.out.println("FechaCotizacion: " + cotizacionBean.getFechaCotizacion());
			System.out.println("fechaSalida: " + cotizacionBean.getFechaSalida());
			System.out.println("fechaRetorno: " + cotizacionBean.getFechaRetorno());
			System.out.println("idTipoCotizacion: " + cotizacionBean.getIdTipoCotizacion());
			System.out.println("idOrigenPartida: " + cotizacionBean.getIdOrigenPartida());

			int registro = cotizacionService.registrarCotizacion(cotizacionBean);

			System.out.println("grabarCotiPaquete: [Status:"+ registro +",Id:"+cotizacionBean.getIdCotizacion()+",Nro:"+cotizacionBean.getNumeroCotizacion()+"]");
			
			//Mensaje de respusta a la vista:
			String htmlMensaje = "La cotización Nro. <strong>" + cotizacionBean.getNumeroCotizacion() + "</strong> ha sido registrada <br /><br />";			
			
			htmlMensaje += "A continuación el detalle de la cotización <strong>Paquete Turístico</strong><br /><br />";

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
					
					htmlMensaje += "Se consideran los siguientes motivos en su viaje: ";

					for (int i = 0; i < motivo.length; i++) {

						System.out.println("motivo"+i+": "+motivo[i]);

						m = Integer.parseInt( motivo[i] );
						motivoViajeBean.setCodigoMotivo(m);
						
						htmlMensaje += (m==1)?"Cultural":(m==2)?"Deportes":(m==3)?"Relajación":(m==4)?"Playa":"";
						
						int res = cotizacionService.registrarMotivo(motivoViajeBean);
						System.out.println("registrarMotivo("+m+") " + res);
					}
					
					htmlMensaje += "<br />";
					
				}

			}

			System.out.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("Iniciando grabar Destinos");

			String datosDestino = request.getParameter("datosDestino");
			
			List<CotizacionDetalleBean> cotizacionDestinos = null;			

			if ( datosDestino.length() > 0 ) {

				datosDestino = datosDestino.substring(0, datosDestino.length()-1 );
				System.out.println("Destinos: " + datosDestino);

				String destino[] = datosDestino.split(",");
				System.out.println("Cantidad de Destinos: " + destino.length);

				CotizacionDetalleBean cotizacionDetalleBean = new CotizacionDetalleBean();
				cotizacionDetalleBean.setNumeroCotizacion(cotizacionBean.getNumeroCotizacion());

				String g[];
				cotizacionDestinos = new ArrayList<CotizacionDetalleBean>();

				if (destino.length > 0){
					for (int i = 0; i < destino.length; i++) {

						g = destino[i].split("_");

						cotizacionDetalleBean.setOrigen( Integer.parseInt( g[0] ));
						cotizacionDetalleBean.setDestino( Integer.parseInt( g[1] ));

						int res = cotizacionService.registrarCotizacionDetalleTicket(cotizacionDetalleBean);
						
						cotizacionDetalleBean.setIdCotizacion(cotizacionBean.getIdCotizacion());
						cotizacionDestinos.add(cotizacionDetalleBean);

						System.out.println("registrarDestino("+g[0] + "/" + g[1] +") " + res);

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
			
			System.out.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("Iniciando grabar Servicios Adicionales: Tipo Habitacion");

			String servicioTipoHab = request.getParameter("datosHoteles");

			if ( servicioTipoHab.length() > 0 ) {

				servicioTipoHab = servicioTipoHab.substring(0, servicioTipoHab.length()-1 );
				System.out.println("Servicio Tipo Habitacion: " + servicioTipoHab);

				String servicio[] = servicioTipoHab.split(",");
				System.out.println("Cantidad de servicio Tipo Habitacion: " + servicio.length);
				
				HotelHabitacionBean oHab = new HotelHabitacionBean();
				oHab.setIdCotiza(cotizacionBean.getNumeroCotizacion());
				
				if (servicio.length > 0) {
					String g[];
					
					for (int i = 0; i < servicio.length; i++) {						
						g = servicio[i].split("_");
						
						oHab.setIdTipoHabitacion(Integer.parseInt( g[0] ));
						oHab.setNuHabitacion(Integer.parseInt( g[1] ));
						
						int res = cotizacionService.registrarHabitacion(oHab);

						System.out.println("registrar servicio Tipo Habitacion("+servicio[i] +") " + res);
					}
				}
			}
			
			System.out.println("msghtml: " + htmlMensaje);
			
			////////////////////////////////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////////////////////////////
			//BUSQUEDA DE PAQUETES
			/*
			//1- TIPO DE PROGRAMA
			int tipoPrograma = cotizacionBean.getIdTipoPrograma();
			
			//2- PRESUPUESTO: ALTO, MEDIO, BAJO
			double precioPresupuestoPrograma = cotizacionBean.getPresupuestoMaximo();			
			PaqueteManagerBean oPaquete = new PaqueteManagerBean();			
			oPaquete.setImPrecio(precioPresupuestoPrograma);
			oPaquete.setIdTipoPaquete(tipoPrograma);			
			
			//3- MODELO DESTINOS: A, B Y C
			List<PaqueteManagerBean> listPaqueteSearch = new ArrayList<PaqueteManagerBean>();
			List<PaqueteManagerBean> listCotizacionManBeanAlto = null;
			List<PaqueteManagerBean> listCotizacionManBeanMedio = null;
			List<PaqueteManagerBean> listCotizacionManBeanBajo = null;
			
			//Se realizan 3 iteracciones, uno por categoria de presupuesto: Alto, Medio y Bajo
			for ( int i=0; i<3; i++ ) {
								
				if (i == 0) {
					//3.1- Primera Iteracion: Presupuesto ALTO					
					oPaquete.setImPrecioMax(oPaquete.getImPrecioMaxAlto());
					oPaquete.setImPrecioMin(oPaquete.getImPrecioMinAlto());
					oPaquete.setTiPresupuestoValue("Alto");
					listCotizacionManBeanAlto = cotizacionService.listarPaquete(oPaquete);					
					for (PaqueteManagerBean o:listCotizacionManBeanAlto){
						if ( !listPaqueteSearch.contains(o) ) {
							System.out.println("listPaqueteSearch[id_paquete:"+o.getIdPaquete()+", nombre:"+o.getNomPaquete()+", comentario:"+o.getComentario()+", im_precio:"+o.getImPrecio()+", tipoPresupuesto:"+o.getTiPresupuestoValue()+"]");
							listPaqueteSearch.add(o);
						}
					}					
				} else if (i ==1){
					//3.2- Segunda Iteracion: Presupuesto MEDIO					
					oPaquete.setImPrecioMax(oPaquete.getImPrecioMaxMedio());
					oPaquete.setImPrecioMin(oPaquete.getImPrecioMinMedio());
					oPaquete.setTiPresupuestoValue("Medio");
					listCotizacionManBeanMedio = cotizacionService.listarPaquete(oPaquete);					
					for (PaqueteManagerBean o:listCotizacionManBeanMedio){
						if ( !listPaqueteSearch.contains(o) ) {
							System.out.println("listPaqueteSearch[id_paquete:"+o.getIdPaquete()+", nombre:"+o.getNomPaquete()+", comentario:"+o.getComentario()+", im_precio:"+o.getImPrecio()+", tipoPresupuesto:"+o.getTiPresupuestoValue()+"]");
							listPaqueteSearch.add(o);
						}
					}
				} else if (i == 2){
					//3.3- Tercera Iteracion: Presupuesto BAJO					
					oPaquete.setImPrecioMax(oPaquete.getImPrecioMaxBajo());
					oPaquete.setImPrecioMin(oPaquete.getImPrecioMinBajo());
					oPaquete.setTiPresupuestoValue("Bajo");
					listCotizacionManBeanBajo = cotizacionService.listarPaquete(oPaquete);					
					for (PaqueteManagerBean o:listCotizacionManBeanBajo){
						if ( !listPaqueteSearch.contains(o) ) {
							System.out.println("listPaqueteSearch[id_paquete:"+o.getIdPaquete()+", nombre:"+o.getNomPaquete()+", comentario:"+o.getComentario()+", im_precio:"+o.getImPrecio()+", tipoPresupuesto:"+o.getTiPresupuestoValue()+"]");
							listPaqueteSearch.add(o);
						}
					}
				}
				
			}
			//Se obtienen todos los paquetes disponibles en: listPaqueteSearch();	
			
			//Se filtran todos los destinos para estos paquetes y se guardan en: destinosList();
			oPaquete.setList(cotizacionDestinos);
			List<PaqueteManagerBean> destinosList = cotizacionService.listarPaqueteDestino(oPaquete);
			List<Integer> paqueteIds = new ArrayList<Integer>();
						
			//4- PAQUETES
			System.out.println("Paquetes finales.......................");
			for (PaqueteManagerBean  o:destinosList) {															
				if ( !paqueteIds.contains(o.getIdPaquete()) ) {
					paqueteIds.add(o.getIdPaquete());
					System.out.println("PaqueteID: " + o.getIdPaquete());
				}
			}
			
			//5- CARACTERISTICAS
			*/
			
			mapa.put("nroCotizacion", cotizacionBean.getNumeroCotizacion());			
			
			status = "ok";
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		dataJSON.setRespuesta(status, null, mapa);
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping( value = "/grabarCotiTicket" )
	public ModelAndView grabarCotiTicket(HttpServletRequest request, HttpServletResponse response){
		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapa = new HashMap<String, Object>();
		List<AnimalBean> listaToro = new ArrayList<AnimalBean>();
		DataJsonBean dataJSON = new DataJsonBean();

		try {
			
			modelAndView = new ModelAndView();
			
			System.out.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("Iniciando grabarCotiTicket");
			
			String idCliente = (request.getParameter("idCliente")==null?"":request.getParameter("idCliente"));

			Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
			Map<String, Object> cotizacionBeanMap = (Map<String, Object>) parametrosRequest.get("cotizacionBean");
			
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
			cotizacionBean.setIdEstado(10);
			
			try {
				
				cotizacionBean.setFechaSalida( "0000-00-00" );
				cotizacionBean.setFechaRetorno( "0000-00-00" );
				cotizacionBean.setTipoAlojamiento("0");
				cotizacionBean.setCategoriaAlojamiento("0");
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				System.out.println("ERROR EN FECHAS " + e.getMessage());
			}
			
			
			System.out.println("FechaCotizacion: " + cotizacionBean.getFechaCotizacion());
			System.out.println("fechaSalida: " + cotizacionBean.getFechaSalida());
			System.out.println("fechaRetorno: " + cotizacionBean.getFechaRetorno());
			System.out.println("idTipoCotizacion: " + cotizacionBean.getIdTipoCotizacion());
			System.out.println("idOrigenPartida: " + cotizacionBean.getIdOrigenPartida());
			
			System.out.println("llego grabarCotiTicket");
			int registro = cotizacionService.registrarCotizacion(cotizacionBean);	
			System.out.println("salio grabarCotiTicket");
			
			System.out.println("grabarCotiTicket: [Status:"+ registro +",Id:"+cotizacionBean.getIdCotizacion()+",Nro:"+cotizacionBean.getNumeroCotizacion()+"]");
			
			String datosVuelos = request.getParameter("datosVuelos");
			System.out.println("longitud del string de vuelos: " + datosVuelos.length());
			
			if ( datosVuelos.length() > 0 ) {

				datosVuelos = datosVuelos.substring(0, datosVuelos.length()-1 );
				
				System.out.println("string de vuelos: " + datosVuelos);
				
				String vuelos[] = datosVuelos.split(";");				
				
				String g[];
				
				if ( vuelos.length > 0 ) {		
					
					System.out.println("cantidad de vuelos" + vuelos.length);
				
					for (int i = 0; i < vuelos.length; i++) {
						
						System.out.println("string de detalle de vuelos["+i+"]" + vuelos[i]);
	
						g = vuelos[i].split(",");
						
						CotizacionDetalleBean oCotizacionDetalleBean = new CotizacionDetalleBean();
						
						oCotizacionDetalleBean.setNumeroCotizacion(cotizacionBean.getNumeroCotizacion());
						oCotizacionDetalleBean.setOrigen( Integer.parseInt( g[2] ));
						oCotizacionDetalleBean.setDestino( Integer.parseInt( g[3] ));
						oCotizacionDetalleBean.setFechaPartida(Utils.stringToStringyyyyMMdd ( g[0] ));
						
						if ( g[4].toString().equals("0") ) {
							oCotizacionDetalleBean.setFechaRetorno(Utils.stringToStringyyyyMMdd ( g[1] ));
						} else {
							oCotizacionDetalleBean.setFechaRetorno("0000-00-00");
						}
						
						oCotizacionDetalleBean.setTiIda(Integer.parseInt( g[4] ));
						
						//fPartidaTicket+","+fRetornoTicket+","+ciudadOrigenVal+","+ciudadDestinoVal+","+ parseInt(isSoloIda)+";
	
						int res = cotizacionService.registrarCotizacionDetalleTicket(oCotizacionDetalleBean);
	
						System.out.println("registrarCotizacionDetalleTicket("+g[0] + "/" + g[1]+ "/" + g[2]+ "/" + g[3]+ "/" + g[4] +") " + res);
	
					}
				}												
				
			}
			
			/*			
			
			System.out.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("Iniciando grabar Vuelos");

			String datosDestino = request.getParameter("datosVuelos");

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
			*/			
			
			//Mensaje de respuesta con el detalle de los destinos para el ticket
			CotizacionDetalleBean cotizacionDetalleBean=new CotizacionDetalleBean();  
			cotizacionDetalleBean.setNumeroCotizacion(cotizacionBean.getNumeroCotizacion());
			List<CotizacionDetalleBean> listDestinosDetalle = cotizacionService.listarDestinosDetail(cotizacionDetalleBean);
			String mensajeHtml="";
			
			for (CotizacionDetalleBean item:listDestinosDetalle ){
				mensajeHtml += "<strong>" + item.getDesTiVuelo() + "</strong>: ";
				
				String vuelo = item.getDesCiudadOrigen() + " (" + item.getIsoCiudadOrigen() + ")" + " - " +  
						item.getDesCiudadDestino() + " (" + item.getIsoCiudadDestino() + ")";
				
				mensajeHtml += vuelo;
				
				if ( item.getTiIda() == 0 ) {					
					//Ida yVuelta
					vuelo = "<br />" + item.getDesCiudadDestino() + " (" + item.getIsoCiudadDestino() + ")" + " - " +
							item.getDesCiudadOrigen() + " (" + item.getIsoCiudadOrigen() + ")";
					mensajeHtml += vuelo;
				}
				
				mensajeHtml += "<br /><br />";
			}
			
			mapa.put("nroCotizacion", cotizacionBean.getNumeroCotizacion());
			mapa.put("idCotizacion", cotizacionBean.getIdCotizacion());
			mapa.put("listDestinosDetalle", listDestinosDetalle);
			mapa.put("detalle", mensajeHtml);
			
			dataJSON.setRespuesta("ok", null, mapa);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ERROR.............................................");
			System.out.println(e.getMessage());
		}
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
		
	@RequestMapping( value = "/enviarPaquete", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView enviarPaquete(HttpServletRequest request, HttpServletResponse response){
		
		System.out.println("enviar paquete ...........................................");
		
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();		
		
		try {
			
			mapa.put("titulo", "Enviar Paquete");			
			
			int idCotizacion = Integer.parseInt(request.getParameter("idCotizacion"));			
			
			CotizacionBean cotizacionBean = new CotizacionBean();
			cotizacionBean.setIdEstado(9);
			cotizacionBean.setIdCotizacion(idCotizacion);
			cotizacionService.actualizarCotizacion(cotizacionBean);
			
			ExpedienteLogBean expedienteLogBean = new ExpedienteLogBean();
			expedienteLogBean.setTiLog("COTIZA");
			expedienteLogBean.setIdTx(idCotizacion);
			expedienteLogBean.setIdUser(0);
			expedienteLogBean.setIdEstado(9);
			expedienteLogBean.setDesLog("Cotizacion Enviada");
			
			cotizacionService.registrarExpedienteLog(expedienteLogBean);
			
			dataJSON.setRespuesta("ok", null, mapa);
			
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return ControllerUtil.handleJSONResponse(dataJSON, response);
		
	}
	
	@RequestMapping( value = "/grabarPaquete", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView grabarPaquete(HttpServletRequest request, HttpServletResponse response){
		
		System.out.println("grabar paquete ...........................................");
		
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();		
		
		try {
			
			mapa.put("titulo", "Grabar Paquete");			
			
			int idCotizacion = Integer.parseInt(request.getParameter("idCotizacion"));
			int idPaquete = Integer.parseInt(request.getParameter("idPaquete"));
			
			CotizacionBean cotizacionBean = new CotizacionBean();
			cotizacionBean.setIdEstado(5);
			cotizacionBean.setIdCotizacion(idCotizacion);
			cotizacionBean.setIdPaquete(idPaquete);
			cotizacionService.actualizarCotizacion(cotizacionBean);
			
			ExpedienteLogBean expedienteLogBean = new ExpedienteLogBean();
			expedienteLogBean.setTiLog("COTIZA");
			expedienteLogBean.setIdTx(idCotizacion);
			expedienteLogBean.setIdUser(0);
			expedienteLogBean.setIdEstado(5);
			expedienteLogBean.setDesLog("Cotizacion Finalizada");
			
			cotizacionService.registrarExpedienteLog(expedienteLogBean);
			
			dataJSON.setRespuesta("ok", null, mapa);
			
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return ControllerUtil.handleJSONResponse(dataJSON, response);
		
	}
		
	@RequestMapping( value = "/buscarPaquete", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView buscarPaquete(HttpServletRequest request, HttpServletResponse response){
		
		System.out.println("buscar paquete ...........................................");
		
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		PaqueteManagerBean oPaquete = new PaqueteManagerBean();

		try {
			
			//////////////////////////////////////////////////////////////////////////////////////			
			//BUSQUEDA DE PAQUETES
			
			int idCotizacion = Integer.parseInt(request.getParameter("idCotizacion"));
			
			CotizacionBean cotizacionBean = new CotizacionBean();
			cotizacionBean.setIdCotizacion(idCotizacion);
			cotizacionBean = cotizacionService.obtenerCotizacion(cotizacionBean);
			
			String numeroCotizacion = String.valueOf(cotizacionBean.getNumeroCotizacion());			
			
			//1- TIPO DE PROGRAMA
			int idTipoPrograma = cotizacionBean.getIdTipoPrograma();
			oPaquete.setIdTipoPaquete(idTipoPrograma);
			
			//2- PRESUPUESTO: ALTO, MEDIO, BAJO
			double imPresupuesto = cotizacionBean.getPresupuestoMaximo();				
			oPaquete.setImPrecio(imPresupuesto);
			
			System.out.println("precio A max" + oPaquete.getImPrecioMaxAlto());
			System.out.println("precio A min" + oPaquete.getImPrecioMinAlto());
			System.out.println("precio B max" + oPaquete.getImPrecioMaxMedio());
			System.out.println("precio B min" + oPaquete.getImPrecioMinMedio());
			System.out.println("precio C max" + oPaquete.getImPrecioMaxBajo());
			System.out.println("precio C min" + oPaquete.getImPrecioMinBajo());
			
			int idCategoriaAlojamiento = cotizacionBean.getIdCategoriaAlojamiento();
			int idTipoAlojamiento = cotizacionBean.getIdTipoAlojamiento();
			
			//3- MODELO DESTINOS: A, B Y C
			List<PaqueteManagerBean> listPaqueteSearch = new ArrayList<PaqueteManagerBean>();
			List<PaqueteManagerBean> listCotizacionManBeanAlto = null;
			List<PaqueteManagerBean> listCotizacionManBeanMedio = null;
			List<PaqueteManagerBean> listCotizacionManBeanBajo = null;
			
			//Se realizan 3 iteracciones, uno por categoria de presupuesto: Alto, Medio y Bajo
			for ( int i=0; i<3; i++ ) {								
				if (i == 0) {
					//3.1- Primera Iteracion: Presupuesto ALTO					
					oPaquete.setImPrecioMax(oPaquete.getImPrecioMaxAlto());
					oPaquete.setImPrecioMin(oPaquete.getImPrecioMinAlto());
					oPaquete.setTiPresupuestoValue("Alto");
					listCotizacionManBeanAlto = cotizacionService.listarPaquete(oPaquete);					
					for (PaqueteManagerBean o:listCotizacionManBeanAlto){
						if ( !listPaqueteSearch.contains(o) ) {
							System.out.println("listPaqueteSearch[id_paquete:"+o.getIdPaquete()+", nombre:"+o.getNomPaquete()+", comentario:"+o.getComentario()+", im_precio:"+o.getImPrecio()+", tipoPresupuesto:"+o.getTiPresupuestoValue()+"]");
							listPaqueteSearch.add(o);
						}
					}					
				} else if (i ==1){
					//3.2- Segunda Iteracion: Presupuesto MEDIO					
					oPaquete.setImPrecioMax(oPaquete.getImPrecioMaxMedio());
					oPaquete.setImPrecioMin(oPaquete.getImPrecioMinMedio());
					oPaquete.setTiPresupuestoValue("Medio");
					listCotizacionManBeanMedio = cotizacionService.listarPaquete(oPaquete);					
					for (PaqueteManagerBean o:listCotizacionManBeanMedio){
						if ( !listPaqueteSearch.contains(o) ) {
							System.out.println("listPaqueteSearch[id_paquete:"+o.getIdPaquete()+", nombre:"+o.getNomPaquete()+", comentario:"+o.getComentario()+", im_precio:"+o.getImPrecio()+", tipoPresupuesto:"+o.getTiPresupuestoValue()+"]");
							listPaqueteSearch.add(o);
						}
					}
				} else if (i == 2){
					//3.3- Tercera Iteracion: Presupuesto BAJO					
					oPaquete.setImPrecioMax(oPaquete.getImPrecioMaxBajo());
					oPaquete.setImPrecioMin(oPaquete.getImPrecioMinBajo());
					oPaquete.setTiPresupuestoValue("Bajo");
					listCotizacionManBeanBajo = cotizacionService.listarPaquete(oPaquete);					
					for (PaqueteManagerBean o:listCotizacionManBeanBajo){
						if ( !listPaqueteSearch.contains(o) ) {
							System.out.println("listPaqueteSearch[id_paquete:"+o.getIdPaquete()+", nombre:"+o.getNomPaquete()+", comentario:"+o.getComentario()+", im_precio:"+o.getImPrecio()+", tipoPresupuesto:"+o.getTiPresupuestoValue()+"]");
							listPaqueteSearch.add(o);
						}
					}
				}
				
			}
			
			//Se obtienen todos los paquetes disponibles en: listPaqueteSearch();	
			System.out.println("Total de Paquetes encontrados: " + listPaqueteSearch.size());
			
			//Numero aleatorio
			int x = (int)(Math.random() * ((19999999 - 1) + 1)) + 1;
			
			//Ruta absoluta del dominio de la aplicacion
			String AbsolutePath = new File(".").getAbsolutePath();
			System.out.println("AbsolutePath: " + AbsolutePath);			
			
			//Nombre del archivo a crear
			String csvFile = AbsolutePath + numeroCotizacion +"_"+x+".csv";
	        FileWriter writer = new FileWriter(csvFile);	        
	        
	        //for header CSV
	        CSVUtils.writeLine(writer, Arrays.asList("presupuesto", "idPaquete", "nomPaquete", "destinos", "tour", "hotel", "ticket", "tipoAlojamiento",
	        		"categoriaAlojamiento","hotelHabitacion","playa","relajacion","deportes","cultural"));
			
			PaqueteResumeBean paquete = null;
			
			//for detail CSV
			for (PaqueteManagerBean  o:listPaqueteSearch) {
				//Inicializamos el bean
				paquete = new PaqueteResumeBean();				
				paquete.setIdPaquete(o.getIdPaquete());				
				paquete.setNumeroCotizacion(numeroCotizacion);
				paquete.setIdCategoriaAlojamiento(idCategoriaAlojamiento);
				paquete.setIdTipoAlojamiento(idTipoAlojamiento);				
				paquete = cotizacionService.obtenerPaquete(paquete);
				
				//Log
				System.out.println("Datos ...........................................");								
				System.out.println("presupuesto:" + o.getTiPresupuestoValue());	
				System.out.println("idPaquete:" + o.getIdPaquete());
				System.out.println("nomPaquete:" + o.getNomPaquete()); 
				System.out.println("destinos:" + paquete.getDestinos());
				System.out.println("tour:" + paquete.getTour());
				System.out.println("hotel:" + paquete.getHotel());
				System.out.println("ticket:" + paquete.getTicket());
				System.out.println("tipo_alojamiento:" + paquete.getTipoAlojamiento());
				System.out.println("categoria_alojamiento:" + paquete.getCategoriaAlojamiento());
				System.out.println("hotel_habitacion:" + paquete.getHotelHabitacion());
				System.out.println("playa:" + paquete.getPlaya());
				System.out.println("relajacion:" + paquete.getRelajacion());
				System.out.println("deportes:" + paquete.getDeportes());
				System.out.println("cultural:" + paquete.getCultural());
				System.out.println("playaTour:" + paquete.getPlayaTour());
				System.out.println("relajacionTour:" + paquete.getRelajacionTour());
				System.out.println("deportesTour:" + paquete.getDeportesTour());
				System.out.println("culturalTour:" + paquete.getCulturalTour());				
				
				//Nueva Fila
		        List<String> list = new ArrayList<String>();	            
	            list.add(o.getTiPresupuestoValue().toString());
	            list.add(String.valueOf(o.getIdPaquete()));
	            list.add(o.getNomPaquete());
	            list.add(paquete.getDestinos().toString());
	            list.add(paquete.getTour().toString());
	            list.add(paquete.getHotel());
	            list.add(paquete.getTicket());
	            list.add(paquete.getTipoAlojamiento());	            
	            list.add(paquete.getCategoriaAlojamiento());
	            list.add(paquete.getHotelHabitacion());
	            list.add(paquete.getPlaya());
	            list.add(paquete.getRelajacion());
	            list.add(paquete.getDeportes());
	            list.add(paquete.getCultural());	            
	            CSVUtils.writeLine(writer, list);
			}
			
			writer.flush();
	        writer.close();
	        
	        System.out.println("csvFile");
	        System.out.println(csvFile);
	        
	        //Busqueda Algoritmo ID3
	        TableManager tm = new DataManager(csvFile);	       	       
	        
	        System.out.println("************************************************************************");	     
	        System.out.println(tm);
	        System.out.println("size(file *.csv): " + tm.getRows().size());
						
			//cumple los destinos: reducimos la tabla
	        System.out.println("************************************************************************");
	        System.out.println("Reducing table with the attribute DESTINOS and value SI.");
			TableManager tm2 = tm.getSubTable("destinos", "Si");											
			System.out.println(tm2);
			System.out.println("size(destinos): " + tm2.getRows().size());
			
			double percent = 0;
			int qtypercent = 0;
			
			//cumple con los servicios:
			System.out.println("************************************************************************");
			System.out.println("Reducing table with the attribute SERVICIOS and value SI.");
			
			if ( cotizacionBean.getTicket()==1 ){
				System.out.println("ticket:" + tm2.getBestObjectiveValueFromAttribute("ticket", "Si"));
				tm2 = tm2.getSubTable("ticket", "Si");
				percent += 10; //score
				qtypercent += 1; //quantity
			} else {
				System.out.println("Ticket not found");
			}

			if ( cotizacionBean.getTour()==1 ){
				System.out.println("tour:" + tm2.getBestObjectiveValueFromAttribute("tour", "Si"));
				tm2 = tm2.getSubTable("tour", "Si");
				percent += 10; //score
				qtypercent += 1; //quantity
			} else {
				System.out.println("Tour not found");
			}
			
			if ( cotizacionBean.getHotel()==1 ){
				System.out.println("hotel:" + tm2.getBestObjectiveValueFromAttribute("hotel", "Si"));
				tm2 = tm2.getSubTable("hotel", "Si");
				percent += 10; //score
				qtypercent += 1; //quantity
			} else {
				System.out.println("Hotel not found");
			}
			
			System.out.println(tm2);
			System.out.println("size(servicios): " + tm2.getRows().size());
			List<PaqueteResumeBean> resumeDestinos = null;
			
			if ( tm2.getRows().size() > 0 ) {
			
				/* String valueBestObjectiveTour = tm2.getBestObjectiveValueFromAttribute("tour", "Si");
				String valueBestObjectiveTicket = tm2.getBestObjectiveValueFromAttribute("ticket", "Si");
				String valueBestObjectiveHotel = tm2.getBestObjectiveValueFromAttribute("hotel", "Si");						
				
				if ( valueBestObjectiveTour.equals("Alto") || valueBestObjectiveTicket.equals("Alto") ||
					valueBestObjectiveTour.equals("Medio") || valueBestObjectiveHotel.equals("Medio") ||
					valueBestObjectiveHotel.equals("Alto") || valueBestObjectiveTicket.equals("Medio") ){ */
					if ( cotizacionBean.getHotel()==1 ){
						if ( cotizacionBean.getIdCategoriaAlojamiento()>0 ){
							percent += 5; //score
							qtypercent += 1; //quantity
						}
						
						if ( cotizacionBean.getIdTipoAlojamiento()>0 ){
							percent += 5; //score
							qtypercent += 1; //quantity
						}
					}
					if ( cotizacionBean.getPlaya() > 0 ){
						percent += 5; //score
						qtypercent += 1; //quantity
					}
					
					if ( cotizacionBean.getRelajacion() > 0 ){
						percent += 5; //score
						qtypercent += 1; //quantity
					}
					
					if ( cotizacionBean.getDeportes() > 0 ){
						percent += 5; //score
						qtypercent += 1; //quantity
					}
					
					if ( cotizacionBean.getCultural() > 0 ){
						percent += 5; //score
						qtypercent += 1; //quantity
					}
				//}
				
				//percent = percent/qtypercent*9.0;
				System.out.println("************************************************************************");				
				System.out.println("Number of equalities of parameters: " + qtypercent);
				System.out.println("Getting a table for trainning with the " + percent + "% of the datas");
				
				if ( percent < 75 || percent > 100 ) {
					percent = 75;
				}
				
				System.out.println("" + percent + "% change!");
				
				System.out.println("************************************************************************");				
				System.out.println("before");
				System.out.println(tm2);				
				
				/* tm2 = tm2.getTrainAndProbeSet(percent);
				System.out.println("************************************************************************");
				System.out.println("after");
				System.out.println(tm2); */
				
				for (int i=0; i<tm2.getRows().size(); i++) {					
					System.out.println("************************************************************************");
					System.out.println("Paquete ID");
					System.out.println(tm2.getRow(i).get(1));					
					if ( i==0 ) {						
						paquete = new PaqueteResumeBean();
						paquete.setIdPaquete(Integer.parseInt(tm2.getRow(i).get(1)));
						resumeDestinos = cotizacionService.listarPaqueteDetail(paquete);
						break;
					}
				}
			}
	        
			mapa.put("titulo", "Paquetes");
			mapa.put("listaPaquetes", tm2);
			mapa.put("cantidadPaquetes", tm2.getRows().size());
			mapa.put("destinos", resumeDestinos);
			
	        //Return bean Paquete escogido
			dataJSON.setRespuesta("ok", null, mapa);
			
		} catch (Exception e) { 
			e.printStackTrace();
			System.out.println("e: " + e.getMessage() );
		}		
		return ControllerUtil.handleJSONResponse(dataJSON, response);		
	}	
	
	
	
	
	
	
	
	
		
	@RequestMapping( value = "/buscarVuelos", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView buscarVuelos(HttpServletRequest request, HttpServletResponse response){
		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapa = new HashMap<String, Object>();		
		DataJsonBean dataJSON = new DataJsonBean();
		
		OrdenPlanificacionBean ordenPlanBean = null;
		List<FareInfoBean> listaTickets = null;			
		String detalleVuelos = "";
		List<OrdenPlanificacionBean> listaOrdenPlan = null;	
		
		try {			
			modelAndView = new ModelAndView();
			
			System.out.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");			
			
			String numeroCotizacion = request.getParameter("nroCotizacion");
			
			System.out.println("Numero Cotizacion");
			System.out.println(numeroCotizacion);
						
			CotizacionDetalleBean cotizacionDetalleBean=new CotizacionDetalleBean();  
			cotizacionDetalleBean.setNumeroCotizacion(numeroCotizacion);
			List<CotizacionDetalleBean> listDestinosDetalle = cotizacionService.listarDestinosDetail(cotizacionDetalleBean);
			
			System.out.println("Destinos");
			System.out.println(listDestinosDetalle.size());
						
			listaOrdenPlan = new ArrayList<OrdenPlanificacionBean>();			
			
			for (CotizacionDetalleBean item:listDestinosDetalle ) {				
				String vuelo = item.getIsoCiudadOrigen() + "," +  
						item.getIsoCiudadDestino() + "," + 
						item.getFechaPartida() + "," +
						item.getDestino();
				System.out.println("Vuelo A");
				System.out.println(vuelo);
				System.out.println("Solo Ida?");
				System.out.println(item.getTiIda());				
				
				listaTickets = cotizacionService.listarTickets(vuelo);
				ordenPlanBean = cotizacionService.minorCostTicket(listaTickets);	
				if ( ordenPlanBean != null ) {
					//Mensaje Vuelo
					detalleVuelos += "<strong>"+ item.getDesCiudadDestino() +" ("+ item.getFechaPartida() +")</strong>: " + 
							ordenPlanBean.getNombreAerolinea() + " / USD " + ordenPlanBean.getPrecioAerolinea() + 						
							" (Comision " + ordenPlanBean.getComision() + ")";				
					//Agregamos a la lista
					listaOrdenPlan.add(ordenPlanBean);
				}
				
				if ( item.getTiIda() == 0 ) {
					//Ida y Vuelta					
					vuelo = item.getIsoCiudadDestino() + "," +  
							item.getIsoCiudadOrigen() + "," + 
							item.getFechaRetorno() + "," +
							item.getOrigen();				
					System.out.println("Vuelo B");
					System.out.println(vuelo);
					
					listaTickets = cotizacionService.listarTickets(vuelo);
					ordenPlanBean = cotizacionService.minorCostTicket(listaTickets);	
					
					if ( ordenPlanBean != null ) {
						//Mensaje Vuelo
						detalleVuelos += "<br /><strong>"+ item.getDesCiudadOrigen() +" ("+ item.getFechaRetorno() +")</strong>: " + 
								ordenPlanBean.getNombreAerolinea() + " / USD " + ordenPlanBean.getPrecioAerolinea() + 						
							" (Comision: " + ordenPlanBean.getComision() + ")";
						//Agregamos a la lista
						listaOrdenPlan.add(ordenPlanBean);
					}
				}
				detalleVuelos += "<br /><br />";				
			}
			
			System.out.println("Mensaje");
			System.out.println(detalleVuelos);						
			
			dataJSON.setRespuesta("ok", null, mapa);
			
		} catch (Exception e) {
			if ( detalleVuelos.length()<0 ){
				detalleVuelos = "No se encontraron vuelos";
			}
			System.out.println("**********************************************************************");
			System.out.println("error:");
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		
		System.out.println("**********************************************************************");
		System.out.println("mensaje final");
		System.out.println(detalleVuelos);
		
		mapa.put("detalleVuelos", detalleVuelos);
		mapa.put("listaVuelos", listaOrdenPlan);
		mapa.put("cantidadVuelos", listaOrdenPlan.size());
		
		dataJSON.setRespuesta("ok", null, mapa);
		
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}	
	
	@RequestMapping( value = "/grabarVuelos", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView grabarVuelos(HttpServletRequest request, HttpServletResponse response){
		
		ModelAndView modelAndView = null;
		Map<String, Object> mapa = new HashMap<String, Object>();		
		DataJsonBean dataJSON = new DataJsonBean();
		
		try {			
			modelAndView = new ModelAndView();						
			String numeroCotizacion = request.getParameter("nroCotizacion");
			
			CotizacionDetalleBean cotizacionDetalleBean=new CotizacionDetalleBean();  
			cotizacionDetalleBean.setNumeroCotizacion(numeroCotizacion);
			List<CotizacionDetalleBean> listDestinosDetalle = cotizacionService.listarDestinosDetail(cotizacionDetalleBean);
			
			OrdenPlanificacionBean ordenPlanBean = null;
			CotizacionDetalleTicketVueloBean cotizacionTicket = null;
			List<FareInfoBean> listaTickets = null;	
			int idCotizacion = 0;
			
			for (CotizacionDetalleBean item:listDestinosDetalle ) {				
				String vuelo = item.getIsoCiudadOrigen() + "," +  
						item.getIsoCiudadDestino() + "," + 
						item.getFechaPartida() + "," +
						item.getDestino();
				listaTickets = cotizacionService.listarTickets(vuelo);
				ordenPlanBean = cotizacionService.minorCostTicket(listaTickets);
				cotizacionTicket = new CotizacionDetalleTicketVueloBean(
						item.getIdCotizaDeta(),numeroCotizacion,ordenPlanBean.getIdAerolinea(),ordenPlanBean.getPrecioAerolinea(),
						ordenPlanBean.getIdProveedorAerolinea(), ordenPlanBean.getUrlShop(),0,ordenPlanBean.getComision(),
						item.getDestino(), item.getOrigen(), item.getFechaPartida(), item.getFechaRetorno());
				cotizacionService.registrarConsolidador(cotizacionTicket);				
				if ( item.getTiIda() == 0 ) {
					//Ida y Vuelta					
					vuelo = item.getIsoCiudadDestino() + "," +  
							item.getIsoCiudadOrigen() + "," + 
							item.getFechaRetorno() + "," +
							item.getOrigen();					
					listaTickets = cotizacionService.listarTickets(vuelo);
					ordenPlanBean = cotizacionService.minorCostTicket(listaTickets);
					cotizacionTicket = new CotizacionDetalleTicketVueloBean(
							item.getIdCotizaDeta(),numeroCotizacion,ordenPlanBean.getIdAerolinea(),ordenPlanBean.getPrecioAerolinea(),
							ordenPlanBean.getIdProveedorAerolinea(), ordenPlanBean.getUrlShop(),0,ordenPlanBean.getComision(),
							item.getOrigen(), item.getDestino(), item.getFechaRetorno(), item.getFechaRetorno());
					cotizacionService.registrarConsolidador(cotizacionTicket);
				}
			}
			
			mapa.put("idCotizacion", idCotizacion);
		
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		dataJSON.setRespuesta("ok", null, mapa);
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}	

}









