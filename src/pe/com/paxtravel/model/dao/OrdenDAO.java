package pe.com.paxtravel.model.dao;

import java.util.List;

import pe.com.paxtravel.bean.OrdenBean;
import pe.com.paxtravel.bean.ReservaBean;

public interface OrdenDAO {
	
	List<OrdenBean> listaOrden(OrdenBean ordenBean);
	
	String generarNumeroOrden();
	
	int registrarOrden(OrdenBean ordenBean);
	
	int registrarDestino(OrdenBean ordenBean);
	
	int registrarServicio(OrdenBean ordenBean);
	
	int registrarMotivo(OrdenBean ordenBean);
	
	OrdenBean obtenerOrdenDetalle(OrdenBean ordenBean);
	
	List<OrdenBean> listarMotivoViajeDetalle(OrdenBean ordenBean);
	
	List<OrdenBean> listarServicioDetalle(OrdenBean ordenBean);
	
}
