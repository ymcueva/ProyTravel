package pe.com.paxtravel.service;

import java.io.OutputStream;
import java.util.List;

import pe.com.paxtravel.bean.ClienteBean;
import pe.com.paxtravel.bean.EmpleadoBean;
import pe.com.paxtravel.bean.ProduccionBean;

public interface EmpleadoService {

	public List<EmpleadoBean> listarEmpleado(EmpleadoBean empleadoBean);
	
	public String generarCodigoEmpleado();
	
	public int registrarEmpleado(EmpleadoBean empleadoBean);

    public void exportarExcel(List<EmpleadoBean> lista, OutputStream outputStream) throws Exception;

}
