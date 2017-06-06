package pe.com.paxtravel.service;

import java.util.ArrayList;
import java.util.List;

import pe.com.paxtravel.bean.PaqueteTuristicoBean;
import pe.com.paxtravel.bean.TourBean;
import pe.com.paxtravel.model.dao.PaqueteTuristicoDAO;

public class PaqueteTuristicoServiceImpl implements PaqueteTuristicoService {
	
	private PaqueteTuristicoDAO paqueteTuristicoDAO;
	
	public PaqueteTuristicoDAO getPaqueteTuristicoDAO() {
		return paqueteTuristicoDAO;
	}
	
	public void setPaqueteTuristicoDAO(PaqueteTuristicoDAO paqueteTuristicoDAO) {
		this.paqueteTuristicoDAO = paqueteTuristicoDAO;
	}
	
	@Override
	public List<PaqueteTuristicoBean> listarPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean) {
		List<PaqueteTuristicoBean> listaPaquete = new ArrayList<PaqueteTuristicoBean>();
		listaPaquete = paqueteTuristicoDAO.listaPaqueteTuristico(paqueteTuristicoBean);
		return listaPaquete;
	}
	
	@Override
	public int GrabarPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean) {
		return paqueteTuristicoDAO.GrabarPaqueteTuristico(paqueteTuristicoBean);
	}
	
	@Override
	public String obtenerCodigoPaqTuristico() {
		return (String) paqueteTuristicoDAO.obtenerCodigoPaqTuristico();
	}
	
	@Override
	public List<TourBean> listarTour(TourBean tourBean) {
		List<TourBean> listaTour = new ArrayList<TourBean>();
		listaTour = paqueteTuristicoDAO.listaTour(tourBean);
		return listaTour;
	}
	
}
