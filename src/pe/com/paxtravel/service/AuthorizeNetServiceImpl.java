package pe.com.paxtravel.service;

import org.springframework.stereotype.Service;

import pe.com.paxtravel.bean.AuthorizeNetBean;
import pe.com.paxtravel.bean.ProcesarPagoBean;
import pe.com.paxtravel.util.Utils;

@Service
public class AuthorizeNetServiceImpl implements AuthorizeNetService {

	@Override
	public AuthorizeNetBean procesarPago(ProcesarPagoBean procesarPagoBean) {
		AuthorizeNetBean bean = new AuthorizeNetBean();
		bean.setNumeroOperacion(Utils.getRandomNumber(10));
		bean.setEstadoOperacion("ACEPTADO");
		bean.setMensajeProcesador("Pago aceptado");
		return bean;
	}

}
