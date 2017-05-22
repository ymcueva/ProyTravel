package pe.com.paxtravel.service;

import java.util.List;

import pe.com.paxtravel.bean.EmpleadoBean;
import pe.com.paxtravel.bean.InseminacionBean;
import pe.com.paxtravel.bean.ProduccionBean;

public interface InseminacionService {
	
	public List<InseminacionBean> listarInseminacion(InseminacionBean inseminacionBean);

	public int registrarInseminacion(InseminacionBean inseminacionBean);

	public String obtenerCodigoInseminacion();
	
	public int editarInseminacion(InseminacionBean inseminacionBean);

	public int eliminarInseminacion(InseminacionBean inseminacionBean);

	public InseminacionBean verDetalleInseminacion(InseminacionBean inseminacionBean);

}
