package pe.com.paxtravel.service;

import pe.com.paxtravel.bean.AuthorizeNetBean;
import pe.com.paxtravel.bean.ProcesarPagoBean;

public interface AuthorizeNetService {
	
	public AuthorizeNetBean procesarPago(ProcesarPagoBean procesarPagoBean); 

}
