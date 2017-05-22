package pe.com.paxtravel.model.dao;

import java.util.List;

import pe.com.paxtravel.bean.AnimalBean;
import pe.com.paxtravel.bean.InseminacionBean;
import pe.com.paxtravel.bean.ProduccionBean;

public interface AnimalDAO {
	
	List<AnimalBean> listaToro();
	
	List<AnimalBean> listaVacasAInseminar(AnimalBean animalBean);
	
	List<AnimalBean> listaVacasAParir(AnimalBean animalBean);

	int actualizaEstadoProcesoEvolutivo(AnimalBean animalBean);
	
	int registrarAnimal(AnimalBean animalBean);
	
}
