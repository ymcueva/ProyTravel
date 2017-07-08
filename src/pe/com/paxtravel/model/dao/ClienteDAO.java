package pe.com.paxtravel.model.dao;

import java.util.List;

import pe.com.paxtravel.bean.ClienteBean;

public interface ClienteDAO {

	List<ClienteBean> listaCliente(ClienteBean clienteBean);

	ClienteBean obtenerCliente(int idCliente);
	// void listaCliente();
	
	int actualizarFlagValidacionEmail(ClienteBean clienteBean);

}
