package pe.com.paxtravel.model.dao.ibatis;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import pe.com.paxtravel.bean.AnimalBean;
import pe.com.paxtravel.bean.EmpleadoBean;
import pe.com.paxtravel.bean.InseminacionBean;
import pe.com.paxtravel.bean.ProduccionBean;
import pe.com.paxtravel.model.dao.AnimalDAO;
import pe.com.paxtravel.model.dao.InseminacionDAO;
//import pe.com.paxtravel.model.dao.ProduccionDAO;

public class SqlMapAnimalDAO extends SqlMapClientDaoSupport implements AnimalDAO{
	
	@SuppressWarnings("unchecked")
	@Override
	public List<AnimalBean> listaVacasAInseminar(AnimalBean animalBean) {
		return getSqlMapClientTemplate().queryForList("animal.listaVacasAInseminar", animalBean);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<AnimalBean> listaVacasAParir(AnimalBean animalBean) {
		return getSqlMapClientTemplate().queryForList("animal.listaVacasAParir", animalBean);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<AnimalBean> listaToro() {
		return getSqlMapClientTemplate().queryForList("animal.listaToro");
	}

	@Override
	public int actualizaEstadoProcesoEvolutivo(AnimalBean animalBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("animal.actualizaEstadoProcesoEvolutivo", animalBean);
		return 1;
	}

	@Override
	public int registrarAnimal(AnimalBean animalBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).update("animal.insertarAnimal", animalBean);
		return 1;
	}
	
}