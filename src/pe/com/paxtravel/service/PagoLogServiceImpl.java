package pe.com.paxtravel.service;

import pe.com.paxtravel.bean.PagoLogBean;
import pe.com.paxtravel.model.dao.PagoLogDAO;

public class PagoLogServiceImpl implements PagoLogService {

	private PagoLogDAO pagoLogDAO;

	public PagoLogDAO getPagoLogDAO() {
		return pagoLogDAO;
	}

	public void setPagoLogDAO(PagoLogDAO pagoLogDAO) {
		this.pagoLogDAO = pagoLogDAO;
	}

	@Override
	public void grabarPagoLog(PagoLogBean pagoLogBean) {
		pagoLogDAO.grabarPagoLog(pagoLogBean);
	}

}
