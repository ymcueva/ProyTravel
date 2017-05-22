package pe.com.paxtravel.model.dao;

import java.util.List;

import pe.com.paxtravel.bean.EmpleadoBean;
import pe.com.paxtravel.bean.ProduccionBean;

public interface EmpleadoDAO {
	
	List<EmpleadoBean> listaEmpleado(EmpleadoBean empleadoBean);

	String generarCodigoEmpleado();
	
	int registrarEmpleado(EmpleadoBean empleadoBean);

}
