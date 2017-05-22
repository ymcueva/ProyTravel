package pe.com.paxtravel.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import pe.com.paxtravel.bean.ClienteBean;
import pe.com.paxtravel.service.CiudadService;

@Controller
public class CiudadController {

	@Autowired
	private CiudadService ciudadService;

	@RequestMapping("/holaMundo")
	public ModelAndView holaMundo() {
		ModelAndView mv = new ModelAndView();
		int g = ciudadService.grabar();
		System.out.println("numero: " + g);

		mv.addObject("msje", "mensaje de pruebasssssssssssssss");
		mv.setViewName("prueba");
		return mv;
	}

	@RequestMapping("/listaCliente")
	public ModelAndView listaCliente() {
		ModelAndView mv = new ModelAndView();

		List<ClienteBean> lista = new ArrayList<ClienteBean>();
		lista = ciudadService.obtieneCliente();
		System.out.println("numero: " + lista.size());

		mv.addObject("msje", "mensaje de pruebasssssssssssssss");
		mv.addObject("data", lista);
		mv.setViewName("cliente/listaCliente");

		return mv;
	}

}
