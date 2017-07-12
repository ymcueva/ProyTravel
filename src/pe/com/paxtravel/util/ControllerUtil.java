package pe.com.paxtravel.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sojo.interchange.json.JsonSerializer;

//import org.apache.commons.io.IOUtils;
import org.springframework.web.servlet.ModelAndView;

import pe.gob.sunat.framework.spring.util.conversion.SojoUtil;

public class ControllerUtil {

	public static ModelAndView handleJSONResponse(DataJsonBean dataJsonBean, HttpServletResponse response) {

		try {
			response.setContentType("text/plain;charset=utf-8");
			response.setHeader("Cache-Control", "no-cache");

			// String dataJsonString = JSONSerializer.toJSON(dataJsonBean).toString();
			String dataJsonString = SojoUtil.toJson(dataJsonBean);
			PrintWriter writer = response.getWriter();

			if (writer != null) {
				writer.write(dataJsonString);
				// writer.close();
			}

		} catch (Exception sos) {
			// no hay mucho que se pueda hacer aqui
		}
		return null;
	}
	

	public static String handleJSONError(DataJsonBean dataJsonBean, Exception sos) {

		// se recoge el mensaje de error
		String msgError = handleMsgError(sos);

		// se setea el bean json de respuesta con el mensaje de error
		dataJsonBean.setRespuesta("error", msgError, null);

		return msgError;
	}
	
	// recoge null safe toda la data de la excepcion, incluyendo el atribut getCause()
	public static String handleMsgError(Exception e) {

		// seteando el mensaje de error
		String msgError = "" + ((e == null || e instanceof NullPointerException) ? "Null Pointer Exception" : e.getMessage());
		if (e != null && e.getCause() != null) {
			msgError = msgError + ", CAUSA: " + e.getCause().getMessage();
		}

		return msgError;
	}

	@SuppressWarnings("unchecked")
	public static Map<String, Object> parseRequestToMap(HttpServletRequest request) throws ServletException, IOException {
		String dataCadena = IOUtils.toString(request.getInputStream(), "UTF-8");
		
		Map<String, Object> mapaData = (Map<String, Object>) new JsonSerializer().deserialize(dataCadena, Map.class);

		try {

			mapaData = mapaData == null ? new HashMap<String, Object>() : mapaData;

			Map<String, String[]> parameterMap = request.getParameterMap();

			Iterator<String> it = parameterMap.keySet().iterator();

			String key = null;
			while (it.hasNext()) {
				key = it.next();
				if (!mapaData.containsKey(key)) {
					mapaData.put(key, ((String[]) parameterMap.get(key))[0]);
				}
			}
	
		} catch (Exception e) {
			e.getStackTrace();
		}
		return mapaData;
	}
}