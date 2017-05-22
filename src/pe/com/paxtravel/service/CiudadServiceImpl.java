package pe.com.paxtravel.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pe.com.paxtravel.bean.ClienteBean;
import pe.com.paxtravel.model.dao.CiudadDAO;
import pe.com.paxtravel.model.dao.ClienteDAO;

@Service
public class CiudadServiceImpl implements CiudadService {

	private CiudadDAO ciudadDAO;
	
	private ClienteDAO clienteDAO;

	public void setClienteDAO(ClienteDAO clienteDAO) {
		this.clienteDAO = clienteDAO;
	}

	public void setCiudadDAO(CiudadDAO ciudadDAO) {
		this.ciudadDAO = ciudadDAO;
	}

	
	@Override
	public int grabar() {
		ciudadDAO.listaCiudad();
		int a = 5;
		int b = 4;
		return a+b;
	}

	@Override
	public List<ClienteBean> obtieneCliente() {
		List<ClienteBean> lista = new ArrayList<ClienteBean>();
		Map<String, Object> map = null;
		ClienteBean o = new ClienteBean();
		o.setCodigo("00001");
		lista = clienteDAO.listaCliente(o);
		return lista;
	}
}
