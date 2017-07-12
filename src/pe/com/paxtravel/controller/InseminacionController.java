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
import pe.com.paxtravel.bean.EmpleadoBean;
import pe.com.paxtravel.bean.InseminacionBean;
import pe.com.paxtravel.bean.ProduccionBean;
import pe.com.paxtravel.service.AnimalService;
import pe.com.paxtravel.service.EmpleadoService;
import pe.com.paxtravel.service.InseminacionService;
//import pe.com.paxtravel.service.ProduccionService;
import pe.com.paxtravel.util.ControllerUtil;
import pe.com.paxtravel.util.DataJsonBean;
import pe.com.paxtravel.util.Utils;
import pe.gob.sunat.framework.spring.util.conversion.SojoUtil;

@Controller
public class InseminacionController {

	
	public InseminacionController() {
	}
	
	@Autowired
	private InseminacionService inseminacionService;
	
	@Autowired
	private AnimalService animalService;
	
	private String jsonView;

	public String getJsonView() {
		return jsonView;
	}

	public void setJsonView(String jsonView) {
		this.jsonView = jsonView;
	}
	
	@RequestMapping( value = "/listarInseminacion", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView listarInseminacion(HttpServletRequest request, HttpServletResponse response){
		
		ModelAndView modelAndView = null;
		HashMap<String, Object> mapa = new HashMap<String, Object>();

		List<InseminacionBean> listaInseminacion = new ArrayList<InseminacionBean>();
		InseminacionBean inseminacionBean = new InseminacionBean();
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		
		boolean flag = false;
		DataJsonBean dataJSON = new DataJsonBean();

		try {
			modelAndView = new ModelAndView();
			
			String botonBuscar = (request.getParameter("btnBuscar"))!=null?request.getParameter("btnBuscar"):"";
			
			mapa.put("titulo", "INSEMINACION");
			
			if("1".equals(botonBuscar)){
				Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
				Map<String, Object> inseminacionBeanMap = (Map<String, Object>) parametrosRequest.get("inseminacionBean");
				// inserta en el bean todos los valores del mapa (property vs keys)
				BeanUtils.populate(inseminacionBean, inseminacionBeanMap);
				
				if (!"".equals(inseminacionBean.getFechaInseminacion())) {
					String fechaInseminacion = Utils.stringToStringyyyyMMdd(inseminacionBean.getFechaInseminacion());
					inseminacionBean.setFechaInseminacion(fechaInseminacion);
				}
				
				listaInseminacion = inseminacionService.listarInseminacion(inseminacionBean);
				
				mapa.put("listaInseminacion",  listaInseminacion);
				
				dataJSON.setRespuesta("ok", null, mapa);
				flag = true;
			} else {
				listaInseminacion = inseminacionService.listarInseminacion(inseminacionBean);
				modelAndView.addObject("listaInseminacion", SojoUtil.toJson(listaInseminacion) );
				mapa.put("fechaInseminacion", sdf.format( new Date() ));
				modelAndView.addObject("mapaDatos", mapa);
				modelAndView.setViewName("inseminacion/listarInseminacion");
				
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
	
	@RequestMapping( value = "/listarVacasAInseminar", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView listarVacasAInseminar(HttpServletRequest request, HttpServletResponse response){
		
		ModelAndView modelAndView = null;
		Map<String, Object> mapa = new HashMap<String, Object>();
		List<AnimalBean> listaVacasAInseminar = new ArrayList<AnimalBean>();
		AnimalBean animalBean = new AnimalBean();

		String botonBuscar = (request.getParameter("btnBuscar"))!=null?request.getParameter("btnBuscar"):"";
		
		boolean flag = false;
		DataJsonBean dataJSON = new DataJsonBean();
		
		try {
			
			modelAndView = new ModelAndView();
	        
			
			if("1".equals(botonBuscar)){
				Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
				Map<String, Object> animlalBeanMap = (Map<String, Object>) parametrosRequest.get("animalBean");
				// inserta en el bean todos los valores del mapa (property vs keys)
				BeanUtils.populate(animalBean, animlalBeanMap);
				
				listaVacasAInseminar = animalService.listarVacasAInseminar(animalBean);
				mapa.put("listaVacasAInseminar",  listaVacasAInseminar);
				dataJSON.setRespuesta("ok", null, mapa);
				flag = true;
			} else {
				listaVacasAInseminar = animalService.listarVacasAInseminar(animalBean);
				mapa.put("titulo", "LISTA DE VACAS A INSEMINAR");
				
				modelAndView.addObject("listaVacasAInseminar", SojoUtil.toJson(listaVacasAInseminar) );
				modelAndView.addObject("mapaDatos", mapa);
				modelAndView.setViewName("inseminacion/listarVacasAInseminar");
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
	
	@RequestMapping( value = "/abrirRegistrarInseminacion", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView abrirRegistrarInseminacion(HttpServletRequest request, HttpServletResponse response){
		
		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapa = new HashMap<String, Object>();
		List<AnimalBean> listaToro = new ArrayList<AnimalBean>();
		DataJsonBean dataJSON = new DataJsonBean();

		try {
			modelAndView = new ModelAndView();
	        
			listaToro = animalService.listarToro();
			
			Map<String, Object> mapaListaToro = new HashMap<String, Object>();
			for (AnimalBean animalBean : listaToro) {
				mapaListaToro.put("codigo", animalBean.getCodigoAnimal());
				mapaListaToro.put("descripcion", animalBean.getNombreAnimal());
			}
			
	        mapa.put("titulo", "Registrar Inseminaci&oacute;n");
			mapa.put("codigoAnimal",(String) request.getParameter("codigoAnimal"));
			mapa.put("nombreAnimal",(String) request.getParameter("nombreAnimal"));
			mapa.put("listaToro", SojoUtil.toJson(mapaListaToro) );
			mapa.put("fechaActual", sdf.format( new Date() ));
			
			dataJSON.setRespuesta("ok", null, mapa);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}
	
	@RequestMapping( value = "/abrirEditarInseminacion", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView abrirEditarInseminacion(HttpServletRequest request, HttpServletResponse response){
		
		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapa = new HashMap<String, Object>();
		List<AnimalBean> listaToro = new ArrayList<AnimalBean>();
		DataJsonBean dataJSON = new DataJsonBean();

		List<InseminacionBean> listaInseminacion = new ArrayList<InseminacionBean>();
		InseminacionBean inseminacionBean = new InseminacionBean();
		
		try {
			modelAndView = new ModelAndView();
	        String codigoInseminacion = request.getParameter("codInseminacion");
	        
	        inseminacionBean.setCodigoInseminacion(codigoInseminacion);
	        listaInseminacion = inseminacionService.listarInseminacion(inseminacionBean);
			
	        mapa.put("titulo", "Editar Inseminaci&oacute;n");
	        mapa.put("botonGrabar", "Editar");
	        
	        if (listaInseminacion != null){
		        for (InseminacionBean inseminacionBean2 : listaInseminacion) {
		        	String fechaInseminacion = Utils.stringToStringddMMyyyy(inseminacionBean2.getFechaInseminacion());
		        	
		        	mapa.put("codigoInseminacion", inseminacionBean2.getCodigoInseminacion() );
		        	mapa.put("codigoVaca", inseminacionBean2.getCodigoVaca() );
		        	mapa.put("nombreVaca", inseminacionBean2.getNombreVaca());
		        	mapa.put("codigoToro", inseminacionBean2.getCodigoToro());
		        	mapa.put("tipoInseminacion", inseminacionBean2.getTipoInseminacion());
		        	mapa.put("fechaInseminacion", fechaInseminacion );
		        	mapa.put("observacion", inseminacionBean2.getObservacion());
		        	
				}
	        }
			
			dataJSON.setRespuesta("ok", null, mapa);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}

	@RequestMapping( value = "/verDetalleInseminacion", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView verDetalleInseminacion(HttpServletRequest request, HttpServletResponse response){
		
		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapa = new HashMap<String, Object>();
		List<AnimalBean> listaToro = new ArrayList<AnimalBean>();

		InseminacionBean inseminacionBean = new InseminacionBean();
		DataJsonBean dataJSON = new DataJsonBean();
		try {
			modelAndView = new ModelAndView();
	        String codigoInseminacion = request.getParameter("codInseminacion");
	        inseminacionBean.setCodigoInseminacion(codigoInseminacion);
	        inseminacionBean = inseminacionService.verDetalleInseminacion(inseminacionBean);
			
	        mapa.put("titulo", "Detalle Inseminaci&oacute;n");
	        mapa.put("inseminacionBean", inseminacionBean);
	        
	        dataJSON.setRespuesta("ok", null, mapa);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping( value = "/grabarInseminacion" )
	public ModelAndView grabarInseminacion(HttpServletRequest request, HttpServletResponse response){
		
		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapa = new HashMap<String, Object>();
		List<AnimalBean> listaToro = new ArrayList<AnimalBean>();
		DataJsonBean dataJSON = new DataJsonBean();

		try {
			modelAndView = new ModelAndView();
			HttpSession session = request.getSession();
			String usuario = (String) session.getAttribute("idUsuario");
			
			Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
			Map<String, Object> inseminacionBeanMap = (Map<String, Object>) parametrosRequest.get("inseminacionBean");
			InseminacionBean inseminacionBean = new InseminacionBean();
			AnimalBean animalBean = new AnimalBean();
			
			// inserta en el bean todos los valores del mapa (property vs keys)
			BeanUtils.populate(inseminacionBean, inseminacionBeanMap);
	        String codigoInseminacion = inseminacionService.obtenerCodigoInseminacion();
			inseminacionBean.setCodigoInseminacion(codigoInseminacion);
			inseminacionBean.setFechaInseminacion( Utils.stringToStringyyyyMMdd (inseminacionBean.getFechaInseminacion()) );
			inseminacionBean.setUsuario( usuario );

			animalBean.setCodigoAnimal(inseminacionBean.getCodigoVaca());
			animalBean.setEstadoProcesoEvolutivo("2");
			
			int registro = inseminacionService.registrarInseminacion(inseminacionBean);
			int actualizaEstado = animalService.actualizaEstadoProcesoEvolutivo(animalBean);
			
			dataJSON.setRespuesta("ok", null, mapa);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping( value = "/editarInseminacion" )
	public ModelAndView editarInseminacion(HttpServletRequest request, HttpServletResponse response){
		
		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();

		try {
			modelAndView = new ModelAndView();
			HttpSession session = request.getSession();

			Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
			Map<String, Object> inseminacionBeanMap = (Map<String, Object>) parametrosRequest.get("inseminacionBean");
			InseminacionBean inseminacionBean = new InseminacionBean();
			
			// inserta en el bean todos los valores del mapa (property vs keys)
			BeanUtils.populate(inseminacionBean, inseminacionBeanMap);
			inseminacionBean.setFechaInseminacion( Utils.stringToStringyyyyMMdd (inseminacionBean.getFechaInseminacion()) );
			inseminacionBean.setUsuario( session.getAttribute("idUsuario").toString() );

			int registro = inseminacionService.editarInseminacion(inseminacionBean);
			dataJSON.setRespuesta("ok", null, mapa);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping( value = "/eliminarInseminacion" )
	public ModelAndView eliminarInseminacion(HttpServletRequest request, HttpServletResponse response){
		ModelAndView modelAndView = null;
		InseminacionBean inseminacionBean = new InseminacionBean();		DataJsonBean dataJSON = new DataJsonBean();
		Map<String, Object> mapa = new HashMap<String, Object>();
		
		try {
			modelAndView = new ModelAndView();
			HttpSession session = request.getSession();
			
			String codigoInseminacion = request.getParameter("codInseminacion");		
			String codigoAnimal = request.getParameter("codAnimal");
			inseminacionBean.setCodigoInseminacion(codigoInseminacion);
			inseminacionBean.setUsuario( session.getAttribute("idUsuario").toString() );
			inseminacionService.eliminarInseminacion(inseminacionBean);
			
			AnimalBean animalBean = new AnimalBean();
			animalBean.setCodigoAnimal(codigoAnimal);
			animalBean.setEstadoProcesoEvolutivo("1");
			animalService.actualizaEstadoProcesoEvolutivo(animalBean);

			dataJSON.setRespuesta("ok", null, mapa);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}

}









