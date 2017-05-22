package pe.com.paxtravel.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

//import pe.gob.sunat.framework.uti

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import pe.com.paxtravel.bean.EmpleadoBean;
import pe.com.paxtravel.service.EmpleadoService;
import pe.com.paxtravel.util.ControllerUtil;
import pe.com.paxtravel.util.DataJsonBean;
import pe.com.paxtravel.util.Utils;

@Controller
public class EmpleadoController {

	@Autowired
	private EmpleadoService empleadoService;

	private String jsonView;
	
	@Autowired
	private Properties acceso; 

	public String getJsonView() {
		return jsonView;
	}

	public void setJsonView(String jsonView) {
		this.jsonView = jsonView;
	}
	
	@RequestMapping( value = "/obtenerEmpleadosInicial", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView obtenerEmpleadosInicial(HttpServletRequest request, HttpServletResponse response){
		
		DataJsonBean dataJSON = new DataJsonBean();
		
		try {
			List<EmpleadoBean> listaEmpleado = new ArrayList<EmpleadoBean>();
			HashMap<String, Object> mapaDatos = new HashMap<String, Object>();
			EmpleadoBean empleadoBean = Utils.mapearBean(request, EmpleadoBean.class);
			
			listaEmpleado = empleadoService.listarEmpleado(empleadoBean);
			
			mapaDatos.put("listaEmpleados", listaEmpleado);
			mapaDatos.put("pagConForm", StringUtils.trimToEmpty(acceso.getProperty("paginadoEmpleados")));
			dataJSON.setRespuesta("ok", null, mapaDatos);
		} catch (Exception e) {
			System.out.println("error: " + e.getMessage());
		} finally{
			
		}
		
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}
	
	@RequestMapping( value = "/exportaListaEmpleado", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView exportaListaEmpleado(HttpServletRequest request, HttpServletResponse response){
		try {
			SimpleDateFormat sdfExcel = new SimpleDateFormat("yyyyMMddmmss");
			String nombreExcel = "Empleado"+sdfExcel.format(new Date());
			List<EmpleadoBean> listaEmpleado = new ArrayList<EmpleadoBean>();
			EmpleadoBean empleadoBean = Utils.mapearBean(request, EmpleadoBean.class);
			
			listaEmpleado = empleadoService.listarEmpleado(empleadoBean);
			
			response.setContentType("application/xls");
			response.setHeader("Content-Disposition", "attachment; filename="+nombreExcel+".xls");
			
			empleadoService.exportarExcel(listaEmpleado, response.getOutputStream());
			
			return null;	
		} catch (Exception e) {
			String msgError = ControllerUtil.handleMsgError(e);
			return null;
//			return ControllerUtil.handleError(msgError, e, request);
		}
	}

	@RequestMapping( value = "/verDetalleEmpleado", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView verDetalleEmpleado(HttpServletRequest request, HttpServletResponse response){
		ModelAndView modelAndView = null; 
		try {
			Map<String, Object> mapa = new HashMap<String, Object>();
			String codigo = request.getParameter("codigoEmpleado");
			List<EmpleadoBean> listaEmpleado = new ArrayList<EmpleadoBean>();
			EmpleadoBean empleadoBean = new EmpleadoBean();
			empleadoBean.setCodigo(codigo);
			
			listaEmpleado = empleadoService.listarEmpleado(empleadoBean);
			
			if (CollectionUtils.isNotEmpty(listaEmpleado)) {
	            empleadoBean = listaEmpleado.get(0);
	        }
			
			if (listaEmpleado.size()>0 && listaEmpleado !=null ){
				mapa.put("codigo", empleadoBean.getCodigo());
				mapa.put("username", empleadoBean.getUsername());
				mapa.put("nombre", empleadoBean.getNombre());
				mapa.put("paterno", empleadoBean.getPaterno());
				mapa.put("materno", empleadoBean.getMaterno());
				mapa.put("dni", empleadoBean.getCodigo());
				mapa.put("fechaNacimiento", empleadoBean.getFechaNacimiento());
			}
			
//			modelAndView.setViewName("empleado/verDetalle");
//			modelAndView.addObject(mapa);
			return new ModelAndView("empleado/verDetalle", mapa);	
		} catch (Exception e) {
			String msgError = ControllerUtil.handleMsgError(e);
			return null;
//			return ControllerUtil.handleError(msgError, e, request);
		}
		
	}

	@RequestMapping( value = "/cargarRegistrarEmpleado", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView cargarRegistrarEmpleado(HttpServletRequest request, HttpServletResponse response){
		ModelAndView modelAndView = null; 
		try {
			modelAndView = new ModelAndView();
			String tipoUsuario = String.valueOf(acceso.get("tipoUsuario"));
			String estado = String.valueOf(acceso.get("estado"));
			
			List<Map<String, Object>> listaTipoUsuario = null;
			List<Map<String, Object>> listaEstado = null;
			listaTipoUsuario = (List<Map<String, Object>>) new JsonSerializer().deserialize(tipoUsuario, java.util.Map.class);
			listaEstado = (List<Map<String, Object>>) new JsonSerializer().deserialize(estado, java.util.Map.class);
			
			Map<String, Object> mapaDatos = new HashMap<String, Object>();
			mapaDatos.put("listTipoUsuario", listaTipoUsuario);
			mapaDatos.put("listEstado", listaEstado);
			
			modelAndView.addObject("mapaDatos", mapaDatos);
			modelAndView.addObject("fechaIngreso", Utils.dateUtilToStringDDMMYYYY( new Date() ));
			modelAndView.addObject("fechaCese", Utils.dateUtilToStringDDMMYYYY( new Date() )) ;
			modelAndView.setViewName("empleado/registrarEmpleado");
//			return new ModelAndView("empleado/registrarEmpleado", mapa);
			return modelAndView;
		} catch (Exception e) {
			String msgError = ControllerUtil.handleMsgError(e);
			return null;
//			return ControllerUtil.handleError(msgError, e, request);
		}
		
	}
	
	@RequestMapping( value = "/buscarEmpleado", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView buscarEmpleado(HttpServletRequest request, HttpServletResponse response){
		
		DataJsonBean dataJSON = new DataJsonBean();
		
		try {
			List<EmpleadoBean> listaEmpleado = new ArrayList<EmpleadoBean>();
			
			HashMap<String, Object> mapaDatos = new HashMap<String, Object>();
			
//			listaEmpleado = empleadoService.listarEmpleado();
			
			
			mapaDatos.put("listaEmpleados", listaEmpleado);
			mapaDatos.put("pagConForm", StringUtils.trimToEmpty(acceso.getProperty("paginadoEmpleados")));
			dataJSON.setRespuesta("ok", null, mapaDatos);
		} catch (Exception e) {
			// TODO: handle exception
		} finally{
			
		}
		
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}
	
	@RequestMapping("/listaEmpleado")
	public ModelAndView listaEmpleado() {
		ModelAndView modelAndView = null;
		modelAndView = new ModelAndView();
		
		SimpleDateFormat sd = new SimpleDateFormat("dd/MM/yyyy");
		List<EmpleadoBean> listaEmpleado = new ArrayList<EmpleadoBean>();

		String tipoUsuario = String.valueOf(acceso.get("tipoUsuario"));
		List<Map<String, Object>> listaTipoUsuario = null;
		listaTipoUsuario = (List<Map<String, Object>>) new JsonSerializer().deserialize(tipoUsuario, java.util.Map.class);
		
		Map<String, Object> mapaDatos = new HashMap<String, Object>();
		mapaDatos.put("listTipoUsuario", listaTipoUsuario);
		
		modelAndView.addObject("mapaDatos", mapaDatos);
		modelAndView.addObject("tituloPagina", "LISTA-EMPLEADOS");
		modelAndView.addObject("fechaActual", sd.format( new Date() ));
		modelAndView.setViewName("empleado/listaEmpleado");
		
		return modelAndView;
	}
	
	@RequestMapping("/cargaRegistroEmpleado")
	public ModelAndView cargaRegistroEmpleado() {
		ModelAndView modelAndView = null;
		modelAndView = new ModelAndView();
		
		String codigoEmpleado = empleadoService.generarCodigoEmpleado();
		String tipoUsuario = String.valueOf(acceso.get("tipoUsuario"));
		
		List<Map<String, Object>> listaTipoUsuario = null;
		listaTipoUsuario = (List<Map<String, Object>>) new JsonSerializer().deserialize(tipoUsuario, java.util.Map.class);
		
		Map<String, Object> mapaDatos = new HashMap<String, Object>();
		mapaDatos.put("listTipoUsuario", listaTipoUsuario);
		
		modelAndView.addObject("mapaDatos", mapaDatos);
		modelAndView.addObject("tituloPagina", "REGISTRAR-EMPLEADO");
		modelAndView.addObject("codigoEmpleado", codigoEmpleado);
		modelAndView.setViewName("empleado/registrarEmpleado");
		return modelAndView;
	}
	
	/*
	@RequestMapping("/registrarEmpleado")
	public ModelAndView registrarEmpleado() {
		ModelAndView modelAndView = null;
		modelAndView = new ModelAndView();
		
//		String codigoEmpleado = empleadoService.generarCodigoEmpleado();
		modelAndView.addObject("tituloPagina", "REGISTRAR-EMPLEADO");
//		modelAndView.addObject("codigoEmpleado", codigoEmpleado);
		modelAndView.setViewName("empleado/registrarEmpleado");
		return modelAndView;
	}
*/
	
	@RequestMapping(value = "/cargarDatosSession", method = RequestMethod.GET)
	public ModelAndView cargarDatosSession(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = null;
		EmpleadoBean empleadoBean = Utils.mapearBean(request, EmpleadoBean.class);
		request.getSession().setAttribute("empleadoBean", empleadoBean);
		
		//COMPLETAR EL REGISTRO, INGRESANDO EL PASSWORD DEL EMPLEADO
		modelAndView = new ModelAndView("jsonView");
		modelAndView.addObject("valor1", "REGISTRAR PASSWORD DE EMPLEADO");
		return modelAndView;
	}
	
	@RequestMapping(value = "/registrarPassword", method = RequestMethod.GET)
	public ModelAndView registrarPassword(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = null;
		
		//COMPLETAR EL REGISTRO, INGRESANDO EL PASSWORD DEL EMPLEADO
		modelAndView = new ModelAndView("empleado/registrarPassword");
		modelAndView.addObject("tituloPagina", "REGISTRAR PASSWORD DE EMPLEADO");
		return modelAndView;
	}
	
	@RequestMapping(value = "/completarRegistroEmpleado", method = RequestMethod.GET)
	public ModelAndView completarRegistroEmpleado(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = null;
		String password = request.getParameter("password");
		
		EmpleadoBean empleadoBean = (EmpleadoBean) request.getSession().getAttribute("empleadoBean");
		empleadoBean.setPassword(password);
		
		int registro = empleadoService.registrarEmpleado(empleadoBean);
		modelAndView = new ModelAndView("jsonView", "resultado", "hola");
		modelAndView.addObject("tituloPagina", "REGISTRO OK EMPLEADO");
		modelAndView.addObject("estadoRegistro", registro);
		return modelAndView;
	}
	
	@RequestMapping(value = "/registrarOK")
	public ModelAndView registrarOK(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = null;
		
		//COMPLETAR EL REGISTRO, INGRESANDO EL PASSWORD DEL EMPLEADO
		modelAndView = new ModelAndView("empleado/RegistroOKEmpleado");
		modelAndView.addObject("tituloPagina", "REGISTRO SATISFACTORIO DE EMPLEADO");
		return modelAndView;
	}
	
	@RequestMapping(value = "/cargarListaEmpleado")
	public ModelAndView cargarListaEmpleado(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = null;
		
		String codigoEmpleado = empleadoService.generarCodigoEmpleado();
		String tipoDocumento = String.valueOf(acceso.get("tipoDocumento"));
		
		List<Map<String, Object>> listaTipoUsuario = null;
		listaTipoUsuario = (List<Map<String, Object>>) new JsonSerializer().deserialize(tipoDocumento, java.util.Map.class);
		
		modelAndView = new ModelAndView(jsonView, "resultado", listaTipoUsuario);
		modelAndView.addObject("tituloPagina", "REGISTRO SATISFACTORIO DE EMPLEADO");
		return modelAndView;
	}
	
	
	@RequestMapping("/grabarTransaccion")
	public ModelAndView registrarTransaccion(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = null;
		modelAndView = new ModelAndView();
		
		try {
			Map<String, Object> parametrosRequest = ControllerUtil.parseRequestToMap(request);
			Map<String, Object> empleadoBeanMap = (Map<String, Object>) parametrosRequest.get("empleadoBean");
			
			EmpleadoBean empleadoBean = new EmpleadoBean();
			// inserta en el bean todos los valores del mapa (property vs keys)
			BeanUtils.populate(empleadoBean, empleadoBeanMap);
			BeanUtils.copyProperties(empleadoBean, empleadoBeanMap);
			
			Map<String, Object> mapaParametros = (Map<String, Object>) parametrosRequest.get("empleadoBean");
			mapaParametros.put("empleadoBean", empleadoBean);
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}finally{
			
		}

		modelAndView.addObject("tituloPagina", "REGISTRAR-TRANSACCION");
		modelAndView.setViewName("empleado/registrarEmpleado");
		return modelAndView;
	}
	
}









