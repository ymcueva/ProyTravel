package pe.com.paxtravel.service;

import java.util.List;

import pe.com.paxtravel.bean.AnimalBean;
import pe.com.paxtravel.bean.EmpleadoBean;
import pe.com.paxtravel.bean.InseminacionBean;
import pe.com.paxtravel.bean.ProduccionBean;

public interface AnimalService {
	
	public List<AnimalBean> listarToro();

	public List<AnimalBean> listarVacasAInseminar(AnimalBean animalBean);
	
	public List<AnimalBean> listarVacasAParir(AnimalBean animalBean);
	
	public int actualizaEstadoProcesoEvolutivo(AnimalBean animalBean);
	
	public int registrarAnimal(AnimalBean animalBean);
	
}
