package pe.com.paxtravel.tree.decision;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import pe.com.paxtravel.service.CotizacionService;
import pe.com.paxtravel.tree.data.PaqueteManagerBean;

public class DataManagerTest2 {
	
		
	
	public static void main(String[] args) {
		
		
		
		TableManager tm = new DataManager("test.csv");
		System.out.println("Initialiting test.csv.\n");
		System.out.println(tm);
		
		//test 1: Observing if we can reduce the table.
		System.out.println("Reducing table with the attribute Altura and value Alto.\n");
		TableManager tm2 = tm.getSubTable("Motivo1", "Trabajo");
		System.out.println(tm2);
		
		//Test 2: Observing the best objective value for value Rojo.
		System.out.println("Getting the best objective value for value 1 (Habitacion).");
		if(!tm2.getBestObjectiveValueFromAttribute("Habitacion", "1").equals("Alto")) throw new RuntimeException("Test 2 failed.");
		System.out.println("Second test passed.");
		
		//Test 3: Observing the best objective value for value Moreno.
		System.out.println("Getting the best objective value for value Moreno.");
		if(!tm2.getBestObjectiveValueFromAttribute("Categoria", "2").equals("Bajo")) throw new RuntimeException("Test 3 failed.");
		System.out.println("Third test passed.");
		
		//Test 4: Observing the best objective value for value Azules.
		System.out.println("Getting the best objective value for value Azules.");
		if(!tm2.getBestObjectiveValueFromAttribute("ValorDetalle2", "Alto").equals("Alto")) throw new RuntimeException("Test 4 failed.");
		System.out.println("Fourth test passed.");
		
		//Test 5: Observing if we can obtain a subset of data for training. 
		System.out.println("Getting a table for trainning with the 75% of the datas");
		tm2=tm.getTrainAndProbeSet(75.0);
		System.out.println(tm);
		System.out.println(tm2.getAttributes());
		System.out.println(tm2); 
		
		
	}

}
