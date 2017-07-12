package pe.com.paxtravel.controller;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import pe.com.paxtravel.bean.UsuarioBean;
import pe.com.paxtravel.service.InseminacionService;
import pe.com.paxtravel.service.LoginService;
import pe.com.paxtravel.util.ControllerUtil;

@Controller
public class LoginController {
	
	@Autowired
	private LoginService loginService;
	
	private String jsonView;

	public String getJsonView() {
		return jsonView;
	}

	public void setJsonView(String jsonView) {
		this.jsonView = jsonView;
	}

	@RequestMapping( value = "/login", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response){
		ModelAndView modelAndView = null;
		try {
			UsuarioBean usuarioBean = new UsuarioBean();

			HttpSession session = request.getSession();
			String usuario = request.getParameter("codigoUsuario");
			String password = request.getParameter("claveUsuario");
			usuarioBean.setCodigoUsuario( usuario );
			usuarioBean.setClaveUsuario( password );
			
			usuarioBean = loginService.obtenerLogin(usuarioBean);
			
			boolean flag = false;
			if (!"".equals(usuarioBean.getCodigoUsuario())){
				session.setAttribute("codigoUsuario", usuarioBean.getCodigoUsuario());
				session.setAttribute("codigoPerfil", usuarioBean.getCodigoPerfil());
				session.setAttribute("idUsuario", usuarioBean.getIdUsuario());
			
				modelAndView = new ModelAndView();
				modelAndView.setViewName("login/redirect");
			}
		} catch (Exception e) {
		}
		return modelAndView;
	}
	
	@RequestMapping( value = "/principal", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView principal(HttpServletRequest request, HttpServletResponse response){
		ModelAndView modelAndView = null;
		try {
			HttpSession session = request.getSession();
			
			String usuario = (String) session.getAttribute("codigoUsuario");
			String password = (String) session.getAttribute("codigoPerfil");
			
			modelAndView = new ModelAndView();
			modelAndView.setViewName("login/principal");
		} catch (Exception e) {
		}
		return modelAndView;
	}
	
	@RequestMapping( value = "/logout", method ={RequestMethod.GET, RequestMethod.POST} )
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response){
		ModelAndView modelAndView = null;
		try {
			HttpSession session = request.getSession(false);
			// invalidando cualquier sesion existente
			session.invalidate();
			modelAndView = new ModelAndView();
			modelAndView.setViewName("login/login");
		} catch (Exception e) {
		}
		return modelAndView;
	}
}