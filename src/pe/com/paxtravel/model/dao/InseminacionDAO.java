package pe.com.paxtravel.model.dao;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import pe.com.paxtravel.bean.InseminacionBean;
import pe.com.paxtravel.bean.ProduccionBean;

public interface InseminacionDAO {
	
	List<InseminacionBean> listaInseminacion(InseminacionBean inseminacionBean);
	
	int registrarInseminacion(InseminacionBean inseminacionBean);
	
	int editarInseminacion(InseminacionBean inseminacionBean);
	
	int eliminarInseminacion(InseminacionBean inseminacionBean);
	
	String obtenerCodigoInseminacion();
	
//	List<InseminacionBean> buscarInseminacion(String codigoInseminacion);
	
	InseminacionBean verDetalleInseminacion(InseminacionBean inseminacionBean);
		
}
