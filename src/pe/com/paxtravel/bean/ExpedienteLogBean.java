package pe.com.paxtravel.bean;

public class ExpedienteLogBean {
	
	private int idLog;
	private String tiLog;
	private int idTx;
	private int idUser;
	private String feLog;
	private String feLogtime;
	private String desLog;
	private int idEstado;	
	
	public int getIdEstado() {
		return idEstado;
	}
	public void setIdEstado(int idEstado) {
		this.idEstado = idEstado;
	}
	public int getIdLog() {
		return idLog;
	}
	public void setIdLog(int idLog) {
		this.idLog = idLog;
	}
	public String getTiLog() {
		return tiLog;
	}
	public void setTiLog(String tiLog) {
		this.tiLog = tiLog;
	}
	public int getIdTx() {
		return idTx;
	}
	public void setIdTx(int idTx) {
		this.idTx = idTx;
	}
	public int getIdUser() {
		return idUser;
	}
	public void setIdUser(int idUser) {
		this.idUser = idUser;
	}
	public String getFeLog() {
		return feLog;
	}
	public void setFeLog(String feLog) {
		this.feLog = feLog;
	}
	public String getFeLogtime() {
		return feLogtime;
	}
	public void setFeLogtime(String feLogtime) {
		this.feLogtime = feLogtime;
	}
	public String getDesLog() {
		return desLog;
	}
	public void setDesLog(String desLog) {
		this.desLog = desLog;
	}
	@Override
	public String toString() {
		return "ExpedienteLogBean [idLog=" + idLog + ", tiLog=" + tiLog
				+ ", idTx=" + idTx + ", idUser=" + idUser + ", feLog=" + feLog
				+ ", feLogtime=" + feLogtime + ", desLog=" + desLog
				+ ", idEstado=" + idEstado + "]";
	}	
	

}
