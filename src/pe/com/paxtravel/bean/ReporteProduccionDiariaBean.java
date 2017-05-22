package pe.com.paxtravel.bean;

public class ReporteProduccionDiariaBean {

	private int numeroFila;
	
	private String fechaOrdeno;

	private Double cantidadTotalProduccion;
	
	private String ordenador;

	private String vacaMasProductiva;
	
	private String vacaMenosProductiva;

	public int getNumeroFila() {
		return numeroFila;
	}

	public void setNumeroFila(int numeroFila) {
		this.numeroFila = numeroFila;
	}
	
	public String getFechaOrdeno() {
		return fechaOrdeno;
	}

	public void setFechaOrdeno(String fechaOrdeno) {
		this.fechaOrdeno = fechaOrdeno;
	}

	public Double getCantidadTotalProduccion() {
		return cantidadTotalProduccion;
	}

	public void setCantidadTotalProduccion(Double cantidadTotalProduccion) {
		this.cantidadTotalProduccion = cantidadTotalProduccion;
	}

	public String getOrdenador() {
		return ordenador;
	}

	public void setOrdenador(String ordenador) {
		this.ordenador = ordenador;
	}

	public String getVacaMasProductiva() {
		return vacaMasProductiva;
	}

	public void setVacaMasProductiva(String vacaMasProductiva) {
		this.vacaMasProductiva = vacaMasProductiva;
	}

	public String getVacaMenosProductiva() {
		return vacaMenosProductiva;
	}

	public void setVacaMenosProductiva(String vacaMenosProductiva) {
		this.vacaMenosProductiva = vacaMenosProductiva;
	}
	
}