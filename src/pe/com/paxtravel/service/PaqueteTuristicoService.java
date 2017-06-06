 package pe.com.paxtravel.service;

import java.util.List;

import pe.com.paxtravel.bean.PaqueteTuristicoBean;
import pe.com.paxtravel.bean.TourBean;

public interface PaqueteTuristicoService {

	
	public List<PaqueteTuristicoBean> listarPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	
    public int GrabarPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	
	public String obtenerCodigoPaqTuristico();
	
	List<TourBean> listarTour(TourBean tourBean);
	
	
}
