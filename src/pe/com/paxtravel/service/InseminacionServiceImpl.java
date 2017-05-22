package pe.com.paxtravel.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pe.com.paxtravel.bean.EmpleadoBean;
import pe.com.paxtravel.bean.InseminacionBean;
import pe.com.paxtravel.bean.ProduccionBean;
import pe.com.paxtravel.model.dao.InseminacionDAO;
//import pe.com.paxtravel.model.dao.ProduccionDAO;

@Service
public class InseminacionServiceImpl implements InseminacionService {

	private InseminacionDAO inseminacionDAO;

	public void setInseminacionDAO(InseminacionDAO inseminacionDAO) {
		this.inseminacionDAO = inseminacionDAO;
	}

	@Override
	public List<InseminacionBean> listarInseminacion(InseminacionBean inseminacionBean) {
		List<InseminacionBean> listaInseminacion = new ArrayList<InseminacionBean>();
		listaInseminacion = inseminacionDAO.listaInseminacion(inseminacionBean);
		return listaInseminacion;
	}

	@Override
	public int registrarInseminacion(InseminacionBean inseminacionBean) {
		return inseminacionDAO.registrarInseminacion(inseminacionBean);
	}

	@Override
	public String obtenerCodigoInseminacion() {
		return (String) inseminacionDAO.obtenerCodigoInseminacion();
	}

	@Override
	public int editarInseminacion(InseminacionBean inseminacionBean) {
		return inseminacionDAO.editarInseminacion(inseminacionBean);
	}

	@Override
	public int eliminarInseminacion(InseminacionBean inseminacionBean) {
		return inseminacionDAO.eliminarInseminacion(inseminacionBean);
	}

	@Override
	public InseminacionBean verDetalleInseminacion(InseminacionBean inseminacionBean) {
		InseminacionBean inseminacionBeanAux = new InseminacionBean();
		inseminacionBeanAux = inseminacionDAO.verDetalleInseminacion(inseminacionBean);
		return inseminacionBeanAux;
	}

//	@Override
//	public List<InseminacionBean> buscarInseminacion(String codigoInseminacion) {
//		List<InseminacionBean> listaInseminacion = new ArrayList<InseminacionBean>();
//		listaInseminacion = inseminacionDAO.listaInseminacion(codigoInseminacion);
//		return listaInseminacion;
//	}

}
