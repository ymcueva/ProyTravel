package pe.com.paxtravel.controller;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.List;

//import giovynet.nativelink.SerialPort;
import gnu.io.CommPort;
import gnu.io.CommPortIdentifier;

public class EscribirPuertoSerial {

	public static void main(String[] args) throws Exception {

		EscribirPuertoSerial obj = new EscribirPuertoSerial();
		
//		SerialPort serialPort1 = new SerialPort();
//		List<String> portsFree = serialPort1.getFreeSerialPort();
//		String g = serialPort1.getStateSerialPortC("COM6");
//		System.out.println("g:  "+ g);
//		for (String free : portsFree) {
//			System.out.println(free);
//		}
		
		

		// ESCRIBIENDO EN UN PUERTO SERIAL
		Enumeration puertos;
		OutputStream ops;
		CommPortIdentifier portId;
		puertos = CommPortIdentifier.getPortIdentifiers();
		CommPort serialPort;
		Double cantidadProduccion = 0.0; 
		while(puertos.hasMoreElements()){
			portId = (CommPortIdentifier) puertos.nextElement();
//			System.out.println("puerto id: " + portId.getName());
			if (portId.getName().equalsIgnoreCase("COM2")){
				try {
					serialPort =  portId.open("EscrituraSerial1", 500);
					ops = serialPort.getOutputStream();
					cantidadProduccion = 5.47;
					ops.write(cantidadProduccion.toString().getBytes());
					ops.close();
					serialPort.close();
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
		}
		
		
//		Enumeration puertos;
//		OutputStream ops;
//		CommPortIdentifier portId;
//		puertos = CommPortIdentifier.getPortIdentifiers();
//		SerialPort serialPort;
//		String vec[] = new String[2];
//		PrintStream salida;
//		
//		while(puertos.hasMoreElements()){
//			portId = (CommPortIdentifier) puertos.nextElement();
//			System.out.println("puerto id: " + portId.getName());
//			if (portId.getName().equalsIgnoreCase("COM7")){
//				try {
//					serialPort = (SerialPort) portId.open("EscrituraSerial1", 500);
//					
//					salida = new PrintStream(serialPort.getOutputStream());
//					
//					for (int i = 0; i < vec.length; i++) {
//						String c = "1000";
//						vec[i] = c;
//						salida.print(vec[i]+"\n");
//					}
//					
//					salida.close();
//					serialPort.close();
//					
//				} catch (Exception e) {
//					// TODO: handle exception
//				}
//			}
//		}
		
		
		// FIN ESCRITURA PUERTO SERIAL
		
		
		FileWriter fichero = null;
        PrintWriter pw = null;
        
        try{
        	File file = new File("c:/prueba.txt");
        	if (file.exists()){
        		BufferedWriter bw = new BufferedWriter(new FileWriter("c:/prueba.txt"));
        		bw.write(cantidadProduccion.toString());
        		bw.close();
        	}
//            fichero = new FileWriter("c:/prueba.txt", true);
//            pw = new PrintWriter(fichero);


        } catch (Exception e) {
            e.printStackTrace();
        } 
	}

}
