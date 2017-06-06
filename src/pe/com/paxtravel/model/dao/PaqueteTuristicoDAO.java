package pe.com.paxtravel.model.dao;

import java.util.List;

import pe.com.paxtravel.bean.PaqueteTuristicoBean;
import pe.com.paxtravel.bean.TourBean;

public interface PaqueteTuristicoDAO {
	
	List<PaqueteTuristicoBean> listaPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	
	int GrabarPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	
	String obtenerCodigoPaqTuristico();
	
	List<TourBean> listaTour(TourBean tourBean);

}
