package kr.or.wabis.framework.web.view;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

import kr.or.wabis.framework.util.ExcelUtil;


@Component("excelDownView")
public class ExcelDownView extends AbstractView {
	
	 private static final int DEFAULT_BUF_SIZE = 65536;
	 private static final int MAX_COLUMN_WIDTH= 255*256;
	
	 private Logger logger = LoggerFactory.getLogger(ExcelDownView.class);    
	
    @Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {    	
    	
    	String excelName = (String)model.get( "excelName" ) + ".xls";
        String sheetName = (String)model.get( "sheetName" );
        
        logger.debug("excelName : " + excelName + ", sheetName : " + sheetName);
        
        List<String[]> headerMap = (List<String[]>)model.get( "headerMap" );
        List<CellRangeAddress> mergeMap = (List<CellRangeAddress>)model.get( "mergeMap" );        
        String[] columnMap = (String[])model.get( "columnMap" );
        short[] alignMap = (short[])model.get( "alignMap" );
        List<Map<String,Object>> dataMap = (List)model.get( "dataMap" );
        
    	HSSFWorkbook workbook = new HSSFWorkbook();               
        HSSFSheet sheet = workbook.createSheet();       
        HSSFCellStyle headerCellStyle = (HSSFCellStyle)ExcelUtil.genericHeaderCellStyle( workbook );
        CellStyle dataCellStyle = ExcelUtil.genericDataCellStyle( workbook );
   
        workbook.setSheetName( 0 , sheetName );
        createHeader( sheet , headerMap , headerCellStyle );
        createData(  workbook, sheet , columnMap , dataMap , alignMap , dataCellStyle , ( headerMap == null || headerMap.size() == 0 ) ? 1 : headerMap.size() );
        createMerge( sheet , mergeMap );
        autoSizeColumns( sheet );
                        
        File excelFile = new File( excelName );
        excelFile.createNewFile(); 
        FileOutputStream fos = new FileOutputStream( excelFile , false );
        
        workbook.write(fos);        
        
        if( excelFile == null || ! excelFile.canRead() ){
            throw new FileNotFoundException( "File not found" );
        } 
        
        setDisposition( excelName , request, response);
        
        response.setContentType( "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" );
        response.setHeader( "Content-Transfer-Encoding", "binary" );
        response.setHeader( "Cache-Control", "no-cache, must-revalidate" );
        response.setHeader( "Pragma" , "no-cache" );
        response.setHeader( "Expires" , "0" );
        
        long seek_start = 0L;
        byte abyte0[] = null;
        
        String seek_range = request.getHeader("Range");
        
        
        if (seek_range != null) {
            
            long l1 = 0L;
            int i1 = seek_range.indexOf('=') + 1;
            int j1 = seek_range.indexOf('-');
            String s8 = seek_range.substring(i1, j1);
            seek_start = Long.parseLong(s8);
            l1 = excelFile.length() - seek_start;
            
            if (l1 < 0L) {
                l1 = 0L;
            }
            
            response.setHeader("Content-Range", Long.toString(seek_start) + "-" + (l1 - 1L) + "/" + excelFile.length());
            response.setContentLength((int) l1);
            
        } else {
            response.setContentLength((int) excelFile.length());
        }        
        
        abyte0 = new byte[DEFAULT_BUF_SIZE];
        RandomAccessFile randomAccessFile = new RandomAccessFile(excelFile, "r");
        if (seek_range != null) {
            randomAccessFile.seek(seek_start);
        }
        
        ServletOutputStream servletUutputStream = response.getOutputStream();
        
        int j = 0;
        try {
            
            int i = 0;
            while ((i = randomAccessFile.read(abyte0, 0, DEFAULT_BUF_SIZE)) != -1) {
                servletUutputStream.write(abyte0, 0, i);
                servletUutputStream.flush();
                j += i;
            }
            
        } finally {
            
            if (randomAccessFile != null) {
                try {
                    randomAccessFile.close();
                } catch (Exception ignore) {
                }
            }
            
            if (servletUutputStream != null) {
                try {
                    servletUutputStream.close();
                } catch (Exception ignore) {
                }
            }
            
            randomAccessFile = null;
            servletUutputStream = null;            
        }
        
        fos.close();
        
    }
    
    private void createMerge( Sheet sheet , List<CellRangeAddress> mergeMap ){
    	
    	if( mergeMap == null || mergeMap.size() == 0 ) return;
    	
    	for( int i = 0 ; i < mergeMap.size() ; i++ ){
    		sheet.addMergedRegion( mergeMap.get( i ) );
    	}
    	
    }
    
    private void createData( Workbook workbook, Sheet sheet, String[] columnMap , List<Map<String, Object>> dataMap , short[] alignMap , CellStyle dataStyle , int startIndex ) {
    	
    	if( dataMap == null || dataMap.size() == 0 ) return;
    	
    	for( int i = startIndex ; i < ( dataMap.size() + startIndex ) ; i++ ){
			Row row = sheet.createRow( i );
			Cell cell = null;
			for( int s = 0 ; s < columnMap.length ; s++ ){ 
				cell = row.createCell( s );
				if(dataMap.get( i - startIndex ).get( columnMap[ s ] ) != null){
					cell.setCellValue( "" + dataMap.get( i - startIndex ).get( columnMap[ s ] ) );					
				} else {
					cell.setCellValue( "" );										
				}

				cell.setCellStyle( dataStyle );
				CellUtil.setAlignment(cell, workbook, alignMap[ s ]);

			}
    	}
    	
    }

    private void createHeader(Sheet sheet, List<String[]> headerMap , HSSFCellStyle headerStyle ) {
        
    	if( headerMap == null || headerMap.size() == 0 ) return;
    	
    	for( int i = 0 ; i < headerMap.size() ; i++ ){
    		Row row = sheet.createRow( i );
    		row.setHeight( (short)400 );
    		Cell cell = null;
    		for( int s = 0 ; s < headerMap.get( i ).length ; s++ ){
    			cell = row.createCell( s );
    			cell.setCellValue( headerMap.get( i )[ s ] );
    			cell.setCellStyle( headerStyle );
    		}
    	}
    	
    }
    
    public Sheet autoSizeColumns(Sheet sheet) {
        
        for( Row row : sheet ){
			for( Cell cell : row ){
					    
			    if( row.getRowNum() > 1 ){
			        break;
			    }
			    
			    sheet.autoSizeColumn( cell.getColumnIndex() );
			    
			    long width = sheet.getColumnWidth( cell.getColumnIndex() ) + 2500;
				    
			    if (width > MAX_COLUMN_WIDTH) { 
	                width = MAX_COLUMN_WIDTH; 
	            } 				    
			    
			    sheet.setColumnWidth( cell.getColumnIndex() ,  (int) width );
			}
        }
        
        return sheet;
    }    
    
    private String getBrowser(HttpServletRequest request) {
        
        String header = request.getHeader("User-Agent");
        if (header.indexOf("MSIE") > -1) {
            return "MSIE";
        } 
        
        else if (header.indexOf("Trident") > -1) { // IE11 문자열 깨짐 방지
            return "Trident";
        } 
        
        else if (header.indexOf("Chrome") > -1) {
            return "Chrome";
        } 
        
        else if (header.indexOf("Opera") > -1) {
            return "Opera";
        }
        
        return "Firefox";
    }

    private void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        String browser = getBrowser(request);
        
        String dispositionPrefix = "attachment; filename=";
        String encodedFilename = null;
        
        if (browser.equals("MSIE")) {
            encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
        } 
        
        else if (browser.equals("Trident")) { // IE11 문자열 깨짐 방지
            encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
        } 
        
        else if (browser.equals("Firefox")) {
            encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
        }
        
        else if (browser.equals("Opera")) {
            encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
        } 
        
        else if (browser.equals("Chrome")) {
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < filename.length(); i++) {
                char c = filename.charAt(i);
                if (c > '~') {
                    sb.append(URLEncoder.encode("" + c, "UTF-8"));
                } else {
                    sb.append(c);
                }
            }
            encodedFilename = sb.toString();
        }
        
        else {
            throw new IOException("Not supported browser");
        }
        
        response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);
        
        if ("Opera".equals(browser)) {
            response.setContentType("application/octet-stream;charset=UTF-8");
        }
        
        logger.debug("{}, {}, Content-Disposition:{}", new String[] { request.getRemoteAddr(), browser, dispositionPrefix + encodedFilename });
    }

	
}
