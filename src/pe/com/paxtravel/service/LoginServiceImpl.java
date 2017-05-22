package pe.com.paxtravel.service;

import org.springframework.stereotype.Service;

import pe.com.paxtravel.bean.UsuarioBean;
import pe.com.paxtravel.model.dao.LoginDAO;

@Service
public class LoginServiceImpl implements LoginService {

	private LoginDAO loginDAO;
	
	public void setLoginDAO(LoginDAO loginDAO) {
		this.loginDAO = loginDAO;
	}

	@Override
	public UsuarioBean obtenerLogin(UsuarioBean usuarioBean) {
		return loginDAO.obtenerLogin(usuarioBean);
	}

}
