
package pe.com.paxtravel.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

//import org.apache.commons.beanutils.BeanUtils;

import pe.com.paxtravel.bean.FareInfoBean;
import pe.com.paxtravel.util.Constantes;

/**
 * @author jjurado
 * @since 27.08.2015 Utils.
 */

@SuppressWarnings({ "unchecked" })
public class Utils {

    /**
     * Metodo mapea una determinada clase, Te crea una objeto de una determinada
     * clase y le matea los parametros del request.
     * 
     * @author jjurado
     * @since 27.08.2015
     * @param <T>
     * @param HttpServletRequest
     * @param clase
     * @return
     */
    public static <T> T mapearBean(HttpServletRequest request, Class<T> clase) {
        try {

            String className = clase.getName();
            Object generico = Class.forName(className).newInstance();
            mapearBean( generico, request );
            return clase.cast(generico);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    protected static Map<String, Field> _toMapFields(Class<?> clase) {
        Field[] fields = clase.getDeclaredFields();
        Map<String, Field> mapFields = new HashMap<String, Field>();
        for (Field field : fields) {
            mapFields.put(field.getName(), field);
        }
        return mapFields;
    }

    private static void mapearBean(Object generico, HttpServletRequest request) throws Exception {

    	Map<String, String[]> mapaDatos = request.getParameterMap();
        
        Class<?> clase = generico.getClass();
        Iterator<String> itMapaDatos = mapaDatos.keySet().iterator();
        Map<String, Field> mapFields = _toMapFields( clase );
        boolean isAccessible;
        Object valor = null;
        Field field;
        String key;
        String[] value;

        // si el bean no tiene atributos
        if (mapFields.isEmpty()) {
            return;
        }

        while (itMapaDatos.hasNext()) {
            key = itMapaDatos.next();
            value = mapaDatos.get(key);
            if (value == null || value.length == 0) {
                continue;
            }

            field = mapFields.get(key);
            // verificamos si existe un campo que tenga el mismo nombre del key
            // (mapa)
            if (!isEmpty(field)) {
                try {
                    // se asigna valor del mapa al object (se castea)
                    if (equiv(field.getType(), Long.class)) {
                        valor = toLong( value[0] );
                    } else if (equiv( field.getType(), Short.class )) {
                        valor = toShort( value[0] );
                    } else if (equiv(field.getType(), Integer.class)) {
                        valor = toInteger(value[0]);
                    } else if (equiv(field.getType(), Double.class)) {
                        valor = toDouble( !isEmpty( value[0] ) ? value[0].replaceAll( "\\,", "" ) : value[0] );
                    } else if (equiv(field.getType(), Float.class)) {
                        valor = toFloat( !isEmpty( value[0] ) ? value[0].replaceAll( "\\,", "" ) : value[0] );
                    } else if (equiv( field.getType(), Date.class )) {
                        valor =stringToDate(value[0], Constantes.INT_TWO ) ;
                    } else if (equiv( field.getType(), String[].class )) {
                        // esto xEjemplo: cuando sean varios checkbox con el mismo nombre
                        valor = value;
                    } else {
                        valor = value[0];
                    }

                    // si el atributo no es accesible (private) lo volvemos
                    // accesible temporalmente
                    if (!(isAccessible = field.isAccessible())) {
                        field.setAccessible(true);
                    }
                    field.set(generico, valor);
                    // se le quita la accesibilidad si es que no lo era
                    if (!isAccessible) {
                        field.setAccessible(false);
                    }
                } catch (Exception e) {
                	e.printStackTrace();
                }
            }
        }
        
        /** INICIO DE FormFiles **/
        Enumeration<String> attributeNames = request.getAttributeNames();
        if (attributeNames.hasMoreElements()) {
            key = attributeNames.nextElement();
            valor = request.getAttribute( key );
            if (!isEmpty( valor )) {
                if (equiv( FormFile.class, valor.getClass() )) {
                    field = mapFields.get( key );
                    // verificamos si existe un campo que tenga el mismo nombre
                    // del key (mapa)
                    if (!isEmpty( field )) {
                        if (equiv( field.getType(), FormFile.class )) {

                            // si el atributo no es accesible (private) lo
                            // volvemos
                            // accesible temporalmente
                            if (!(isAccessible = field.isAccessible())) {
                                field.setAccessible( true );
                            }
                            field.set( generico, valor );
                            // se le quita la accesibilidad si es que no lo era
                            if (!isAccessible) {
                                field.setAccessible( false );
                            }

                        }
                    }
                }
            }
        }
        /** FIN FormFiles **/
    }
    
    /**
     * Metodo convierte una cadena a long.
     * 
     *@author jjurado
     * @since 27.08.2015
     * @param objeto
     * @return
     */
    public static Long toLong(Object objeto) {
        if (isEmpty(objeto)) {
            return null;
        }
        try {
            return Long.parseLong(objeto.toString().replaceAll("\\,", ""));
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Metodo convierte una cadena a integer.
     * 
     * @author jjurado
     * @since 27.08.2015
     * @param objeto
     * @return
     */
    public static Integer toInteger(Object objeto) {
        if (isEmpty(objeto)) {
            return null;
        }
        try {
            return Integer.parseInt(objeto.toString().replaceAll("\\,", ""));
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Metodo convierte una cadena a short.
     * 
     * @author jjurado
     * @since 27.08.2015
     * @param objeto
     * @return
     */
    public static Short toShort(Object objeto) {
        if (isEmpty( objeto )) {
            return null;
        }
        try {
            return Short.parseShort( objeto.toString() );
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return null;
        }
    }


    /**
     * Metodo convierte una cadena a double.
     * 
     * @author jjurado
     * @since 27.08.2015
     * @param object
     * @return
     */
    public static Double toDouble(Object objeto) {
        if (isEmpty(objeto)) {
            return null;
        }
        try {
            return Double.parseDouble(objeto.toString().replaceAll("\\,", ""));
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Metodo convierte una cadena a float.
     * 
     * @author jjurado
     * @since 27.08.2015
     * @param object
     * @return
     */
    public static Float toFloat(Object objeto) {
        if (isEmpty(objeto)) {
            return null;
        }
        try {
            return Float.parseFloat(objeto.toString().replaceAll("\\,", ""));
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Metodo convierte un objeto a cadena
     * 
     * @author jjurado
     * @since 27.08.2015
     * @param object
     * @return
     */
    public static String toStr(Object cadena) {
        return isEmpty(cadena) ? null : toBlank(cadena.toString());
    }

    /**
     * Metodo devuelve una cadena formateada.
     * 
     * @author jjurado
     * @since 27.08.2015
     * @param cadena
     * @return
     */
    public static String toBlank(String cadena) {
        return isEmpty(cadena) ? "" : cadena;
    }

    /**
     * Metodo devuelve una cadena, cadena vacia si el objeto es null (uso para
     * grilla).
     * 
     *  @author jjurado
     * @since 27.08.2015
     * @param object
     * @return
     */
    public static String toBlankObject(Object object) {
        return isEmpty(object) ? "" : object.toString();
    }

    /**
     * Verifica si un objecto es vacio: 
     * - Object: Verifica si es nulo (o vacio de ser List)
     * - String: El valor es nulo o vacio
     * 
     * @author jjurado
     * @since 27.08.2015
     * @param object
     * @return
     */
    public static boolean isEmpty(Object object) {
        if (object == null) {
            return true;
        }
        if (object instanceof String) {
            return object.toString().trim().length() == 0;
        }
        if (object instanceof StringBuilder) {
            return object.toString().trim().length() == 0;
        }
        if (object instanceof List<?> || object instanceof ArrayList<?>) {
            return ((List<?>) object).isEmpty();
        }
        return false;
    }

    /**
     * Verifica si todas las posiciones de un array son vacios.
     * 
     * @author jjurado
     * @since 27.08.2015
     * @param array
     * @return
     */
    public static boolean isEmptyArray(Object[] array) {
        if (array == null) {
            return true;
        }
        if (array.length == 0) {
            return true;
        }
        for (Object object : array) {
            if (!isEmpty(object)) {
                return false;
            }
        }

        return true;
    }

    /**
     * Compara si el valor de dos objetos es igual
     * 
     * @author jjurado
     * @since 27.08.2015
     * @param object1
     * @param object2
     * @return
     */
    public static boolean equiv(Object object1, Object object2) {
        if (isEmpty(object1) && !isEmpty(object2) || !isEmpty(object1) && isEmpty(object2)) {
            return false;
        }
        if (isEmpty(object1) && isEmpty(object2) || object1 == object2) {
            return true;
        }

        if (object1 instanceof String && object2 instanceof String) {
            return toBlank(object1.toString()).equals(toBlank(object2.toString()));
        }
        return object1.equals(object2);
    }

    /**
     * Metodo busca una cadena en una arreglo de cadenas.
     * 
     * @author jjurado
     * @since 27.08.2015
     * @param cadena
     * @param valores
     * @return
     */
    public static boolean inList(String cadena, String... valores) {
        for (String valor : valores) {
            if (cadena.equals(valor)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Metodo que elimina una saltos de l�nea en una cadena.
     * 
     * @author jjurado
     * @since 27.08.2015
     * @param cadena
     * @return
     */
    public static String quitarSaltosLinea(String cadena){
        if(!isEmpty(cadena)){
            return cadena.replaceAll("[\n\r]","");
        }
        
        return cadena;
    }
    
    /**
     * Metodo que devuelve un subString desde la posicion 0 hasta una posicion final,
     * 
     * @author jjurado
     * @since 27.08.2015
     * @param cadena
     * @param indexFin
     * @return
     */
    public static String subStr(String cadena, int indexFin){
       return subStr(cadena, 0, indexFin);
    }
    
    /**
     * Metodo que devuelve un subString desde una posicion inicial hasta una posicion final,
     * 
     * @author jjurado
     * @since 27.08.2015
     * @param cadena
     * @param indexInicio
     * @param indexFin
     * @return
     */
    public static String subStr(String cadena, int indexInicio, int indexFin){
       if(isEmpty(cadena)){
          return cadena;
       }
       int posicionFinal = cadena.length() - 1;
       if( posicionFinal < indexInicio){
          return null;
       }
       if(posicionFinal < indexFin){
          return cadena.substring(indexInicio);
       }
       
       return cadena.substring(indexInicio, indexFin);
    }
    
    public static Date sumarDiasAFecha(Date fecha, int dias){
        if (dias==0) return fecha;
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(fecha); 
        calendar.add(Calendar.DAY_OF_YEAR, dias);  
        return calendar.getTime(); 
  }

    public static Date stringToDate(String string, Integer option) {
        SimpleDateFormat formatter = null;
        Date date = null;
        if (option.equals(Constantes.INT_ONE)) {
                        formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        } else if (option.equals(Constantes.INT_TWO)) {
                        formatter = new SimpleDateFormat("dd/MM/yyyy");
        } else if (option.equals(Constantes.INT_THREE)) {
                        formatter = new SimpleDateFormat("HH:mm:ss");
        } else {
            			formatter = new SimpleDateFormat("yyyy-MM-dd");
        }
        try {
                        date = formatter.parse(string);
        } catch (ParseException ex) {
                        ex.printStackTrace();
                        date = null;
        }
        return date;
        
    }
    
    public static String stringToStringyyyyMMdd(String fecha) {
        String dia = fecha.substring(0,2);
        String mes = fecha.substring(3,5);
        String anio = fecha.substring(6,10);
        return anio+"-"+mes+"-"+dia;
    }
    
        
    public static String stringToStringddMMyyyy(String fecha) {
        String dia = fecha.substring(0,2);
        String mes = fecha.substring(3,5);
        String anio = fecha.substring(6,10);
        return dia+"/"+mes+"/"+anio;
    }
    
	public static String dateUtilToStringDDMMYYYY(Date date){
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		int mes = cal.get(Calendar.MONTH) + 1;
		String mesStr="";
		int dia = cal.get(Calendar.DATE);
		String diaStr="";
		if(mes<10){
			mesStr = "0"+mes;
		}else{
			mesStr=""+ mes;
		}
		if(dia<10){
			diaStr = "0"+dia;
		}else{
			diaStr = ""+dia;
		} 
		String formatedDate = diaStr + "/" + (mesStr) + "/" +  cal.get(Calendar.YEAR);
		return formatedDate;
	}
    
    public static String dateUtilToStringhhmm(Date date){
    	
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(date);
    	int minuto = cal.get(Calendar.MINUTE) + 1;
    	String minutoStr = "";
    	if (minuto<10){
    		minutoStr = "0"+ minuto;
    	} else {
    		minutoStr = "" + minuto;
    	}
    	String formatedDate = cal.get(Calendar.HOUR) + ":" + minutoStr;
    	return formatedDate;
    }

    // redondea al nro de decimales establecido sin el problema de la coma flotante/double de Java
    public static BigDecimal roundBigDecimal(double numero, int nroDecimales) {
        return new BigDecimal(numero + "").setScale(nroDecimales, BigDecimal.ROUND_HALF_UP);
    }

    // redondea y retorna double
    public static double round(double numero, int nroDecimales) {
        return roundBigDecimal(numero, nroDecimales).doubleValue();
    }

    // redondea y formatea como cadena
    public static String roundString(double numero, int nroDecimales) {
        return roundBigDecimal(numero, nroDecimales).toString();
    }

}
