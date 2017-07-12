package pe.com.paxtravel.service;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.apache.commons.collections.CollectionUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pe.com.paxtravel.bean.EmpleadoBean;
import pe.com.paxtravel.bean.ProduccionBean;
import pe.com.paxtravel.model.dao.EmpleadoDAO;
import pe.com.paxtravel.util.ExcelUtil;

@Service
public class EmpleadoServiceImpl implements EmpleadoService {

	private EmpleadoDAO empleadoDAO;
	
	public void setEmpleadoDAO(EmpleadoDAO empleadoDAO) {
		this.empleadoDAO = empleadoDAO;
	}

	@Override
	public List<EmpleadoBean> listarEmpleado(EmpleadoBean empleadoBean) {
		List<EmpleadoBean> listaEmpleado = new ArrayList<EmpleadoBean>();
		listaEmpleado = empleadoDAO.listaEmpleado(empleadoBean);
		return listaEmpleado;
	}

	@Override
	public String generarCodigoEmpleado() {
		return empleadoDAO.generarCodigoEmpleado();
	}

	@Override
	public int registrarEmpleado(EmpleadoBean empleadoBean) {
		return empleadoDAO.registrarEmpleado(empleadoBean);
	}

	@Override
	public void exportarExcel(List<EmpleadoBean> lista, OutputStream outputStream) throws Exception {
		
		ExcelUtil excel = new ExcelUtil();
		
		List<String> header = new ArrayList<String>();
		
		header.add("Usuario");
		header.add("Nombre");
		header.add("Paterno");
		header.add("Materno");
		header.add("Fecha Nacimiento");
		excel.xlsInitLibro("Lista-empleados");
		
		//estilos para la hoja de excel
		HSSFCellStyle _styleCenter = excel.getStyleNegritaCenter();
		HSSFCellStyle _styleBloque = excel.getStyleBloque();
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		
		excel.xlsBloque(header, null, 4);
		int k = 0;
		if (CollectionUtils.isNotEmpty(lista)) {

			//columna
			
			EmpleadoBean item = null;

			for (int i = 0; i < lista.size(); i++) {

				item = lista.get(i);

				// crear nueva fila
				excel.xlsRow();

				// crear celdas en la columna k
				k = 1;

				// Nombre del Extranjero
				excel.xlsCell(k++, item.getUsername());

				// Apellido Paterno
				excel.xlsCell(k++, item.getNombre());

				// Apellido Materno
				excel.xlsCell(k++, item.getPaterno());

				// Nacionalidad
				excel.xlsCell(k++, item.getMaterno());

				// Fecha
				excel.xlsCell(k++, item.getFechaNacimiento(), _styleCenter);

			}
			
		} else {
			excel.xlsRow();
			k = 1;
			excel.xlsCell(k++, "No se encontraron resultados para la b\u00FAsqueda", _styleBloque);
			excel.xlsRow();
			excel.xlsRow();
			excel.xlsRow();
		}
		
		excel.xlsGetWbLibro().write(outputStream);
			
	}
	
}
