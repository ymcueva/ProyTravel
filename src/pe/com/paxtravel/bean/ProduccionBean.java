package pe.com.paxtravel.bean;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class ProduccionBean {

	private int numeroFila;
	
	private String codigoProduccion;

	private String codigoAnimal;
	
	private String nombreAnimal;
	
	private Double cantidadProducida;
	
	private String turno;
	
	private String usuario;
	
	private String fechaOrdeno;
	
	private String fechaInicio;

	private String fechaFin;

	public int getNumeroFila() {
		return numeroFila;
	}

	public void setNumeroFila(int numeroFila) {
		this.numeroFila = numeroFila;
	}
	
	public String getCodigoProduccion() {
		return codigoProduccion;
	}

	public void setCodigoProduccion(String codigoProduccion) {
		this.codigoProduccion = codigoProduccion;
	}
	
	public String getCodigoAnimal() {
		return codigoAnimal;
	}

	public void setCodigoAnimal(String codigoAnimal) {
		this.codigoAnimal = codigoAnimal;
	}

	public String getNombreAnimal() {
		return nombreAnimal;
	}

	public void setNombreAnimal(String nombreAnimal) {
		this.nombreAnimal = nombreAnimal;
	}

	public Double getCantidadProducida() {
		return cantidadProducida;
	}

	public void setCantidadProducida(Double cantidadProducida) throws NumberFormatException, IOException {
		if (cantidadProducida == 0.0){
			this.cantidadProducida = lee();
		} else {
			this.cantidadProducida = cantidadProducida;
		}
	}

	public String getTurno() {
		return turno;
	}

	public void setTurno(String turno) {
		this.turno = turno;
	}

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	

	public String getFechaOrdeno() {
		return fechaOrdeno;
	}

	public void setFechaOrdeno(String fechaOrdeno) {
		this.fechaOrdeno = fechaOrdeno;
	}

	public Double lee() throws NumberFormatException, IOException{
		File fichero = new File("c:/prueba.txt");
		FileReader fr = new FileReader(fichero);
		BufferedReader br = new BufferedReader(fr);
		return Double.parseDouble( br.readLine() ); 
	}
	
	
	public String getFechaInicio() {
		return fechaInicio;
	}

	public void setFechaInicio(String fechaInicio) {
		this.fechaInicio = fechaInicio;
	}

	public String getFechaFin() {
		return fechaFin;
	}

	public void setFechaFin(String fechaFin) {
		this.fechaFin = fechaFin;
	}
	
}
