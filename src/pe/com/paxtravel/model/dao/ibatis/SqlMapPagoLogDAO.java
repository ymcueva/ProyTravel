package pe.com.paxtravel.model.dao.ibatis;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import pe.com.paxtravel.bean.PagoLogBean;
import pe.com.paxtravel.model.dao.PagoLogDAO;

public class SqlMapPagoLogDAO extends SqlMapClientDaoSupport implements
		PagoLogDAO {

	@Override
	public void grabarPagoLog(PagoLogBean pagoLogBean) {
		new SqlMapClientTemplate(getSqlMapClientTemplate().getSqlMapClient()).insert("pagolog.insertarPagoLog", pagoLogBean);
	}

}
