package pe.com.paxtravel.service;

import org.springframework.stereotype.Service;

import pe.com.paxtravel.bean.ClienteBean;
import pe.com.paxtravel.model.dao.ClienteDAO;

@Service
public class ClienteServiceImpl implements ClienteService {

	private ClienteDAO clienteDAO;

	@Override
	public ClienteBean obtenerCliente(int idCliente) {
		return clienteDAO.obtenerCliente(idCliente);
	}

	public ClienteDAO getClienteDAO() {
		return clienteDAO;
	}

	public void setClienteDAO(ClienteDAO clienteDAO) {
		this.clienteDAO = clienteDAO;
	}

	@Override
	public int actualizarFlagValidacionEmail(ClienteBean clienteBean) {
		return clienteDAO.actualizarFlagValidacionEmail(clienteBean);
	}

}
