package pe.com.paxtravel.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import pe.com.paxtravel.bean.AnimalBean;
import pe.com.paxtravel.bean.CiudadBean;
import pe.com.paxtravel.bean.CotizacionBean;
import pe.com.paxtravel.bean.MotivoViajeBean;
import pe.com.paxtravel.bean.OrdenDestinoBean;
import pe.com.paxtravel.bean.OrdenPlanificacionBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.ServicioAdicionalBean;
import pe.com.paxtravel.service.OrdenPlanificacionService;
import pe.com.paxtravel.util.ControllerUtil;
import pe.com.paxtravel.util.DataJsonBean;
import pe.com.paxtravel.util.Utils;
import pe.gob.sunat.framework.spring.util.conversion.SojoUtil;

@Controller
public class OrdenPlanificacionController {
	@Autowired
	private OrdenPlanificacionService ordenPlanificacionService;

	private String jsonView;

	public String getJsonView() {
		return jsonView;
	}

	public void setJsonView(String jsonView) {
		this.jsonView = jsonView;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/listarOrdenPlanificacion", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView listarOrdenPlanificacion(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView modelAndView = null;

		HashMap<String, Object> mapa = new HashMap<String, Object>();

		List<OrdenPlanificacionBean> lopb = new ArrayList<OrdenPlanificacionBean>();
		OrdenPlanificacionBean ordenPlanificacionBean = new OrdenPlanificacionBean();

		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		boolean flag = false;

		DataJsonBean dataJSON = new DataJsonBean();
		try {
			modelAndView = new ModelAndView();
			String botonBuscar = (request.getParameter("btnBuscar")) != null ? request
					.getParameter("btnBuscar") : "";
			mapa.put("titulo", "Orden de Planificacion");
			if ("1".equals(botonBuscar)) {

				Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
				Map<String, Object> ordenPlanificacionMap = (Map<String, Object>) parametrosRequest.get("ordenPlanificacionBean");
				// inserta en el bean todos los valores del mapa (property vs keys)
				BeanUtils.populate(ordenPlanificacionBean, ordenPlanificacionMap);

				if (!"".equals(ordenPlanificacionBean.getFeOrder())) {
					String fechaOrden = Utils.stringToStringyyyyMMdd(ordenPlanificacionBean.getFeOrder());
					ordenPlanificacionBean.setFeOrder(fechaOrden);
				}

				lopb = ordenPlanificacionService.listarOrdenPlanificacion(ordenPlanificacionBean);

				mapa.put("listaOrdenPlanificacion",  lopb);

				dataJSON.setRespuesta("ok", null, mapa);
				flag = true;

			} else {
				lopb = ordenPlanificacionService
						.listarOrdenPlanificacion(ordenPlanificacionBean);
				System.out.println("size:... " + lopb.size());
				modelAndView.addObject("listarOrdenPlanificacion",
						SojoUtil.toJson(lopb));
				// mapa.put("fechaInseminacion", sdf.format( new Date() ));
				// modelAndView.addObject("mapaDatos", mapa);
				modelAndView
						.setViewName("ordenPlanificacion/listarOrdenPlanificacion");
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
/*
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
	}*/
	
	@RequestMapping(value = "/formRegistrarOrdenPlanificacion", method = {RequestMethod.GET, RequestMethod.POST })
	public ModelAndView formRegistrarOrdenPlanificacion(
			HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapaDatos = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {
			modelAndView = new ModelAndView();
			List<CiudadBean> listaCiudad = new ArrayList<CiudadBean>();
			List<PaisBean> listaPais = new ArrayList<PaisBean>();
			CiudadBean ciudadBean = new CiudadBean();
			PaisBean paisBean = new PaisBean();
			//ciudadBean.setIdPais(1);
			listaCiudad = ordenPlanificacionService.listarCiudad(ciudadBean);
			listaPais = ordenPlanificacionService.listarPais(paisBean);
			// List<PaisBean> listaPais = new ArrayList<PaisBean>();
			mapaDatos.put("titulo", "REGISTRAR ORDEN PLANIFICACION");

			Map<String, Object> mapaListaCiudad = new HashMap<String, Object>();
			for (CiudadBean ciudadBean1 : listaCiudad) {
				mapaListaCiudad.put("idCiudad", ciudadBean1.getIdCiudad());
				mapaListaCiudad.put("nomCiudad", ciudadBean1.getNomCiudad());
			}
			
			mapaDatos.put("listCotizacion", listaCiudad);
			mapaDatos.put("listPais", listaPais);

			modelAndView.addObject("titulo", "REGISTRAR ORDEN PLANIFICACION");
			modelAndView.addObject("mapaDatos", mapaDatos);
			modelAndView.addObject("fechaOrden",
					Utils.dateUtilToStringDDMMYYYY(new Date()));
			modelAndView
					.setViewName("ordenPlanificacion/registrarOrdenPlanificacion");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return modelAndView;
	}
 
	@SuppressWarnings("unchecked")
	@RequestMapping( value = "/grabarTransaccionOrden" )
	public ModelAndView grabarTransaccionOrden(HttpServletRequest request, HttpServletResponse response){

		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();

		try {
			modelAndView = new ModelAndView();
			HttpSession session = request.getSession();
			String usuario = (String) session.getAttribute("idUsuario");


			String idCliente = (request.getParameter("idCliente")==null?"":request.getParameter("idCliente"));
			String fecpar = (request.getParameter("txtfecpartida")==null?"1":request.getParameter("txtfecpartida"));
			String fecret = (request.getParameter("txtfecretorno")==null?"1":request.getParameter("txtfecretorno"));
			String nuninos = (request.getParameter("txtcantnin")==null?"0":request.getParameter("txtcantnin"));
			String nuadultos = (request.getParameter("txtcantadult")==null?"1":request.getParameter("txtcantadult"));
			

				Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
				Map<String, Object> ordenPlanificacionBeanMap = (Map<String, Object>) parametrosRequest.get("ordenplanificacionBean");
				OrdenPlanificacionBean ordenPlanificacionBean = new OrdenPlanificacionBean();

				// inserta en el bean todos los valores del mapa (property vs keys)
				ordenPlanificacionBeanMap.remove("motivoViajeOrden[]");
				ordenPlanificacionBeanMap.remove("servicioAdicional[]");

				BeanUtils.populate(ordenPlanificacionBean, ordenPlanificacionBeanMap);

				ordenPlanificacionBean.setFeOrder( Utils.stringToStringyyyyMMdd (ordenPlanificacionBean.getFeOrder()));
				ordenPlanificacionBean.setIdCliente(Integer.parseInt(idCliente) );
				ordenPlanificacionBean.setNuOrden(ordenPlanificacionService.generarNumeroOrden());
				ordenPlanificacionBean.setDescripcion((String)ordenPlanificacionBeanMap.get("descripcion"));
				ordenPlanificacionBean.setFeInicio(Utils.stringToStringyyyyMMdd(fecpar));
				ordenPlanificacionBean.setFeFin(Utils.stringToStringyyyyMMdd(fecret));
				ordenPlanificacionBean.setNuNinos(Integer.parseInt(nuninos));
				ordenPlanificacionBean.setNuAdultos(Integer.parseInt(nuadultos));
				

				int registro = ordenPlanificacionService.GrabarOrdenPlanificacion(ordenPlanificacionBean);

				// DATOS DE DESTINO
				String datosDestino = request.getParameter("datosDestino");
				System.out.println("datosDestino?1 " + datosDestino);

				datosDestino = datosDestino.substring(0, datosDestino.length()-1 );
				System.out.println("datosDestino?2 " + datosDestino);

				String destino[] = datosDestino.split(",");
				OrdenDestinoBean ordenDestinoBean = new OrdenDestinoBean();
				ordenDestinoBean.setIdorden(ordenPlanificacionBean.getIdOrden());

				String g[];
				if (destino.length > 0){
					for (int i = 0; i < destino.length; i++) {
						g = destino[i].split("_");

						ordenDestinoBean.setDestino( Integer.parseInt( g[1] ));

						ordenPlanificacionService.registrarOrdenDestino(ordenDestinoBean);

					}
				}

				String motivoViaje = request.getParameter("motivoViaje");
				String servicioAdicional = request.getParameter("servAdicional");
				// MOTIVO DE VIAJE
				motivoViaje = motivoViaje.substring(0, motivoViaje.length()-1 );
				String motivo[] = motivoViaje.split(",");
				MotivoViajeBean motivoViajeBean = new MotivoViajeBean();
				motivoViajeBean.setNumeroOrden(ordenPlanificacionBean.getNuOrden());
				int m = 0;
				if (motivo.length > 0){
					for (int i = 0; i < motivo.length; i++) {
						m = Integer.parseInt( motivo[i] );
						motivoViajeBean.setCodigoMotivo(m);
						ordenPlanificacionService.registrarMotivo(motivoViajeBean);
					}
				}

				// SERVICIOS ADICIONALES
				servicioAdicional = servicioAdicional.substring(0, servicioAdicional.length()-1 );
				String servicio[] = servicioAdicional.split(",");
				ServicioAdicionalBean servicioAdicionalBean = new ServicioAdicionalBean();
				servicioAdicionalBean.setNumeroOrden(ordenPlanificacionBean.getNuOrden());

				m = 0;
				if (servicio.length > 0) {
					for (int i = 0; i < servicio.length; i++) {
						m = Integer.parseInt( servicio[i] );
						servicioAdicionalBean.setCodigoServicio(m);
						ordenPlanificacionService.registrarServicio(servicioAdicionalBean);
					}
				}
			

			dataJSON.setRespuesta("ok", null, mapa);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}

	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/grabarTransaccionOrdPlanificacion")
	public ModelAndView grabarTransaccionOrdPlanificacion(HttpServletRequest request, HttpServletResponse response){
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		String status = "error";

		try{
			System.out.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("Iniciando grabarOrdenPlan");

			//String idCliente = (request.getParameter("idCliente")==null?"":request.getParameter("idCliente"));

			Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
			Map<String, Object> ordenPlanificacionBeanMap = (Map<String, Object>) parametrosRequest.get("ordenPlanificacionBean");

			// inserta en el bean todos los valores del mapa (property vs keys)
			ordenPlanificacionBeanMap.remove("motivoViajeOrden[]");
			ordenPlanificacionBeanMap.remove("servicioAdicional[]");

			System.out.println("FechaCotizacion: " + ordenPlanificacionBeanMap.get("fechaCotizacion"));
			System.out.println("fechaSalida: " + ordenPlanificacionBeanMap.get("fechaSalida"));
			System.out.println("fechaRetorno: " + ordenPlanificacionBeanMap.get("fechaRetorno"));
			System.out.println("idTipoCotizacion: " + ordenPlanificacionBeanMap.get("idTipoCotizacion"));
			System.out.println("idOrigenPartida: " + ordenPlanificacionBeanMap.get("idOrigenPartida"));

			OrdenPlanificacionBean ordenPlanificacionBean = new OrdenPlanificacionBean();

			//idTipoCotizacion idOrigenPartida idTipoPrograma

			BeanUtils.populate(ordenPlanificacionBean, ordenPlanificacionBeanMap);

			ordenPlanificacionBean.setFeOrder( Utils.stringToStringyyyyMMdd (ordenPlanificacionBean.getFeOrder()));
			ordenPlanificacionBean.setIdCliente(ordenPlanificacionBean.getIdCliente());
			ordenPlanificacionBean.setNuOrden(ordenPlanificacionService.generarNumeroOrden());

			ordenPlanificacionBean.setFeInicio( Utils.stringToStringyyyyMMdd (ordenPlanificacionBean.getFeInicio()));
			ordenPlanificacionBean.setFeFin( Utils.stringToStringyyyyMMdd (ordenPlanificacionBean.getFeFin()));

			System.out.println("FechaOrden: " + ordenPlanificacionBean.getFeOrder());
			System.out.println("fechaSalida: " + ordenPlanificacionBean.getFeInicio());
			System.out.println("fechaRetorno: " + ordenPlanificacionBean.getFeFin());

			int registro = ordenPlanificacionService.GrabarOrdenPlanificacion(ordenPlanificacionBean);

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
				motivoViajeBean.setNumeroOrden(ordenPlanificacionBean.getNuOrden());

				int m = 0;

				if (motivo.length > 0) {

					for (int i = 0; i < motivo.length; i++) {

						System.out.println("motivo"+i+": "+motivo[i]);

						m = Integer.parseInt( motivo[i] );
						motivoViajeBean.setCodigoMotivo(m);
						int res = ordenPlanificacionService.registrarMotivo(motivoViajeBean);
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

				OrdenDestinoBean ordenDestinoBean = new OrdenDestinoBean();
				ordenDestinoBean.setIdorden(ordenPlanificacionBean.getIdOrden());

				String g[];

				if (destino.length > 0){
					for (int i = 0; i < destino.length; i++) {

						g = destino[i].split("_");

						ordenDestinoBean.setDestino( Integer.parseInt( g[0] ));

						int res = ordenPlanificacionService.registrarOrdenDestino(ordenDestinoBean);

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
				servicioAdicionalBean.setNumeroOrden(ordenPlanificacionBean.getNuOrden());

				int m = 0;
				if (servicio.length > 0) {
					for (int i = 0; i < servicio.length; i++) {
						m = Integer.parseInt( servicio[i] );
						servicioAdicionalBean.setCodigoServicio(m);
						int res = ordenPlanificacionService.registrarServicio(servicioAdicionalBean);

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
}
