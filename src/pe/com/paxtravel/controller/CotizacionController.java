package pe.com.paxtravel.controller;

import java.io.File;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import pe.com.paxtravel.bean.AnimalBean;
import pe.com.paxtravel.bean.AuthorizeNetBean;
import pe.com.paxtravel.bean.CiudadBean;
import pe.com.paxtravel.bean.ClienteBean;
import pe.com.paxtravel.bean.CotizacionBean;
import pe.com.paxtravel.bean.CotizacionDetalleBean;
import pe.com.paxtravel.bean.CotizacionDetalleDestinosBean;
import pe.com.paxtravel.bean.CotizacionDetalleTicketVueloBean;
import pe.com.paxtravel.bean.ExpedienteLogBean;
import pe.com.paxtravel.bean.FareInfoBean;
import pe.com.paxtravel.bean.HotelHabitacionBean;
import pe.com.paxtravel.bean.MotivoViajeBean;
import pe.com.paxtravel.bean.OrdenPlanificacionBean;
import pe.com.paxtravel.bean.PagoLogBean;
import pe.com.paxtravel.bean.PaisBean;
import pe.com.paxtravel.bean.PaqueteResumeBean;
import pe.com.paxtravel.bean.PaqueteTuristicoBean;
import pe.com.paxtravel.bean.ProcesarPagoBean;
import pe.com.paxtravel.bean.RechazarCotizacionBean;
import pe.com.paxtravel.bean.ServicioAdicionalBean;
import pe.com.paxtravel.bean.ValidarEmailBean;
import pe.com.paxtravel.service.AuthorizeNetService;
import pe.com.paxtravel.service.ClienteService;
import pe.com.paxtravel.service.CotizacionService;
import pe.com.paxtravel.service.PagoLogService;
import pe.com.paxtravel.service.PaqueteTuristicoService;
import pe.com.paxtravel.tree.data.CSVUtils;
import pe.com.paxtravel.tree.data.PaqueteManagerBean;
import pe.com.paxtravel.tree.decision.DataManager;
import pe.com.paxtravel.tree.decision.TableManager;
import pe.com.paxtravel.util.ControllerUtil;
import pe.com.paxtravel.util.DataJsonBean;
import pe.com.paxtravel.util.EmailUtil;
import pe.com.paxtravel.util.Utils;
import pe.gob.sunat.framework.spring.util.conversion.SojoUtil;
//import pe.gob.sunat.framework.uti
//import org.apache.commons.beanutils.BeanUtils;
//import pe.com.paxtravel.service.ProduccionService;

@Controller
public class CotizacionController {

	@Autowired
	private CotizacionService cotizacionService;

	@Autowired
	private ClienteService clienteService;

	@Autowired
	private AuthorizeNetService authorizeNetService;

	@Autowired
	private PagoLogService pagoLogService;

	@Autowired
	private PaqueteTuristicoService paqueteTuristicoService;

	private String jsonView;

	public String getJsonView() {
		return jsonView;
	}

	public void setJsonView(String jsonView) {
		this.jsonView = jsonView;
	}

	@RequestMapping(value = "/verDetalleCotizacion", method = {
			RequestMethod.GET, RequestMethod.POST })
	public ModelAndView verDetalleCotizacion(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {
			CotizacionBean o = new CotizacionBean();
			int idCotizacion = Integer.parseInt(request
					.getParameter("idCotizacion"));
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

	@RequestMapping(value = "/listarCotizacion", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView listarCotizacion(HttpServletRequest request,
			HttpServletResponse response) {

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

			String botonBuscar = (request.getParameter("btnBuscar")) != null ? request
					.getParameter("btnBuscar") : "";

			mapa.put("titulo", "");

			System.out.println("boton: " + botonBuscar);

			if ("1".equals(botonBuscar)) {

				System.out.println("Ingreso....");

				Map<String, Object> parametrosRequest = ControllerUtil
						.parseRequestToMap(request);
				Map<String, Object> cotizacionBeanMap = (Map<String, Object>) parametrosRequest.get("cotizacionBean");

				// "numeroCotizacion":"","codigoEstadoCotizacion":"1","fechaCotizacion":"14/06/2017","tipoBusqueda":"1","nombreCliente"

				System.out.println("[cotizacionBeanMap]");

				System.out.println("numeroCotizacion: "
						+ cotizacionBeanMap.get("numeroCotizacion"));
				System.out.println("codigoEstadoCotizacion: "
						+ cotizacionBeanMap.get("codigoEstadoCotizacion"));
				System.out.println("fechaCotizacion: "
						+ cotizacionBeanMap.get("fechaCotizacion"));
				System.out.println("tipoBusqueda: "
						+ cotizacionBeanMap.get("tipoBusqueda"));
				System.out.println("nombreCliente: "
						+ cotizacionBeanMap.get("nombreCliente"));

				// inserta en el bean todos los valores del mapa (property vs
				// keys)
				BeanUtils.populate(cotizacionBean, cotizacionBeanMap);

				System.out.println("[cotizacionBean]");

				System.out.println("numeroCotizacion: "
						+ cotizacionBean.getNumeroCotizacion());
				System.out.println("codigoEstadoCotizacion: "
						+ cotizacionBean.getCodigoEstadoCotizacion());
				System.out.println("fechaCotizacion: "
						+ cotizacionBean.getFechaCotizacion());
				System.out.println("tipoBusqueda: "
						+ cotizacionBean.getTipoBusqueda());
				System.out.println("nombreCliente: "
						+ cotizacionBean.getNombreCliente());

				if (!"".equals(cotizacionBean.getFechaCotizacion())) {
					String fechaCotizacion = Utils
							.stringToStringyyyyMMdd(cotizacionBean
									.getFechaCotizacion());
					cotizacionBean.setFechaCotizacion(fechaCotizacion);
				}

				if (cotizacionBean.getTipoBusqueda() == 1) {
					cotizacionBean.setDocumentoCliente(cotizacionBean
							.getNombreCliente());
					cotizacionBean.setNombreCliente("");
				} else if (cotizacionBean.getTipoBusqueda() == 2) {
					cotizacionBean.setDocumentoCliente("");
					cotizacionBean.setNombreCliente("%"
							+ cotizacionBean.getNombreCliente() + "%");
				}

				listarCotizacion = cotizacionService
						.listarCotizacion(cotizacionBean);
				mapa.put("listaCotizacion", listarCotizacion);
				dataJSON.setRespuesta("ok", null, mapa);
				flag = true;

			} else {

				listarCotizacion = cotizacionService
						.listarCotizacion(cotizacionBean);
				modelAndView.addObject("listaCotizacion",
						SojoUtil.toJson(listarCotizacion));

				// mapa.put("fechaInseminacion", sdf.format( new Date() ));
				// modelAndView.addObject("mapaDatos", mapa);

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

	@RequestMapping(value = "/revisarCotizacion", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView revisarCotizacion(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "cotizacionId") String cotizacionId) {

		ModelAndView modelAndView = new ModelAndView();
		try {
			// Consultar info segun cotizacion id
			CotizacionBean cotizacionBean = cotizacionService
					.obtenerCotizacionPorId(Integer.parseInt(cotizacionId));
			if (cotizacionBean != null) {
				// Consultar si aun no se ha verificado el email
				ClienteBean clienteBean = clienteService
						.obtenerCliente(cotizacionBean.getIdCliente());
				if (clienteBean != null) {
					if (!clienteBean.isEmailValidado()) {
						modelAndView
								.addObject("cotizacionBean", cotizacionBean);
						modelAndView.setViewName("cotizacion/validarEmail");
						return modelAndView;
					} else {
						return this.loadRevisarCotizacion(request, response,
								cotizacionId);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping(value = "/loadRevisarCotizacion", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView loadRevisarCotizacion(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "cotizacionId") String cotizacionId) {

		ModelAndView modelAndView = new ModelAndView();
		HashMap<String, Object> mapa = new HashMap<String, Object>();

		CotizacionBean cotizacionBean = new CotizacionBean();

		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

		boolean flag = false;
		DataJsonBean dataJSON = new DataJsonBean();

		System.out.println("Bienvenido a revisar cotizacion");

		if (cotizacionId != null && cotizacionId.length() > 0) {
			System.out.println("paramterer cotizacion id: " + cotizacionId);

			// Consultar info segun cotizacion id
			cotizacionBean = cotizacionService.obtenerCotizacionPorId(Integer
					.parseInt(cotizacionId));
			if (cotizacionBean != null) {

				// RN_082 Validar que la cotizacion tenga estado enviado y fecha
				// vigente
				if (!cotizacionBean.getEstado().equalsIgnoreCase("ENVIADO")) {
					modelAndView
							.addObject(
									"mensajeResultado",
									"No puede acceder a esta cotización porque no se encuentra con estado Enviado o no tiene fecha vigente");
					modelAndView.setViewName("cotizacion/mensajeResultado");
					return modelAndView;
				}

				System.out.println("coti bean "
						+ cotizacionBean.getIdCotizacion());
				// Si es tipo paquete turistico
				if (cotizacionBean.getIdTipoCotizacion() == 1) {
					System.out.println("tipo 1 paquete turistico");
					List<CotizacionDetalleDestinosBean> listCotDetDestBean = cotizacionService
							.listarCotizacionPaqueteDestinos(Integer
									.parseInt(cotizacionId));
					if (listCotDetDestBean != null
							&& listCotDetDestBean.size() > 0) {
						// Lista destinos
						cotizacionBean
								.setListCotizacionDetalleDestinos(listCotDetDestBean);
						cotizacionBean.setIdCotizacion(listCotDetDestBean
								.get(0).getIdCotiza());
						cotizacionBean.setIdCliente(listCotDetDestBean.get(0)
								.getIdCliente());
						cotizacionBean.setNumeroCotizacion(listCotDetDestBean
								.get(0).getNuCotiza());
						cotizacionBean.setFechaCotizacion(listCotDetDestBean
								.get(0).getFeCotiza());
						cotizacionBean.setNombreCliente(listCotDetDestBean.get(
								0).getNombresCliente()
								+ " "
								+ listCotDetDestBean.get(0)
										.getApellidosCliente());
						cotizacionBean.setTipoDocumento(listCotDetDestBean.get(
								0).getTipoDocu());
						cotizacionBean.setDocumentoCliente(listCotDetDestBean
								.get(0).getNuDocumento());
						PaqueteTuristicoBean paqueteTuristicoBean = new PaqueteTuristicoBean();
						paqueteTuristicoBean.setIdPaquete(listCotDetDestBean
								.get(0).getIdPaqueteTuristico());
						paqueteTuristicoBean.setFeInicio(listCotDetDestBean
								.get(0).getFePartida());
						paqueteTuristicoBean.setFeFin(listCotDetDestBean.get(0)
								.getFeRetorno());
						paqueteTuristicoBean.setNombre(listCotDetDestBean
								.get(0).getNombrePaqueteTuristico());
						paqueteTuristicoBean
								.setCantidadPasajeros(listCotDetDestBean.get(0)
										.getNuAdultos()
										+ listCotDetDestBean.get(0)
												.getNuNinos());
						cotizacionBean
								.setPaqueteTuristico(paqueteTuristicoBean);
						cotizacionBean.setPrecioTotal(listCotDetDestBean.get(0)
								.getImPrecio());
						System.out.println("[cotizacionBean] "
								+ cotizacionBean.toString());
						modelAndView
								.addObject("cotizacionBean", cotizacionBean);
						modelAndView.addObject("listaDestinos", SojoUtil
								.toJson(cotizacionBean
										.getListCotizacionDetalleDestinos()));
						modelAndView
								.setViewName("cotizacion/revisarCotizacion");

					}
				}
				// Si es tipo ticket aereo
				else if (cotizacionBean.getIdTipoCotizacion() == 2) {
					System.out.println("tipo 2 ticket");

					List<CotizacionDetalleDestinosBean> listCotDetDestBean = cotizacionService
							.listarCotizacionTicketDestinos(Integer
									.parseInt(cotizacionId));
					if (listCotDetDestBean != null
							&& listCotDetDestBean.size() > 0) {
						// Lista destinos
						cotizacionBean
								.setListCotizacionDetalleDestinos(listCotDetDestBean);
						cotizacionBean.setIdCotizacion(listCotDetDestBean
								.get(0).getIdCotiza());
						cotizacionBean.setIdCliente(listCotDetDestBean.get(0)
								.getIdCliente());
						cotizacionBean.setNumeroCotizacion(listCotDetDestBean
								.get(0).getNuCotiza());
						cotizacionBean.setFechaCotizacion(listCotDetDestBean
								.get(0).getFeCotiza());
						cotizacionBean.setNombreCliente(listCotDetDestBean.get(
								0).getNombresCliente()
								+ " "
								+ listCotDetDestBean.get(0)
										.getApellidosCliente());
						cotizacionBean.setTipoDocumento(listCotDetDestBean.get(
								0).getTipoDocu());
						cotizacionBean.setDocumentoCliente(listCotDetDestBean
								.get(0).getNuDocumento());
						cotizacionBean.setPrecioTotal(listCotDetDestBean.get(0)
								.getImPrecio());
						cotizacionBean.setCantidadPasajeros(listCotDetDestBean
								.get(0).getNuAdultos()
								+ listCotDetDestBean.get(0).getNuNinos());
						System.out.println("[cotizacionBean] "
								+ cotizacionBean.toString());
						modelAndView
								.addObject("cotizacionBean", cotizacionBean);
						modelAndView.addObject("listaDestinos", SojoUtil
								.toJson(cotizacionBean
										.getListCotizacionDetalleDestinos()));
						modelAndView
								.setViewName("cotizacion/revisarCotizacionTicket");
					}
				}
			}
		}
		if (flag) {
			return ControllerUtil.handleJSONResponse(dataJSON, response);
		} else {
			return modelAndView;
		}
	}

	@RequestMapping(value = "/validarEmail", method = { RequestMethod.POST,
			RequestMethod.GET })
	public ModelAndView validarEmail(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			Map<String, Object> parametrosRequest = ControllerUtil
					.parseRequestToMap(request);
			Map<String, Object> validarEmailBeanMap = (Map<String, Object>) parametrosRequest
					.get("validarEmailBean");
			ValidarEmailBean validarEmailBean = new ValidarEmailBean();
			BeanUtils.populate(validarEmailBean, validarEmailBeanMap);
			System.out.println("validarEmailBean: "
					+ validarEmailBean.toString());
			ClienteBean clienteBean = clienteService
					.obtenerCliente(validarEmailBean.getIdCliente());
			if (clienteBean != null) {
				System.out.println("clienteBean: " + clienteBean.toString());
				// Si es email valido
				if (validarEmailBean.getEmail().equals(clienteBean.getEmail())) {
					System.out.println("email valido");
					// Actualizar flag de validacion email
					HashMap<String, Object> mapa = new HashMap<String, Object>();
					mapa.put("resultadoValidarEmail", "OK");
					String url = "http://localhost:7001/ProyTravel/loadRevisarCotizacion?cotizacionId="
							+ validarEmailBean.getIdCotizacion();
					mapa.put("url", url);
					DataJsonBean dataJSON = new DataJsonBean();
					dataJSON.setRespuesta("ok1", null, mapa);
					clienteService
							.actualizarFlagValidacionEmail(new ClienteBean(
									validarEmailBean.getIdCliente(), true));
					return ControllerUtil
							.handleJSONResponse(dataJSON, response);
					// return this.revisarCotizacion(request, response,
					// String.valueOf(validarEmailBean.getIdCotizacion()));
				} else {
					System.out.println("email no valido");
					// Mostrar mensaje de error
					HashMap<String, Object> mapa = new HashMap<String, Object>();
					mapa.put("resultadoValidarEmail", "ERROR");
					DataJsonBean dataJSON = new DataJsonBean();
					dataJSON.setRespuesta("ok1", null, mapa);
					return ControllerUtil
							.handleJSONResponse(dataJSON, response);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping(value = "/procesarPagoCotizacion", method = {
			RequestMethod.POST, RequestMethod.GET })
	public ModelAndView procesarPagoCotizacion(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			Map<String, Object> parametrosRequest = ControllerUtil
					.parseRequestToMap(request);
			Map<String, Object> procesarPagoBeanMap = (Map<String, Object>) parametrosRequest
					.get("procesarPagoBean");
			ProcesarPagoBean procesarPagoBean = new ProcesarPagoBean();
			BeanUtils.populate(procesarPagoBean, procesarPagoBeanMap);
			System.out.println("procesarPagoBean: "
					+ procesarPagoBean.toString());
			// Procesar pago en Authorize
			AuthorizeNetBean authorizeNetBean = authorizeNetService
					.procesarPago(procesarPagoBean);
			System.out.println("se proceso pago en authorize "
					+ authorizeNetBean.toString());
			// Grabar la operacion
			PagoLogBean pagoLogBean = new PagoLogBean();
			pagoLogBean.setIdCliente(procesarPagoBean.getIdCliente());
			pagoLogBean.setIdCotiza(procesarPagoBean.getIdCotiza());
			pagoLogBean.setImPrecio(procesarPagoBean.getImPrecio());
			pagoLogBean.setIdPaquete(procesarPagoBean.getIdPaquete());
			pagoLogBean.setNuOperacion(authorizeNetBean.getNumeroOperacion());
			pagoLogBean.setStOperacion(authorizeNetBean.getEstadoOperacion());
			pagoLogBean.setDeMensaje(authorizeNetBean.getMensajeProcesador());
			pagoLogService.grabarPagoLog(pagoLogBean);
			System.out.println("se grabo pago" + pagoLogBean.toString());
			// Actualizar el expediente con estado de la operacion
			ExpedienteLogBean expedienteLogBean = new ExpedienteLogBean();
			expedienteLogBean.setTiLog("COTIZA");
			expedienteLogBean.setIdTx(procesarPagoBean.getIdCotiza());
			expedienteLogBean.setIdUser(0);
			expedienteLogBean.setIdEstado(12);
			expedienteLogBean.setDesLog("Cotizacion Confirmada");
			cotizacionService.registrarExpedienteLog(expedienteLogBean);
			System.out.println("se actualizo con estado de la operacion "
					+ expedienteLogBean.toString());
			// Actualizar cotizacion estado aprobado
			CotizacionBean cotizacionBean = new CotizacionBean();
			cotizacionBean.setIdEstado(15);
			cotizacionBean.setIdCotizacion(procesarPagoBean.getIdCotiza());
			cotizacionBean.setIdPaquete(procesarPagoBean.getIdPaquete());
			cotizacionService.actualizarCotizacion(cotizacionBean);
			System.out.println("se actualizo ctoizacion estado aprobado");
			// Enviar correo al cliente
			buildEmail(procesarPagoBean.getEmailCliente(), "PAGO COTIZACION",
					"SE PAGO EXITOSAMENTE LA COTIZACION");
			System.out.println("se envio correo al cliente");
			// Actualizar el expediente con estado Aprobado de la cotizacion
			expedienteLogBean = new ExpedienteLogBean();
			expedienteLogBean.setTiLog("COTIZA");
			expedienteLogBean.setIdTx(procesarPagoBean.getIdCotiza());
			expedienteLogBean.setIdUser(0);
			expedienteLogBean.setIdEstado(15);
			expedienteLogBean.setDesLog("Cotizacion Aprobada");
			cotizacionService.registrarExpedienteLog(expedienteLogBean);
			System.out
					.println("se actualizo expediente con estado aprobado de la cotizacion");
			// Actualizar paquete turistico a estado asignado
			PaqueteTuristicoBean paqueteTuristicoBean = new PaqueteTuristicoBean();
			paqueteTuristicoBean.setIdEstado(6);
			paqueteTuristicoBean.setIdPaquete(procesarPagoBean.getIdPaquete());
			paqueteTuristicoService
					.actualizarEstadoPaqueteTuristico(paqueteTuristicoBean);
			System.out.println("se actualizo paquete con estado asignado");
			// Mostrar el numero de operacion de la cotizacion
			HashMap<String, Object> mapa = new HashMap<String, Object>();
			mapa.put(
					"resultadoProcesarPago",
					"PAGO REALIZADO (NRO. TRANSACCION: "
							+ authorizeNetBean.getNumeroOperacion() + ")");
			DataJsonBean dataJSON = new DataJsonBean();
			dataJSON.setRespuesta("ok1", null, mapa);
			return ControllerUtil.handleJSONResponse(dataJSON, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping(value = "/rechazarCotizacion", method = {
			RequestMethod.POST, RequestMethod.GET })
	public ModelAndView rechazarCotizacion(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			Map<String, Object> parametrosRequest = ControllerUtil
					.parseRequestToMap(request);
			Map<String, Object> rechazarBeanMap = (Map<String, Object>) parametrosRequest
					.get("rechazarCotizacionBean");
			RechazarCotizacionBean rechazarCotizacionBean = new RechazarCotizacionBean();
			BeanUtils.populate(rechazarCotizacionBean, rechazarBeanMap);
			System.out.println("rechazarCotizacionBean: "
					+ rechazarCotizacionBean.toString());
			// Actualizar la cotizacion a estado rechazado
			CotizacionBean cotizacionBean = new CotizacionBean();
			cotizacionBean.setIdEstado(16);
			cotizacionBean
					.setIdCotizacion(rechazarCotizacionBean.getIdCotiza());
			cotizacionBean.setIdPaquete(rechazarCotizacionBean.getIdPaquete());
			cotizacionService.actualizarCotizacion(cotizacionBean);
			System.out.println("se actualizo la cotizacion a estado rechazado");
			// Actualizar expediente con estado rechazado a la cotizacion
			ExpedienteLogBean expedienteLogBean = new ExpedienteLogBean();
			expedienteLogBean.setTiLog("COTIZA");
			expedienteLogBean.setIdTx(rechazarCotizacionBean.getIdCotiza());
			expedienteLogBean.setIdUser(0);
			expedienteLogBean.setIdEstado(16);
			expedienteLogBean.setDesLog("Cotizacion Rechazada");
			cotizacionService.registrarExpedienteLog(expedienteLogBean);
			System.out.println("se registro expediente con estado rechazado");
			// Mostrar el numero de operacion de la cotizacion
			HashMap<String, Object> mapa = new HashMap<String, Object>();
			mapa.put("resultadoRechazarCotizacion",
					"LA COTIZACION HA SIDO RECHAZADA");
			DataJsonBean dataJSON = new DataJsonBean();
			dataJSON.setRespuesta("ok1", null, mapa);
			return ControllerUtil.handleJSONResponse(dataJSON, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	private void buildEmail(String email, String subject, String text) {
		String[] recipientsTO = { email };
		try {
			EmailUtil.sendEmail(recipientsTO, null, null, subject, text);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/cargarFormRegistrarCotizacion", method = {
			RequestMethod.GET, RequestMethod.POST })
	public ModelAndView cargarFormRegistrarCotizacion(
			HttpServletRequest request, HttpServletResponse response) {

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

			/*
			 * listaToro = animalService.listarToro();
			 * 
			 * Map<String, Object> mapaListaToro = new HashMap<String,
			 * Object>(); for (AnimalBean animalBean : listaToro) {
			 * mapaListaToro.put("codigo", animalBean.getCodigoAnimal());
			 * mapaListaToro.put("descripcion", animalBean.getNombreAnimal()); }
			 * mapa.put("codigoAnimal",(String)
			 * request.getParameter("codigoAnimal"));
			 * mapa.put("nombreAnimal",(String)
			 * request.getParameter("nombreAnimal")); mapa.put("listaToro",
			 * SojoUtil.toJson(mapaListaToro) ); mapa.put("fechaActual",
			 * sdf.format( new Date() )); dataJSON.setRespuesta("ok", null,
			 * mapa); Map<String, Object> mapaDatos = new HashMap<String,
			 * Object>(); mapaDatos.put("listTipoUsuario", listaTipoUsuario);
			 */

			mapaDatos.put("titulo", "Registrar Cotizaci&oacute;n");
			Map<String, Object> mapaListaCiudad = new HashMap<String, Object>();

			for (CiudadBean ciudadBean1 : listaCiudad) {
				mapaListaCiudad.put("idCiudad", ciudadBean1.getIdCiudad());
				mapaListaCiudad.put("nomCiudad", ciudadBean1.getNomCiudad());
			}

			mapaDatos.put("listCiudad", listaCiudad);
			mapaDatos.put("listPais", listaPais);

			modelAndView.addObject("numeroCotizacion",
					cotizacionService.generarNumeroCotizacion() + "");
			modelAndView.addObject("titulo", "REGISTRAR COTIZACI&Oacute;N");
			modelAndView.addObject("mapaDatos", mapaDatos);
			modelAndView.addObject("fechaCotizacion",
					Utils.dateUtilToStringDDMMYYYY(new Date()));
			modelAndView.setViewName("cotizacion/registrarCotizacion");

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return modelAndView;
	}

	@RequestMapping(value = "/listarCiudad", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView listarCiudad(HttpServletRequest request,
			HttpServletResponse response) {

		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {

			List<CiudadBean> listaCiudad = new ArrayList<CiudadBean>();

			CiudadBean ciudadBean = new CiudadBean();
			int codigoPais = Integer.parseInt(request.getParameter("idPais"));
			ciudadBean.setIdPais(codigoPais);
			listaCiudad = cotizacionService.listarCiudad(ciudadBean);

			mapa.put("titulo", "Detalle Inseminaci&oacute;n");
			mapa.put("listaCiudad", listaCiudad);

			dataJSON.setRespuesta("ok", null, mapa);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}

	@RequestMapping(value = "/listarPaisDestino", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView listarPaisDestino(HttpServletRequest request,
			HttpServletResponse response) {

		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		try {

			List<PaisBean> lista = new ArrayList<PaisBean>();

			PaisBean bean = new PaisBean();
			int codigoPais = Integer.parseInt(request.getParameter("idPais"));
			bean.setIdPais(codigoPais);
			lista = cotizacionService.listarPais(bean);

			mapa.put("titulo", "Lista de Paises disponible");
			mapa.put("listaPais", lista);

			dataJSON.setRespuesta("ok", null, mapa);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}

	@RequestMapping(value = "/obtenerNombreCliente", method = {
			RequestMethod.GET, RequestMethod.POST })
	public ModelAndView obtenerNombreCliente(HttpServletRequest request,
			HttpServletResponse response) {

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

			if (listaCliente.size() > 0) {

				int age = listaCliente.get(0).getAge();

				System.out
						.println(listaCliente.get(0).getNombre() + ": " + age);

				if (age >= 18) {
					mapa.put("nombreCliente", listaCliente.get(0).getNombre()
							.toString().toUpperCase());
					mapa.put("idCliente", listaCliente.get(0).getIdCliente());
					mapa.put("status", "1");
				} else {
					mapa.put("nombreCliente", "");
					mapa.put("idCliente", "");
					mapa.put("mensajeCliente", "El cliente "
							+ listaCliente.get(0).getNombre()
							+ " es menor de edad (" + age
							+ "). Debe seleccionar un cliente mayor de edad.");
				}

			} else {

				mapa.put("nombreCliente", "");
				mapa.put("idCliente", "");
				mapa.put("mensajeCliente", "No se encontro el cliente. ");

			}

			dataJSON.setRespuesta("ok", null, mapa);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/grabarCotiPaquete")
	public ModelAndView grabarCotiPaquete(HttpServletRequest request,
			HttpServletResponse response) {
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		String status = "error";

		try {
			System.out
					.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("Iniciando grabarCotiPaquete");

			String idCliente = (request.getParameter("idCliente") == null ? ""
					: request.getParameter("idCliente"));

			Map<String, Object> parametrosRequest = ControllerUtil
					.parseRequestToMap(request);
			Map<String, Object> cotizacionBeanMap = (Map<String, Object>) parametrosRequest
					.get("cotizacionBean");

			// inserta en el bean todos los valores del mapa (property vs keys)
			cotizacionBeanMap.remove("motivoViajeCotiza[]");
			cotizacionBeanMap.remove("servicioAdicional[]");

			System.out.println("FechaCotizacion: "
					+ cotizacionBeanMap.get("fechaCotizacion"));
			System.out.println("fechaSalida: "
					+ cotizacionBeanMap.get("fechaSalida"));
			System.out.println("fechaRetorno: "
					+ cotizacionBeanMap.get("fechaRetorno"));
			System.out.println("idTipoCotizacion: "
					+ cotizacionBeanMap.get("idTipoCotizacion"));
			System.out.println("idOrigenPartida: "
					+ cotizacionBeanMap.get("idOrigenPartida"));

			CotizacionBean cotizacionBean = new CotizacionBean();

			// idTipoCotizacion idOrigenPartida idTipoPrograma

			BeanUtils.populate(cotizacionBean, cotizacionBeanMap);

			cotizacionBean
					.setFechaCotizacion(Utils
							.stringToStringyyyyMMdd(cotizacionBean
									.getFechaCotizacion()));
			cotizacionBean.setIdCliente(Integer.parseInt(idCliente));
			cotizacionBean.setNumeroCotizacion(cotizacionService
					.generarNumeroCotizacion());

			cotizacionBean.setFechaSalida(Utils
					.stringToStringyyyyMMdd(cotizacionBean.getFechaSalida()));
			cotizacionBean.setFechaRetorno(Utils
					.stringToStringyyyyMMdd(cotizacionBean.getFechaRetorno()));
			cotizacionBean.setIdEstado(4);

			System.out.println("FechaCotizacion: "
					+ cotizacionBean.getFechaCotizacion());
			System.out.println("fechaSalida: "
					+ cotizacionBean.getFechaSalida());
			System.out.println("fechaRetorno: "
					+ cotizacionBean.getFechaRetorno());
			System.out.println("idTipoCotizacion: "
					+ cotizacionBean.getIdTipoCotizacion());
			System.out.println("idOrigenPartida: "
					+ cotizacionBean.getIdOrigenPartida());

			int registro = cotizacionService
					.registrarCotizacion(cotizacionBean);

			System.out
					.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("grabarCotiPaquete: [Status:" + registro
					+ ",Id:" + cotizacionBean.getIdCotizacion() + ",Nro:"
					+ cotizacionBean.getNumeroCotizacion() + "]");

			System.out
					.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("expedienteLog grabarCotiPaquete: ");
			cotizacionService.registrarExpedienteLog(new ExpedienteLogBean(
					"COTIZA", cotizacionBean.getIdCotizacion(), 0,
					"Cotizacion Paquete Pendiente", 4));

			// Mensaje de respusta a la vista:
			String htmlMensaje = "La cotización Nro. <strong>"
					+ cotizacionBean.getNumeroCotizacion()
					+ "</strong> ha sido registrada <br /><br />";

			htmlMensaje += "A continuación el detalle de la cotización <strong>Paquete Turístico</strong><br /><br />";

			System.out
					.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("Iniciando grabar Motivos");

			// Obtenemos los motivos del viaje para el historial por get
			String motivoViaje = request.getParameter("motivoViaje");

			// Si hay Motivos
			if (motivoViaje.length() > 0) {

				motivoViaje = motivoViaje
						.substring(0, motivoViaje.length() - 1);

				System.out.println("Motivos: " + motivoViaje);

				String motivo[] = motivoViaje.split(",");

				System.out.println("Cantidad de Motivos: " + motivo.length);

				MotivoViajeBean motivoViajeBean = new MotivoViajeBean();
				motivoViajeBean.setNumeroCotizacion(cotizacionBean
						.getNumeroCotizacion());

				int m = 0;

				if (motivo.length > 0) {

					htmlMensaje += "Se consideran los siguientes motivos en su viaje: ";

					for (int i = 0; i < motivo.length; i++) {

						System.out.println("motivo" + i + ": " + motivo[i]);

						m = Integer.parseInt(motivo[i]);
						motivoViajeBean.setCodigoMotivo(m);

						htmlMensaje += (m == 1) ? "Cultural"
								: (m == 2) ? "Deportes"
										: (m == 3) ? "Relajación"
												: (m == 4) ? "Playa" : "";

						int res = cotizacionService
								.registrarMotivo(motivoViajeBean);
						System.out.println("registrarMotivo(" + m + ") " + res);
					}

					htmlMensaje += "<br />";

				}

			}

			System.out
					.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("Iniciando grabar Destinos");

			String datosDestino = request.getParameter("datosDestino");

			List<CotizacionDetalleBean> cotizacionDestinos = null;

			if (datosDestino.length() > 0) {

				datosDestino = datosDestino.substring(0,
						datosDestino.length() - 1);
				System.out.println("Destinos: " + datosDestino);

				String destino[] = datosDestino.split(",");
				System.out.println("Cantidad de Destinos: " + destino.length);

				CotizacionDetalleBean cotizacionDetalleBean = new CotizacionDetalleBean();
				cotizacionDetalleBean.setNumeroCotizacion(cotizacionBean
						.getNumeroCotizacion());

				String g[];
				cotizacionDestinos = new ArrayList<CotizacionDetalleBean>();

				if (destino.length > 0) {
					for (int i = 0; i < destino.length; i++) {

						g = destino[i].split("_");

						cotizacionDetalleBean.setOrigen(Integer.parseInt(g[0]));
						cotizacionDetalleBean
								.setDestino(Integer.parseInt(g[1]));

						int res = cotizacionService
								.registrarCotizacionDetalleTicket(cotizacionDetalleBean);

						cotizacionDetalleBean.setIdCotizacion(cotizacionBean
								.getIdCotizacion());
						cotizacionDestinos.add(cotizacionDetalleBean);

						System.out.println("registrarDestino(" + g[0] + "/"
								+ g[1] + ") " + res);

					}
				}

			}

			System.out
					.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("Iniciando grabar Servicios Adicionales");

			String servicioAdicional = request.getParameter("servAdicional");

			if (servicioAdicional.length() > 0) {

				servicioAdicional = servicioAdicional.substring(0,
						servicioAdicional.length() - 1);
				System.out.println("Servicios Adicional: " + servicioAdicional);

				String servicio[] = servicioAdicional.split(",");
				System.out.println("Cantidad de servicios adicionales: "
						+ servicio.length);

				ServicioAdicionalBean servicioAdicionalBean = new ServicioAdicionalBean();
				servicioAdicionalBean.setNumeroCotizacion(cotizacionBean
						.getNumeroCotizacion());

				int m = 0;
				if (servicio.length > 0) {
					for (int i = 0; i < servicio.length; i++) {
						m = Integer.parseInt(servicio[i]);
						servicioAdicionalBean.setCodigoServicio(m);
						int res = cotizacionService
								.registrarServicio(servicioAdicionalBean);

						System.out.println("registrar servicios adicionales("
								+ servicio[i] + ") " + res);
					}
				}

			}

			System.out
					.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out
					.println("Iniciando grabar Servicios Adicionales: Tipo Habitacion");

			String servicioTipoHab = request.getParameter("datosHoteles");

			if (servicioTipoHab.length() > 0) {

				servicioTipoHab = servicioTipoHab.substring(0,
						servicioTipoHab.length() - 1);
				System.out.println("Servicio Tipo Habitacion: "
						+ servicioTipoHab);

				String servicio[] = servicioTipoHab.split(",");
				System.out.println("Cantidad de servicio Tipo Habitacion: "
						+ servicio.length);

				HotelHabitacionBean oHab = new HotelHabitacionBean();
				oHab.setIdCotiza(cotizacionBean.getNumeroCotizacion());

				if (servicio.length > 0) {
					String g[];

					for (int i = 0; i < servicio.length; i++) {
						g = servicio[i].split("_");

						oHab.setIdTipoHabitacion(Integer.parseInt(g[0]));
						oHab.setNuHabitacion(Integer.parseInt(g[1]));

						int res = cotizacionService.registrarHabitacion(oHab);

						System.out
								.println("registrar servicio Tipo Habitacion("
										+ servicio[i] + ") " + res);
					}
				}
			}

			System.out
					.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("mensaje grabarCotiPaquete: ");
			System.out.println("msghtml: " + htmlMensaje);

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
	@RequestMapping(value = "/grabarCotiTicket")
	public ModelAndView grabarCotiTicket(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView modelAndView = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Map<String, Object> mapa = new HashMap<String, Object>();
		List<AnimalBean> listaToro = new ArrayList<AnimalBean>();
		DataJsonBean dataJSON = new DataJsonBean();

		try {

			modelAndView = new ModelAndView();

			System.out
					.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("Iniciando grabarCotiTicket");

			String idCliente = (request.getParameter("idCliente") == null ? ""
					: request.getParameter("idCliente"));

			Map<String, Object> parametrosRequest = ControllerUtil
					.parseRequestToMap(request);
			Map<String, Object> cotizacionBeanMap = (Map<String, Object>) parametrosRequest
					.get("cotizacionBean");

			cotizacionBeanMap.remove("motivoViajeCotiza[]");
			cotizacionBeanMap.remove("servicioAdicional[]");

			System.out.println("FechaCotizacion: "
					+ cotizacionBeanMap.get("fechaCotizacion"));
			System.out.println("fechaSalida: "
					+ cotizacionBeanMap.get("fechaSalida"));
			System.out.println("fechaRetorno: "
					+ cotizacionBeanMap.get("fechaRetorno"));
			System.out.println("idTipoCotizacion: "
					+ cotizacionBeanMap.get("idTipoCotizacion"));
			System.out.println("idOrigenPartida: "
					+ cotizacionBeanMap.get("idOrigenPartida"));
			System.out.println("Comentarios: "
					+ cotizacionBeanMap.get("observacionTicket"));
			System.out.println("cantidadAdultos: "
					+ cotizacionBeanMap.get("cantidadAdultosTicket"));
			System.out.println("cantidadNiños: "
					+ cotizacionBeanMap.get("cantidadNinosTicket"));

			CotizacionBean cotizacionBean = new CotizacionBean();

			// idTipoCotizacion idOrigenPartida idTipoPrograma

			BeanUtils.populate(cotizacionBean, cotizacionBeanMap);

			cotizacionBean
					.setFechaCotizacion(Utils
							.stringToStringyyyyMMdd(cotizacionBean
									.getFechaCotizacion()));
			cotizacionBean.setIdCliente(Integer.parseInt(idCliente));
			cotizacionBean.setNumeroCotizacion(cotizacionService
					.generarNumeroCotizacion());
			cotizacionBean.setIdEstado(10);

			try {
				cotizacionBean.setFechaSalida("0000-00-00");
				cotizacionBean.setFechaRetorno("0000-00-00");
				cotizacionBean.setTipoAlojamiento("0");
				cotizacionBean.setCategoriaAlojamiento("0");
				cotizacionBean.setObservacion(cotizacionBean
						.getObservacionTicket());
				cotizacionBean.setCantidadAdultos(cotizacionBean
						.getCantidadAdultosTicket());
				cotizacionBean.setCantidadNinos(cotizacionBean
						.getCantidadNinosTicket());
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				System.out.println("ERROR EN FECHAS " + e.getMessage());
			}

			System.out.println("FechaCotizacion: "
					+ cotizacionBean.getFechaCotizacion());
			System.out.println("fechaSalida: "
					+ cotizacionBean.getFechaSalida());
			System.out.println("fechaRetorno: "
					+ cotizacionBean.getFechaRetorno());
			System.out.println("idTipoCotizacion: "
					+ cotizacionBean.getIdTipoCotizacion());
			System.out.println("idOrigenPartida: "
					+ cotizacionBean.getIdOrigenPartida());

			int registro = cotizacionService
					.registrarCotizacion(cotizacionBean);

			System.out
					.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("grabarCotiTicket: [Status:" + registro + ",Id:"
					+ cotizacionBean.getIdCotizacion() + ",Nro:"
					+ cotizacionBean.getNumeroCotizacion() + "]");

			System.out
					.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("expedienteLog grabarCotiTicket: ");
			cotizacionService.registrarExpedienteLog(new ExpedienteLogBean(
					"COTIZA", cotizacionBean.getIdCotizacion(), 0,
					"Cotizacion Ticket Iniciado", 10));

			System.out
					.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			String datosVuelos = request.getParameter("datosVuelos");
			System.out.println("longitud del string de vuelos: "
					+ datosVuelos.length());

			if (datosVuelos.length() > 0) {

				datosVuelos = datosVuelos
						.substring(0, datosVuelos.length() - 1);

				System.out.println("string de vuelos: " + datosVuelos);

				String vuelos[] = datosVuelos.split(";");

				String g[];

				if (vuelos.length > 0) {

					System.out.println("cantidad de vuelos" + vuelos.length);

					for (int i = 0; i < vuelos.length; i++) {

						System.out.println("string de detalle de vuelos[" + i
								+ "]" + vuelos[i]);

						g = vuelos[i].split(",");

						CotizacionDetalleBean oCotizacionDetalleBean = new CotizacionDetalleBean();

						oCotizacionDetalleBean
								.setNumeroCotizacion(cotizacionBean
										.getNumeroCotizacion());
						oCotizacionDetalleBean
								.setOrigen(Integer.parseInt(g[2]));
						oCotizacionDetalleBean.setDestino(Integer
								.parseInt(g[3]));
						oCotizacionDetalleBean.setFechaPartida(Utils
								.stringToStringyyyyMMdd(g[0]));

						if (g[4].toString().equals("0")) {
							oCotizacionDetalleBean.setFechaRetorno(Utils
									.stringToStringyyyyMMdd(g[1]));
						} else {
							oCotizacionDetalleBean
									.setFechaRetorno("0000-00-00");
						}

						oCotizacionDetalleBean.setTiIda(Integer.parseInt(g[4]));

						// fPartidaTicket+","+fRetornoTicket+","+ciudadOrigenVal+","+ciudadDestinoVal+","+
						// parseInt(isSoloIda)+";

						int res = cotizacionService
								.registrarCotizacionDetalleTicket(oCotizacionDetalleBean);

						System.out.println("registrarCotizacionDetalleTicket("
								+ g[0] + "/" + g[1] + "/" + g[2] + "/" + g[3]
								+ "/" + g[4] + ") " + res);

					}
				}

			}

			// Mensaje de respuesta con el detalle de los destinos para el
			// ticket
			CotizacionDetalleBean cotizacionDetalleBean = new CotizacionDetalleBean();
			cotizacionDetalleBean.setNumeroCotizacion(cotizacionBean
					.getNumeroCotizacion());
			List<CotizacionDetalleBean> listDestinosDetalle = cotizacionService
					.listarDestinosDetail(cotizacionDetalleBean);
			String mensajeHtml = "";

			for (CotizacionDetalleBean item : listDestinosDetalle) {
				mensajeHtml += "<strong>" + item.getDesTiVuelo()
						+ "</strong>: ";

				String vuelo = item.getDesCiudadOrigen() + " ("
						+ item.getIsoCiudadOrigen() + ")" + " - "
						+ item.getDesCiudadDestino() + " ("
						+ item.getIsoCiudadDestino() + ")";

				mensajeHtml += vuelo;

				if (item.getTiIda() == 0) {
					// Ida yVuelta
					vuelo = "<br />" + item.getDesCiudadDestino() + " ("
							+ item.getIsoCiudadDestino() + ")" + " - "
							+ item.getDesCiudadOrigen() + " ("
							+ item.getIsoCiudadOrigen() + ")";
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
			System.out
					.println("ERROR.............................................");
			System.out.println(e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}

	@RequestMapping(value = "/enviarPaquete", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView enviarPaquete(HttpServletRequest request,
			HttpServletResponse response) {

		System.out
				.println("enviar paquete ...........................................");

		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();

		try {

			mapa.put("titulo", "Enviar Paquete");

			int idCotizacion = Integer.parseInt(request
					.getParameter("idCotizacion"));
			int idCliente = Integer.parseInt(request.getParameter("idCliente"));

			// validacion email cliente

			ClienteBean clienteBean = new ClienteBean();
			clienteBean.setIdCliente(idCliente);
			List<ClienteBean> listaCliente = new ArrayList<ClienteBean>();
			listaCliente = cotizacionService.obtenerNombreCliente(clienteBean);

			String email = "";
			String mensaje = "";
			int envio = 0;

			if (listaCliente.size() > 0) {

				if (listaCliente.get(0).getEmail() != null) {
					email = listaCliente.get(0).getEmail();
				}
				System.out.println("email: " + listaCliente.get(0).getEmail());

			}

			if (email.length() > 0) {

				envio = 1;

				CotizacionBean cotizacionBean = new CotizacionBean();
				cotizacionBean.setIdEstado(9);
				cotizacionBean.setIdCotizacion(idCotizacion);
				cotizacionService.actualizarCotizacion(cotizacionBean);

				ExpedienteLogBean expedienteLogBean = new ExpedienteLogBean(
						"COTIZA", idCotizacion, 0, "Cotizacion Enviada", 9);
				cotizacionService.registrarExpedienteLog(expedienteLogBean);

			} else {
				mensaje = "No se encontro email para el cliente";
			}

			mapa.put("mensaje", mensaje);
			mapa.put("envio", envio);
			dataJSON.setRespuesta("ok", null, mapa);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return ControllerUtil.handleJSONResponse(dataJSON, response);

	}

	@RequestMapping(value = "/grabarPaquete", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView grabarPaquete(HttpServletRequest request,
			HttpServletResponse response) {

		System.out
				.println("grabar paquete ...........................................");

		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();

		try {

			mapa.put("titulo", "Grabar Paquete");

			int idCotizacion = Integer.parseInt(request
					.getParameter("idCotizacion"));
			int idPaquete = Integer.parseInt(request.getParameter("idPaquete"));

			System.out.println("idPaquete");
			System.out.println(idCotizacion);
			System.out.println("idCotizacion");
			System.out.println(idPaquete);

			CotizacionBean cotizacionBean = new CotizacionBean();
			cotizacionBean.setIdEstado(5);
			cotizacionBean.setIdCotizacion(idCotizacion);
			cotizacionBean.setIdPaquete(idPaquete);
			cotizacionService.actualizarCotizacion(cotizacionBean);

			cotizacionService.registrarExpedienteLog(new ExpedienteLogBean(
					"COTIZA", idCotizacion, 0,
					"Cotizacion Grabar Paquete Finalizada", 5));

			dataJSON.setRespuesta("ok", null, mapa);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return ControllerUtil.handleJSONResponse(dataJSON, response);

	}

	@RequestMapping(value = "/buscarPaquete", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView buscarPaquete(HttpServletRequest request,
			HttpServletResponse response) {

		System.out
				.println("buscar paquete ...........................................");

		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();
		PaqueteManagerBean oPaquete = new PaqueteManagerBean();

		try {

			// ////////////////////////////////////////////////////////////////////////////////////
			// BUSQUEDA DE PAQUETES

			int idCotizacion = Integer.parseInt(request
					.getParameter("idCotizacion"));

			CotizacionBean cotizacionBean = new CotizacionBean();
			cotizacionBean.setIdCotizacion(idCotizacion);
			cotizacionBean = cotizacionService
					.obtenerCotizacion(cotizacionBean);

			String numeroCotizacion = String.valueOf(cotizacionBean
					.getNumeroCotizacion());

			// 1- TIPO DE PROGRAMA
			int idTipoPrograma = cotizacionBean.getIdTipoPrograma();
			oPaquete.setIdTipoPaquete(idTipoPrograma);

			// 2- PRESUPUESTO: ALTO, MEDIO, BAJO
			double imPresupuesto = cotizacionBean.getPresupuestoMaximo();
			oPaquete.setImPrecio(imPresupuesto);

			System.out.println("precio A max" + oPaquete.getImPrecioMaxAlto());
			System.out.println("precio A min" + oPaquete.getImPrecioMinAlto());
			System.out.println("precio B max" + oPaquete.getImPrecioMaxMedio());
			System.out.println("precio B min" + oPaquete.getImPrecioMinMedio());
			System.out.println("precio C max" + oPaquete.getImPrecioMaxBajo());
			System.out.println("precio C min" + oPaquete.getImPrecioMinBajo());

			int idCategoriaAlojamiento = cotizacionBean
					.getIdCategoriaAlojamiento();
			int idTipoAlojamiento = cotizacionBean.getIdTipoAlojamiento();

			// 3- MODELO DESTINOS: A, B Y C
			List<PaqueteManagerBean> listPaqueteSearch = new ArrayList<PaqueteManagerBean>();
			List<PaqueteManagerBean> listCotizacionManBeanAlto = null;
			List<PaqueteManagerBean> listCotizacionManBeanMedio = null;
			List<PaqueteManagerBean> listCotizacionManBeanBajo = null;

			// Se realizan 3 iteracciones, uno por categoria de presupuesto:
			// Alto, Medio y Bajo
			for (int i = 0; i < 3; i++) {
				if (i == 0) {
					// 3.1- Primera Iteracion: Presupuesto ALTO
					oPaquete.setImPrecioMax(oPaquete.getImPrecioMaxAlto());
					oPaquete.setImPrecioMin(oPaquete.getImPrecioMinAlto());
					oPaquete.setTiPresupuestoValue("Alto");
					listCotizacionManBeanAlto = cotizacionService
							.listarPaquete(oPaquete);
					for (PaqueteManagerBean o : listCotizacionManBeanAlto) {
						if (!listPaqueteSearch.contains(o)) {
							System.out.println("listPaqueteSearch[id_paquete:"
									+ o.getIdPaquete() + ", nombre:"
									+ o.getNomPaquete() + ", comentario:"
									+ o.getComentario() + ", im_precio:"
									+ o.getImPrecio() + ", tipoPresupuesto:"
									+ o.getTiPresupuestoValue() + "]");
							listPaqueteSearch.add(o);
						}
					}
				} else if (i == 1) {
					// 3.2- Segunda Iteracion: Presupuesto MEDIO
					oPaquete.setImPrecioMax(oPaquete.getImPrecioMaxMedio());
					oPaquete.setImPrecioMin(oPaquete.getImPrecioMinMedio());
					oPaquete.setTiPresupuestoValue("Medio");
					listCotizacionManBeanMedio = cotizacionService
							.listarPaquete(oPaquete);
					for (PaqueteManagerBean o : listCotizacionManBeanMedio) {
						if (!listPaqueteSearch.contains(o)) {
							System.out.println("listPaqueteSearch[id_paquete:"
									+ o.getIdPaquete() + ", nombre:"
									+ o.getNomPaquete() + ", comentario:"
									+ o.getComentario() + ", im_precio:"
									+ o.getImPrecio() + ", tipoPresupuesto:"
									+ o.getTiPresupuestoValue() + "]");
							listPaqueteSearch.add(o);
						}
					}
				} else if (i == 2) {
					// 3.3- Tercera Iteracion: Presupuesto BAJO
					oPaquete.setImPrecioMax(oPaquete.getImPrecioMaxBajo());
					oPaquete.setImPrecioMin(oPaquete.getImPrecioMinBajo());
					oPaquete.setTiPresupuestoValue("Bajo");
					listCotizacionManBeanBajo = cotizacionService
							.listarPaquete(oPaquete);
					for (PaqueteManagerBean o : listCotizacionManBeanBajo) {
						if (!listPaqueteSearch.contains(o)) {
							System.out.println("listPaqueteSearch[id_paquete:"
									+ o.getIdPaquete() + ", nombre:"
									+ o.getNomPaquete() + ", comentario:"
									+ o.getComentario() + ", im_precio:"
									+ o.getImPrecio() + ", tipoPresupuesto:"
									+ o.getTiPresupuestoValue() + "]");
							listPaqueteSearch.add(o);
						}
					}
				}

			}

			// Se obtienen todos los paquetes disponibles en:
			// listPaqueteSearch();
			System.out.println("Total de Paquetes encontrados: "
					+ listPaqueteSearch.size());

			// Numero aleatorio
			int x = (int) (Math.random() * ((19999999 - 1) + 1)) + 1;

			// Ruta absoluta del dominio de la aplicacion
			String AbsolutePath = new File(".").getAbsolutePath();
			System.out.println("AbsolutePath: " + AbsolutePath);

			// Nombre del archivo a crear
			String csvFile = AbsolutePath + numeroCotizacion + "_" + x + ".csv";
			FileWriter writer = new FileWriter(csvFile);

			// for header CSV
			CSVUtils.writeLine(writer, Arrays.asList("presupuesto",
					"idPaquete", "nomPaquete", "destinos", "tour", "hotel",
					"ticket", "tipoAlojamiento", "categoriaAlojamiento",
					"hotelHabitacion", "playa", "relajacion", "deportes",
					"cultural"));

			PaqueteResumeBean paquete = null;

			// for detail CSV
			for (PaqueteManagerBean o : listPaqueteSearch) {
				// Inicializamos el bean
				paquete = new PaqueteResumeBean();
				paquete.setIdPaquete(o.getIdPaquete());
				paquete.setNumeroCotizacion(numeroCotizacion);
				paquete.setIdCategoriaAlojamiento(idCategoriaAlojamiento);
				paquete.setIdTipoAlojamiento(idTipoAlojamiento);
				paquete = cotizacionService.obtenerPaquete(paquete);

				// Log
				System.out
						.println("Datos ...........................................");
				System.out.println("presupuesto:" + o.getTiPresupuestoValue());
				System.out.println("idPaquete:" + o.getIdPaquete());
				System.out.println("nomPaquete:" + o.getNomPaquete());
				System.out.println("destinos:" + paquete.getDestinos());
				System.out.println("tour:" + paquete.getTour());
				System.out.println("hotel:" + paquete.getHotel());
				System.out.println("ticket:" + paquete.getTicket());
				System.out.println("tipo_alojamiento:"
						+ paquete.getTipoAlojamiento());
				System.out.println("categoria_alojamiento:"
						+ paquete.getCategoriaAlojamiento());
				System.out.println("hotel_habitacion:"
						+ paquete.getHotelHabitacion());
				System.out.println("playa:" + paquete.getPlaya());
				System.out.println("relajacion:" + paquete.getRelajacion());
				System.out.println("deportes:" + paquete.getDeportes());
				System.out.println("cultural:" + paquete.getCultural());
				System.out.println("playaTour:" + paquete.getPlayaTour());
				System.out.println("relajacionTour:"
						+ paquete.getRelajacionTour());
				System.out.println("deportesTour:" + paquete.getDeportesTour());
				System.out.println("culturalTour:" + paquete.getCulturalTour());

				// Nueva Fila
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

			// Busqueda Algoritmo ID3
			TableManager tm = new DataManager(csvFile);

			System.out
					.println("************************************************************************");
			System.out.println(tm);
			System.out.println("size(file *.csv): " + tm.getRows().size());

			// cumple los destinos: reducimos la tabla
			System.out
					.println("************************************************************************");
			System.out
					.println("Reducing table with the attribute DESTINOS and value SI.");
			TableManager tm2 = tm.getSubTable("destinos", "Si");
			System.out.println(tm2);
			System.out.println("size(destinos): " + tm2.getRows().size());

			double percent = 0;
			int qtypercent = 0;

			// cumple con los servicios:
			System.out
					.println("************************************************************************");
			System.out
					.println("Reducing table with the attribute SERVICIOS and value SI.");

			if (cotizacionBean.getTicket() == 1) {
				System.out
						.println("ticket:"
								+ tm2.getBestObjectiveValueFromAttribute(
										"ticket", "Si"));
				tm2 = tm2.getSubTable("ticket", "Si");
				percent += 10; // score
				qtypercent += 1; // quantity
			} else {
				System.out.println("Ticket not found");
			}

			if (cotizacionBean.getTour() == 1) {
				System.out.println("tour:"
						+ tm2.getBestObjectiveValueFromAttribute("tour", "Si"));
				tm2 = tm2.getSubTable("tour", "Si");
				percent += 10; // score
				qtypercent += 1; // quantity
			} else {
				System.out.println("Tour not found");
			}

			if (cotizacionBean.getHotel() == 1) {
				System.out
						.println("hotel:"
								+ tm2.getBestObjectiveValueFromAttribute(
										"hotel", "Si"));
				tm2 = tm2.getSubTable("hotel", "Si");
				percent += 10; // score
				qtypercent += 1; // quantity
			} else {
				System.out.println("Hotel not found");
			}

			System.out.println(tm2);
			System.out.println("size(servicios): " + tm2.getRows().size());
			List<PaqueteResumeBean> resumeDestinos = null;

			if (tm2.getRows().size() > 0) {

				/*
				 * String valueBestObjectiveTour =
				 * tm2.getBestObjectiveValueFromAttribute("tour", "Si"); String
				 * valueBestObjectiveTicket =
				 * tm2.getBestObjectiveValueFromAttribute("ticket", "Si");
				 * String valueBestObjectiveHotel =
				 * tm2.getBestObjectiveValueFromAttribute("hotel", "Si");
				 * 
				 * if ( valueBestObjectiveTour.equals("Alto") ||
				 * valueBestObjectiveTicket.equals("Alto") ||
				 * valueBestObjectiveTour.equals("Medio") ||
				 * valueBestObjectiveHotel.equals("Medio") ||
				 * valueBestObjectiveHotel.equals("Alto") ||
				 * valueBestObjectiveTicket.equals("Medio") ){
				 */
				if (cotizacionBean.getHotel() == 1) {
					if (cotizacionBean.getIdCategoriaAlojamiento() > 0) {
						percent += 5; // score
						qtypercent += 1; // quantity
					}

					if (cotizacionBean.getIdTipoAlojamiento() > 0) {
						percent += 5; // score
						qtypercent += 1; // quantity
					}
				}
				if (cotizacionBean.getPlaya() > 0) {
					percent += 5; // score
					qtypercent += 1; // quantity
				}

				if (cotizacionBean.getRelajacion() > 0) {
					percent += 5; // score
					qtypercent += 1; // quantity
				}

				if (cotizacionBean.getDeportes() > 0) {
					percent += 5; // score
					qtypercent += 1; // quantity
				}

				if (cotizacionBean.getCultural() > 0) {
					percent += 5; // score
					qtypercent += 1; // quantity
				}
				// }

				// percent = percent/qtypercent*9.0;
				System.out
						.println("************************************************************************");
				System.out.println("Number of equalities of parameters: "
						+ qtypercent);
				System.out.println("Getting a table for trainning with the "
						+ percent + "% of the datas");

				if (percent < 75 || percent > 100) {
					percent = 75;
				}

				System.out.println("" + percent + "% change!");

				System.out
						.println("************************************************************************");
				System.out.println("before");
				System.out.println(tm2);

				/*
				 * tm2 = tm2.getTrainAndProbeSet(percent); System.out.println(
				 * "************************************************************************"
				 * ); System.out.println("after"); System.out.println(tm2);
				 */

				for (int i = 0; i < tm2.getRows().size(); i++) {
					System.out
							.println("************************************************************************");
					System.out.println("Paquete ID");
					System.out.println(tm2.getRow(i).get(1));
					if (i == 0) {
						paquete = new PaqueteResumeBean();
						paquete.setIdPaquete(Integer.parseInt(tm2.getRow(i)
								.get(1)));
						resumeDestinos = cotizacionService
								.listarPaqueteDetail(paquete);
						break;
					}
				}
			}

			mapa.put("titulo", "Paquetes");
			mapa.put("listaPaquetes", tm2);
			mapa.put("cantidadPaquetes", tm2.getRows().size());
			mapa.put("destinos", resumeDestinos);

			// Return bean Paquete escogido
			dataJSON.setRespuesta("ok", null, mapa);

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("e: " + e.getMessage());
		}
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}

	@RequestMapping(value = "/buscarVuelos", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView buscarVuelos(HttpServletRequest request,
			HttpServletResponse response) {
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

			System.out
					.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");

			String numeroCotizacion = request.getParameter("nroCotizacion");

			System.out.println("Numero Cotizacion");
			System.out.println(numeroCotizacion);

			CotizacionDetalleBean cotizacionDetalleBean = new CotizacionDetalleBean();
			cotizacionDetalleBean.setNumeroCotizacion(numeroCotizacion);
			List<CotizacionDetalleBean> listDestinosDetalle = cotizacionService
					.listarDestinosDetail(cotizacionDetalleBean);

			System.out.println("Destinos");
			System.out.println(listDestinosDetalle.size());

			listaOrdenPlan = new ArrayList<OrdenPlanificacionBean>();

			for (CotizacionDetalleBean item : listDestinosDetalle) {
				String vuelo = item.getIsoCiudadOrigen() + ","
						+ item.getIsoCiudadDestino() + ","
						+ item.getFechaPartida() + "," + item.getDestino();
				System.out.println("Vuelo A");
				System.out.println(vuelo);
				System.out.println("Solo Ida?");
				System.out.println(item.getTiIda());

				listaTickets = cotizacionService.listarTickets(vuelo);
				ordenPlanBean = cotizacionService.minorCostTicket(listaTickets);
				if (ordenPlanBean != null) {
					// Mensaje Vuelo
					detalleVuelos += "<strong>" + item.getDesCiudadDestino()
							+ " (" + item.getFechaPartida() + ")</strong>: "
							+ ordenPlanBean.getNombreAerolinea() + " / USD "
							+ ordenPlanBean.getPrecioAerolinea()
							+ " (Comision " + ordenPlanBean.getComision() + ")";
					// Agregamos a la lista
					listaOrdenPlan.add(ordenPlanBean);
				}

				if (item.getTiIda() == 0) {
					// Ida y Vuelta
					vuelo = item.getIsoCiudadDestino() + ","
							+ item.getIsoCiudadOrigen() + ","
							+ item.getFechaRetorno() + "," + item.getOrigen();
					System.out.println("Vuelo B");
					System.out.println(vuelo);

					listaTickets = cotizacionService.listarTickets(vuelo);
					ordenPlanBean = cotizacionService
							.minorCostTicket(listaTickets);

					if (ordenPlanBean != null) {
						// Mensaje Vuelo
						detalleVuelos += "<br /><strong>"
								+ item.getDesCiudadOrigen() + " ("
								+ item.getFechaRetorno() + ")</strong>: "
								+ ordenPlanBean.getNombreAerolinea()
								+ " / USD "
								+ ordenPlanBean.getPrecioAerolinea()
								+ " (Comision: " + ordenPlanBean.getComision()
								+ ")";
						// Agregamos a la lista
						listaOrdenPlan.add(ordenPlanBean);
					}
				}
				detalleVuelos += "<br /><br />";
			}

			System.out.println("Mensaje");
			System.out.println(detalleVuelos);

			dataJSON.setRespuesta("ok", null, mapa);

		} catch (Exception e) {
			if (detalleVuelos.length() < 0) {
				detalleVuelos = "No se encontraron vuelos";
			}
			System.out
					.println("**********************************************************************");
			System.out.println("error:");
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		System.out
				.println("**********************************************************************");
		System.out.println("mensaje final");
		System.out.println(detalleVuelos);

		mapa.put("detalleVuelos", detalleVuelos);
		mapa.put("listaVuelos", listaOrdenPlan);
		mapa.put("cantidadVuelos", listaOrdenPlan.size());

		dataJSON.setRespuesta("ok", null, mapa);

		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}

	@RequestMapping(value = "/grabarVuelos", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView grabarVuelos(HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView modelAndView = null;
		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();

		try {
			modelAndView = new ModelAndView();
			String numeroCotizacion = request.getParameter("nroCotizacion");

			CotizacionDetalleBean cotizacionDetalleBean = new CotizacionDetalleBean();
			cotizacionDetalleBean.setNumeroCotizacion(numeroCotizacion);
			List<CotizacionDetalleBean> listDestinosDetalle = cotizacionService
					.listarDestinosDetail(cotizacionDetalleBean);

			OrdenPlanificacionBean ordenPlanBean = null;
			CotizacionDetalleTicketVueloBean cotizacionTicket = null;
			List<FareInfoBean> listaTickets = null;
			int idCotizacion = 0;
			int cantidadPasajeros = 1;

			for (CotizacionDetalleBean item : listDestinosDetalle) {
				String vuelo = item.getIsoCiudadOrigen() + ","
						+ item.getIsoCiudadDestino() + ","
						+ item.getFechaPartida() + "," + item.getDestino();
				listaTickets = cotizacionService.listarTickets(vuelo);
				ordenPlanBean = cotizacionService.minorCostTicket(listaTickets);
				cotizacionTicket = new CotizacionDetalleTicketVueloBean(
						item.getIdCotizaDeta(), numeroCotizacion,
						ordenPlanBean.getIdAerolinea(),
						ordenPlanBean.getPrecioAerolinea(),
						ordenPlanBean.getIdProveedorAerolinea(),
						ordenPlanBean.getUrlShop(), 0,
						ordenPlanBean.getComision(), item.getDestino(),
						item.getOrigen(), item.getFechaPartida(),
						item.getFechaRetorno());
				cotizacionService.registrarConsolidador(cotizacionTicket);
				if (item.getTiIda() == 0) {
					// Ida y Vuelta
					vuelo = item.getIsoCiudadDestino() + ","
							+ item.getIsoCiudadOrigen() + ","
							+ item.getFechaRetorno() + "," + item.getOrigen();
					listaTickets = cotizacionService.listarTickets(vuelo);
					ordenPlanBean = cotizacionService
							.minorCostTicket(listaTickets);
					cotizacionTicket = new CotizacionDetalleTicketVueloBean(
							item.getIdCotizaDeta(), numeroCotizacion,
							ordenPlanBean.getIdAerolinea(),
							ordenPlanBean.getPrecioAerolinea(),
							ordenPlanBean.getIdProveedorAerolinea(),
							ordenPlanBean.getUrlShop(), 0,
							ordenPlanBean.getComision(), item.getOrigen(),
							item.getDestino(), item.getFechaRetorno(),
							item.getFechaRetorno());
					cotizacionService.registrarConsolidador(cotizacionTicket);
				}
				idCotizacion = item.getIdCotizacion();
				if (item.getCantidadPasajeros() > 0) {
					cantidadPasajeros = item.getCantidadPasajeros();
				}
			}

			System.out
					.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("actualizar Cotizacion: ");
			CotizacionBean cotizacionBean = new CotizacionBean();
			cotizacionBean.setIdEstado(5);
			cotizacionBean.setIdCotizacion(idCotizacion);
			cotizacionBean.setTicket(1);
			cotizacionBean.setNumeroCotizacion(numeroCotizacion);
			cotizacionBean.setCantidadAdultos(cantidadPasajeros);
			cotizacionService.actualizarCotizacion(cotizacionBean);

			System.out
					.println("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");
			System.out.println("expedienteLog grabarVuelos: ");
			cotizacionService.registrarExpedienteLog(new ExpedienteLogBean(
					"COTIZA", idCotizacion, 0, "Cotizacion Grabar Vuelos", 5));

			mapa.put("idCotizacion", idCotizacion);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		dataJSON.setRespuesta("ok", null, mapa);
		return ControllerUtil.handleJSONResponse(dataJSON, response);
	}

	@RequestMapping(value = "/aprobarPaquete", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView aprobarPaquete(HttpServletRequest request,
			HttpServletResponse response) {

		System.out
				.println("aprobar paquete ...........................................");

		Map<String, Object> mapa = new HashMap<String, Object>();
		DataJsonBean dataJSON = new DataJsonBean();

		try {

			mapa.put("titulo", "Aprobar Paquete");

			int idCotizacion = Integer.parseInt(request
					.getParameter("idCotizacion"));
			String comentario = (request.getParameter("comentario"));

			CotizacionBean cotizacionBean = new CotizacionBean();
			cotizacionBean.setIdEstado(15);
			cotizacionBean.setIdCotizacion(idCotizacion);
			cotizacionBean.setComentario(comentario);
			cotizacionBean.setIsAprobado(1);
			cotizacionService.actualizarCotizacion(cotizacionBean);

			ExpedienteLogBean expedienteLogBean = new ExpedienteLogBean(
					"COTIZA", idCotizacion, 0,
					"Cotizacion Aprobada Manualmente", 15);
			cotizacionService.registrarExpedienteLog(expedienteLogBean);

			dataJSON.setRespuesta("ok", null, mapa);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return ControllerUtil.handleJSONResponse(dataJSON, response);

	}

}