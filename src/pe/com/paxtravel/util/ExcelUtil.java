package pe.com.paxtravel.util;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.Region;

/**
 * @author JcFR
 * Esta clase sirve como utilitario para generar documentos EXCEL utilizando la libreria POI (se está utilizando la versión POI que 
 * ofrece sunat en su ear tecnología terceros), el flujo de salida puede ser un  fichero en disco o el flujo de salida del servlet para 
 * que el usuario lo descargue directamente del browser.
 * Contiene estilos por default para cada celda _styleXXX, pero si se desea personalizar se pueden crear estilos propios
 * y pasarlos como argumentos al metodo xlsCell() que escribe una celda en el excel.
 */

@SuppressWarnings("deprecation")
public class ExcelUtil {

	// FUNCIONALIDAD PARA EXPORTAR A EXCEL
	private boolean _seContruyeronEstilos;
	protected HSSFWorkbook _wbLibro;
	protected HSSFSheet _hoja;
	protected HSSFRow _row;
	protected short _posRow;
	protected HSSFCellStyle _styleNormal;
	protected HSSFCellStyle _styleNegrita;

	protected HSSFCellStyle _styleNormalCenter;
	protected HSSFCellStyle _styleNegritaCenter;

	protected HSSFCellStyle _styleNormalDerecha;
	protected HSSFCellStyle _styleNegritaDerecha;

	protected HSSFCellStyle _styleTotal;
	protected HSSFCellStyle _styleTotalRight;
	protected HSSFCellStyle _styleTotalCenter;
	protected HSSFCellStyle _styleCabecera;
	protected HSSFCellStyle _styleTitulo;
	protected HSSFCellStyle _styleTituloGeneral;
	protected HSSFCellStyle _styleBloque;
	protected HSSFCellStyle _styleBloqueItem;
	protected HSSFCellStyle _style2Digits;
	protected HSSFCellStyle _style2DigitsTotal;
	protected HSSFCellStyle _style3Digits;
	protected HSSFCellStyle _style3DigitsTotal;

	protected HSSFCellStyle _styleDate;
	protected HSSFCellStyle _styleDatetime;

	// ATRIBUTOS ESPECIALES
	private String _tituloGeneral;
	private int _tituloGeneralNroCeldas;

	public ExcelUtil() {
		_seContruyeronEstilos = false;
	}

	// METODOS QUE PUEDEN LLAMARSE ANTES DE CREAR LA HOJA
	public void xlsMakeTituloGeneral(String tituloGeneral, int nroCeldas) {
		this._tituloGeneral = tituloGeneral;
		this._tituloGeneralNroCeldas = nroCeldas;
	}

	public HSSFWorkbook xlsGetWbLibro() {
		return _wbLibro;
	}

	public HSSFSheet xlsGetHoja() {
		return _hoja;
	}

	public void xlsGetHoja(HSSFSheet hoja) {
		this._hoja = hoja;
	}

	protected void xlsMakeHoja(String nombreSheet) {
		_hoja = _wbLibro.createSheet(StringUtils.isBlank(nombreSheet) ? "hoja" : StringUtils.trimToEmpty(nombreSheet));
		_posRow = 0;
	}

	public void xlsInitLibro(String nombreSheet) {
		xlsInitLibro(nombreSheet, (List<String>) null, null, 0);
	}

	public void xlsInitLibro(String nombreSheet, String columnasTabla) {
		xlsInitLibro(nombreSheet, columnasTabla, null, 0);
	}

	public void xlsInitLibro(String nombreSheet, List<String> columnasTabla) {
		xlsInitLibro(nombreSheet, columnasTabla, null, 0);
	}

	public void xlsInitLibro(String nombreSheet, String columnasTabla, List<String> itemsCabecera, int joinItemsCabecera) {

		if (StringUtils.isBlank(columnasTabla)) {
			xlsInitLibro(nombreSheet, new ArrayList<String>(), itemsCabecera, joinItemsCabecera);
			return;
		}

		String split[] = StringUtils.trimToEmpty(columnasTabla).split(",");
		List<String> itemsCabeceraTabla = new ArrayList<String>(split == null ? 10 : split.length);
		for (int i = 0; i < split.length; i++) {
			itemsCabeceraTabla.add(StringUtils.trimToEmpty(split[i]));
		}

		xlsInitLibro(nombreSheet, itemsCabeceraTabla, itemsCabecera, joinItemsCabecera);
	}

	public void xlsInitLibro(String nombreSheet, List<String> columnasTabla, List<String> itemsCabecera, int joinItemsCabecera) {

		if (_wbLibro == null) _wbLibro = new HSSFWorkbook();

		_hoja = _wbLibro.createSheet(StringUtils.isBlank(nombreSheet) ? "hoja" : StringUtils.trimToEmpty(nombreSheet));

		_posRow = 0;

		if (!_seContruyeronEstilos) {
			construirEstilos();
			_seContruyeronEstilos = true;
		}

		if (!StringUtils.isBlank(_tituloGeneral)) {
			xlsRow();
			xlsCell(1, _tituloGeneral, getStyleTituloGeneral());
			xlsJoinColumns(1, Math.max(1, _tituloGeneralNroCeldas));
		}

		// AGREGANDO LOS ITEMS DEL TITULO
		xlsMakeItemsCabecera(itemsCabecera, joinItemsCabecera);

		// AGREGANDO LOS ITEMS EN LAS CABECERA DE LA TABLA
		xlsMakeItemsCabeceraTabla(columnasTabla);

	}

	protected void xlsMakeItemsCabecera(List<String> columnasTabla, int joinItemsCabecera) {
		if (CollectionUtils.isNotEmpty(columnasTabla)) {
			xlsRow();
			HSSFCellStyle estilo = getStyleTitulo();
			int joinSize = Math.max(2, joinItemsCabecera);
			for (String item : columnasTabla) {
				xlsRow();
				xlsCell(1, item, estilo);
				xlsJoinColumns(1, joinSize);
			}
			xlsRow();
		}
	}

	protected void xlsMakeItemsCabeceraTabla(List<String> columnasTabla) {
		if (CollectionUtils.isNotEmpty(columnasTabla)) {
			xlsRow();
			HSSFCellStyle estilo = getStyleCabecera();
			int size = columnasTabla.size();
			for (int c = 1; c <= size; c++) {
				xlsCell(c, columnasTabla.get(c - 1), estilo);
			}
		}
	}

	protected void xlsMakeItemsCabeceraTabla(String columnasTabla) {
		if (StringUtils.isBlank(columnasTabla)) return;

		String split[] = StringUtils.trimToEmpty(columnasTabla).split(",");
		List<String> itemsCabeceraTabla = new ArrayList<String>(split == null ? 10 : split.length);
		for (int i = 0; i < split.length; i++) {
			itemsCabeceraTabla.add(StringUtils.trimToEmpty(split[i]));
		}

		xlsMakeItemsCabeceraTabla(itemsCabeceraTabla);
	}

	// estilos y bordes
	protected HSSFCellStyle xlsMakeStyleNormal(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// ESTILO GENERAL, NORMAL PARA TODAS LAS CELDAS
		HSSFCellStyle style = _wbLibro.createCellStyle();
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setFontName("Arial");
		font.setColor(HSSFColor.DARK_BLUE.index);
		style.setFont(font);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyleNegrita(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// ESTILO GENERAL, NORMAL PARA TODAS LAS CELDAS
		HSSFCellStyle style = _wbLibro.createCellStyle();
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setFontName("Arial");
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setColor(HSSFColor.DARK_BLUE.index);
		style.setFont(font);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyleNormalCenter(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// CREANDO ESTILO CENTRADA
		HSSFCellStyle style = _wbLibro.createCellStyle();
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setFontName("Arial");
		font.setColor(HSSFColor.DARK_BLUE.index);
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyleNormalDerecha(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// CREANDO ESTILO DERECHA
		HSSFCellStyle style = _wbLibro.createCellStyle();
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setFontName("Arial");
		font.setColor(HSSFColor.DARK_BLUE.index);
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyleNegritaCenter(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// CREANDO ESTILO CENTRADA
		HSSFCellStyle style = _wbLibro.createCellStyle();
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setFontName("Arial");
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setColor(HSSFColor.DARK_BLUE.index);
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyleNegritaDerecha(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// CREANDO ESTILO DERECHA
		HSSFCellStyle style = _wbLibro.createCellStyle();
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setFontName("Arial");
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setColor(HSSFColor.DARK_BLUE.index);
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyleTotal(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// ESTILO PARA EL TEXTO EN EL TOTALIZADO
		HSSFCellStyle style = _wbLibro.createCellStyle();
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setFontName("Arial");
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setColor(HSSFColor.GREY_80_PERCENT.index);
		style.setFont(font);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyleTotalRight(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// ESTILO PARA EL TEXTO EN EL TOTALIZADO DERECHA
		HSSFCellStyle style = _wbLibro.createCellStyle();
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setFontName("Arial");
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setColor(HSSFColor.GREY_80_PERCENT.index);
		style.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		style.setFont(font);

		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyleTotalCenter(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// ESTILO PARA EL TEXTO EN EL TOTALIZADO CENTRADO
		HSSFCellStyle style = _wbLibro.createCellStyle();
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setFontName("Arial");
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setColor(HSSFColor.GREY_80_PERCENT.index);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setFont(font);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyle2Digits(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// ESTILO PARA LOS NUMEROS REDONDEADOS A 2 DIGITOS
		HSSFCellStyle style = _wbLibro.createCellStyle();
		style.setDataFormat(_wbLibro.createDataFormat().getFormat("0.00"));
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setFontName("Arial");
		font.setColor(HSSFColor.DARK_BLUE.index);
		style.setFont(font);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyle2DigitsTotal(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// ESTILO PARA LOS NUMEROS REDONDEADOS A 2 DIGITOS QUE TOTALIAZN
		HSSFCellStyle style = _wbLibro.createCellStyle();
		style.setDataFormat(_wbLibro.createDataFormat().getFormat("0.00"));
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("Arial");
		font.setColor(HSSFColor.GREY_80_PERCENT.index);
		style.setFont(font);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyle3Digits(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// ESTILO PARA LOS NUMEROS REDONDEADOS A 3 DIGITOS
		HSSFCellStyle style = _wbLibro.createCellStyle();
		style.setDataFormat(_wbLibro.createDataFormat().getFormat("0.000"));
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setFontName("Arial");
		font.setColor(HSSFColor.DARK_BLUE.index);
		style.setFont(font);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyle3DigitsTotal(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// ESTILO PARA LOS NUMEROS REDONDEADOS A 3 DIGITOS QUE TOTALIAZN
		HSSFCellStyle style = _wbLibro.createCellStyle();
		style.setDataFormat(_wbLibro.createDataFormat().getFormat("0.000"));
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("Arial");
		font.setColor(HSSFColor.GREY_80_PERCENT.index);
		style.setFont(font);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyleNroDigits(int nroDigits, boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// ESTILO PARA LOS NUMEROS REDONDEADOS A 3 DIGITOS
		HSSFCellStyle style = _wbLibro.createCellStyle();
		style.setDataFormat(_wbLibro.createDataFormat().getFormat("0." + REPLICATE('0', nroDigits)));
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setFontName("Arial");
		font.setColor(HSSFColor.DARK_BLUE.index);
		style.setFont(font);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyleNroDigitsTotal(int nroDigits, boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// ESTILO PARA LOS NUMEROS REDONDEADOS A 3 DIGITOS QUE TOTALIAZN
		HSSFCellStyle style = _wbLibro.createCellStyle();
		style.setDataFormat(_wbLibro.createDataFormat().getFormat("0." + REPLICATE('0', nroDigits)));
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("Arial");
		font.setColor(HSSFColor.GREY_80_PERCENT.index);
		style.setFont(font);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyleTitulo(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// ESTILO PARA EL TEXTO QUE APARECE EN EL TITULO
		HSSFCellStyle style = _wbLibro.createCellStyle();
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 11);
		font.setFontName("Arial");
		font.setColor(HSSFColor.DARK_GREEN.index);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		style.setFont(font);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyleTituloGeneral(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// ESTILO PARA EL TEXTO QUE APARECE EN EL TITULO UNICO
		HSSFCellStyle style = _wbLibro.createCellStyle();
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 13);
		font.setFontName("Arial");
		font.setColor(HSSFColor.GREY_80_PERCENT.index);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setFont(font);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyleBloque(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// ESTILO PARA EL TEXTO QUE APARECE EN EL TITULO DE BLOQUE
		HSSFCellStyle style = _wbLibro.createCellStyle();
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 10);
		font.setFontName("Arial");
		font.setColor(HSSFColor.DARK_GREEN.index);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		style.setFont(font);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyleBloqueItem(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// ESTILO PARA EL TEXTO QUE APARECE EN EL TITULO DE BLOQUE, PERO EL ITEM, NO LA CABECERA
		HSSFCellStyle style = _wbLibro.createCellStyle();
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 10);
		font.setFontName("Arial");
		font.setColor(HSSFColor.DARK_GREEN.index);
		style.setFont(font);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyleCabecera(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// ESTILO PARA EL TEXTO DE LA CABECERA DE LA TABLA
		HSSFCellStyle style = _wbLibro.createCellStyle();
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setFontName("Arial");
		font.setColor(HSSFColor.GREY_80_PERCENT.index);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyleDate(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// ESTILO PARA LAS FECHAS
		HSSFCellStyle style = _wbLibro.createCellStyle();
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setFontName("Arial");
		font.setColor(HSSFColor.DARK_BLUE.index);
		style.setFont(font);
		HSSFDataFormat format = _wbLibro.createDataFormat();
		style.setDataFormat(format.getFormat("dd/mm/yyyy"));
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	protected HSSFCellStyle xlsMakeStyleDatetime(boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		// ESTILO PARA LAS FECHAS
		HSSFCellStyle style = _wbLibro.createCellStyle();
		HSSFFont font = _wbLibro.createFont();
		font.setFontHeightInPoints((short) 9);
		font.setFontName("Arial");
		font.setColor(HSSFColor.DARK_BLUE.index);
		style.setFont(font);
		HSSFDataFormat format = _wbLibro.createDataFormat();
		style.setDataFormat(format.getFormat("dd/mm/yyyy hh:mm:ss AM/PM"));
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		construirBordesStyle(style, arriba, derecha, abajo, izquierda);
		return style;
	}

	private void construirEstilos() {
		_styleNormal = xlsMakeStyleNormal(false, false, false, false);
		_styleNegrita = xlsMakeStyleNegrita(false, false, false, false);

		_styleNormalCenter = xlsMakeStyleNormalCenter(false, false, false, false);
		_styleNegritaCenter = xlsMakeStyleNegritaCenter(false, false, false, false);

		_styleNormalDerecha = xlsMakeStyleNormalDerecha(false, false, false, false);
		_styleNegritaDerecha = xlsMakeStyleNegritaDerecha(false, false, false, false);

		_styleTotal = xlsMakeStyleTotal(false, false, false, false);
		_styleTotalRight = xlsMakeStyleTotalRight(false, false, false, false);
		_styleTotalCenter = xlsMakeStyleTotalCenter(false, false, false, false);
		_style2Digits = xlsMakeStyle2Digits(false, false, false, false);
		_style2DigitsTotal = xlsMakeStyle2DigitsTotal(false, false, false, false);
		_style3Digits = xlsMakeStyle3Digits(false, false, false, false);
		_style3DigitsTotal = xlsMakeStyle3DigitsTotal(false, false, false, false);
		_styleTitulo = xlsMakeStyleTitulo(false, false, false, false);
		_styleTituloGeneral = xlsMakeStyleTituloGeneral(false, false, false, false);
		_styleBloque = xlsMakeStyleBloque(false, false, false, false);
		_styleBloqueItem = xlsMakeStyleBloqueItem(false, false, false, false);
		_styleCabecera = xlsMakeStyleCabecera(false, false, false, false);
		_styleDate = xlsMakeStyleDate(false, false, false, false);
		_styleDatetime = xlsMakeStyleDatetime(false, false, false, false);
	}

	private void construirBordesStyle(HSSFCellStyle style, boolean arriba, boolean derecha, boolean abajo, boolean izquierda) {
		if (arriba) {
			style.setTopBorderColor(HSSFColor.GREY_80_PERCENT.index);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		}
		if (derecha) {
			style.setRightBorderColor(HSSFColor.GREY_80_PERCENT.index);
			style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		}
		if (abajo) {
			style.setBottomBorderColor(HSSFColor.GREY_80_PERCENT.index);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		}
		if (izquierda) {
			style.setLeftBorderColor(HSSFColor.GREY_80_PERCENT.index);
			style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		}
	}

	// METODOS DE BLOQUE
	public void xlsBloque(String columnasTablaBloque, List<String> itemsCabeceraBloque, int joinItemsCabeceraBloque) {
		if (StringUtils.isBlank(columnasTablaBloque)) {
			xlsBloque((List<String>) null, itemsCabeceraBloque, joinItemsCabeceraBloque);
			return;
		}

		String split[] = StringUtils.trimToEmpty(columnasTablaBloque).split(",");
		List<String> itemsCabeceraTabla = new ArrayList<String>(split == null ? 10 : split.length);
		for (int i = 0; i < split.length; i++) {
			itemsCabeceraTabla.add(StringUtils.trimToEmpty(split[i]));
		}

		xlsBloque(itemsCabeceraTabla, itemsCabeceraBloque, joinItemsCabeceraBloque);
	}

	public void xlsBloque(List<String> columnasTablaBloque, List<String> itemsCabeceraBloque, int joinItemsCabeceraBloque) {

		xlsRow();

		// AGREGANDO LOS ITEMS DEL TITULO
		if (CollectionUtils.isNotEmpty(itemsCabeceraBloque)) {
			HSSFCellStyle estilo = getStyleBloque();
			int joinSize = Math.max(2, joinItemsCabeceraBloque);
			for (String item : itemsCabeceraBloque) {
				xlsRow();
				xlsCell(1, item, estilo);
				xlsJoinColumns(1, joinSize);
			}
		}

		xlsRow();

		// AGREGANDO LOS ITEMS EN LAS CABECERA DE LA TABLA
		if (CollectionUtils.isNotEmpty(columnasTablaBloque)) {
			HSSFCellStyle estilo = getStyleCabecera();
			int size = columnasTablaBloque.size();
			for (int c = 1; c <= size; c++) {
				xlsCell(c, columnasTablaBloque.get(c - 1), estilo);
			}
		}

	}

	//
	protected Object[] xlsItemEnCelda(Object... celdas) {
		if (celdas == null || celdas.length == 0) return new Object[] { "", "" };
		Object[] itemsBloque = new Object[celdas.length];
		System.arraycopy(celdas, 0, itemsBloque, 0, celdas.length);
		return itemsBloque;

	}

	protected void xlsJoinColumns(int columna1, int columna2) {
		_hoja.addMergedRegion(new Region(_posRow, (short) columna1, _posRow, (short) columna2));
	}

	public void xlsRow() {
		_posRow++;
		_row = _hoja.createRow(_posRow);
	}

	protected void xlsColumnWidth(int columna, int size) {
		_hoja.setColumnWidth((short) columna, (short) (256 * size));
	}

	// NUMEROS
	public void xlsCell(int columna, double valor) {
		HSSFCell cell = _row.createCell((short) columna);
		cell.setCellValue(valor);
		cell.setCellStyle(_styleNormal);
	}

	public void xlsCell(int columna, double valor, HSSFCellStyle nuevoEstilo) {
		HSSFCell cell = _row.createCell((short) columna);
		cell.setCellValue(valor);
		cell.setCellStyle(nuevoEstilo);
	}

	public void xlsCell(int columna, Double valor) {
		if (valor == null) {
			xlsCellNull(columna);
		} else {
			xlsCell(columna, valor.doubleValue());
		}
	}

	public void xlsCell(int columna, Double valor, HSSFCellStyle nuevoEstilo) {

		if (valor == null) {
			xlsCellNull(columna);
		} else {
			xlsCell(columna, valor.doubleValue(), nuevoEstilo);
		}

	}

	public void xlsCell(int columna, String valor) {
		HSSFCell cell = _row.createCell((short) columna);
		cell.setCellValue(new HSSFRichTextString(valor == null ? " " : valor));
		cell.setCellStyle(_styleNormal);
	}

	public void xlsCell(int columna, String valor, HSSFCellStyle nuevoEstilo) {
		HSSFCell cell = _row.createCell((short) columna);
		cell.setCellValue(new HSSFRichTextString(valor == null ? " " : valor));
		cell.setCellStyle(nuevoEstilo);
	}

	public void xlsCellNull(int columna) {
		HSSFCell cell = _row.createCell((short) columna);
		cell.setCellValue((String) null);
		cell.setCellStyle(_styleNormal);
	}

	public void xlsCell(int columna, Date valor) {
		HSSFCell cell = _row.createCell((short) columna);
		if (valor != null) cell.setCellValue(valor);
		cell.setCellStyle(_styleDate);
	}

	public void xlsCell(int columna, Date valor, HSSFCellStyle nuevoEstilo) {
		HSSFCell cell = _row.createCell((short) columna);
		if (valor != null) cell.setCellValue(valor);
		cell.setCellStyle(nuevoEstilo);
	}

	private String REPLICATE(char valor, int nroVeces) {
		if (nroVeces <= 0) return "";
		StringBuilder s = new StringBuilder(nroVeces);
		for (int i = nroVeces; --i >= 0;) {
			s.append(valor);
		}
		return s.toString();
	}

	// accesadores a los estilos
	public HSSFCellStyle getStyleNormal() {
		return _styleNormal;
	}

	public HSSFCellStyle getStyleNegrita() {
		return _styleNegrita;
	}

	public HSSFCellStyle getStyleNormalCenter() {
		return _styleNormalCenter;
	}

	public HSSFCellStyle getStyleNegritaCenter() {
		return _styleNegritaCenter;
	}

	public HSSFCellStyle getStyleNormalDerecha() {
		return _styleNormalDerecha;
	}

	public HSSFCellStyle getStyleNegritaDerecha() {
		return _styleNegritaDerecha;
	}

	public HSSFCellStyle getStyleTotal() {
		return _styleTotal;
	}

	public HSSFCellStyle getStyleTotalRight() {
		return _styleTotalRight;
	}

	public HSSFCellStyle getStyleTotalCenter() {
		return _styleTotalCenter;
	}

	public HSSFCellStyle getStyleCabecera() {
		return _styleCabecera;
	}

	public HSSFCellStyle getStyleTitulo() {
		return _styleTitulo;
	}

	public HSSFCellStyle getStyleTituloGeneral() {
		return _styleTituloGeneral;
	}

	public HSSFCellStyle getStyleBloque() {
		return _styleBloque;
	}

	public HSSFCellStyle getStyleBloqueItem() {
		return _styleBloqueItem;
	}

	public HSSFCellStyle getStyle2Digits() {
		return _style2Digits;
	}

	public HSSFCellStyle getStyle2DigitsTotal() {
		return _style2DigitsTotal;
	}

	public HSSFCellStyle getStyle3Digits() {
		return _style3Digits;
	}

	public HSSFCellStyle getStyle3DigitsTotal() {
		return _style3DigitsTotal;
	}

	public HSSFCellStyle getStyleDate() {
		return _styleDate;
	}

	public HSSFCellStyle getStyleDatetime() {
		return _styleDatetime;
	}

}
