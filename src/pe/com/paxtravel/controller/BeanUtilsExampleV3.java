package pe.com.paxtravel.controller;

import org.apache.commons.beanutils.BeanUtils;

import java.util.Map;
import java.util.Date;
import java.util.List;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.GregorianCalendar;

public class BeanUtilsExampleV3 {

	public static void main(String args[]) throws Exception {
	    BeanUtilsExampleV3 diff = new BeanUtilsExampleV3();
	    Actor actor = diff.prepareData();

	    Map describedData = BeanUtils.describe(actor);

	    // check the map
	    System.err.println(describedData.get("name"));

	    // change this value
	    describedData.put("name", "Robert Redford");

	    // create a new Actor Bean
	    Actor newActor = new Actor();
	    System.out.println("antes del populate");
	    BeanUtils.populate(newActor, describedData);
	    System.out.println("newActor: " + newActor.getName());
	    System.out.println("despues del populate");

	    System.err.println(BeanUtils.getProperty(newActor, "name"));

	  }
	
	 Actor prepareData() {
	    Actor actor = new Actor();
	    actor.setName("Michael Caine");
	    actor.setGender(1);
	    actor.setWorth(10000000);
	    return actor;
	  }
}
