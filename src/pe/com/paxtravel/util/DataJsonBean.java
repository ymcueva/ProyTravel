package pe.com.paxtravel.util;

public class DataJsonBean {
    
    // estado de la peticion: ok, error
    private String estado;

    // mensaje en caso de error
    private String msg;

    // data json respuesta de la peticion
    private Object dataJson;

    public void setRespuesta(String estado, String msg, Object dataJson) {
        setEstado(estado);
        setMsg(msg);
        setDataJson(dataJson);
    }

    public void setRespuesta(String estado, String msg) {
        setEstado(estado);
        setMsg(msg);
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        if (estado == null) this.estado = "";
        else this.estado = estado;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        if (msg == null) this.msg = "";
        else this.msg = msg;
    }

    public Object getDataJson() {
        return dataJson;
    }

    public void setDataJson(Object dataJson) {
        this.dataJson = dataJson;
    }
    
}
