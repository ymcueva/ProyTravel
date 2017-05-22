package pe.com.paxtravel.service;

import java.util.List;
import org.springframework.stereotype.Service;

import pe.com.paxtravel.bean.AnimalBean;
import pe.com.paxtravel.model.dao.AnimalDAO;

@Service
public class AnimalServiceImpl implements AnimalService {

	private AnimalDAO animalDAO;

	public void setAnimalDAO(AnimalDAO animalDAO) {
		this.animalDAO = animalDAO;
	}

	@Override
	public List<AnimalBean> listarToro() {
		return animalDAO.listaToro();
	}

	@Override
	public List<AnimalBean> listarVacasAInseminar(AnimalBean animalBean) {
		return animalDAO.listaVacasAInseminar(animalBean);
	}

	@Override
	public List<AnimalBean> listarVacasAParir(AnimalBean animalBean) {
		return animalDAO.listaVacasAParir(animalBean);
	}
	
	@Override
	public int actualizaEstadoProcesoEvolutivo(AnimalBean animalBean) {
		return animalDAO.actualizaEstadoProcesoEvolutivo(animalBean);
	}
	
	@Override
	public int registrarAnimal(AnimalBean animalBean) {
		return animalDAO.registrarAnimal(animalBean);
	}
}
