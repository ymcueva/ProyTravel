package pe.com.paxtravel.controller;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintStream;
import java.util.Enumeration;

import gnu.io.CommPortIdentifier;
import gnu.io.PortInUseException;
import gnu.io.SerialPort;
import gnu.io.UnsupportedCommOperationException;

public class EjemploRXTX {
	
    static CommPortIdentifier portId;
    static CommPortIdentifier saveportId;
    static Enumeration  portList;
    static InputStream inputStream;
    static OutputStream outputStream;
    static BufferedInputStream bufferedInputStream;
    static SerialPort  serialPort;
   
   // viedos lectura y escritura puerto serial
    //https://www.youtube.com/watch?v=nYsWEQtSeKA
    
    static String datoTer = "";
    /**
     * @param args
     * @throws IOException
     */
    public static void main(String[] args) throws IOException{
    	try{
    		
    		
    		// ESCRIBIENDO EN UN PUERTO SERIAL
//    		Enumeration puertos;
//    		OutputStream ops;
//    		CommPortIdentifier portId;
//    		puertos = CommPortIdentifier.getPortIdentifiers();
//    		SerialPort serialPort;
//    		
//    		while(puertos.hasMoreElements()){
//    			portId = (CommPortIdentifier) puertos.nextElement();
//    			System.out.println("puerto id: " + portId.getName());
//    			if (portId.getName().equalsIgnoreCase("COM7")){
//    				try {
//						serialPort = (SerialPort) portId.open("EscrituraSerial1", 500);
//						ops = serialPort.getOutputStream();
//						ops.write("hola mundo SERIAL".getBytes());
//						ops.close();
//						serialPort.close();
//					} catch (Exception e) {
//						// TODO: handle exception
//					}
//    			}
//    		}
    		
    		
//    		Enumeration puertos;
//    		OutputStream ops;
//    		CommPortIdentifier portId;
//    		puertos = CommPortIdentifier.getPortIdentifiers();
//    		SerialPort serialPort;
//    		String vec[] = new String[2];
//    		PrintStream salida;
//    		
//    		while(puertos.hasMoreElements()){
//    			portId = (CommPortIdentifier) puertos.nextElement();
//    			System.out.println("puerto id: " + portId.getName());
//    			if (portId.getName().equalsIgnoreCase("COM7")){
//    				try {
//						serialPort = (SerialPort) portId.open("EscrituraSerial1", 500);
//						
//						salida = new PrintStream(serialPort.getOutputStream());
//						
//						for (int i = 0; i < vec.length; i++) {
//							String c = "1000";
//							vec[i] = c;
//							salida.print(vec[i]+"\n");
//						}
//						
//						salida.close();
//						serialPort.close();
//						
//					} catch (Exception e) {
//						// TODO: handle exception
//					}
//    			}
//    		}
    		
    		
    		// FIN ESCRITURA PUERTO SERIAL
    		
    		
			System.loadLibrary("rxtxSerial");
			System.out.println("Se ha cargado la librería nativa correctamente");

			Enumeration listaPuertos = CommPortIdentifier.getPortIdentifiers();
			CommPortIdentifier idPuerto = null;
			boolean encontrado = false;
			while (listaPuertos.hasMoreElements() && !encontrado) {
				idPuerto = (CommPortIdentifier) listaPuertos.nextElement();
				if (idPuerto.getPortType() == CommPortIdentifier.PORT_SERIAL) {
					if (idPuerto.getName().equals("COM2")) {
						encontrado = true;
					}
				}
			}
			
			
			if (encontrado) {
				OutputStream ops;
				
				SerialPort puertoSerie = null;
				try {
					puertoSerie = (SerialPort) idPuerto.open("DescripcionPropietario", 2000);
				} catch (PortInUseException e) {
					System.out.println("Error abriendo el puerto serie: " + idPuerto.getName());
				}
	
				try {
					puertoSerie.setSerialPortParams(9600, SerialPort.DATABITS_8,SerialPort.STOPBITS_1, SerialPort.PARITY_NONE);
					
//					System.out.println("escribiendo en puerto com1");
//					ops = puertoSerie.getOutputStream();
//					datoTer = "3.9";
//					ops.write(datoTer.getBytes());
//					ops.close();
					
					puertoSerie.notifyOnDataAvailable(true);
				} catch (UnsupportedCommOperationException e) {
					System.out.println("Error configurando parámetros de configuración");
				}
				
				InputStream entrada = puertoSerie.getInputStream();
				
				
				String s = "";
//				while (entrada.available() > 0) {
					
					System.out.println("disponible: " + entrada.available());
					int dato = entrada.read();
					System.out.println("DATO: " + dato);
					s = s + (char) dato;
//				}
				
				puertoSerie.close();
				System.out.println("entrada de la balanza: " + s);
			}
			
			
		} catch (UnsatisfiedLinkError u) {
			System.err.println("No se ha encontrado la librería nativa de puerto serie");
			u.getMessage();
		}
    	
    	/*        boolean gotPort = false;
        String port;
        portList = CommPortIdentifier.getPortIdentifiers();
       
        while (portList.hasMoreElements()) {
            portId = (CommPortIdentifier) portList.nextElement(); //get next port to check
            if (portId.getPortType() == CommPortIdentifier.PORT_SERIAL) {
                if ( portId.getName().equals("COM4") ) {
                    port = portId.getName(); 
                    gotPort = true;
                }
               
                if (gotPort == true) {
                    try {
                        serialPort = (SerialPort)portId.open("SMSSender", 2000);
                    } catch (PortInUseException ex) {
                        ex.printStackTrace();
                    }
                    try {
                        outputStream = serialPort.getOutputStream();
                    } catch (IOException ex) {
                        ex.printStackTrace();
                    }
                    try {
                        serialPort.setSerialPortParams(19200,
                                SerialPort.DATABITS_8,
                                SerialPort.STOPBITS_2,
                                SerialPort.PARITY_NONE
                                );
                    } catch (UnsupportedCommOperationException ex) {
                        ex.printStackTrace();
                    }
                   
                    try {
                        inputStream = serialPort.getInputStream();
                        bufferedInputStream = new BufferedInputStream(inputStream);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                   
                    serialPort.notifyOnDataAvailable(true);
                }
            }
        }
       
       //Escribir en el puerto serie
       try {
            if (!(outputStream == null)){
//                outputStream.write("array de váis que queremos enviar");
                outputStream.write(8192);
            }
           
            byte[] readBuffer = new byte[1];
            boolean read = false;
            while(!read) {
                try {
                    String getInfo = "";
                    Thread.sleep(100);
                    while (bufferedInputStream.available() > 0) {
                        int numBytes = bufferedInputStream.read(readBuffer);
                        getInfo += new String(readBuffer);
                        read = true;
                    }
//                    feedback += getInfo;
                    int length = getInfo.length();
                } catch (Exception e){
                    e.printStackTrace();
                }
            }
        } catch (IOException e){
            e.printStackTrace();
        }*/
    }
    public String datoTerminal(String s){
    	String cadena = "";
    	if (s.equals("")){
    		cadena = datoTer;
    	}else{
    		cadena =  s;
    	}
    	return cadena;
    }
    
}
