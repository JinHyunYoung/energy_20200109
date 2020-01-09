package kr.or.wabis.framework.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.ClientAnchor;
import org.apache.poi.ss.usermodel.ClientAnchor.AnchorType;
import org.apache.poi.ss.usermodel.Drawing;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Picture;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFClientAnchor;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import kr.or.wabis.framework.contants.DateFormatConstant;

public class ExcelUtil {
    
    private static final int CELL_COUNT_MAX = 50;
    
    private static SimpleDateFormat DATE_FORMATTER = new SimpleDateFormat(DateFormatConstant.JAVA_DATE_FORMAT);
    
    /**
     * Write Excel != 엑셀형식 파일을 생성한다. =!
     * 
     * @param fileName
     *            String
     * @param wb
     *            Workbook
     * @throws Exception
     */
    public static void writeExcel(String filename, Workbook wb) throws Exception {
        FileOutputStream fileout = null;
        try {
            fileout = new FileOutputStream(new File(filename));
            wb.write(fileout);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (fileout != null) {
                    fileout.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    
    /**
     * Read Excel != 엑셀파일 읽는다. =!
     * 
     * @param filePath
     *            String
     * @return Workbook
     */
    public static Workbook readExcel(String filePath) throws Exception {
        return readExcel(new FileInputStream(filePath), filePath);
    }
    
    /**
     * Read Excel != 엑셀파일 읽는다 =!
     * 
     * @param is
     * @param filePath
     * @return Workbook
     * @throws Exception
     */
    public static Workbook readExcel(InputStream is, String filePath) throws Exception {
        Workbook wb = null;
        String extension = null;
        try {
            extension = StringUtils.substringAfterLast(filePath, ".");
            
            if (extension.toLowerCase().equals("xls")) {
                wb = new HSSFWorkbook(is);
            } else if (extension.toLowerCase().equals("xlsx")) {
                wb = new XSSFWorkbook(is);
            } else if (extension.toLowerCase().equals("xlsm")) {
                wb = new XSSFWorkbook(is);
            } else {
                throw new Exception(MessageUtil.getMessage("system.00014"));
            }
            
        } catch (Exception e) {
            throw e;
        } finally {
            if (is != null)
                is.close();
        }
        return wb;
    }
    
    /**
     * getSheetNameList != 엑셀 파일의 시트 리스트를 반환한다. =!
     * 
     * @param filePath
     *            String
     * @return String[]
     * @throws Exception
     */
    public static String[] getSheetNameList(String filePath) throws Exception {
        Workbook wb = readExcel(filePath);
        
        Sheet sheet;
        List<String> sheetNameList = new ArrayList<String>();
        for (int sheetNum = 0; sheetNum < wb.getNumberOfSheets(); sheetNum++) {
            sheet = wb.getSheetAt(sheetNum);
            sheetNameList.add(sheet.getSheetName());
        }
        String[] sheetNameStrList = new String[sheetNameList.size()];
        return sheetNameList.toArray(sheetNameStrList);
    }
    
    /**
     * getCellValue != Cell의 값을 반환한다. =!
     * 
     * @param cell
     * @return String
     */
    public static String getCellValue(Cell cell) {
        String value = null;
        
        if (cell != null) {
            
            switch (cell.getCellType()) {
                
                case Cell.CELL_TYPE_NUMERIC:
                    if (HSSFDateUtil.isCellDateFormatted(cell)) {
                        value = DATE_FORMATTER.format(cell.getDateCellValue());
                    } else {
                        value = "" + cell.getNumericCellValue();
//                        value = "" + Math.round(cell.getNumericCellValue());
                    }
                    
                    break;
                case Cell.CELL_TYPE_STRING:
                    value = cell.getRichStringCellValue().getString();
                    break;
                
                case Cell.CELL_TYPE_FORMULA:
                    value = getCellValue(cell.getCachedFormulaResultType(), cell);
                    break;
                
                case Cell.CELL_TYPE_BLANK:
                    value = "";
                    break;
                
                case Cell.CELL_TYPE_BOOLEAN:
                    value = "" + cell.getBooleanCellValue();
                    break;
                
                case Cell.CELL_TYPE_ERROR:
                    value = "" + cell.getErrorCellValue();
                    break;
            }
        }
        return value;
    }
    
    /**
     * getCellValue != Cell의 값을 반환한다. =!
     * 
     * @param cell
     * @return String
     */
    public static String getCellValue(int type, Cell cell) {
        String value = null;
        
        if (cell != null) {
            switch (type) {
                
                case Cell.CELL_TYPE_NUMERIC:
                    if (HSSFDateUtil.isCellDateFormatted(cell)) {
                        value = DATE_FORMATTER.format(cell.getDateCellValue());
                    } else {
                        value = "" + cell.getNumericCellValue();
                    }
                    
                    break;
                case Cell.CELL_TYPE_STRING:
                    value = cell.getRichStringCellValue().getString();
                    break;
                
                case Cell.CELL_TYPE_FORMULA:
                    value = getCellValue(cell.getCachedFormulaResultType(), cell);
                    break;
                
                case Cell.CELL_TYPE_BLANK:
                    value = "";
                    break;
                
                case Cell.CELL_TYPE_BOOLEAN:
                    value = "" + cell.getBooleanCellValue();
                    break;
                
                case Cell.CELL_TYPE_ERROR:
                    value = "" + cell.getErrorCellValue();
                    break;
            }
        }
        return value;
    }
    
    /**
     * getCellStyle != 선택된 row안에 있는 cell 들의 style를 반환한다. =!
     * 
     * @param targetRow
     *            Row
     * @return CellStyle[]
     */
    public static CellStyle[] getCellStyle(Row targetRow) {
        int totalCellCount = targetRow.getPhysicalNumberOfCells();
        Cell targetCell = null;
        CellStyle[] cellStyle = new CellStyle[totalCellCount];
        for (int cellIndex = 0; cellIndex < totalCellCount; cellIndex++) {
            targetCell = targetRow.getCell(cellIndex);
            if (targetCell != null) {
                cellStyle[cellIndex] = targetCell.getCellStyle();
            }
        }
        return cellStyle;
    }
    
    public static Date getCellValueToDate(Cell cell) throws Exception {
        String cellValue = getCellValue(cell);
        if (StringUtil.isEmpty(cellValue)) {
            return null;
        }
        SimpleDateFormat format = new SimpleDateFormat(DateFormatConstant.UI_DATE_FORMAT);
        return format.parse(getCellValue(cell));
    }
    
    public static BigDecimal getCellValueToBigDecimal(Cell cell) throws Exception {
        String cellValue = getCellValue(cell);
        if (StringUtil.isEmpty(cellValue)) {
            return null;
        }
        return new BigDecimal(cellValue);
    }
    
    public static Integer getCellValueToInteger(Cell cell) throws Exception {
        String cellValue = getCellValue(cell);
        if (StringUtil.isEmpty(cellValue)) {
            return null;
        }
        return Integer.parseInt(cellValue);
    }
    
    public static BigInteger getCellValueToBigInteger(Cell cell) throws Exception {
        String cellValue = getCellValue(cell);
        if (StringUtil.isEmpty(cellValue)) {
            return null;
        }
        return new BigInteger(cellValue);
    }
    
    /**
     * createRow != sheet에 row를 생성한다. 생성시에 cellStyle를 적용한다. =!
     * 
     * @param sheet
     *            Sheet
     * @param rowIndex
     *            int
     * @param cellStyle
     *            CellStyle[]
     * @return Row
     */
    public static Row createRow(Sheet sheet, int rowIndex, CellStyle[] cellStyle) {
        Row newRow = sheet.createRow(rowIndex);
        
        for (int cellIndex = 0; cellIndex < cellStyle.length; cellIndex++) {
            newRow.createCell(cellIndex).setCellStyle(cellStyle[cellIndex]);
        }
        
        return newRow;
    }
    
    /**
     * Check Empty Row != 빈 Row 인지 확인한다 =!
     * 
     * @param targetRow
     * @return
     */
    public static boolean isEmptyRow(Row targetRow) {
        try {
            int totalCellCount = (targetRow.getPhysicalNumberOfCells() < CELL_COUNT_MAX) ? targetRow.getPhysicalNumberOfCells() : CELL_COUNT_MAX;
            
            for (int cellIndex = 0; cellIndex < totalCellCount; cellIndex++) {
                String cellValue = ExcelUtil.getCellValue(targetRow.getCell(cellIndex));
                
                if (cellValue == null) {
                    continue;
                }
                
                if (StringUtil.isNotEmpty(cellValue.trim())) {
                    return false;
                }
            }
        } catch (Exception e) {
            return true;
        }
        return true;
    }
    
    /**
     * setCellImage != 이미지 파일을 로딩해서 Cell에 삽입한다. =!
     * 
     * @param workBook
     *            Workbook
     * @param sheet
     *            Sheet
     * @param cell
     *            Cell
     * @param imagePath
     *            String
     * @throws Exception
     */
    public static void setCellImage(Workbook workBook, Sheet sheet, Cell cell, String imagePath) throws Exception {
        
        // 이미지의 크기를 사용하게 되면 주석 풀어서 사용
        // File imageFile = new File(imagePath);
        // Image img = new ImageIcon(imageFile.getAbsolutePath()).getImage();
        // int imgHeight = img.getHeight(null);
        // int imgWidth = img.getWidth(null);
        // sheet.getRow(cell.getRowIndex()).setHeight((short) imgHeight);
        // sheet.setColumnWidth(columnIndex, imgWidth);
        
        /* Add Picture to Workbook, Specify picture type as PNG and Get an Index */
        int picture_id = loadPicture(imagePath, workBook);
        
        /* Create the drawing container */
        Drawing drawing = sheet.createDrawingPatriarch();
        
        /* Create an anchor point */
        ClientAnchor anchor = null;
        if (workBook instanceof XSSFWorkbook) {
            anchor = new XSSFClientAnchor();
        } else if (workBook instanceof HSSFWorkbook) {
            anchor = new HSSFClientAnchor();
        }
        
        /* Define top left corner, and we can resize picture suitable from there */
        
        anchor.setDx1(160);
        anchor.setDy1(12);
        anchor.setDx2(863);
        anchor.setDy2(243);
        anchor.setCol1(cell.getColumnIndex());
        anchor.setRow1(cell.getRowIndex());
        anchor.setCol2(cell.getColumnIndex());
        anchor.setRow2(cell.getRowIndex());
        
        // 0 = Move and size with Cells, 2 = Move but don't size with cells, 3 = Don't move or size with cells.
        anchor.setAnchorType(AnchorType.MOVE_DONT_RESIZE);
        
        /* Invoke createPicture and pass the anchor point and ID */
        Picture picture = drawing.createPicture(anchor, picture_id);
        
        /* Call resize method, which resizes the image */
        picture.resize();
    }
    
    /**
     * getImageFormat != 이미지 파일 종류를 리턴한다. =!
     * 
     * @param filePath
     *            String
     * @return int
     */
    public static int getImageFormat(String filePath) {
        
        String fileExtension = StringUtils.substringAfterLast(filePath, ".");
        
        if (fileExtension.equalsIgnoreCase("png")) {
            return Workbook.PICTURE_TYPE_PNG;
        }
        if (fileExtension.equalsIgnoreCase("jpg") || fileExtension.equalsIgnoreCase("jpeg")) {
            return Workbook.PICTURE_TYPE_JPEG;
        }
        if (fileExtension.equalsIgnoreCase("bmp") || fileExtension.equalsIgnoreCase("ico")) {
            return Workbook.PICTURE_TYPE_DIB;
        }
        return -1;
    }
    
    /**
     * loadPicture != 이미지를 파일에 로딩한다. =!
     * 
     * @param imagePath
     * @param wb
     *            Workbook
     * @return int
     * @throws IOException
     */
    private static int loadPicture(String imagePath, Workbook wb) throws Exception {
        
        byte[] bytes = FileUtils.readFileToByteArray(new File(imagePath));
        
        /* Add Picture to Workbook, Specify picture type as PNG and Get an Index */
        int picture_id = wb.addPicture(bytes, getImageFormat(imagePath));
        
        return picture_id;
    }
    
    /**
     * 
     * @param filePath
     * @param excelFileName
     * @return
     * @throws IOException
     */
    public static List procExcelFile(String filePath, String excelFileName) throws IOException {
        
        List excelContentList = null;
        
        String downfilePath = filePath + File.separator + excelFileName;
        
        if (excelFileName.indexOf(".xlsx") > -1) {
            
            // EXCEL 2007(.xlsx)
            excelContentList = procExtractExcel2007(downfilePath);
            
        } else if (excelFileName.indexOf(".xls") > -1) {
            
            // EXCEL 97~2003(.xls)
            excelContentList = procExtractExcel(downfilePath);
        }
        
        return excelContentList;
    }
    
    /**
     * 
     * @param filePath
     * @param excelFileName
     * @return
     * @throws IOException
     */
    public static List procExcelFile(String filePath, String excelFileName, int idx) throws IOException {
        
        List excelContentList = null;
        
        String downfilePath = filePath + File.separator + excelFileName;
        
        if (excelFileName.indexOf(".xlsx") > -1) {
            
            // EXCEL 2007(.xlsx)
            excelContentList = procExtractExcel2007(downfilePath, idx);
            
        } else if (excelFileName.indexOf(".xls") > -1) {
            
            // EXCEL 97~2003(.xls)
            excelContentList = procExtractExcel(downfilePath);
        }
        
        return excelContentList;
    }    
    /**
     * 
     * @param excelFileName
     * @return
     * @throws IOException
     */
    public static List procExtractExcel2007(String excelFileName) throws IOException {
        
        // SET LOCAL VALUE
        List excelContentList = new ArrayList();
        File file = new File(excelFileName);
        
        // VALIDATE FILE
        if (!file.exists() || !file.isFile() || !file.canRead()) {
            throw new IOException(excelFileName);
        }
        
        try {
            XSSFWorkbook wb = new XSSFWorkbook(new FileInputStream(file));
            int listCount = 0;
            ArrayList list = null;
            for (int i = 0; i < wb.getNumberOfSheets(); i++) {
                int cellCnt = 0, cellIdx = 0;
                for (Row row : wb.getSheetAt(i)) {
                    if (listCount > 0)
                        list = new ArrayList(cellCnt);
                    cellIdx = 0;
                    for (Cell cell : row) {
                        if (listCount == 0) {
                            cellCnt++;
                        } else {
                            if (cellIdx < cellCnt) {
                                list.add(getCellValue(cell));
                            }
                            cellIdx++;
                        }
                    }
                    if (listCount > 0 && cellIdx < cellCnt - 1) {
                        for (int j = cellIdx; j < cellCnt; j++)
                            list.add("");
                    }
                    if (listCount > 0)
                        excelContentList.add(list);
                    listCount++;
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
        return excelContentList;
    }
    
    /**
     * 
     * @param excelFileName
     * @return
     * @throws IOException
     */
    public static List procExtractExcel2007(String excelFileName, int idx) throws IOException {
        
        // SET LOCAL VALUE
        List excelContentList = new ArrayList();
        File file = new File(excelFileName);
        
        // VALIDATE FILE
        if (!file.exists() || !file.isFile() || !file.canRead()) {
            throw new IOException(excelFileName);
        }
        
        try {
            XSSFWorkbook wb = new XSSFWorkbook(new FileInputStream(file));
            ArrayList list = null;
            int totalRows = wb.getSheetAt(idx).getLastRowNum() + 1;//Total Row
            for (Row row : wb.getSheetAt(idx)) {
                list = new ArrayList(totalRows);
                for (Cell cell : row) {
                    list.add(getCellValue(cell));
                }
                excelContentList.add(list);

            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
        return excelContentList;
    }
    /**
     * 엑셀업로드 후 데이터 추출 EXCEL 97~2003(*.xls)
     * 
     * @REX
     */
    public static List procExtractExcel(String excelFileName) throws IOException {
        
        // SET LOCAL VALUE
        List excelContentList = new ArrayList();
        File file = new File(excelFileName);
        
        // VALIDATE FILE
        if (!file.exists() || !file.isFile() || !file.canRead()) {
            throw new IOException(excelFileName);
        }
        
        try {
            HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(file));
            int listCount = 0;
            int cellMax = 0;
            for (int i = 0; i < wb.getNumberOfSheets(); i++) {
                int cellCnt = 0, cellIdx = 0;
                ArrayList list = null;
                for (Row row : wb.getSheetAt(i)) {
                    if (listCount > 0)
                        list = new ArrayList(cellCnt);
                    
                    cellIdx = 0;
                    
                    if (listCount == 0) {
                        for (Cell cell : row) {
                            cellCnt++;
                        }
                    } else {
                        for (int z = 0; z < cellCnt; z++) {
                            if (cellIdx < cellCnt) {
                                Cell cell = row.getCell(z);
                                list.add(getCellValue(cell));
                            }
                            
                            cellIdx++;
                        }
                    }
                    
                    if (listCount > 0 && cellIdx < cellCnt - 1) {
                        for (int j = cellIdx; j < cellCnt; j++)
                            list.add("");
                    }
                    
                    if (listCount > 0)
                        excelContentList.add(list);
                    
                    listCount++;
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
        return excelContentList;
    }
    /**
     * 엑셀업로드 후 데이터 추출 EXCEL 97~2003(*.xls)
     * 
     * @REX
     */
    public static List procExtractExcel(String excelFileName, int idx) throws IOException {
        
        // SET LOCAL VALUE
        List excelContentList = new ArrayList();
        File file = new File(excelFileName);
        
        // VALIDATE FILE
        if (!file.exists() || !file.isFile() || !file.canRead()) {
            throw new IOException(excelFileName);
        }
        
        try {
            HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(file));
            int listCount = 0;
            int cellMax = 0;
                int cellCnt = 0, cellIdx = 0;
                ArrayList list = null;
                for (Row row : wb.getSheetAt(idx)) {
                    if (listCount > 0)
                        list = new ArrayList(cellCnt);
                    
                    cellIdx = 0;
                    
                    if (listCount == 0) {
                        for (Cell cell : row) {
                            cellCnt++;
                        }
                    } else {
                        for (int z = 0; z < cellCnt; z++) {
                            if (cellIdx < cellCnt) {
                                Cell cell = row.getCell(z);
                                list.add(getCellValue(cell));
                            }
                            
                            cellIdx++;
                        }
                    }
                    
                    if (listCount > 0 && cellIdx < cellCnt - 1) {
                        for (int j = cellIdx; j < cellCnt; j++)
                            list.add("");
                    }
                    
                    if (listCount > 0)
                        excelContentList.add(list);
                    
                    listCount++;
                }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
        return excelContentList;
    }
    /**
     * 엑셀 헤더 셀의 공통 스타일 설정 함수
     * 
     * @param workbook
     *            : 엑셀 Workbook
     * @return CellStyle
     */
    public final static CellStyle genericHeaderCellStyle(Workbook workbook) {
        CellStyle style = workbook.createCellStyle();
        
        // 정렬
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        
        // 라인
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBottomBorderColor(HSSFColor.BLACK.index);
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setLeftBorderColor(HSSFColor.BLACK.index);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setRightBorderColor(HSSFColor.BLACK.index);
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setTopBorderColor(HSSFColor.BLACK.index);
        
        // 백그라운드 색상
        style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        
        // 폰트
        /*
         * Font font = workbook.createFont(); //font.setFontName(HSSFFont.FONT_ARIAL); font.setFontHeightInPoints((short) 10); font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); //font.setColor(HSSFColor.BLACK.index); style.setFont(font);
         */
        
        return style;
    }
    
    /**
     * 엑셀 데이타 셀의 공통 스타일 설정 함수
     * 
     * @param workbook
     *            : 엑셀 Workbook
     * @return CellStyle
     */
    public final static CellStyle genericDataCellStyle(Workbook workbook) {
        CellStyle style = workbook.createCellStyle();
        
        // 정렬
        style.setAlignment(HorizontalAlignment.LEFT);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        
        // 라인
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBottomBorderColor(HSSFColor.BLACK.index);
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setLeftBorderColor(HSSFColor.BLACK.index);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setRightBorderColor(HSSFColor.BLACK.index);
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setTopBorderColor(HSSFColor.BLACK.index);
        
        return style;
    }
    
    /**
     * 셀의 데이타를 유형에 맞게 읽기위한 함수
     * 
     * @param cell
     *            : 엑셀 Cell
     * @return Object
     */
    public final static Object getCellData(Cell cell) {
        Object cellData = null;
        
        switch (cell.getCellType()) {
            
            case Cell.CELL_TYPE_STRING:
                cellData = cell.getStringCellValue();
                break;
            
            case Cell.CELL_TYPE_NUMERIC:
                /*
                 * if( DateUtil.isCellDateFormatted(cell) ) cellData = cell.getDateCellValue(); else cellData = cell.getNumericCellValue();
                 */
                break;
            
            case Cell.CELL_TYPE_FORMULA:
                cellData = cell.getCellFormula();
                break;
            
            case Cell.CELL_TYPE_BOOLEAN:
                cellData = cell.getBooleanCellValue();
                break;
            
            case Cell.CELL_TYPE_ERROR:
                cellData = cell.getErrorCellValue();
                break;
            
            case Cell.CELL_TYPE_BLANK:
                cellData = "";
                break;
            
            default:
                break;
            
        }
        
        return cellData;
    }
    
    /**
     * 
     * @param cell
     * @return
     */
    public static String getExcelCellString(Cell cell) {
        String value = "";
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
        if (cell != null) {
            switch (cell.getCellType()) {
                case HSSFCell.CELL_TYPE_FORMULA:
                    value = cell.getCellFormula();
                    break;
                
                case HSSFCell.CELL_TYPE_NUMERIC:
                    if (HSSFDateUtil.isCellDateFormatted(cell)) {
                        value = sdf.format(cell.getDateCellValue());
                    } else {
                        value = Long.toString((long) cell.getNumericCellValue());
                    }
                    
                    break;
                
                case HSSFCell.CELL_TYPE_STRING:
                    value = "" + cell.getStringCellValue();
                    break;
                
                case HSSFCell.CELL_TYPE_BLANK:
                    value = "" + cell.getStringCellValue();
                    break;
                
                case HSSFCell.CELL_TYPE_BOOLEAN:
                    value = "" + cell.getBooleanCellValue();
                    break;
                
                case HSSFCell.CELL_TYPE_ERROR:
                    break;
            }
        }
        return value;
    }
}
