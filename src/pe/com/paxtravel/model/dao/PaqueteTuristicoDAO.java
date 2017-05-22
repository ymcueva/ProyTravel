package pe.com.paxtravel.model.dao;

import java.util.List;

import pe.com.paxtravel.bean.PaqueteTuristicoBean;

public interface PaqueteTuristicoDAO {
	
	List<PaqueteTuristicoBean> listaPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	
	int GrabarPaqueteTuristico(PaqueteTuristicoBean paqueteTuristicoBean);
	
	String obtenerCodigoPaqTuristico();

}
