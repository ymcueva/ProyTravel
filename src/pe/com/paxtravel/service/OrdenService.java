package pe.com.paxtravel.service;

import java.util.List;

import pe.com.paxtravel.bean.CotizacionBean;
import pe.com.paxtravel.bean.OrdenBean;
import pe.com.paxtravel.bean.ReservaBean;
import pe.com.paxtravel.bean.ReservaPasajeroDetalleBean;

public interface OrdenService {

	public List<OrdenBean> listarOrden(OrdenBean ordenBean);
	
	public String generarNumeroOrden();
	
	public int registrarOrden(OrdenBean ordenBean);
	
	public int registrarDestino(OrdenBean ordenBean);
	
	public int registrarServicio(OrdenBean ordenBean);
	
	public int registrarMotivo(OrdenBean ordenBean);
	
}
