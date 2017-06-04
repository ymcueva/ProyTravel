package pe.com.paxtravel.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import pe.com.paxtravel.bean.CotizacionBean;
import pe.com.paxtravel.bean.OrdenPlanificacionBean;
import pe.com.paxtravel.service.CotizacionService;
import pe.com.paxtravel.service.OrdenPlanificacionService;
import pe.com.paxtravel.util.ControllerUtil;
import pe.com.paxtravel.util.DataJsonBean;
import pe.com.paxtravel.util.Utils;
import pe.gob.sunat.framework.spring.util.conversion.SojoUtil;

@Controller
public class OrdenPlanificacionController {
	@Autowired
	private OrdenPlanificacionService ordenPlanificacionService;

	@Autowired
	private CotizacionService cotizacionService;

	private String jsonView;

	public String getJsonView() {
		return jsonView;
	}

	public void setJsonView(String jsonView) {
		this.jsonView = jsonView;
	}

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
				/*
				 * Map<String, Object> parametrosRequest =
				 * ControllerUtil.parseRequestToMap(request); Map<String,
				 * Object> cotizacionBeanMap = (Map<String, Object>)
				 * parametrosRequest.get("cotizacionBean"); // inserta en el
				 * bean todos los valores del mapa (property vs keys)
				 * BeanUtils.populate(cotizacionBean, cotizacionBeanMap); if
				 * (!"".equals(cotizacionBean.getFechaCotizacion()) ) { String
				 * fechaCotizacion =
				 * Utils.stringToStringyyyyMMdd(cotizacionBean.
				 * getFechaCotizacion());
				 * cotizacionBean.setFechaCotizacion(fechaCotizacion); }
				 * listarCotizacion =
				 * cotizacionService.listarCotizacion(cotizacionBean);
				 * mapa.put("listaCotizacion", listarCotizacion);
				 * dataJSON.setRespuesta("ok", null, mapa); flag = true;
				 */
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

	@RequestMapping(value = "/formRegistrarOrdenPlanificacion", method = {RequestMethod.GET, RequestMethod.POST })
	public ModelAndView formRegistrarOrdenPlanificacion(
			HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapaDatos = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {
			modelAndView = new ModelAndView();
			List<CotizacionBean> listaCotizacion = new ArrayList<CotizacionBean>();
			// List<PaisBean> listaPais = new ArrayList<PaisBean>();
			mapaDatos.put("titulo", "REGISTRAR ORDEN PLANIFICACION");

			mapaDatos.put("listCotizacion", listaCotizacion);
			// mapaDatos.put("listPais", listaPais);
			// modelAndView.addObject("numeroCotizacion",
			// cotizacionService.generarNumeroCotizacion()+"");
			modelAndView.addObject("titulo", "REGISTRAR ORDEN PLANIFICACION");
			modelAndView.addObject("mapaDatos", mapaDatos);
			modelAndView.addObject("fechaCotizacion",
					Utils.dateUtilToStringDDMMYYYY(new Date()));
			modelAndView
					.setViewName("ordenPlanificacion/registrarOrdenPlanificacion");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return modelAndView;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/grabarTransaccionOrdPlanificacion")
	public ModelAndView grabarTransaccionOrdPlanificacion(
			HttpServletRequest request, HttpServletResponse response) {
		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {

			System.out.println("grabarTransaccionOrdPlanificacion ");
			modelAndView = new ModelAndView();
			Map<String, Object> parametrosRequest = ControllerUtil
					.parseRequestToMap(request);
			Map<String, Object> ordenPlanificacionBeanMap = (Map<String, Object>) parametrosRequest
					.get("ordenPlanificacionBean");
			OrdenPlanificacionBean ordenPlanificacionBean = new OrdenPlanificacionBean();
			BeanUtils.populate(ordenPlanificacionBean,
					ordenPlanificacionBeanMap);
			System.out.println(" Inicio bean ");
			System.out.println(" bean: " + ordenPlanificacionBean.toString());
			// System.out.println(estado);
			ordenPlanificacionBean.setIdCotiza(ordenPlanificacionBean
					.getIdCotiza());
			ordenPlanificacionBean.setNuOrden(ordenPlanificacionBean
					.getNuOrden());
			ordenPlanificacionBean.setIdEstado(1);
			ordenPlanificacionBean.setObservacion(ordenPlanificacionBean
					.getObservacion());
			ordenPlanificacionBean.setDescripcion(ordenPlanificacionBean
					.getDescripcion());
			ordenPlanificacionBean.setAutorizacion(1);
			ordenPlanificacionBean.setIdCliente(ordenPlanificacionBean
					.getIdCliente());
			System.out.println(" fechas ini... ");

			if (ordenPlanificacionBean.getFeOrder() != null
					&& !ordenPlanificacionBean.getFeOrder().equals("")) {
				ordenPlanificacionBean.setFeOrder(Utils
						.stringToStringyyyyMMdd(ordenPlanificacionBean
								.getFeOrder()));
			} else {
				ordenPlanificacionBean.setFeOrder(null);
			}

			if (ordenPlanificacionBean.getFeInicio() != null
					&& !ordenPlanificacionBean.getFeInicio().equals("")) {
				ordenPlanificacionBean.setFeInicio(Utils
						.stringToStringyyyyMMdd(ordenPlanificacionBean
								.getFeInicio()));
			}

			if (ordenPlanificacionBean.getFeFin() != null
					&& !ordenPlanificacionBean.getFeFin().equals("")) {
				ordenPlanificacionBean.setFeFin(Utils
						.stringToStringddMMyyyy(ordenPlanificacionBean
								.getFeFin()));
			}
			System.out.println(" fechas fin... ");
			/*
			 * ordenPlanificacionBean.setIdTrabajador(1);
			 * ordenPlanificacionBean.
			 * setNuNinos(ordenPlanificacionBean.getNuNinos());
			 * ordenPlanificacionBean
			 * .setNuAdultos(ordenPlanificacionBean.getNuAdultos());
			 */
			ordenPlanificacionBean.setIdMoneda(1);
			ordenPlanificacionBean
					.setImPresupuestoMaximo(ordenPlanificacionBean
							.getImPresupuestoMaximo());
			ordenPlanificacionBean
					.setImPresupuestoMinimo(ordenPlanificacionBean
							.getImPresupuestoMinimo());
			// System.out.println(ordenPlanificacionBean);
			System.out.println(" enviar a grabar... ");
			System.out.println(" objeto: " + ordenPlanificacionBean.toString());
			int registro = ordenPlanificacionService
					.GrabarOrdenPlanificacion(ordenPlanificacionBean);
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
