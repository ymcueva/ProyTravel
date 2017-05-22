package pe.com.paxtravel.controller;


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

import pe.com.paxtravel.bean.AnimalBean;
import pe.com.paxtravel.bean.CiudadBean;
import pe.com.paxtravel.bean.CotizacionBean;
import pe.com.paxtravel.bean.EmpleadoBean;
import pe.com.paxtravel.bean.InseminacionBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.PaqueteTuristicoBean;
import pe.com.paxtravel.bean.ProduccionBean;
import pe.com.paxtravel.service.AnimalService;
import pe.com.paxtravel.service.CotizacionService;
import pe.com.paxtravel.service.EmpleadoService;
import pe.com.paxtravel.service.InseminacionService;
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
		
	private String jsonView;

	public String getJsonView() {
		return jsonView;
	}

	public void setJsonView(String jsonView) {
		this.jsonView = jsonView;
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
				/* Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
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
				flag = true; */
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
