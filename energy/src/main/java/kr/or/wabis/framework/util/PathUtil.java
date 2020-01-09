package kr.or.wabis.framework.util;

public class PathUtil {
	
	private static String WEBAPP_PATH = null;
        
	static {
		
		WEBAPP_PATH = Thread.currentThread().getContextClassLoader().getResource(".").getFile();	
		
	}
    
	
	public static String getWebappPath(){
		if(WEBAPP_PATH == null){
			WEBAPP_PATH = Thread.currentThread().getContextClassLoader().getResource(".").getFile();	
		}
		return WEBAPP_PATH;
	}
}
