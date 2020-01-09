package kr.or.wabis.framework.web.view;

import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import kr.or.wabis.framework.util.ExcelUtil;

public class GenericExcelView extends AbstractExcelView {
    
    private static final Logger log = Logger.getLogger(GenericExcelView.class);
    
    @Override
    protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest req, HttpServletResponse res) throws Exception {
        
        String userAgent = req.getHeader("User-Agent");
        log.debug("userAgent : " + userAgent);
        
        String fileName = (String) model.get("fileName"); // 파일명
        String sheetName = (String) model.get("sheetName"); // 쉬트명
        
        if (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1) {
            fileName = URLEncoder.encode(fileName, "utf-8");
        } else {
            fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1");
        }
        
        res.setContentType("application/msexcel");
        res.setHeader("Content-Disposition", "attachment; filename=" + fileName + ".xls");
        
        List colName = (List) model.get("colName");
        List colValue = (List) model.get("colValue");
        
        Sheet sheet = workbook.createSheet(sheetName);
        
        // 헤더 표시
        Row headerRow = sheet.createRow(0);
        headerRow.setHeight((short) 400);
        for (int i = 0; i < colName.size(); i++) {
            
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(new HSSFRichTextString((String) colName.get(i)));
            
            cell.setCellStyle(ExcelUtil.genericHeaderCellStyle(workbook));
        }
        
        // 데이타 표시
        for (int i = 0; i < colValue.size(); i++) {
            
            Row row = sheet.createRow(i + 1);
            row.setHeight((short) 300);
            String[] rowData = (String[]) colValue.get(i);
            for (int j = 0; j < rowData.length; j++) {
                
                Cell cell = row.createCell(j);
                cell.setCellValue(new HSSFRichTextString(rowData[j]));
                
                cell.setCellStyle(ExcelUtil.genericDataCellStyle(workbook));
            }            
        }
        
        // 셀 넓이 자동 설정
        for (int colNum = 0; colNum < headerRow.getLastCellNum(); colNum++) {
            
            sheet.autoSizeColumn((short) colNum);
            
            // 윗줄만으로는 컬럼의 width 가 부족하여 더 늘려야 함.
            sheet.setColumnWidth(colNum, (sheet.getColumnWidth(colNum)) + 512); 
        }        
    }    
}
