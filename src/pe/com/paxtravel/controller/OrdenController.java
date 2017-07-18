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
import pe.com.paxtravel.bean.OrdenBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.ReservaBean;
import pe.com.paxtravel.bean.ReservaPasajeroDetalleBean;
import pe.com.paxtravel.service.CotizacionService;
import pe.com.paxtravel.service.OrdenService;
import pe.com.paxtravel.service.ReservaService;
import pe.com.paxtravel.util.ControllerUtil;
import pe.com.paxtravel.util.DataJsonBean;
import pe.com.paxtravel.util.Utils;
import pe.gob.sunat.framework.spring.util.conversion.SojoUtil;

@Controller
public class OrdenController {

	@Autowired
	private OrdenService ordenService;

	@Autowired
	private CotizacionService cotizacionService;
	
	private String jsonView;

	public String getJsonView() {
		return jsonView;
	}

	public void setJsonView(String jsonView) {
		this.jsonView = jsonView;
	}
	
	@RequestMapping( value = "/listarOrden", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView listarPaqueteTuristico(HttpServletRequest request, HttpServletResponse response){
	
		ModelAndView modelAndView = null;
		HashMap<String, Object> mapa = new HashMap<String, Object>();

		List<OrdenBean> listarOrden = new ArrayList<OrdenBean>();
		OrdenBean ordenBean = new OrdenBean();
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		
		boolean flag = false;
		DataJsonBean dataJSON = new DataJsonBean();

		try {
			modelAndView = new ModelAndView();
			
			String botonBuscar = (request.getParameter("btnBuscar"))!=null?request.getParameter("btnBuscar"):"";
			
			mapa.put("titulo", "ORDEN");
			
			if("1".equals(botonBuscar)){
				Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
				Map<String, Object> ordenBeanMap = (Map<String, Object>) parametrosRequest.get("ordenBean");
				BeanUtils.populate(ordenBean, ordenBeanMap);
				
				listarOrden = ordenService.listarOrden(ordenBean);

				mapa.put("listaOrden",  listarOrden);
				dataJSON.setRespuesta("ok", null, mapa);
				flag = true; 
				
			} else {
				listarOrden = ordenService.listarOrden(ordenBean);
				modelAndView.addObject("listaOrden", SojoUtil.toJson(listarOrden) );
				modelAndView.setViewName("orden/listarOrden");
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
	
	@RequestMapping( value = "/listarPaisXTipoPaquete", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView listarPaisDestino(HttpServletRequest request, HttpServletResponse response){

		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {

			List<PaisBean> lista = new ArrayList<PaisBean>();

			PaisBean bean = new PaisBean();
			int codigoPais = Integer.parseInt( request.getParameter("idTipoPaquete") );
			
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
	
	@RequestMapping( value = "/cargarFormRegistrarOrden", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView cargarFormRegistrarOrden(HttpServletRequest request, HttpServletResponse response){

		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapaDatos = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();

		List<PaisBean> listaPais = new ArrayList<PaisBean>();
		PaisBean paisBean = new PaisBean();
		try {
			
			modelAndView = new ModelAndView();
			
			mapaDatos.put("titulo", "Registrar Cotizaci&oacute;n");			
			Map<String, Object> mapaListaCiudad = new HashMap<String, Object>();
			
			
			listaPais = cotizacionService.listarPais(paisBean);
			
			mapaDatos.put("listaPais", listaPais);
			
			modelAndView.addObject("titulo", "REGISTRAR ORDEN");
			modelAndView.addObject("mapaDatos", mapaDatos);
			modelAndView.addObject("fechaOrden", Utils.dateUtilToStringDDMMYYYY( new Date() )) ;
			modelAndView.setViewName("orden/registrarOrden");

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return modelAndView;
	}
	

	@RequestMapping( value = "/grabarOrden", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView grabarReserva(HttpServletRequest request, HttpServletResponse response){
		
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();		
		
		try {
			
			mapa.put("titulo", "Grabar Orden");
			
			String idDestino = request.getParameter("idDestino");
			String idServicio = request.getParameter("idServicio");
			String idMotivo = request.getParameter("idMotivo");
			int flagAutorizacion = Integer.parseInt( request.getParameter("flagAutorizacion") );
			int flagCantidadDias = Integer.parseInt( request.getParameter("flagCantidadDias") );
			int numeroDias = Integer.parseInt( request.getParameter("numeroDias") );
			
			OrdenBean ordenBean = new OrdenBean();
			
			Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
			Map<String, Object> ordenBeanMap = (Map<String, Object>) parametrosRequest.get("ordenBean");
			BeanUtils.populate(ordenBean, ordenBeanMap);

			// flag autorizacion
			ordenBean.setAutorizacion(flagAutorizacion);
						
			// numero de dias de estadia
			ordenBean.setFlagCantidadDias(flagCantidadDias);
			ordenBean.setNumeroDias(numeroDias);
			
			//fecha Partida
			if (!"".equals(ordenBean.getFechaPartida()) ) {
				String fechaPartida = Utils.stringToStringyyyyMMdd(ordenBean.getFechaPartida());
				ordenBean.setFechaPartida(fechaPartida);					
			} else {
				ordenBean.setFechaPartida(null);
			}
			
			//fecha Retorno
			if (!"".equals(ordenBean.getFechaRetorno()) ) {					
				String fechaRetorno = Utils.stringToStringyyyyMMdd(ordenBean.getFechaRetorno());
				ordenBean.setFechaRetorno(fechaRetorno);					
			} else {
				ordenBean.setFechaRetorno(null);
			}
			
			String numeroOrden = ordenService.generarNumeroOrden();
			ordenBean.setNumeroOrden(numeroOrden);
			
			int idOrden = ordenService.registrarOrden(ordenBean);
			
			System.out.println("orden: " + idOrden);
			
			if (idOrden > 0){
				ordenBean.setIdOrden(idOrden);
				
				// registrando motivos de la orden
				if (!"".equals(idMotivo)) {
					idMotivo = idMotivo.substring(0, idMotivo.length()-1);
					
					String[] motivo = idMotivo.split("_");
					if ( motivo.length > 0 ) {
						for (int i = 0; i < motivo.length; i++) {
							ordenBean.setIdMotivo( Integer.parseInt(motivo[i]) );
							ordenService.registrarMotivo(ordenBean);
						}
					}
				}
				
				// registrando servicio de la orden
				if (!"".equals(idServicio)) {
					idServicio = idServicio.substring(0, idServicio.length()-1);
					
					String[] servicio = idServicio.split("_");
					
					if ( servicio.length > 0 ) {
						for (int i = 0; i < servicio.length; i++) {
							ordenBean.setIdServicio( Integer.parseInt(servicio[i]) );
							ordenService.registrarServicio(ordenBean);
						}
					}
				}
				
				if (!"".equals(idDestino)) {

					String destino[] = idDestino.split(",");				
					if ( destino.length > 0 ) {		
						for (int i = 0; i < destino.length; i++) {
							ordenBean.setIdDestinoCiudad( Integer.parseInt(destino[i]) );
							ordenService.registrarDestino(ordenBean);
						}
					}
				}
				
				
				
				
			}
			
			// expediente - auditoria
			// registra en auditoria el cambio de estado en ORDEN - Asignado
			ExpedienteLogBean expedienteLogBean = new ExpedienteLogBean();
			expedienteLogBean.setTiLog("ORDEN");
			expedienteLogBean.setIdTx(idOrden);
			expedienteLogBean.setIdUser(0);
			expedienteLogBean.setIdEstado(6);
			expedienteLogBean.setDesLog("Orden- Estado Asignado");
			cotizacionService.registrarExpedienteLog(expedienteLogBean);
			
			// registra en auditoria el cambio de estado en RESERVA - Confirmado
//			expedienteLogBean.setTiLog("RESERVA");
//			expedienteLogBean.setIdTx( idReserva );
//			expedienteLogBean.setIdUser(0);
//			expedienteLogBean.setIdEstado(12);
//			expedienteLogBean.setDesLog("Reserva - Estado Confirmado");
//			cotizacionService.registrarExpedienteLog(expedienteLogBean);

			mapa.put("numeroOrden", numeroOrden);
			
			dataJSON.setRespuesta("ok", null, mapa);
			
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}
	
	@RequestMapping( value = "/verDetalleOrden", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView verDetalleOrden(HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {
			OrdenBean o = new OrdenBean();
			int idOrden = Integer.parseInt( request.getParameter("idOrden") );
			o.setIdOrden(idOrden);
			o = ordenService.obtenerOrdenDetalle(o);
			
			String motivoViaje = "";
			String servicioViaje = "";
			
			List<OrdenBean> listaMotivo = new ArrayList<OrdenBean>();
			listaMotivo = ordenService.listarMotivoViajeDetalle(o);
			
			if (listaMotivo.size()>0) {
				for (OrdenBean ordenBean : listaMotivo) {
					motivoViaje += ordenBean.getDescripcionMotivoViaje() + ", ";
				}
				motivoViaje = motivoViaje.substring(0, motivoViaje.length()-2);
			}
			
			List<OrdenBean> listaServicio = new ArrayList<OrdenBean>();
			listaServicio = ordenService.listarServicioDetalle(o);
			
			if (listaServicio.size()>0) {
				for (OrdenBean ordenBean : listaServicio) {
					servicioViaje += ordenBean.getDescripcionServicioViaje() + ", ";
				}
				servicioViaje = servicioViaje.substring(0, servicioViaje.length()-2);
			}
			
			
	        mapa.put("titulo", "Detalle Orden");
	        mapa.put("motivoViaje", motivoViaje);
	        mapa.put("servicioViaje", servicioViaje);
	        mapa.put("orden", o);
	        dataJSON.setRespuesta("ok", null, mapa);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}
	
}
